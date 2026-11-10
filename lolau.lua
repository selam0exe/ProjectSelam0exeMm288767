-- Project Selam0exe (by lo6) - fixed build
-- Changes: 
--  * Removed "Coming Soon" locked tabs
--  * Added new "Cheats" tab (Camlock, Closest Player, Change Speed, Jump Boost, etc.)
--  * Kyoto: mobile buttons are no longer hidden/lost while kyoto runs
--  * Single Tech tab, no Animations tab

---------------------------------------------------------------------
-- LOAD WINDUI
---------------------------------------------------------------------
local lib
do
    local ok, res = pcall(function()
        return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    end)
    if not ok or type(res) ~= "table" then
        warn("[Selam0exe] WindUI failed to load: " .. tostring(res))
        return
    end
    lib = res
end

---------------------------------------------------------------------
-- SERVICES AND HELPERS
---------------------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local VIM = nil
pcall(function() VIM = game:GetService("VirtualInputManager") end)

local localPlayer = Players.LocalPlayer
while not localPlayer do
    task.wait()
    localPlayer = Players.LocalPlayer
end

local ACCENT = "#a29bfe"
local ACCENT2 = "#0984e3"
local DISCORD_LINK = "https://discord.gg/GFN6G8GEpB"
local YOUTUBE_LINK = "https://youtube.com/@selam0exe?si=-iUZmFC1yEA_0yor"

local UPPERCUT_IDS = {["10503381238"] = true, ["13379003796"] = true}
local DASH_CD_IDS = {["10479335397"] = true, ["13380255751"] = true}

local cfg = {
    supaDelay = 0.25, supaSpeed = 1, supaBehindOffset = 5, supaRandomMovement = 6, supaBehindEnabled = true,
    loopDelay = 0.16, loopRadius = 6, loopMinTargetDist = 15, loopMaxHeight = 10, loopSteps = 100,
    loopDashInterval = 0.08, loopSettleTime = 0.12, loopSettleHold = 0.6,
    autoCounterDistance = 13, detectBuffer = 0.02, extraDelay = 0.05, cooldown = 1, underOffset = 3,
    techHelperDelay = 0.3, techHelperHold = 0.15, techHelperLookUp = true, techHelperLockPercent = 50,
}

local st = {
    supa = false, upperGrasp = false, upperGraspCooldown = false,
    upperGraspSearchRadius = 70, upperGraspTweenTime = 10, upperGraspAfterDelay = 14, upperGraspCooldownSeconds = 50,
    loop = false, autoSurf = false, autoWhirlwindDunk = false, autoTwisted = false, instantTwisted = false,
    autoLockJump = false, lethalDetect = 16.25, lethalRemote = 1, lethalLock = 16, lethalRadius = 25,
    lethalCooldown = 0, lethalResp = 300,
    loopRework = false, forceJump = true, forceJumpVel = 52,
    lrDetect = 3, lrJump = 0, lrRemote = 1, lrLock = 15, lrRadius = 50, lrCooldown = 10, lrResp = 600,
    autoCounter = false, yoyo = false, yoyoDistanceLimit = 10,
    m1Catch = false, m1Range = 13, m1Hold = 200, m1Pred = 0,
    noClip = false, noEndLag = false, m2Block = false, m1Block = false,
    espEnabled = false, espColor = Color3.fromRGB(9, 132, 227),
    sigmaESP = false, sigmaColor = Color3.fromHex(ACCENT),
    arrowIndicator = false, deathCounterESP = false, fpsBoost = false,
    techHelper = false, fastDash = false, onlyTorsoCollisions = false,
    mouseDash = false, mouseDashDelay = 500,
    -- cheats
    camlock = false, camlockTarget = nil,
    closestPlayer = false,
    speedEnabled = false, speedValue = 16,
    jumpEnabled = false, jumpValue = 50,
    flyEnabled = false, flySpeed = 50,
    infiniteJump = false,
    fullbright = false,
    noFog = false,
}

local cn = {}

local function cb(f)
    return function(...)
        local ok, err = pcall(f, ...)
        if not ok then warn("[Selam0exe] " .. tostring(err)) end
    end
end

local function toColor(x)
    if typeof(x) == "Color3" then return x end
    if type(x) == "table" and typeof(x.Color) == "Color3" then return x.Color end
    return nil
end

local function notify(title, content, dur, icon)
    pcall(function()
        lib:Notify({Title = title, Content = content, Duration = dur or 3, Icon = icon})
    end)
end

local function guiParent()
    local ok, h = pcall(function() return gethui and gethui() end)
    if ok and h then return h end
    local ok2, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok2 and cg then return cg end
    return localPlayer:WaitForChild("PlayerGui")
end

local function sendKey(down, key)
    pcall(function() VIM:SendKeyEvent(down, key, false, game) end)
end

local function tapKey(key)
    sendKey(true, key)
    sendKey(false, key)
end

local function getParts()
    local c = localPlayer.Character
    if not c then return nil end
    local h = c:FindFirstChildOfClass("Humanoid")
    local r = c:FindFirstChild("HumanoidRootPart")
    if h and r then return c, h, r end
    return nil
end

local function numId(animId)
    return tostring(animId or ""):match("%d+")
end

local function playingAny(hum, set)
    for _, t in ipairs(hum:GetPlayingAnimationTracks()) do
        local a = t.Animation
        if a then
            local id = numId(a.AnimationId)
            if id and set[id] then return true end
        end
    end
    return false
end

local function fireDash(char)
    if not char then return end
    local comm = char:FindFirstChild("Communicate")
    if comm then
        pcall(function()
            comm:FireServer({Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = "KeyPress"})
        end)
    end
end

local function nearestLive(char, maxDist)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local live = Workspace:FindFirstChild("Live")
    if not hrp or not live then return nil end
    local best, bd = nil, maxDist or math.huge
    for _, m in ipairs(live:GetChildren()) do
        if m:IsA("Model") and m ~= char then
            local r = m:FindFirstChild("HumanoidRootPart")
            if r then
                local d = (hrp.Position - r.Position).Magnitude
                if d < bd then bd = d; best = m end
            end
        end
    end
    return best
end

local function findBestTarget(radius)
    local live = Workspace:FindFirstChild("Live")
    local char, _, hrp = getParts()
    if not live or not hrp then return nil end
    local best, bd = nil, radius
    for _, m in ipairs(live:GetChildren()) do
        if m:IsA("Model") and m ~= char then
            local r = m:FindFirstChild("HumanoidRootPart")
            local h = m:FindFirstChildOfClass("Humanoid")
            if r and h and h.Health > 0 and (m.Name == "Weakest Dummy" or Players:GetPlayerFromCharacter(m)) then
                local d = (r.Position - hrp.Position).Magnitude
                if d <= bd then bd = d; best = r end
            end
        end
    end
    return best
end

local function groundY(pos, ignore)
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    rp.FilterDescendantsInstances = ignore or {}
    local hit = Workspace:Raycast(pos + Vector3.new(0, 80, 0), Vector3.new(0, -300, 0), rp)
    if hit and hit.Position then return hit.Position.Y end
    return pos.Y
end

local function lrWait(sec, alive)
    local t0 = tick()
    while tick() - t0 < sec do
        if not alive() then return false end
        RunService.Heartbeat:Wait()
    end
    return true
end

local function disc(key)
    if cn[key] then
        pcall(function() cn[key]:Disconnect() end)
        cn[key] = nil
    end
end

---------------------------------------------------------------------
-- WINDOW
---------------------------------------------------------------------
pcall(function()
    lib:AddTheme({
        Name = "PurpleBlue",
        Accent = Color3.fromHex(ACCENT),
        Dialog = Color3.fromHex("#0f0f1a"),
        Outline = Color3.fromHex(ACCENT2),
        Text = Color3.fromHex(ACCENT),
        Placeholder = Color3.fromHex("#0f0f1a"),
        Background = Color3.fromHex("#0f0f1a"),
        Button = Color3.fromHex(ACCENT2),
        Icon = Color3.fromHex(ACCENT),
        Hover = Color3.fromHex(ACCENT2),
        Active = Color3.fromHex(ACCENT),
        ScrollBar = Color3.fromHex(ACCENT2),
        Border = Color3.fromHex("#0f0f1a"),
    })
end)
pcall(function() lib:SetFont("rbxassetid://12187377325") end)
pcall(function() lib.TransparencyValue = 0.2 end)
pcall(function() lib:SetTheme("PurpleBlue") end)

local function gradientText(text, c1, c2)
    local out = ""
    local n = #text
    for i = 1, n do
        local a = n == 1 and 0 or (i - 1) / (n - 1)
        out = out .. string.format('<font color="rgb(%d,%d,%d)">%s</font>',
            math.floor((c1.R + (c2.R - c1.R) * a) * 255),
            math.floor((c1.G + (c2.G - c1.G) * a) * 255),
            math.floor((c1.B + (c2.B - c1.B) * a) * 255),
            text:sub(i, i))
    end
    return out
end

local function makeWindow(opts)
    return pcall(function() return lib:CreateWindow(opts) end)
end

local okW, Window = makeWindow({
    Title = "Project Selam0exe",
    Icon = "rbxassetid://124836024119394",
    Author = "Made by lo6",
    Folder = "ProjectSelam0exe",
    Size = UDim2.fromOffset(650, 550),
    Theme = "PurpleBlue",
    HideSearchBar = false,
    NewElements = true,
    SideBarWidth = 200,
    HidePanelBackground = false,
    Background = "rbxassetid://91381543594907",
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function() notify("Project Selam0exe", "Made by lo6", 2) end,
    },
})
if not okW or not Window then
    warn("[Selam0exe] CreateWindow failed (" .. tostring(Window) .. "), retrying with basic options")
    okW, Window = makeWindow({
        Title = "Project Selam0exe",
        Author = "Made by lo6",
        Folder = "ProjectSelam0exe",
        Size = UDim2.fromOffset(650, 550),
        Theme = "Dark",
    })
end
if not okW or not Window then
    warn("[Selam0exe] Could not create the window: " .. tostring(Window))
    return
end

pcall(function() Window:Tag({Title = "Beta", Color = Color3.fromHex(ACCENT)}) end)
pcall(function()
    Window:CreateTopbarButton("discord-btn", "geist:logo-discord", function()
        if setclipboard then pcall(setclipboard, DISCORD_LINK) end
        notify("Discord link has been copied!", "Please join our discord!", 3, "geist:logo-discord")
    end, 990)
end)
pcall(function()
    Window:CreateTopbarButton("youtube-btn", "lucide:youtube", function()
        if setclipboard then pcall(setclipboard, YOUTUBE_LINK) end
        notify("YouTube link has been copied!", "Please Subscribe!", 3, "lucide:youtube")
    end, 990)
end)

local dummyTab = setmetatable({}, {__index = function() return function() return nil end end})

local function newTab(title, icon, locked)
    local ok, tab = pcall(function()
        local o = {Title = title, Icon = icon, Opened = true}
        if locked then o.Locked = true end
        return Window:Tab(o)
    end)
    if ok and tab then return tab end
    warn("[Selam0exe] Tab failed: " .. title .. " -> " .. tostring(tab))
    return dummyTab
end

local function el(tab, kind, opts)
    local ok, res = pcall(function() return tab[kind](tab, opts) end)
    if not ok then
        warn(("[Selam0exe] %s '%s' failed: %s"):format(kind, tostring(opts and opts.Title), tostring(res)))
        return nil
    end
    return res
end

---------------------------------------------------------------------
-- TABS
---------------------------------------------------------------------
local T = {
    Tech = newTab("Tech", "lucide:cpu"),
    Cheats = newTab("Cheats", "lucide:gamepad-2"),
    Utils = newTab("Utilities", "lucide:square-plus"),
    Settings = newTab("Settings", "lucide:settings"),
    Configs = newTab("Configs", "lucide:save"),
    Credits = newTab("Credits", "lucide:heart"),
}

pcall(function() T.Tech:Select() end)

pcall(function()
    lib:Popup({
        Title = gradientText("Project Selam0exe beta v1.2", Color3.fromHex(ACCENT), Color3.fromHex(ACCENT2)),
        Icon = "lucide:smile",
        Content = "Welcome to Project Selam0exe!",
        Buttons = {{Title = "Enjoy!", Icon = "lucide:heart", Variant = "Primary", Callback = function() end}},
    })
end)

---------------------------------------------------------------------
-- SUPA TECH + HELPER (UPPER GRASP)
---------------------------------------------------------------------
local hookSupa
do
    local function supaRun(char, target)
        if not st.supa then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local thrp = target:FindFirstChild("HumanoidRootPart")
        if not hrp or not thrp then return end
        task.wait(cfg.supaDelay)
        if not st.supa then return end
        fireDash(char)
        task.wait(0.02)
        local pos = thrp.Position
        local under = Vector3.new(pos.X, pos.Y - cfg.underOffset, pos.Z)
        local rnd = Vector3.new(math.random() - 0.5, 0, math.random() - 0.5)
        if rnd.Magnitude == 0 then rnd = Vector3.new(0.1, 0, 0) end
        local lookAt = pos + rnd.Unit * cfg.supaRandomMovement
        local tw = TweenService:Create(hrp, TweenInfo.new(0.2 / cfg.supaSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(under, lookAt)})
        tw:Play()
        tw.Completed:Wait()
        if cfg.supaBehindEnabled then
            local dir = thrp.Position - hrp.Position
            if dir.Magnitude == 0 then dir = Vector3.new(0, 0, 1) end
            local b = thrp.Position - dir.Unit * cfg.supaBehindOffset
            local bp = Vector3.new(b.X, hrp.Position.Y, b.Z)
            local tw2 = TweenService:Create(hrp, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(bp, thrp.Position)})
            tw2:Play()
            tw2.Completed:Wait()
        end
        if st.supa then fireDash(char) end
    end

    hookSupa = function(char)
        disc("supa")
        if not st.supa or not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local busy, held, cd = false, false, false
        cn.supa = RunService.Heartbeat:Connect(function()
            if not char.Parent or not char:FindFirstChild("HumanoidRootPart") then return end
            local playing = playingAny(hum, UPPERCUT_IDS)
            if playing and not busy and not held and not cd then
                busy, held, cd = true, true, true
                task.spawn(function()
                    task.wait(cfg.detectBuffer + cfg.extraDelay)
                    local t = nearestLive(char, 50)
                    if t and st.supa then pcall(supaRun, char, t) end
                    busy = false
                    task.delay(cfg.cooldown, function() cd = false end)
                end)
            elseif not playing then
                held = false
            end
        end)
    end

    local gc = {}
    local function findClosest(char, hrp)
        local live = Workspace:FindFirstChild("Live")
        if not live then return nil end
        local best, bd = nil, st.upperGraspSearchRadius
        for _, m in ipairs(live:GetChildren()) do
            if m:IsA("Model") and m ~= char then
                local part = m:FindFirstChild("Torso") or m:FindFirstChild("UpperTorso") or m:FindFirstChild("HumanoidRootPart") or m:FindFirstChild("Head")
                if part then
                    local d = (hrp.Position - part.Position).Magnitude
                    if d <= bd then bd = d; best = part end
                end
            end
        end
        return best
    end

    local function perform()
        if not st.upperGrasp then return end
        local char, hum, hrp = getParts()
        if not char then return end
        local t = findClosest(char, hrp)
        if t then
            pcall(function()
                local tw = TweenService:Create(hrp, TweenInfo.new(st.upperGraspTweenTime / 100, Enum.EasingStyle.Linear), {CFrame = CFrame.new(t.Position + Vector3.new(0, 5, 0))})
                tw:Play()
                tw.Completed:Wait()
            end)
        end
        local bp = localPlayer.Backpack
        local tool = bp and bp:FindFirstChild("Hunterzzzzz's Grasp")
        local comm = char:FindFirstChild("Communicate")
        if tool and comm then
            pcall(function() comm:FireServer({Tool = tool, Goal = "Console Move"}) end)
        end
    end

    local function onAnim(track)
        if not st.upperGrasp or st.upperGraspCooldown then return end
        if not track or not track.Animation then return end
        local id = numId(track.Animation.AnimationId)
        if id and UPPERCUT_IDS[id] then
            st.upperGraspCooldown = true
            task.delay(st.upperGraspAfterDelay / 100, function()
                if st.upperGrasp then pcall(perform) end
                task.delay(st.upperGraspCooldownSeconds / 10, function() st.upperGraspCooldown = false end)
            end)
        end
    end

    local function hookChar()
        if gc.anim then gc.anim:Disconnect(); gc.anim = nil end
        local _, hum = getParts()
        if hum then gc.anim = hum.AnimationPlayed:Connect(onAnim) end
    end

    function SetupUpperGrasp()
        if gc.anim then gc.anim:Disconnect(); gc.anim = nil end
        if gc.charAdded then gc.charAdded:Disconnect(); gc.charAdded = nil end
        if not st.upperGrasp then st.upperGraspCooldown = false; return end
        hookChar()
        gc.charAdded = localPlayer.CharacterAdded:Connect(function()
            task.wait(0.9)
            if st.upperGrasp then hookChar() end
        end)
        notify("Upper Grasp", "Enabled - will trigger on dash animations", 3, "lucide:hand")
    end
end

el(T.Tech, "Paragraph", {Title = "Supa Tech", Desc = "Dash in them", Image = "lucide:sword", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
el(T.Tech, "Toggle", {Title = "Enable Feature", Flag = "Save13", Value = false, Callback = cb(function(v)
    st.supa = v
    if v then hookSupa(localPlayer.Character) else disc("supa") end
end)})
el(T.Tech, "Toggle", {Title = "Helper", Desc = "Use this to headtab", Flag = "Save14", Value = false, Callback = cb(function(v)
    st.upperGrasp = v
    SetupUpperGrasp()
end)})
el(T.Tech, "Slider", {Title = "Supa Delay (ms)", Flag = "Save15", Value = {Min = 0, Max = 500, Default = 250}, Callback = cb(function(v) cfg.supaDelay = tonumber(v) / 1000 end)})
el(T.Tech, "Slider", {Title = "Supa Speed (x10)", Flag = "Save16", Value = {Min = 5, Max = 25, Default = 10}, Callback = cb(function(v) cfg.supaSpeed = tonumber(v) / 10 end)})

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- HOOK DASH
---------------------------------------------------------------------
local setupSideDash, cleanupSideDash
do
    local sd = {
        enabled = false, mobile = false, distance = 35, range = 2, cooldown = 1, show = true,
        delay = 0.11, smooth = 0.4, prediction = 0.3, reach = 6.5, duration = 0.15,
        color = Color3.fromRGB(162, 155, 254),
    }
    local hd = {target = nil, toggle = false, q = true, f = true, m = true, click = false, lv = nil, att = nil, gui = nil, lastTap = 0}
    local sdConns = {}

    local function getDummy()
        local live = Workspace:FindFirstChild("Live")
        return live and live:FindFirstChild("Weakest Dummy")
    end

    local function targetChar(t)
        if not t then return nil end
        if typeof(t) == "Instance" and t:IsA("Model") then return t end
        return t.Character
    end

    local function removeHighlight(char)
        if not char then return end
        for _, d in ipairs(char:GetDescendants()) do
            if d:IsA("Highlight") and d.Name == "HookDashHighlight" then d:Destroy() end
        end
    end

    local function addHighlight(char)
        if not char or not sd.show then return end
        local h = Instance.new("Highlight")
        h.Name = "HookDashHighlight"
        h.FillColor = sd.color
        h.OutlineColor = sd.color
        h.FillTransparency = 0.8
        h.OutlineTransparency = 0.3
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = char
    end

    local function deselect()
        if hd.target then
            removeHighlight(targetChar(hd.target))
            hd.target = nil
            hd.toggle = false
        end
    end

    local function select(t)
        if t == hd.target then deselect() return end
        deselect()
        hd.target = t
        addHighlight(targetChar(t))
        hd.toggle = true
    end

    local function updateColor()
        if hd.target then
            local c = targetChar(hd.target)
            removeHighlight(c)
            addHighlight(c)
        end
    end

    local function ensureLV(parent)
        if not hd.att or not hd.att.Parent then hd.att = Instance.new("Attachment", parent) end
        if not hd.lv or not hd.lv.Parent then
            local lv = Instance.new("LinearVelocity")
            lv.Attachment0 = hd.att
            lv.MaxForce = math.huge
            lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            lv.RelativeTo = Enum.ActuatorRelativeTo.World
            lv.Parent = parent
            hd.lv = lv
        end
        return hd.lv
    end

    local function setDashVelocity(root, goal, dur)
        local lv = ensureLV(root)
        local flat = Vector3.new(goal.X, root.Position.Y, goal.Z)
        local needed = (flat - root.Position) / math.max(dur, 0.01)
        lv.VectorVelocity = Vector3.new(needed.X, 0, needed.Z)
    end

    local function stopDash()
        if hd.lv then pcall(function() hd.lv.VectorVelocity = Vector3.new(); hd.lv:Destroy() end); hd.lv = nil end
        if hd.att then pcall(function() hd.att:Destroy() end); hd.att = nil end
    end

    local function dashA(char)
        local comm = char:FindFirstChild("Communicate")
        if comm then
            comm:FireServer({Dash = Enum.KeyCode.A, Key = Enum.KeyCode.Q, Goal = "KeyPress"})
        end
    end

    local function playAnim(id)
        if hd.q ~= true then return end
        hd.q = false
        local char = localPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
        local anim = Instance.new("Animation")
        anim.AnimationId = id
        animator:LoadAnimation(anim):Play()
    end
    local function pressQA() playAnim("rbxassetid://10480796021") end
    local function pressQD() playAnim("rbxassetid://10480793962") end

    local function silentAim(humm, t, side)
        local tc = targetChar(t)
        local arm = tc and tc:FindFirstChild("Right Arm")
        if not arm then return end
        local dirv = arm.Position - humm.Position
        local nd = CFrame.fromAxisAngle(Vector3.new(0, side, 0), math.rad(140)) * dirv
        local dd = arm.Position + nd
        local look = Vector3.new(dd.X, humm.Position.Y, dd.Z)
        humm.CFrame = humm.CFrame:Lerp(CFrame.new(humm.Position, look), sd.smooth)
    end

    local function aimlock(t)
        local cam = Workspace.CurrentCamera
        local tc = targetChar(t)
        local r = tc and tc:FindFirstChild("HumanoidRootPart")
        if cam and r then
            cam.CFrame = CFrame.new(cam.CFrame.Position, Vector3.new(r.Position.X, 438, r.Position.Z))
        end
    end

    local function simulateClick()
        if not hd.click then return end
        local char = localPlayer.Character
        local comm = char and char:FindFirstChild("Communicate")
        if not comm then return end
        comm:FireServer({Goal = "KeyRelease", Key = Enum.KeyCode.F})
        comm:FireServer({Mobile = true, Goal = "LeftClick"})
        comm:FireServer({Mobile = true, Goal = "LeftClickRelease"})
    end

    local function performDash()
        if not hd.toggle or not hd.target then return end
        local char = localPlayer.Character
        if not char then return end
        local p = char:FindFirstChild("HumanoidRootPart")
        if not p or p.Position.Y > 442 then return end
        local tchar = targetChar(hd.target)
        local thrp = tchar and tchar:FindFirstChild("HumanoidRootPart")
        if not thrp or thrp.Position.Y > 448 then return end
        if sd.distance < (thrp.Position - p.Position).Magnitude or not hd.f then return end

        hd.click = true
        hd.f = false
        hd.m = true
        dashA(char)

        task.delay(sd.duration, function()
            hd.m = false
            hd.q = true
            local c
            c = RunService.Stepped:Connect(function() aimlock(hd.target) end)
            task.delay(0.5, function() if c then c:Disconnect() end end)
            task.wait(sd.cooldown)
            hd.f = true
        end)
        task.delay(sd.delay, function()
            simulateClick()
            hd.click = false
        end)

        local dir = (thrp.Position - p.Position).Unit
        local fwd = thrp.CFrame.LookVector
        local flat = Vector3.new(dir.X, 0, dir.Z).Unit
        local jok = Vector3.new(flat.Z, 0, -flat.X)
        local jok2 = Vector3.new(-flat.Z, 0, flat.X)
        local des1 = ((thrp.Position + jok * sd.range) - p.Position).Unit
        local des70 = ((thrp.Position + jok2 * sd.range) - p.Position).Unit
        local hum = char:FindFirstChildOfClass("Humanoid")

        local function startSilent(pressFn, side)
            pressFn()
            if hum then hum.AutoRotate = false end
            local c
            c = RunService.Stepped:Connect(function()
                local pp = char:FindFirstChild("HumanoidRootPart")
                if not hd.m or not pp then c:Disconnect(); return end
                silentAim(pp, hd.target, side)
            end)
        end

        local function rightCloser(pos)
            return (thrp.Position + thrp.CFrame.RightVector * sd.range - pos).Magnitude < (thrp.Position - thrp.CFrame.RightVector * sd.range - pos).Magnitude
        end

        local facing = fwd:Dot(dir)
        if rightCloser(p.Position) then
            if facing < 0 then startSilent(pressQA, -1) elseif facing > 0 then startSilent(pressQD, 1) end
        else
            if facing < 0 then startSilent(pressQD, 1) elseif facing > 0 then startSilent(pressQA, -1) end
        end

        local loop
        loop = RunService.Heartbeat:Connect(function()
            if not hd.m then loop:Disconnect(); return end
            local pp = char:FindFirstChild("HumanoidRootPart")
            if not pp or not thrp.Parent then loop:Disconnect(); return end
            local pred = thrp.AssemblyLinearVelocity
            local a1 = thrp.Position + jok * sd.range + pred * sd.prediction
            local a2 = thrp.Position + jok2 * sd.range + pred * sd.prediction
            local d1 = a1 + des1 * sd.reach
            local d2 = a2 + des70 * sd.reach
            local goal
            if rightCloser(pp.Position) then
                goal = Vector3.new(d1.X, pp.Position.Y, d1.Z)
            else
                goal = Vector3.new(d2.X, pp.Position.Y, d2.Z)
            end
            setDashVelocity(pp, goal, sd.duration)
        end)
        task.delay(sd.duration, function()
            hd.m = false
            stopDash()
        end)
    end

    local function getTargetFromMouse()
        local mouse = localPlayer:GetMouse()
        local mp = mouse.Hit.p
        local dummy = getDummy()
        local best, bd = nil, math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= localPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local d = (plr.Character.HumanoidRootPart.Position - mp).Magnitude
                if d < bd then bd = d; best = plr end
            end
        end
        if dummy and dummy:FindFirstChild("HumanoidRootPart") and (dummy.HumanoidRootPart.Position - mp).Magnitude < bd then
            best = dummy
        end
        if best then select(best) else deselect() end
    end

    local function touchSelect(pos)
        local cam = Workspace.CurrentCamera
        local ray = cam:ScreenPointToRay(pos.X, pos.Y)
        local rp = RaycastParams.new()
        rp.FilterDescendantsInstances = {localPlayer.Character}
        rp.FilterType = Enum.RaycastFilterType.Exclude
        local hit = Workspace:Raycast(ray.Origin, ray.Direction * 1000, rp)
        if not hit then deselect() return end
        local model = hit.Instance:FindFirstAncestorOfClass("Model")
        if not model then return end
        local plr = Players:GetPlayerFromCharacter(model)
        local sel = plr or (model == getDummy() and model or nil)
        if sel then select(sel) end
    end

    local function createMobileButton()
        if hd.gui then return end
        local gui = Instance.new("ScreenGui")
        gui.Name = "HookDashButton"
        gui.ResetOnSpawn = false
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = guiParent()
        hd.gui = gui
        local btn = Instance.new("ImageButton", gui)
        btn.Position = UDim2.new(0.9, 0, 0.8, 0)
        btn.Size = UDim2.new(0, 60, 0, 60)
        btn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
        btn.BackgroundTransparency = 0.3
        btn.Image = "rbxassetid://12443244342"
        btn.ImageColor3 = Color3.fromHex(ACCENT)
        btn.Draggable = true
        btn.Active = true
        btn.MouseButton1Click:Connect(function() pcall(performDash) end)
        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(0, 10)
    end

    setupSideDash = function()
        cleanupSideDash()
        sdConns.playerRemoving = Players.PlayerRemoving:Connect(function(plr)
            if hd.target == plr then deselect() end
        end)
        sdConns.health = RunService.Heartbeat:Connect(function()
            if not hd.toggle or not hd.target then return end
            local tc = targetChar(hd.target)
            local h = tc and tc:FindFirstChildOfClass("Humanoid")
            if h and h.Health <= 0 then deselect() end
        end)
        sdConns.touch = UserInputService.InputBegan:Connect(function(input, gp)
            if gp or not sd.enabled then return end
            if input.UserInputType == Enum.UserInputType.Touch then
                if os.clock() - hd.lastTap < 0.3 then pcall(touchSelect, input.Position) end
                hd.lastTap = os.clock()
            end
        end)
        sdConns.keys = UserInputService.InputBegan:Connect(function(input, gp)
            if gp or not sd.enabled then return end
            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.V then pcall(getTargetFromMouse) end
                if input.KeyCode == Enum.KeyCode.C then pcall(performDash) end
            end
        end)
        if sd.mobile then createMobileButton() end
    end

    cleanupSideDash = function()
        for _, c in pairs(sdConns) do pcall(function() c:Disconnect() end) end
        sdConns = {}
        deselect()
        stopDash()
        local _, hum = getParts()
        if hum then hum.AutoRotate = true end
        if hd.gui then hd.gui:Destroy(); hd.gui = nil end
    end

    el(T.Tech, "Paragraph", {Title = "Hook Dash", Desc = "V to choose target, C to do hook dash (mobile: double tap a target)", Image = "geist:anchor", ImageSize = 20, Color = Color3.fromHex(ACCENT2)})
    el(T.Tech, "Toggle", {Title = "Enable Hook Dash", Flag = "Save17", Value = false, Callback = cb(function(v)
        sd.enabled = v
        if v then setupSideDash() else cleanupSideDash() end
    end)})
    el(T.Tech, "Colorpicker", {Title = "Target Color", Flag = "Save18", Default = sd.color, Callback = cb(function(c)
        local col = toColor(c)
        if col then sd.color = col; updateColor() end
    end)})
    el(T.Tech, "Toggle", {Title = "Mobile Mode", Flag = "Save19", Value = false, Callback = cb(function(v)
        sd.mobile = v
        if sd.enabled then
            if v then createMobileButton() elseif hd.gui then hd.gui:Destroy(); hd.gui = nil end
        end
    end)})
    el(T.Tech, "Toggle", {Title = "Show Highlight", Value = true, Callback = cb(function(v)
        sd.show = v
        updateColor()
    end)})
end

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- LOOP DASH
---------------------------------------------------------------------
local hookLoop
do
    local function loopRun(char, target)
        if not st.loop then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local thrp = target:FindFirstChild("HumanoidRootPart")
        if not hrp or not thrp then return end
        task.wait(cfg.loopDelay)
        if not st.loop then return end
        local base = groundY(hrp.Position, {char})
        local height = math.min(hrp.Position.Y - base, cfg.loopMaxHeight)
        if height < 0.5 then height = 2 end
        fireDash(char)
        local t0 = tick()
        local tEnd = t0 + 0.5
        local full = math.pi * 2
        local d0 = hrp.Position - thrp.Position
        local a0 = math.atan2(d0.Z, d0.X)
        local lastDash = tick() - cfg.loopDashInterval
        local seed = math.random() * 1000
        local conn
        conn = RunService.Heartbeat:Connect(function()
            if not (st.loop and char.Parent and target.Parent and hrp.Parent and thrp.Parent) then
                conn:Disconnect()
                return
            end
            local now = tick()
            if now >= tEnd then
                conn:Disconnect()
                local pos = thrp.Position
                local y = groundY(pos, {char, target}) + math.min(height, cfg.loopMaxHeight)
                local v = Vector3.new(pos.X, y, pos.Z)
                local cf = CFrame.new(v, pos + Vector3.new(0, 0.1, 0))
                task.spawn(function()
                    local tw = TweenService:Create(hrp, TweenInfo.new(cfg.loopSettleTime, Enum.EasingStyle.Quad), {CFrame = cf})
                    tw:Play()
                    tw.Completed:Wait()
                    local bp = Instance.new("BodyPosition")
                    bp.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                    bp.P = 10000
                    bp.D = 100
                    bp.Position = v
                    bp.Parent = hrp
                    local bg = Instance.new("BodyGyro")
                    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
                    bg.P = 5000
                    bg.D = 100
                    bg.CFrame = cf
                    bg.Parent = hrp
                    local c2
                    c2 = RunService.Heartbeat:Connect(function()
                        if bg.Parent and thrp.Parent and hrp.Parent then
                            local dv = thrp.Position - hrp.Position
                            local u = dv.Magnitude > 0 and dv.Unit or dv
                            local sum = hrp.CFrame.LookVector + u
                            if sum.Magnitude > 0 then
                                bg.CFrame = CFrame.new(hrp.Position, hrp.Position + sum.Unit)
                            end
                        else
                            c2:Disconnect()
                        end
                    end)
                    task.delay(cfg.loopSettleHold, function()
                        c2:Disconnect()
                        bp:Destroy()
                        bg:Destroy()
                    end)
                end)
                return
            end
            local alpha = math.clamp((now - t0) / 0.5, 0, 1)
            local ang = a0 + full * alpha
            local pos = thrp.Position
            local jx = math.sin((alpha * 12 + seed) * math.pi * 2) * 0.12
            local jz = math.cos((alpha * 9 + seed * 0.7) * math.pi * 2) * 0.09
            local rad = cfg.loopRadius + math.sin((alpha * 6 + seed) * 1.7) * 0.35
            local off = Vector3.new(math.cos(ang), 0, math.sin(ang)) * rad + Vector3.new(jx, 0, jz)
            local y = groundY(pos, {char, target}) + math.min(height, cfg.loopMaxHeight)
            local p1 = Vector3.new(pos.X + off.X, y, pos.Z + off.Z)
            local ang2 = ang + full / cfg.loopSteps
            local off2 = Vector3.new(math.cos(ang2), 0, math.sin(ang2)) * rad + Vector3.new(jx, 0, jz)
            local p2 = Vector3.new(pos.X + off2.X, y, pos.Z + off2.Z)
            hrp.CFrame = CFrame.new(p1, p2)
            if now - lastDash >= cfg.loopDashInterval then
                lastDash = now
                fireDash(char)
            end
        end)
    end

    hookLoop = function(char)
        disc("loop")
        if not st.loop or not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local busy, held, cd = false, false, false
        cn.loop = RunService.Heartbeat:Connect(function()
            if not char.Parent or not char:FindFirstChild("HumanoidRootPart") then return end
            local playing = playingAny(hum, UPPERCUT_IDS)
            if playing and not busy and not held and not cd then
                busy, held, cd = true, true, true
                task.spawn(function()
                    task.wait(cfg.detectBuffer + 0.045)
                    local waited = 0
                    while waited < cfg.loopDelay do
                        task.wait(0.01)
                        waited = waited + 0.01
                        if not st.loop or not playingAny(hum, UPPERCUT_IDS) then
                            busy = false
                            cd = false
                            return
                        end
                    end
                    local t = nearestLive(char, cfg.loopMinTargetDist)
                    if t and st.loop then pcall(loopRun, char, t) end
                    busy = false
                    task.delay(cfg.cooldown, function() cd = false end)
                end)
            elseif not playing then
                held = false
            end
        end)
    end
end

el(T.Tech, "Paragraph", {Title = "Loop Dash", Desc = "Do a loop while dashing", Image = "lucide:refresh-ccw-dot", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
el(T.Tech, "Toggle", {Title = "Enable Feature", Flag = "Save20", Value = false, Callback = cb(function(v)
    st.loop = v
    if v then hookLoop(localPlayer.Character) else disc("loop") end
end)})
el(T.Tech, "Slider", {Title = "Loop Delay", Flag = "Save21", Value = {Min = 0, Max = 500, Default = 160}, Callback = cb(function(v) cfg.loopDelay = tonumber(v) / 1000 end)})
el(T.Tech, "Slider", {Title = "Loop Radius", Flag = "Save22", Value = {Min = 2, Max = 10, Default = 6}, Callback = cb(function(v) cfg.loopRadius = tonumber(v) end)})

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- LOCK MODULE
---------------------------------------------------------------------
local function scanBlocking(blockId)
    local live = Workspace:FindFirstChild("Live")
    if not live then return false end
    local me = localPlayer.Character
    for _, m in ipairs(live:GetChildren()) do
        if m:IsA("Model") and m ~= me then
            local h = m:FindFirstChildOfClass("Humanoid")
            if h and h.Health > 0 then
                local ok, tracks = pcall(function() return h:GetPlayingAnimationTracks() end)
                if ok and tracks then
                    for _, tr in ipairs(tracks) do
                        if tr.Animation and tostring(tr.Animation.AnimationId):find(blockId, 1, true) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

local function makeLockModule(o)
    local M = {c = {}, debounce = false, blocked = false, cleanup = nil}
    local function on() return o.enabled() end
    local function okRun() return on() and not M.blocked end

    function M.restore()
        if M.cleanup then pcall(M.cleanup); M.cleanup = nil end
        local _, hum = getParts()
        if hum then pcall(function() hum.AutoRotate = true end) end
    end

    local function startLock(target, dur)
        local _, _, hrp = getParts()
        if not target or not target.Parent or not hrp or dur <= 0 then return nil end
        local t0 = tick()
        local conn
        conn = RunService.RenderStepped:Connect(function(dt)
            if not okRun() or not target.Parent or not hrp.Parent then conn:Disconnect(); return end
            local pos = hrp.Position
            local goal = Vector3.new(target.Position.X, pos.Y, target.Position.Z)
            if (goal - pos).Magnitude >= 0.001 then
                local cf = CFrame.new(pos, goal)
                local a = o.alpha(dt)
                if a >= 0.999999 then
                    hrp.CFrame = cf
                else
                    local l = hrp.CFrame:Lerp(cf, a)
                    hrp.CFrame = CFrame.new(pos) * CFrame.fromMatrix(Vector3.new(), l.RightVector, l.UpVector)
                end
            end
            if tick() - t0 >= dur then conn:Disconnect() end
        end)
        return function() pcall(function() conn:Disconnect() end) end
    end

    local function run()
        if M.debounce or not okRun() then return end
        M.debounce = true
        local p = o.params()
        local function alive() return okRun() end
        local function abort(hum, ar)
            pcall(function() if hum and hum.Parent and ar ~= nil then hum.AutoRotate = ar end end)
            M.debounce = false
        end
        if not lrWait(p.detect, alive) then M.debounce = false; return end
        local char, hum, hrp = getParts()
        if not hum then M.debounce = false; return end
        local ar = hum.AutoRotate
        hum.AutoRotate = false
        o.jump(hum, hrp)
        if not lrWait(p.jumpWait, alive) then abort(hum, ar); return end
        o.dash(char)
        if not lrWait(p.remote, alive) then abort(hum, ar); return end
        local tgt = o.findTarget(p.radius)
        if tgt and not M.blocked then M.cleanup = startLock(tgt, p.lock) end
        local endT = tick() + math.max(p.lock, 1.2)
        task.spawn(function()
            while tick() < endT and okRun() do
                pcall(function() if hum.Parent then hum.AutoRotate = false end end)
                RunService.Heartbeat:Wait()
            end
            pcall(function() if hum.Parent then hum.AutoRotate = ar end end)
        end)
        task.delay(p.lock, function()
            if M.cleanup then pcall(M.cleanup); M.cleanup = nil end
        end)
        task.delay(p.cooldown, function() M.debounce = false end)
    end

    local function matches(track)
        local id = tostring(track and track.Animation and track.Animation.AnimationId or "")
        return id == o.detectId or id:find(o.detectId, 1, true) ~= nil
    end

    function M.hook()
        for _, k in ipairs({"anim", "scanner", "died"}) do
            if M.c[k] then pcall(function() M.c[k]:Disconnect() end); M.c[k] = nil end
        end
        local _, hum = getParts()
        if not hum then return end
        M.c.anim = hum.AnimationPlayed:Connect(function(track)
            if not okRun() or M.debounce then return end
            if matches(track) then task.spawn(run) end
        end)
        if o.scanner then
            M.c.died = hum.Died:Connect(function()
                M.debounce = false
                M.blocked = false
                M.restore()
            end)
            M.c.scanner = RunService.Heartbeat:Connect(function()
                if not okRun() or M.debounce then return end
                local ok, res = pcall(function() return hum:GetPlayingAnimationTracks() end)
                if ok and res then
                    for _, tr in ipairs(res) do
                        if matches(tr) then task.spawn(run); break end
                    end
                end
            end)
        end
    end

    function M.startBlockChecker()
        if M.c.blockChecker then pcall(function() M.c.blockChecker:Disconnect() end); M.c.blockChecker = nil end
        local acc = 0
        M.c.blockChecker = RunService.Heartbeat:Connect(function(dt)
            if not on() then return end
            acc = acc + dt
            if acc < 0.12 then return end
            acc = 0
            local bl = scanBlocking(o.blockId)
            if bl and not M.blocked then
                M.blocked = true
                M.restore()
                if M.c.anim then pcall(function() M.c.anim:Disconnect() end); M.c.anim = nil end
            elseif not bl and M.blocked then
                M.blocked = false
                if on() then M.hook() end
            end
        end)
    end

    function M.setup()
        for _, k in ipairs({"anim", "scanner", "died", "blockChecker", "charAdded", "charRemoving"}) do
            if M.c[k] then pcall(function() M.c[k]:Disconnect() end); M.c[k] = nil end
        end
        if not on() then
            M.restore()
            M.debounce = false
            M.blocked = false
            return
        end
        M.c.charAdded = localPlayer.CharacterAdded:Connect(function()
            task.wait(0.5)
            if on() then M.hook() end
        end)
        M.c.charRemoving = localPlayer.CharacterRemoving:Connect(function()
            M.restore()
            M.debounce = false
            M.blocked = false
        end)
        M.hook()
        M.startBlockChecker()
    end

    return M
end

---------------------------------------------------------------------
-- LOOP DASH V2
---------------------------------------------------------------------
local loopV2
do
    local fjCooldown = false
    loopV2 = makeLockModule({
        enabled = function() return st.loopRework end,
        detectId = "10503381238",
        blockId = "10471478869",
        scanner = false,
        alpha = function(dt)
            local n = math.clamp(st.lrResp, 1, 10000)
            if n >= 1000 then return 1 end
            return math.clamp(1 - math.exp(-0.02 * n * dt), 0, 1)
        end,
        params = function()
            return {
                detect = st.lrDetect / 10, jumpWait = st.lrJump / 10, remote = st.lrRemote / 10,
                lock = st.lrLock / 10, cooldown = st.lrCooldown / 10, radius = st.lrRadius,
            }
        end,
        jump = function(hum, hrp)
            if not st.forceJump then
                pcall(function() hum.Jump = true; hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
                return
            end
            if fjCooldown then return end
            fjCooldown = true
            pcall(function()
                hum.PlatformStand = false
                hum.Jump = true
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end)
            pcall(function()
                local v = hrp.AssemblyLinearVelocity
                hrp.AssemblyLinearVelocity = Vector3.new(v.X, st.forceJumpVel, v.Z)
            end)
            task.delay(0.18, function() fjCooldown = false end)
        end,
        dash = function(char) fireDash(char) end,
        findTarget = findBestTarget,
    })
end

el(T.Tech, "Paragraph", {Title = "Loop Dash v2", Desc = "Better loop dash, use for oreo tech", Image = "lucide:refresh-ccw-dot", ImageSize = 20, Color = Color3.fromHex(ACCENT2)})
el(T.Tech, "Toggle", {Title = "LoopDash v2 Enabled", Flag = "Save23", Value = false, Callback = cb(function(v) st.loopRework = v; loopV2.setup() end)})
el(T.Tech, "Toggle", {Title = "Jump Assist", Desc = "Use for oreo tech", Flag = "Save24", Value = true, Callback = cb(function(v) st.forceJump = v end)})
el(T.Tech, "Slider", {Title = "Jump height", Flag = "Save25", Value = {Min = 10, Max = 100, Default = 52}, Callback = cb(function(v) st.forceJumpVel = tonumber(v) end)})
el(T.Tech, "Slider", {Title = "Delay", Flag = "Save26", Value = {Min = 0, Max = 10, Default = 3}, Callback = cb(function(v) st.lrDetect = tonumber(v) end)})
el(T.Tech, "Slider", {Title = "Smoothness", Flag = "Save28", Value = {Min = 1, Max = 1000, Default = 600}, Callback = cb(function(v) st.lrResp = tonumber(v) end)})

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- LETHAL DASH + AUTO LETHAL DUNK
---------------------------------------------------------------------
local lethal
local setupAutoWhirlwindDunk
do
    lethal = makeLockModule({
        enabled = function() return st.autoLockJump end,
        detectId = "12296113986",
        blockId = "10471478869",
        scanner = true,
        alpha = function(dt)
            local r = math.clamp(st.lethalResp, 0, 1000) / 1000
            local n = 0.6 + 119.4 * (r ^ 2)
            return math.clamp(1 - math.exp(-n * dt), 0, 1)
        end,
        params = function()
            return {
                detect = st.lethalDetect / 10, jumpWait = 0, remote = st.lethalRemote / 10,
                lock = st.lethalLock / 10, cooldown = st.lethalCooldown / 10, radius = st.lethalRadius,
            }
        end,
        jump = function(hum)
            pcall(function()
                for _ = 1, 3 do
                    hum.Jump = true
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    RunService.Heartbeat:Wait()
                end
            end)
        end,
        dash = function(char)
            for _ = 1, 3 do
                fireDash(char)
                RunService.Heartbeat:Wait()
            end
        end,
        findTarget = findBestTarget,
    })

    local dunkAnim = "rbxassetid://12296113986"
    local teleporting = false
    local lastTrack = nil
    setupAutoWhirlwindDunk = function()
        disc("dunk")
        if not st.autoWhirlwindDunk then return end
        cn.dunk = RunService.RenderStepped:Connect(function()
            local c = localPlayer.Character
            if not c or teleporting then return end
            local h = c:FindFirstChildWhichIsA("Humanoid")
            local hrp = c:FindFirstChild("HumanoidRootPart")
            if not h or not hrp then return end
            for _, v in ipairs(h:GetPlayingAnimationTracks()) do
                if v.Animation and v.Animation.AnimationId == dunkAnim then
                    if lastTrack == v then return end
                    lastTrack = v
                    teleporting = true
                    task.delay(1, function()
                        if hrp and hrp.Parent then hrp.CFrame = hrp.CFrame + Vector3.new(0, 70, 0) end
                        teleporting = false
                    end)
                    break
                end
            end
            if lastTrack and not lastTrack.IsPlaying then lastTrack = nil end
        end)
    end
end

el(T.Tech, "Paragraph", {Title = "Lethal Dash", Desc = "Lethal water into a dash", Image = "geist:arrow-up-down", ImageSize = 20, Color = Color3.fromHex(ACCENT2)})
el(T.Tech, "Toggle", {Title = "Enable LethalDash", Flag = "Save34", Value = false, Callback = cb(function(v) st.autoLockJump = v; lethal.setup() end)})
el(T.Tech, "Slider", {Title = "First flick delay", Flag = "Save35", Value = {Min = 0, Max = 10, Default = 1}, Callback = cb(function(v) st.lethalRemote = tonumber(v) end)})
el(T.Tech, "Slider", {Title = "Smoothness", Flag = "Save36", Value = {Min = 20, Max = 1000, Default = 300}, Callback = cb(function(v) st.lethalResp = tonumber(v) end)})
el(T.Tech, "Toggle", {Title = "Auto Lethal Dunk", Flag = "Save37", Value = false, Callback = cb(function(v) st.autoWhirlwindDunk = v; setupAutoWhirlwindDunk() end)})

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- KYOTO COMBO + AUTO HUNTER SURF  (kyoto fix: no longer touches mobile buttons)
---------------------------------------------------------------------
local startKyoto, stopKyoto, setupAutoSurf
do
    local K = {enabled = false, detected = false, running = false, watcher = nil, distance = 20, moveDur = 0.2, startDelay = 0.1, rotLock = 0.5}
    local DETECT_ANIM = "rbxassetid://12273188754"
    local KYOTO_ANIM = "rbxassetid://10480793962"

    local function move(hrp, fwd, right, dist, dur)
        if not hrp or not hrp.Parent then return end
        local p = hrp.Position + fwd * dist
        local cf = CFrame.new(p, p + right)
        if dur and dur > 0.05 then
            local tw = TweenService:Create(hrp, TweenInfo.new(dur, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {CFrame = cf})
            tw:Play()
            tw.Completed:Wait()
        end
        pcall(function() if hrp.Parent then hrp.CFrame = cf end end)
    end

    -- FIX: Kyoto no longer anchors, teleports wildly, or disables controls.
    -- Previous version was disabling AutoRotate + teleporting, which Roblox treats
    -- as a mobile touch reset. Now we only move the character, nothing else.
    local function doKyoto()
        if K.running then return end
        K.running = true
        local ok, err = pcall(function()
            local _, hum, hrp = getParts()
            if not hum then return end
            tapKey(Enum.KeyCode.One)
            for _, t in ipairs(hum:GetPlayingAnimationTracks()) do pcall(function() t:Stop() end) end
            local anim = Instance.new("Animation")
            anim.AnimationId = KYOTO_ANIM
            local track = hum:LoadAnimation(anim)
            pcall(function() track:Play() end)
            -- DO NOT touch hum.AutoRotate here (was causing mobile buttons to vanish)
            local lv = hrp.CFrame.LookVector
            local fwd = Vector3.new(lv.X, 0, lv.Z)
            if fwd.Magnitude == 0 then fwd = Vector3.new(0, 0, 1) end
            fwd = fwd.Unit
            local rv = hrp.CFrame.RightVector
            local right = Vector3.new(rv.X, 0, rv.Z)
            if right.Magnitude == 0 then right = Vector3.new(1, 0, 0) end
            right = right.Unit
            local done = false
            task.spawn(function()
                move(hrp, fwd, right, K.distance, K.moveDur)
                done = true
            end)
            tapKey(Enum.KeyCode.Two)
            while not done do RunService.Heartbeat:Wait() end
        end)
        if not ok then warn("[Selam0exe] Kyoto: " .. tostring(err)) end
        K.running = false
    end

    local function findTool(name)
        local bp = localPlayer:FindFirstChild("Backpack")
        if bp and bp:FindFirstChild(name) then return bp:FindFirstChild(name) end
        local c = localPlayer.Character
        if c and c:FindFirstChild(name) then return c:FindFirstChild(name) end
        return nil
    end

    local function waitAlive(sec)
        local t0 = tick()
        while tick() - t0 < sec do
            if not K.enabled then return false end
            RunService.Heartbeat:Wait()
        end
        return true
    end

    local function detector()
        if not K.enabled then return end
        local _, hum = getParts()
        if not hum then return end
        for _, v in pairs(hum:GetPlayingAnimationTracks()) do
            if v.Animation and v.Animation.AnimationId == DETECT_ANIM and not K.detected then
                K.detected = true
                task.delay(3, function() K.detected = false end)
                task.spawn(function()
                    if not waitAlive(1.5) then return end
                    local tool = findTool("Lethal Whirlwind Stream")
                    if not waitAlive(K.startDelay) then return end
                    if tool then
                        local c = localPlayer.Character
                        local comm = c and c:FindFirstChild("Communicate")
                        if comm then pcall(function() comm:FireServer({Tool = tool, Goal = "Console Move"}) end) end
                    end
                    if K.enabled and not K.running then doKyoto() end
                end)
                break
            end
        end
    end

    startKyoto = function()
        disc("kyoto")
        K.enabled = true
        cn.kyoto = RunService.Heartbeat:Connect(detector)
    end
    stopKyoto = function()
        disc("kyoto")
        if K.watcher then K.watcher:Disconnect(); K.watcher = nil end
        K.enabled = false
    end

    local surfAnim = "rbxassetid://12309835105"
    local tweening = false
    setupAutoSurf = function()
        disc("surf")
        if not st.autoSurf then return end
        cn.surf = RunService.RenderStepped:Connect(function()
            if tweening then return end
            local _, hum, hrp = getParts()
            if not hum then return end
            local playing = false
            for _, v in ipairs(hum:GetPlayingAnimationTracks()) do
                if v.Animation and v.Animation.AnimationId == surfAnim then playing = true; break end
            end
            if playing then
                tweening = true
                task.spawn(function()
                    task.wait(0.6)
                    local _, _, r = getParts()
                    if r then
                        r.Anchored = false
                        TweenService:Create(r, TweenInfo.new(0.78), {CFrame = r.CFrame + r.CFrame.LookVector.Unit * 50}):Play()
                        task.wait(1.5)
                    end
                    tweening = false
                end)
            end
        end)
    end

    el(T.Tech, "Paragraph", {Title = "Auto Kyoto tech!", Desc = "Flowing water into lethal", Image = "lucide:step-forward", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
    el(T.Tech, "Toggle", {Title = "Auto Kyoto", Flag = "Save29", Value = false, Callback = cb(function(v)
        if v then startKyoto() else stopKyoto() end
    end)})
    el(T.Tech, "Slider", {Title = "Distance", Flag = "Save30", Value = {Min = 0, Max = 50, Default = 20}, Callback = cb(function(v) K.distance = math.floor(tonumber(v) or 20) end)})
    el(T.Tech, "Slider", {Title = "Delay", Flag = "Save31", Value = {Min = 1, Max = 1000, Default = 100}, Callback = cb(function(v) K.startDelay = (tonumber(v) or 0) / 1000 end)})
    el(T.Tech, "Toggle", {Title = "Auto Hunter Surf", Flag = "Save32", Value = false, Callback = cb(function(v) st.autoSurf = v; setupAutoSurf() end)})
end

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- KITTY TECH
---------------------------------------------------------------------
local hookKitty
do
    local kt = {
        enabled = false, dashDelayBefore = 0.01, postDashWait = 0.06, cooldownTime = 4.8,
        orbitRadius = 3, orbitHeight = 1, spinDuration = 0.6, lockStart = 0.26, lockDuration = 0.35,
        targetDistance = 12, attachmentDuration = 0.5, pingMs = 60,
    }
    local function pingToWait(ms)
        local v = math.clamp(ms or 60, 10, 600)
        return math.clamp(v / 1000 * 1.3, 0.03, 0.22)
    end
    kt.postDashWait = pingToWait(kt.pingMs)

    local ap, ao, conn, part
    local flag = false

    local function cleanup()
        if ap then ap:Destroy(); ap = nil end
        if ao then ao:Destroy(); ao = nil end
        if conn then conn:Disconnect(); conn = nil end
        if part then part:Destroy(); part = nil end
        local c = localPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, ch in ipairs(hrp:GetChildren()) do
                if ch:IsA("Attachment") or ch.Name == "HasSnapped" then ch:Destroy() end
            end
        end
    end

    local function attach(target)
        cleanup()
        local _, _, hrp = getParts()
        if not target or not hrp then return end
        part = Instance.new("Part")
        part.Size = Vector3.new(0.5, 0.5, 0.5)
        part.Transparency = 1
        part.Anchored = true
        part.CanCollide = false
        part.Name = "KittyFollowPart"
        part.Parent = Workspace
        local a1 = Instance.new("Attachment", hrp)
        local a2 = Instance.new("Attachment", part)
        local a3 = Instance.new("Attachment", hrp)
        local a4 = Instance.new("Attachment", part)
        ap = Instance.new("AlignPosition")
        ap.Attachment0 = a1
        ap.Attachment1 = a2
        ap.RigidityEnabled = true
        ap.Responsiveness = 200
        ap.MaxForce = math.huge
        ap.Parent = hrp
        ao = Instance.new("AlignOrientation")
        ao.Attachment0 = a3
        ao.Attachment1 = a4
        ao.RigidityEnabled = true
        ao.Responsiveness = 200
        ao.MaxTorque = math.huge
        ao.Parent = hrp
        local elapsed = 0
        conn = RunService.RenderStepped:Connect(function(dt)
            local _, _, r = getParts()
            if target and target.Parent and r and part then
                elapsed = elapsed + dt
                if not kt.enabled then cleanup() return end
                local center = target.Position + Vector3.new(0, kt.orbitHeight, 0)
                local ang = math.rad(360) * (elapsed / kt.spinDuration)
                local pos = center + Vector3.new(math.cos(ang) * kt.orbitRadius, 0, math.sin(ang) * kt.orbitRadius)
                part.CFrame = CFrame.new(pos, target.Position)
                if not r:FindFirstChild("HasSnapped") then
                    r.CFrame = CFrame.new(pos, target.Position)
                    local b = Instance.new("BoolValue")
                    b.Name = "HasSnapped"
                    b.Parent = r
                end
                if kt.lockStart <= elapsed and elapsed <= kt.lockStart + kt.lockDuration then
                    part.CFrame = CFrame.new(r.Position, target.Position)
                end
                return
            end
            cleanup()
        end)
    end

    local function findNearTarget()
        local _, _, hrp = getParts()
        if not hrp then return nil end
        local best, bd = nil, kt.targetDistance
        for _, d in ipairs(Workspace:GetDescendants()) do
            if d:IsA("Model") and d ~= localPlayer.Character then
                local h = d:FindFirstChildOfClass("Humanoid")
                local torso = d:FindFirstChild("HumanoidRootPart") or d:FindFirstChild("Torso") or d:FindFirstChild("UpperTorso")
                if h and h.Health > 0 and torso then
                    local m = (hrp.Position - torso.Position).Magnitude
                    if m < bd then bd = m; best = torso end
                end
            end
        end
        return best
    end

    local function onAnim(track)
        if not kt.enabled or flag then return end
        local id = numId(track.Animation.AnimationId)
        if DASH_CD_IDS[id] then
            flag = true
            task.delay(kt.cooldownTime, function() flag = false end)
            return
        end
        if UPPERCUT_IDS[id] then
            flag = true
            task.delay(kt.dashDelayBefore, function()
                local t = findNearTarget()
                if t then
                    task.wait(kt.postDashWait)
                    tapKey(Enum.KeyCode.Q)
                    attach(t)
                    task.delay(kt.attachmentDuration, cleanup)
                end
            end)
            task.delay(kt.cooldownTime, function() flag = false end)
        end
    end

    hookKitty = function(char)
        disc("kitty")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then cn.kitty = hum.AnimationPlayed:Connect(onAnim) end
    end

    el(T.Tech, "Paragraph", {Title = "Kitty Tech", Desc = "Made by ItzSoph - credits to him! (W.I.P)", Image = "swords", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
    el(T.Tech, "Toggle", {Title = "Enable Kitty Tech", Flag = "Save1", Value = false, Callback = cb(function(v)
        kt.enabled = v
        if v then hookKitty(localPlayer.Character) else disc("kitty"); cleanup() end
    end)})
    local presets = {["10ms (LAN)"] = 10, ["40ms (Good)"] = 40, ["60ms (Default)"] = 60, ["100ms (High)"] = 100, ["200ms (Very High)"] = 200}
    el(T.Tech, "Dropdown", {Title = "Ping Preset", Flag = "Save2", Values = {"10ms (LAN)", "40ms (Good)", "60ms (Default)", "100ms (High)", "200ms (Very High)"}, Value = "60ms (Default)", Callback = cb(function(v)
        kt.pingMs = presets[v] or 60
        kt.postDashWait = pingToWait(kt.pingMs)
    end)})
    el(T.Tech, "Slider", {Title = "Custom Ping (ms)", Flag = "Save3", Value = {Min = 10, Max = 400, Default = 60}, Callback = cb(function(v)
        kt.pingMs = tonumber(v)
        kt.postDashWait = pingToWait(kt.pingMs)
    end)})
    el(T.Tech, "Paragraph", {Title = "Sorry !", Desc = "Other configs will come in future updates !", Image = "lucide:sad", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
end

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- M1 RESET / TWISTED
---------------------------------------------------------------------
local setupNoEndLag, setupAutoTwisted
do
    setupNoEndLag = function()
        disc("noEndLag")
        if not st.noEndLag then return end
        local _, hum = getParts()
        if not hum then return end
        cn.noEndLag = hum.AnimationPlayed:Connect(function(track)
            if not st.noEndLag then return end
            local p = track.Priority
            if p == Enum.AnimationPriority.Action or p == Enum.AnimationPriority.Action2 or p == Enum.AnimationPriority.Action3 or p == Enum.AnimationPriority.Action4 then
                local len = track.Length
                if len and len > 0 then
                    task.delay(len * 0.85 / math.max(track.Speed, 0.1), function()
                        if st.noEndLag and track.IsPlaying then pcall(function() track:Stop(0.1) end) end
                    end)
                end
            end
        end)
    end

    local twAnim = "rbxassetid://13294471966"
    local twCd = false
    setupAutoTwisted = function()
        disc("twisted")
        disc("twistedChar")
        if not st.autoTwisted then return end
        local function bind()
            local _, hum = getParts()
            if not hum then return end
            disc("twisted")
            cn.twisted = hum.AnimationPlayed:Connect(function(track)
                if not st.autoTwisted or twCd then return end
                if track.Animation and track.Animation.AnimationId == twAnim then
                    twCd = true
                    task.delay(0.23, function()
                        if not st.autoTwisted then return end
                        local _, _, hrp = getParts()
                        if hrp then hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, 3.4) end
                        fireDash(localPlayer.Character)
                    end)
                    task.delay(5, function() twCd = false end)
                end
            end)
        end
        bind()
        cn.twistedChar = localPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            if st.autoTwisted then bind() end
        end)
    end
end

el(T.Tech, "Paragraph", {Title = "M1 Reset", Desc = "M1 reset + no end lag", Image = "geist:clock-dashed", ImageSize = 20, Color = Color3.fromHex(ACCENT2)})
el(T.Tech, "Button", {Title = "Execute M1 Reset Script", Icon = "zap", Callback = cb(function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-M1-Reset-46548"))()
end)})
el(T.Tech, "Toggle", {Title = "No End Lag", Flag = "Save38", Value = false, Callback = cb(function(v) st.noEndLag = v; setupNoEndLag() end)})

el(T.Tech, "Divider", {})

el(T.Tech, "Paragraph", {Title = "Instant Twisted", Desc = "4m1 into a dash", Image = "lucide:corner-up-right", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
el(T.Tech, "Toggle", {Title = "Enable Instant Twisted", Value = false, Callback = cb(function(v)
    st.instantTwisted = v
    if v then
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Cyborg883/InstantTwistedRevamp/main/Protected_7455521176683315.lua"))()
        end)
    end
end)})
el(T.Tech, "Toggle", {Title = "Normal twisted", Flag = "Save39", Value = false, Callback = cb(function(v) st.autoTwisted = v; setupAutoTwisted() end)})

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- AUTO BLOCK
---------------------------------------------------------------------
do
    local ab = {enabled = false, m1 = false, dist = 20}
    local set14, set15, set16 = {}, {[10479335397] = true, [13380255751] = true, [134775406437626] = true}, {}
    for _, id in ipairs({10469493270, 10469630950, 10469639222, 10469643643, 13532562418, 13532600125, 13532604085, 13294471966, 13491635433, 13296577783, 13295919399, 13295936866, 13370310513, 13390230973, 13378751717, 13378708199, 14004222985, 13997092940, 14001963401, 14136436157, 15259161390, 15240216931, 15240176873, 15162694192, 16515503507, 16515520431, 16515448089, 16552234590, 17889458563, 17889461810, 17889471098, 17889290569, 123005629431309, 100059874351664, 104895379416342}) do
        set14[id] = true
    end
    for _, id in ipairs({10468665991, 10466974800, 10471336737, 12510170988, 12272894215, 12296882427, 12307656616, 101588604872680, 105442749844047, 109617620932970, 131820095363270, 135289891173395, 125955606488863, 12534735382, 12502664044, 12509505723, 12618271998, 12684390285, 13376869471, 13294790250, 13376962659, 13501296372, 13556985475, 145162735010, 14046756619, 14299135500, 14351441234, 15290930205, 15145462680, 15295895753, 15295336270, 16139108718, 16515850153, 16431491215, 16597322398, 16597912086, 17799224866, 17838006839, 17857788598, 18179181663, 113166426814229, 116753755471636, 116153572280464, 114095570398448, 77509627104305}) do
        set16[id] = true
    end

    local last = {}
    local m1flag = false

    local function block(duration, long)
        local char = localPlayer.Character
        local comm = char and char:FindFirstChild("Communicate")
        if not comm then return end
        comm:FireServer({Goal = "KeyPress", Key = Enum.KeyCode.F})
        if long then task.wait(0.35) else task.wait(duration - 0.0001) end
        comm:FireServer({Goal = "KeyRelease", Key = Enum.KeyCode.F})
        if ab.m1 and not m1flag then
            m1flag = true
            task.spawn(function()
                comm:FireServer({Goal = "LeftClick", Mobile = true})
                task.wait(0.3)
                comm:FireServer({Goal = "LeftClickRelease", Mobile = true})
                task.wait(0.55)
                m1flag = false
            end)
        end
    end

    local function start()
        disc("autoBlock")
        cn.autoBlock = RunService.Heartbeat:Connect(function()
            if not ab.enabled then return end
            local char = localPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            local live = Workspace:FindFirstChild("Live")
            if not hrp or not head or not live then return end
            for _, m in ipairs(live:GetChildren()) do
                if m:IsA("Model") and m ~= char then
                    local hum = m:FindFirstChildOfClass("Humanoid")
                    local r = m:FindFirstChild("HumanoidRootPart")
                    if hum and r and head.CFrame.LookVector:Dot((r.Position - head.Position).Unit) > 0.6 then
                        local mag = (hrp.Position - r.Position).Magnitude
                        if mag <= ab.dist then
                            for _, tr in ipairs(hum:GetPlayingAnimationTracks()) do
                                local id = tr.Animation and tonumber(numId(tr.Animation.AnimationId))
                                if id then
                                    local key = m.Name .. "_" .. id
                                    if set16[id] then
                                        if not last[key] or tick() - last[key] >= 1.1 then
                                            last[key] = tick()
                                            task.spawn(block, 1.1, set15[id] and true or false)
                                        end
                                    elseif set15[id] or set14[id] then
                                        if not last[key] or tick() - last[key] >= 0.6 then
                                            last[key] = tick()
                                            task.spawn(block, 0.6, set15[id] and true or false)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end

    el(T.Tech, "Paragraph", {Title = "AutoBlock (W.I.P)", Desc = "Automatically blocks stuff", Image = "shield", ImageSize = 20, Color = Color3.fromHex(ACCENT2)})
    el(T.Tech, "Toggle", {Title = "Enable AutoBlock", Flag = "Save4", Value = false, Callback = cb(function(v)
        ab.enabled = v
        if v then start() else disc("autoBlock") end
    end)})
    el(T.Tech, "Toggle", {Title = "M1 After Block", Flag = "Save5", Value = false, Callback = cb(function(v) ab.m1 = v end)})
    el(T.Tech, "Slider", {Title = "Block Distance (studs)", Flag = "Save6", Value = {Min = 5, Max = 30, Default = 20}, Callback = cb(function(v) ab.dist = tonumber(v) end)})
end

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- KIBA
---------------------------------------------------------------------
local setupYOYO, yoyoDetach
do
    local ap, ao, rconn, part
    local cooldown = false

    yoyoDetach = function()
        if ap then ap:Destroy(); ap = nil end
        if ao then ao:Destroy(); ao = nil end
        if rconn then rconn:Disconnect(); rconn = nil end
        if part then part:Destroy(); part = nil end
        local c = localPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, ch in ipairs(hrp:GetChildren()) do
                if ch:IsA("Attachment") or ch.Name == "HasSnapped" then ch:Destroy() end
            end
        end
    end

    local function attach(target)
        yoyoDetach()
        local _, _, hrp = getParts()
        if not hrp then return end
        part = Instance.new("Part")
        part.Size = Vector3.new(0.5, 0.5, 0.5)
        part.Transparency = 1
        part.Anchored = true
        part.CanCollide = false
        part.Name = "YOYOFollowPart"
        part.Parent = Workspace
        local a1 = Instance.new("Attachment", hrp)
        local a2 = Instance.new("Attachment", part)
        local a3 = Instance.new("Attachment", hrp)
        local a4 = Instance.new("Attachment", part)
        ap = Instance.new("AlignPosition")
        ap.Attachment0 = a1
        ap.Attachment1 = a2
        ap.RigidityEnabled = true
        ap.Responsiveness = 200
        ap.MaxForce = math.huge
        ap.Parent = hrp
        ao = Instance.new("AlignOrientation")
        ao.Attachment0 = a3
        ao.Attachment1 = a4
        ao.RigidityEnabled = true
        ao.Responsiveness = 200
        ao.MaxTorque = math.huge
        ao.Parent = hrp
        rconn = RunService.RenderStepped:Connect(function()
            if st.yoyo and target and target.Parent and part then
                if localPlayer.Character and hrp.Parent then
                    local offset = target.CFrame * CFrame.Angles(math.rad(85), 0, 0)
                    part.CFrame = offset
                    if not hrp:FindFirstChild("HasSnapped") then
                        hrp.CFrame = offset
                        local b = Instance.new("BoolValue")
                        b.Name = "HasSnapped"
                        b.Parent = hrp
                    end
                    return
                end
            end
            yoyoDetach()
        end)
    end

    local function onAnim(track)
        if not st.yoyo or cooldown then return end
        local id = numId(track.Animation.AnimationId)
        if DASH_CD_IDS[id] then
            cooldown = true
            task.delay(4.8, function() cooldown = false end)
        elseif UPPERCUT_IDS[id] then
            cooldown = true
            task.delay(0.32, function()
                if not st.yoyo then return end
                fireDash(localPlayer.Character)
                local t = findBestTarget(st.yoyoDistanceLimit)
                if t then
                    attach(t)
                    task.delay(0.5, yoyoDetach)
                end
            end)
            task.delay(4.8, function() cooldown = false end)
        end
    end

    setupYOYO = function(char)
        disc("yoyo")
        yoyoDetach()
        if not st.yoyo or not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then cn.yoyo = hum.AnimationPlayed:Connect(onAnim) end
    end
end

el(T.Tech, "Paragraph", {Title = "Kiba Tech", Desc = "dash and look up", Image = "lucide:crosshair", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
el(T.Tech, "Toggle", {Title = "Enable Kiba Tech", Flag = "Save42", Value = false, Callback = cb(function(v)
    st.yoyo = v
    if v then setupYOYO(localPlayer.Character) else disc("yoyo"); yoyoDetach() end
end)})

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- AUTO COUNTER
---------------------------------------------------------------------
do
    local flags = {}
    local ids1 = {["rbxassetid://10479335397"] = true, ["rbxassetid://13380255751"] = true, ["rbxassetid://134775406437626"] = true}
    local ids2 = {["rbxassetid://10469493270"] = true, ["rbxassetid://10469630950"] = true, ["rbxassetid://10469639222"] = true, ["rbxassetid://10469643643"] = true}

    local function counter()
        local bp = localPlayer.Backpack
        local char = localPlayer.Character
        local comm = char and char:FindFirstChild("Communicate")
        if not bp or not comm then return end
        local a = bp:FindFirstChild("Prey's Peril")
        if a then comm:FireServer({Tool = a, Goal = "Console Move"}) end
        local b = bp:FindFirstChild("Split Second Counter")
        if b then comm:FireServer({Tool = b, Goal = "Console Move"}) end
    end

    local function setup()
        disc("autoCounter")
        cn.autoCounter = RunService.Heartbeat:Connect(function()
            if not st.autoCounter then return end
            local char, _, hrp = getParts()
            local live = Workspace:FindFirstChild("Live")
            if not hrp or not live then return end
            for _, m in ipairs(live:GetChildren()) do
                local mh = m:IsA("Model") and m ~= char and m:FindFirstChild("HumanoidRootPart")
                if mh then
                    local hum = m:FindFirstChildOfClass("Humanoid")
                    local animator = hum and hum:FindFirstChildOfClass("Animator")
                    if animator then
                        for _, tr in pairs(animator:GetPlayingAnimationTracks()) do
                            local id = tr.Animation.AnimationId
                            local key = m.Name .. id
                            local near = (hrp.Position - mh.Position).Magnitude <= cfg.autoCounterDistance
                            if (ids1[id] or ids2[id]) and near then
                                if not flags[key] then
                                    flags[key] = true
                                    if ids1[id] then task.delay(0.0001, counter) else counter() end
                                end
                            else
                                flags[key] = nil
                            end
                        end
                    end
                end
            end
        end)
    end

    el(T.Tech, "Paragraph", {Title = "Auto Counter", Desc = "Automatically counter attacks", Image = "lucide:shield", ImageSize = 20, Color = Color3.fromHex(ACCENT2)})
    el(T.Tech, "Toggle", {Title = "Enable Feature", Flag = "Save40", Value = false, Callback = cb(function(v)
        st.autoCounter = v
        if v then setup() else disc("autoCounter") end
    end)})
    el(T.Tech, "Slider", {Title = "Counter Distance", Flag = "Save41", Value = {Min = 5, Max = 20, Default = 13}, Callback = cb(function(v) cfg.autoCounterDistance = tonumber(v) end)})
end

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- HITBOX ABUSE
---------------------------------------------------------------------
do
    local hb = {Enabled = false, Angle = 45, Duration = 50, Delay = 0, SilentLock = false, Show = false, Color = Color3.fromHex(ACCENT)}
    local vis = {part = nil, box = nil, conn = nil}

    local function rotateAndCam(angle)
        local c = localPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local h = c:FindFirstChildOfClass("Humanoid")
        local ar = h and h.AutoRotate
        if h then h.AutoRotate = false end
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(angle), 0)
        local cam = Workspace.CurrentCamera
        if cam then
            local pos = cam.CFrame.Position
            local n = pos - hrp.Position
            local flat = Vector3.new(n.X, 0, n.Z)
            local rot = CFrame.fromAxisAngle(Vector3.yAxis, math.rad(angle)) * flat
            local np = hrp.Position + rot
            cam.CFrame = CFrame.lookAt(Vector3.new(np.X, pos.Y, np.Z), hrp.Position)
        end
        if h then
            task.delay(hb.Duration / 1000, function()
                if h and h.Parent then h.AutoRotate = ar end
            end)
        end
    end

    local function silentLock()
        local c = localPlayer.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local h = c:FindFirstChildOfClass("Humanoid")
        local ar = h and h.AutoRotate
        if h then h.AutoRotate = false end
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(hb.Angle), 0)
        if h then
            task.delay(hb.Duration / 1000, function()
                if h and h.Parent then
                    h.AutoRotate = ar
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(-hb.Angle), 0)
                end
            end)
        end
    end

    local function setInput()
        disc("hitboxInput")
        if not hb.Enabled then return end
        cn.hitboxInput = UserInputService.InputBegan:Connect(function(input, gp)
            if not hb.Enabled or gp then return end
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                task.wait(hb.Delay / 1000)
                if hb.SilentLock then
                    silentLock()
                else
                    rotateAndCam(hb.Angle)
                    task.delay(hb.Duration / 1000, function() rotateAndCam(-hb.Angle) end)
                end
            end
        end)
    end

    local function clearVisual()
        if vis.conn then vis.conn:Disconnect(); vis.conn = nil end
        if vis.box then vis.box:Destroy(); vis.box = nil end
        if vis.part then vis.part:Destroy(); vis.part = nil end
    end

    local function showVisual()
        clearVisual()
        if not hb.Show then return end
        local part = Instance.new("Part")
        part.Name = "ScriptSimpleHitboxVisual_HitboxAbuse"
        part.Size = Vector3.new(8, 5, 8)
        part.Transparency = 1
        part.Anchored = true
        part.CanCollide = false
        part.Parent = Workspace
        vis.part = part
        local sb = Instance.new("SelectionBox")
        sb.Adornee = part
        sb.LineThickness = 0.05
        sb.Color3 = hb.Color
        sb.Transparency = 0.5
        sb.Parent = part
        vis.box = sb
        local offset = CFrame.new(0, 0, -(part.Size.Z / 2 - 1))
        vis.conn = RunService.RenderStepped:Connect(function()
            local _, _, hrp = getParts()
            if hb.Show and hrp and part.Parent then
                part.CFrame = hrp.CFrame * offset
                sb.Color3 = hb.Color
            else
                clearVisual()
            end
        end)
    end

    el(T.Tech, "Paragraph", {Title = "Hitbox Abuse", Desc = "Hitbox tools", Image = "geist:box", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
    el(T.Tech, "Toggle", {Title = "Enable ", Flag = "Save7", Value = false, Callback = cb(function(v) hb.Enabled = v; setInput() end)})
    el(T.Tech, "Toggle", {Title = "Silent Lock", Flag = "Save8", Value = false, Callback = cb(function(v) hb.SilentLock = v end)})
    el(T.Tech, "Toggle", {Title = "Simple Show Hitbox", Flag = "Save9", Value = false, Callback = cb(function(v) hb.Show = v; showVisual() end)})
    el(T.Tech, "Colorpicker", {Title = "Hitbox Color", Desc = "Pick a color for the hitbox outline", Default = hb.Color, Callback = cb(function(c)
        local col = toColor(c)
        if col then hb.Color = col end
    end)})
    el(T.Tech, "Slider", {Title = "Angle (degrees)", Flag = "Save10", Value = {Min = 0, Max = 180, Default = 45}, Callback = cb(function(v) hb.Angle = v end)})
    el(T.Tech, "Slider", {Title = "Duration (ms)", Flag = "Save11", Value = {Min = 10, Max = 500, Default = 50}, Callback = cb(function(v) hb.Duration = v end)})
    el(T.Tech, "Slider", {Title = "Delay (ms)", Flag = "Save12", Value = {Min = 0, Max = 200, Default = 0}, Callback = cb(function(v) hb.Delay = v end)})
end

el(T.Tech, "Divider", {})

---------------------------------------------------------------------
-- TECH HELPER
---------------------------------------------------------------------
local setupTechHelper, setupFastDash
do
    setupTechHelper = function()
        disc("techHelper")
        if not st.techHelper then return end
        local _, hum = getParts()
        if not hum then return end
        cn.techHelper = hum.AnimationPlayed:Connect(function(track)
            local id = numId(track.Animation and track.Animation.AnimationId)
            if not st.techHelper or not id or not UPPERCUT_IDS[id] then return end
            task.delay(cfg.techHelperDelay, function()
                if not st.techHelper or not cfg.techHelperLookUp then return end
                local cam = Workspace.CurrentCamera
                if not cam then return end
                local t0 = tick()
                local c
                c = RunService.RenderStepped:Connect(function()
                    if tick() - t0 >= cfg.techHelperHold then c:Disconnect(); return end
                    local cf = cam.CFrame
                    local lv = cf.LookVector
                    local up = CFrame.new(cf.Position, cf.Position + Vector3.new(lv.X, 1.5, lv.Z))
                    cam.CFrame = cf:Lerp(up, cfg.techHelperLockPercent / 100)
                end)
            end)
        end)
    end

    local holding, detecting = false, false
    local function mouseHold(down)
        local cam = Workspace.CurrentCamera
        if not cam then return end
        local c = cam.ViewportSize / 2
        pcall(function() VIM:SendMouseButtonEvent(c.X, c.Y, 0, down, game, 0) end)
    end
    local function holdForMs(ms)
        if holding then return end
        holding = true
        mouseHold(true)
        task.delay(ms / 1000, function()
            mouseHold(false)
            holding = false
        end)
    end
    local function detectAny()
        local char, _, hrp = getParts()
        if not hrp then return false end
        local range = st.m1Range
        local box = Vector3.new(4, 4, range)
        local cf = hrp.CFrame * CFrame.new(0, 0, -(range / 2))
        local op = OverlapParams.new()
        op.FilterType = Enum.RaycastFilterType.Exclude
        op.FilterDescendantsInstances = {char}
        for _, p in ipairs(Workspace:GetPartBoundsInBox(cf, box, op)) do
            local m = p:FindFirstAncestorOfClass("Model")
            local h = m and m:FindFirstChildOfClass("Humanoid")
            local r = m and m:FindFirstChild("HumanoidRootPart")
            if h and r and h.Health > 0 then
                local predicted = r.Position + r.Velocity * (st.m1Pred / 100)
                local rel = hrp.CFrame:PointToObjectSpace(predicted)
                if rel.Z < 0 and math.abs(rel.X) <= box.X / 2 and math.abs(rel.Y) <= box.Y / 2 and math.abs(rel.Z) <= box.Z / 2 then
                    return true
                end
            end
        end
        return false
    end
    local function setupM1Catch(on)
        disc("m1Catch")
        detecting = false
        if not on then return end
        cn.m1Catch = RunService.Heartbeat:Connect(function()
            local v = detectAny()
            if v and not detecting and not holding then
                detecting = true
                holdForMs(st.m1Hold)
            end
            if not v then detecting = false end
        end)
    end

    setupFastDash = function(char)
        disc("fastDash")
        if not st.fastDash or not char then return end
        local h = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not h or not hrp then return end
        local fastIds = {["10480796021"] = true, ["10480793962"] = true}
        cn.fastDash = h.AnimationPlayed:Connect(function(track)
            local match = track.Animation and numId(track.Animation.AnimationId)
            if not match or not fastIds[match] then return end
            local side = match == "10480796021" and -1 or 1
            local dir = hrp.CFrame.RightVector * side
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Velocity = dir * 250
            bv.MaxForce = Vector3.new(1e5, 0, 1e5)
            task.delay(0.25, function() if bv then bv:Destroy() end end)
            hrp.CFrame = hrp.CFrame + dir * 5
        end)
    end

    local function setTorso(on)
        disc("torso")
        if not on then return end
        cn.torso = RunService.Stepped:Connect(function()
            local function apply(model)
                for _, d in ipairs(model:GetDescendants()) do
                    if d:IsA("BasePart") then
                        d.CanCollide = string.find(string.lower(d.Name), "torso") ~= nil
                    end
                end
            end
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= localPlayer and plr.Character then apply(plr.Character) end
            end
            local live = Workspace:FindFirstChild("Live")
            local dummy = live and live:FindFirstChild("Weakest Dummy")
            if dummy then apply(dummy) end
        end)
    end

    local mdCd = false
    local function setMouseDash(on)
        disc("mouseDash")
        if not on then return end
        cn.mouseDash = UserInputService.InputBegan:Connect(function(input, gp)
            if gp or not st.mouseDash or mdCd then return end
            if input.KeyCode ~= Enum.KeyCode.Q then return end
            mdCd = true
            task.delay(st.mouseDashDelay / 1000, function() mdCd = false end)
            task.delay(0.03, function()
                local _, _, hrp = getParts()
                local hit = localPlayer:GetMouse().Hit
                if hrp and hit then
                    hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(hit.X, hrp.Position.Y, hit.Z))
                end
            end)
        end)
    end

    el(T.Tech, "Paragraph", {Title = "Tech Helper", Desc = "helps with techs", Image = "lucide:hand-helping", ImageSize = 20, Color = Color3.fromHex(ACCENT2)})
    el(T.Tech, "Toggle", {Title = "Enable Feature", Flag = "Save43", Value = false, Callback = cb(function(v) st.techHelper = v; setupTechHelper() end)})
    el(T.Tech, "Slider", {Title = "Tech Helper Delay (ms)", Flag = "Save44", Value = {Min = 100, Max = 500, Default = 300}, Callback = cb(function(v) cfg.techHelperDelay = tonumber(v) / 1000 end)})
    el(T.Tech, "Slider", {Title = "Tech Helper Hold (ms)", Flag = "Save45", Value = {Min = 50, Max = 500, Default = 150}, Callback = cb(function(v) cfg.techHelperHold = tonumber(v) / 1000 end)})
    el(T.Tech, "Toggle", {Title = "Tech Helper Look Up", Flag = "Save46", Value = true, Callback = cb(function(v) cfg.techHelperLookUp = v end)})
    el(T.Tech, "Slider", {Title = "Tech Helper Lock Percentage", Flag = "Save46b", Value = {Min = 0, Max = 100, Default = 50}, Callback = cb(function(v) cfg.techHelperLockPercent = tonumber(v) end)})
    el(T.Tech, "Divider", {})
    el(T.Tech, "Toggle", {Title = "Enable M1 Catch", Flag = "Save47", Value = false, Callback = cb(function(v) st.m1Catch = v; setupM1Catch(v) end)})
    el(T.Tech, "Slider", {Title = "M1 Catch Range (studs)", Flag = "Save48", Value = {Min = 2, Max = 20, Default = 13}, Callback = cb(function(v) st.m1Range = tonumber(v) end)})
    el(T.Tech, "Slider", {Title = "M1 Catch Hold (ms)", Flag = "Save49", Value = {Min = 10, Max = 1000, Default = 200}, Callback = cb(function(v) st.m1Hold = tonumber(v) end)})
    el(T.Tech, "Slider", {Title = "M1 Catch Prediction %", Flag = "Save50", Value = {Min = 0, Max = 100, Default = 0}, Callback = cb(function(v) st.m1Pred = tonumber(v) end)})
    el(T.Tech, "Divider", {})
    el(T.Tech, "Toggle", {Title = "Fast Dash", Flag = "Save51", Desc = "NOT COMPATIBLE WITH MOST FEATURES", Value = false, Callback = cb(function(v) st.fastDash = v; setupFastDash(localPlayer.Character) end)})
    el(T.Tech, "Toggle", {Title = "Only Torso Collisions", Flag = "Save52", Value = false, Callback = cb(function(v) st.onlyTorsoCollisions = v; setTorso(v) end)})
    el(T.Tech, "Divider", {})
    el(T.Tech, "Toggle", {Title = "Enable MouseDash", Flag = "Save53", Value = false, Callback = cb(function(v) st.mouseDash = v; setMouseDash(v) end)})
    el(T.Tech, "Slider", {Title = "MouseDash Delay (ms)", Flag = "Save54", Value = {Min = 500, Max = 3000, Default = 500}, Callback = cb(function(v) st.mouseDashDelay = tonumber(v) end)})
end

---------------------------------------------------------------------
-- NEW: CHEATS TAB  (camlock, closest player, speed, jump, fly, etc.)
---------------------------------------------------------------------
do
    -- Camlock
    local camlockThread = nil
    local function stopCamlock()
        st.camlock = false
        st.camlockTarget = nil
        if camlockThread then
            pcall(function() camlockThread:Disconnect() end)
            camlockThread = nil
        end
        local char, hum = getParts()
        if hum then
            local cam = Workspace.CurrentCamera
            if cam then cam.CameraSubject = hum end
        end
    end
    local function startCamlock()
        stopCamlock()
        st.camlock = true
        camlockThread = RunService.RenderStepped:Connect(function()
            if not st.camlock then
                if camlockThread then camlockThread:Disconnect(); camlockThread = nil end
                return
            end
            local char, hum = getParts()
            local cam = Workspace.CurrentCamera
            if not char or not cam then return end
            local target = st.camlockTarget
            if not target or not target.Parent then
                -- auto-pick closest player
                local best, bd = nil, math.huge
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= localPlayer and p.Character then
                        local r = p.Character:FindFirstChild("HumanoidRootPart")
                        local h = p.Character:FindFirstChildOfClass("Humanoid")
                        if r and h and h.Health > 0 then
                            local d = (hrp.Position - r.Position).Magnitude
                            if d < bd then bd = d; best = r end
                        end
                    end
                end
                target = best
            end
            if target and target.Parent then
                local camPos = cam.CFrame.Position
                cam.CFrame = CFrame.new(camPos, target.Position)
            end
        end)
    end

    el(T.Cheats, "Paragraph", {Title = "Camlock", Desc = "Locks your camera onto the closest player", Image = "lucide:crosshair", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
    el(T.Cheats, "Toggle", {Title = "Enable Camlock", Flag = "SaveCamlock", Value = false, Callback = cb(function(v)
        if v then startCamlock() else stopCamlock() end
    end)})
    el(T.Cheats, "Dropdown", {
        Title = "Camlock Target",
        Desc = "Pick who to lock on",
        Values = {"Closest Player", "Any", "None"},
        Value = "Closest Player",
        Callback = cb(function(v)
            if v == "Closest Player" or v == "None" then
                st.camlockTarget = nil
            end
        end)
    })

    el(T.Cheats, "Divider", {})

    -- Closest Player Info
    el(T.Cheats, "Paragraph", {Title = "Closest Player", Desc = "Shows info on the nearest player", Image = "lucide:users", ImageSize = 20, Color = Color3.fromHex(ACCENT2)})
    el(T.Cheats, "Toggle", {Title = "Show Closest Player", Flag = "SaveClosestPlayer", Value = false, Callback = cb(function(v)
        st.closestPlayer = v
        disc("closestPlayer")
        if not v then return end
        cn.closestPlayer = RunService.Heartbeat:Connect(function()
            if not st.closestPlayer then return end
            local char, _, hrp = getParts()
            if not hrp then return end
            local best, bd = nil, math.huge
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= localPlayer and p.Character then
                    local r = p.Character:FindFirstChild("HumanoidRootPart")
                    local h = p.Character:FindFirstChildOfClass("Humanoid")
                    if r and h and h.Health > 0 then
                        local d = (hrp.Position - r.Position).Magnitude
                        if d < bd then bd = d; best = {p = p, d = d, h = h} end
                    end
                end
            end
            if best then
                print(string.format("[Selam0exe] Closest: %s | Distance: %.1f | HP: %d", best.p.Name, best.d, best.h.Health))
            end
        end)
    end)})

    el(T.Cheats, "Divider", {})

    -- Speed
    el(T.Cheats, "Paragraph", {Title = "WalkSpeed", Desc = "Change your movement speed", Image = "lucide:gauge", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
    local function applySpeed()
        local _, hum = getParts()
        if hum then hum.WalkSpeed = st.speedValue end
    end
    el(T.Cheats, "Toggle", {Title = "Enable Speed", Flag = "SaveSpeedEnabled", Value = false, Callback = cb(function(v)
        st.speedEnabled = v
        if v then applySpeed() else local _, hum = getParts(); if hum then hum.WalkSpeed = 16 end end
    end)})
    el(T.Cheats, "Slider", {Title = "Speed Value", Flag = "SaveSpeedValue", Value = {Min = 16, Max = 300, Default = 50}, Callback = cb(function(v)
        st.speedValue = tonumber(v)
        if st.speedEnabled then applySpeed() end
    end)})

    el(T.Cheats, "Divider", {})

    -- Jump
    el(T.Cheats, "Paragraph", {Title = "Jump Power", Desc = "Change your jump height", Image = "lucide:move-up", ImageSize = 20, Color = Color3.fromHex(ACCENT2)})
    local function applyJump()
        local _, hum = getParts()
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = st.jumpValue
        end
    end
    el(T.Cheats, "Toggle", {Title = "Enable Jump Boost", Flag = "SaveJumpEnabled", Value = false, Callback = cb(function(v)
        st.jumpEnabled = v
        if v then applyJump() else local _, hum = getParts(); if hum then hum.JumpPower = 50 end end
    end)})
    el(T.Cheats, "Slider", {Title = "Jump Power", Flag = "SaveJumpValue", Value = {Min = 50, Max = 300, Default = 100}, Callback = cb(function(v)
        st.jumpValue = tonumber(v)
        if st.jumpEnabled then applyJump() end
    end)})

    el(T.Cheats, "Divider", {})

    -- Infinite Jump
    el(T.Cheats, "Toggle", {Title = "Infinite Jump", Desc = "Jump as many times as you want", Flag = "SaveInfiniteJump", Value = false, Callback = cb(function(v)
        st.infiniteJump = v
        disc("infiniteJump")
        if not v then return end
        cn.infiniteJump = UserInputService.JumpRequest:Connect(function()
            if st.infiniteJump then
                local _, hum = getParts()
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    end)})

    el(T.Cheats, "Divider", {})

    -- Fly
    el(T.Cheats, "Paragraph", {Title = "Fly", Desc = "Bypass movement with a simple fly", Image = "lucide:plane", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
    local flyBV, flyBG
    local function stopFly()
        st.flyEnabled = false
        if flyBV then pcall(function() flyBV:Destroy() end); flyBV = nil end
        if flyBG then pcall(function() flyBG:Destroy() end); flyBG = nil end
        disc("fly")
    end
    local function startFly()
        stopFly()
        local _, hum, hrp = getParts()
        if not hrp then return end
        st.flyEnabled = true
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        flyBV.Velocity = Vector3.zero
        flyBV.Parent = hrp
        flyBG = Instance.new("BodyGyro")
        flyBG.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        flyBG.P = 1000
        flyBG.D = 100
        flyBG.Parent = hrp
        local cam = Workspace.CurrentCamera
        cn.fly = RunService.RenderStepped:Connect(function()
            if not st.flyEnabled then stopFly(); return end
            local _, _, r = getParts()
            if not r or not cam then stopFly(); return end
            local move = Vector3.zero
            local cf = cam.CFrame
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, 1, 0) end
            if move.Magnitude > 0 then
                flyBV.Velocity = move.Unit * st.flySpeed
            else
                flyBV.Velocity = Vector3.zero
            end
            flyBG.CFrame = cf
        end)
    end
    el(T.Cheats, "Toggle", {Title = "Enable Fly", Flag = "SaveFlyEnabled", Value = false, Callback = cb(function(v)
        if v then startFly() else stopFly() end
    end)})
    el(T.Cheats, "Slider", {Title = "Fly Speed", Flag = "SaveFlySpeed", Value = {Min = 10, Max = 300, Default = 50}, Callback = cb(function(v) st.flySpeed = tonumber(v) end)})

    el(T.Cheats, "Divider", {})

    -- Fullbright / No Fog
    el(T.Cheats, "Paragraph", {Title = "Visual", Desc = "Environment visuals", Image = "lucide:sun", ImageSize = 20, Color = Color3.fromHex(ACCENT2)})
    el(T.Cheats, "Toggle", {Title = "Fullbright", Flag = "SaveFullbright", Value = false, Callback = cb(function(v)
        st.fullbright = v
        if v then
            Lighting.Brightness = 2
            Lighting.GlobalShadows = false
            Lighting.EnvironmentDiffuseScale = 1
            Lighting.EnvironmentSpecularScale = 1
        else
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
        end
    end)})
    el(T.Cheats, "Toggle", {Title = "No Fog", Flag = "SaveNoFog", Value = false, Callback = cb(function(v)
        st.noFog = v
        if v then
            Lighting.FogEnd = 1000000
            Lighting.FogStart = 1000000
        else
            Lighting.FogEnd = 1000
            Lighting.FogStart = 0
        end
    end)})

    el(T.Cheats, "Divider", {})

    -- Fly/Reset hint
    el(T.Cheats, "Paragraph", {Title = "Controls", Desc = "Fly: WASD move, Space up, LeftCtrl down", Image = "lucide:keyboard", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
end

---------------------------------------------------------------------
-- UTILITIES
---------------------------------------------------------------------
local enableInvis, disableInvis
do
    local inv = {active = false, track = nil, conns = {}, running = false, root = nil, model = nil}

    local function applyGhost(part)
        if not part:IsA("BasePart") or part.Name == "HumanoidRootPart" or part.Transparency == 1 or part.Name:lower():find("hitbox") then return end
        part.LocalTransparencyModifier = 0.5
        table.insert(inv.conns, part:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
            if inv.active and part.LocalTransparencyModifier ~= 0.5 then part.LocalTransparencyModifier = 0.5 end
        end))
    end

    local function setupGhost(char)
        for _, p in ipairs(char:GetDescendants()) do applyGhost(p) end
        table.insert(inv.conns, char.DescendantAdded:Connect(function(c)
            if inv.active then applyGhost(c) end
        end))
    end

    local function stopAnim()
        if inv.track then
            pcall(function()
                if inv.track.IsPlaying then inv.track:Stop() end
                inv.track:Destroy()
            end)
            inv.track = nil
        end
    end

    enableInvis = function()
        if inv.active then return end
        local char = localPlayer.Character
        if not char or not char:FindFirstChildOfClass("Humanoid") or not char:FindFirstChild("HumanoidRootPart") then return end
        inv.active = true
        inv.model = Instance.new("Model", Workspace)
        inv.model.Name = "InvisAnchor"
        Instance.new("Humanoid", inv.model)
        inv.root = Instance.new("Part", inv.model)
        inv.root.Name = "HumanoidRootPart"
        inv.root.CanCollide = false
        inv.root.Transparency = 1
        inv.root.Anchored = true
        inv.root.Size = Vector3.new(2, 2, 1)
        setupGhost(char)
    end

    disableInvis = function()
        if not inv.active then return end
        inv.active = false
        stopAnim()
        local char = localPlayer.Character
        for _, c in ipairs(inv.conns) do pcall(function() c:Disconnect() end) end
        inv.conns = {}
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then Workspace.CurrentCamera.CameraSubject = hum end
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.LocalTransparencyModifier = 0 end
            end
        end
        if inv.model then inv.model:Destroy(); inv.model = nil; inv.root = nil end
    end

    RunService.Heartbeat:Connect(function()
        if not inv.active or inv.running then return end
        inv.running = true
        local char = localPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not hum or not root then inv.running = false; return end
        if hum.Health <= 0 then stopAnim(); inv.running = false; return end
        local ccf, cvel = root.CFrame, root.AssemblyLinearVelocity
        if inv.root then inv.root.CFrame = ccf end
        local animator = hum:FindFirstChildOfClass("Animator")
        local a = nil
        if animator then
            if not (inv.track and inv.track.Parent ~= nil) then
                local ao = Instance.new("Animation")
                ao.AnimationId = "rbxassetid://71181015443030"
                inv.track = animator:LoadAnimation(ao)
                inv.track.Priority = Enum.AnimationPriority.Action4
                inv.track:Play()
                inv.track:AdjustSpeed(0)
                inv.track:AdjustWeight(2000000000)
            end
            a = inv.track
            a.TimePosition = 13.45
        end
        RunService.RenderStepped:Wait()
        if a and a.IsPlaying then pcall(function() a:Stop() end) end
        if UserInputService:GetFocusedTextBox() == nil and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
            local lv = Workspace.CurrentCamera.CFrame.LookVector
            local hl = Vector3.new(lv.X, 0, lv.Z)
            if hl.Magnitude > 0.001 then
                root.CFrame = CFrame.new(ccf.Position, ccf.Position + hl)
            else
                root.CFrame = ccf
            end
        else
            root.CFrame = ccf
        end
        root.AssemblyLinearVelocity = cvel
        inv.running = false
    end)

    localPlayer.CharacterAdded:Connect(function()
        task.wait(0.2)
        if inv.active then disableInvis() end
    end)
end

local setupCounterESP
do
    local conns = {}
    local ids = {["12351854556"] = true, ["15311685628"] = true, ["78521642007560"] = true}

    local function highlight(char)
        for _, c in ipairs(Workspace:GetChildren()) do
            if c:IsA("Highlight") and c.Name == "CounterESP" and c.Adornee == char then c:Destroy() end
        end
        local h = Instance.new("Highlight")
        h.Name = "CounterESP"
        h.Adornee = char
        h.FillColor = st.sigmaColor
        h.OutlineColor = st.sigmaColor
        h.FillTransparency = 0.2
        h.OutlineTransparency = 0
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = Workspace
        task.delay(3, function() if h.Parent then h:Destroy() end end)
    end

    local function hookChar(char)
        local hum = char:WaitForChild("Humanoid", 2)
        if not hum then return end
        table.insert(conns, hum.AnimationPlayed:Connect(function(track)
            if not st.sigmaESP then return end
            local id = numId(track.Animation.AnimationId)
            if id and ids[id] then highlight(char) end
        end))
    end

    local function hookPlayer(p)
        if p.Character then task.spawn(hookChar, p.Character) end
        table.insert(conns, p.CharacterAdded:Connect(function(c)
            task.wait(1)
            hookChar(c)
        end))
    end

    setupCounterESP = function(on)
        st.sigmaESP = on
        for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
        conns = {}
        if on then
            for _, p in ipairs(Players:GetPlayers()) do hookPlayer(p) end
            table.insert(conns, Players.PlayerAdded:Connect(hookPlayer))
        else
            for _, c in ipairs(Workspace:GetChildren()) do
                if c:IsA("Highlight") and c.Name == "CounterESP" then c:Destroy() end
            end
        end
    end
end

local setupArrow
do
    local conns = {}
    local function arrow(char, track)
        local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
        if not torso then return end
        local gui = Instance.new("BillboardGui")
        gui.Name = "ArrowBillboard"
        gui.Adornee = torso
        gui.Size = UDim2.new(4, 0, 2, 0)
        gui.StudsOffset = Vector3.new(0, 5, 0)
        gui.AlwaysOnTop = true
        gui.Parent = torso
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "v"
        lbl.Font = Enum.Font.GothamBold
        lbl.TextScaled = true
        lbl.TextColor3 = Color3.fromHex(ACCENT)
        lbl.Parent = gui
        task.spawn(function()
            local t = 0
            while gui.Parent and st.arrowIndicator do
                t = (t + 0.05) % 1.05
                lbl.TextColor3 = Color3.fromHex(ACCENT):Lerp(Color3.fromHex(ACCENT2), math.sin(t * math.pi))
                task.wait(0.1)
            end
        end)
        track.Stopped:Connect(function() gui:Destroy() end)
    end

    local function hookHum(hum)
        table.insert(conns, hum.AnimationPlayed:Connect(function(track)
            if st.arrowIndicator and track.Animation.AnimationId == "rbxassetid://10470389827" then
                arrow(hum.Parent, track)
            end
        end))
    end

    local function hookPlayer(p)
        if p.Character then
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            if h then hookHum(h) end
        end
        table.insert(conns, p.CharacterAdded:Connect(function(c)
            local h = c:WaitForChild("Humanoid", 5)
            if h then hookHum(h) end
        end))
    end

    setupArrow = function(on)
        for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
        conns = {}
        if not on then return end
        for _, p in ipairs(Players:GetPlayers()) do hookPlayer(p) end
        table.insert(conns, Players.PlayerAdded:Connect(hookPlayer))
    end
end

local setupDeathCounterESP
do
    local conns, hls = {}, {}
    local function remove(p)
        if hls[p] then pcall(function() hls[p]:Destroy() end); hls[p] = nil end
    end
    local function create(p, char)
        if not st.deathCounterESP then return end
        remove(p)
        local hl = Instance.new("Highlight")
        hl.Name = "DeathCounterHighlight"
        hl.Adornee = char
        hl.FillColor = Color3.fromHex(ACCENT)
        hl.OutlineColor = Color3.fromHex(ACCENT2)
        hl.FillTransparency = 0.6
        hl.OutlineTransparency = 0.1
        hl.Parent = guiParent()
        hls[p] = hl
        task.delay(12, function() if hls[p] == hl then remove(p) end end)
    end
    local function watch(char)
        local p = Players:GetPlayerFromCharacter(char)
        if not p then return end
        if char:FindFirstChild("Death Counter") then create(p, char) end
        table.insert(conns, char.ChildAdded:Connect(function(ch)
            if ch.Name == "Death Counter" then create(p, char) end
        end))
    end
    local function hookPlayer(p)
        if p.Character then watch(p.Character) end
        table.insert(conns, p.CharacterAdded:Connect(function(c)
            task.wait(1)
            if st.deathCounterESP then watch(c) end
        end))
    end
    setupDeathCounterESP = function(on)
        st.deathCounterESP = on
        for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
        conns = {}
        for p in pairs(hls) do remove(p) end
        if not on then return end
        for _, p in ipairs(Players:GetPlayers()) do hookPlayer(p) end
        table.insert(conns, Players.PlayerAdded:Connect(hookPlayer))
        table.insert(conns, Players.PlayerRemoving:Connect(remove))
    end
end

local startESP, stopESP
do
    local objs = {}
    local function new(kind, props)
        local ok, r = pcall(function() return Drawing.new(kind) end)
        if not ok or not r then return nil end
        for k, v in pairs(props or {}) do pcall(function() r[k] = v end) end
        return r
    end
    local function create()
        return {
            Box = new("Square", {Visible = false, Thickness = 1, Filled = false}),
            Name = new("Text", {Visible = false, Center = true, Outline = true, Size = 16, Font = 2}),
            Tracer = new("Line", {Visible = false, Thickness = 1}),
            Health = new("Line", {Visible = false, Thickness = 4}),
        }
    end
    local function hide(e)
        if not e then return end
        for _, d in pairs(e) do pcall(function() d.Visible = false end) end
    end
    local function removeFor(p)
        local e = objs[p]
        if not e then return end
        for _, d in pairs(e) do pcall(function() d:Remove() end) end
        objs[p] = nil
    end
    local function render()
        if not st.espEnabled then
            for _, e in pairs(objs) do hide(e) end
            return
        end
        local cam = Workspace.CurrentCamera
        if not cam then return end
        local color = st.espColor
        local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= localPlayer then
                local char = plr.Character
                local h = char and char:FindFirstChildOfClass("Humanoid")
                if char and h and h.Health > 0 then
                    local ok, cf, size = pcall(function() return char:GetBoundingBox() end)
                    if ok and cf and size then
                        local e = objs[plr] or create()
                        objs[plr] = e
                        local half = size / 2
                        local visible = true
                        local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
                        for x = -1, 1, 2 do
                            for y = -1, 1, 2 do
                                for z = -1, 1, 2 do
                                    local sp, on = cam:WorldToViewportPoint(cf * Vector3.new(half.X * x, half.Y * y, half.Z * z))
                                    if not on then visible = false end
                                    minX = math.min(minX, sp.X); minY = math.min(minY, sp.Y)
                                    maxX = math.max(maxX, sp.X); maxY = math.max(maxY, sp.Y)
                                end
                            end
                        end
                        if visible then
                            local w, hh = maxX - minX, maxY - minY
                            local bw = w * 0.7
                            local bx = minX + (w - bw) / 2
                            local hp = math.clamp(h.Health / (h.MaxHealth > 0 and h.MaxHealth or 100), 0, 1)
                            if e.Box then e.Box.Visible = true; e.Box.Position = Vector2.new(bx, minY); e.Box.Size = Vector2.new(bw, hh); e.Box.Color = color end
                            if e.Name then e.Name.Visible = true; e.Name.Text = plr.Name; e.Name.Position = Vector2.new(bx + bw / 2, minY - 18); e.Name.Color = color end
                            if e.Tracer then e.Tracer.Visible = true; e.Tracer.From = center; e.Tracer.To = Vector2.new(bx + bw / 2, maxY); e.Tracer.Color = color end
                            if e.Health then e.Health.Visible = true; e.Health.From = Vector2.new(bx - 6, maxY); e.Health.To = Vector2.new(bx - 6, maxY - hh * hp); e.Health.Color = color end
                        else
                            hide(e)
                        end
                    end
                elseif objs[plr] then
                    hide(objs[plr])
                end
            end
        end
    end
    startESP = function()
        disc("esp")
        cn.esp = RunService.RenderStepped:Connect(render)
    end
    stopESP = function()
        disc("esp")
        for _, e in pairs(objs) do hide(e) end
    end
    Players.PlayerRemoving:Connect(removeFor)
end

local fpsBoost
do
    local connected = false
    local function clean(d)
        if d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Fire") or d:IsA("Smoke") or d:IsA("Sparkles") then
            pcall(function() d:Destroy() end)
        elseif d:IsA("Part") or d:IsA("MeshPart") or d:IsA("UnionOperation") then
            d.Material = Enum.Material.SmoothPlastic
            d.Reflectance = 0
            d.CastShadow = false
        elseif d:IsA("Decal") or d:IsA("Texture") then
            pcall(function() d:Destroy() end)
        end
    end
    fpsBoost = function()
        if not st.fpsBoost then return end
        local map = Workspace:FindFirstChild("Map")
        if map then
            for _, n in ipairs({"GrassBottom", "GrassTop", "Grass", "Trash", "Trees", "Walls", "Total Kills Leaderboard", "Total Kills Leaderboard Real", "Benchs"}) do
                local o = map:FindFirstChild(n)
                if o then o:Destroy() end
            end
        end
        pcall(function() settings().Rendering.QualityLevel = 1 end)
        pcall(function() settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01 end)
        Lighting.FogEnd = 1000000
        Lighting.FogStart = 1000000
        Lighting.GlobalShadows = false
        Lighting.Brightness = 2
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        for _, d in ipairs(Workspace:GetDescendants()) do
            clean(d)
            if d:IsA("SurfaceGui") or d:IsA("Light") then pcall(function() d:Destroy() end) end
        end
        local terrain = Workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.Decoration = false
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
        end
        if not connected then
            connected = true
            Workspace.DescendantAdded:Connect(function(d)
                if st.fpsBoost then clean(d) end
            end)
        end
    end
end

local setM2Block, setM1Block, setNoClip
do
    setM2Block = function(on)
        disc("m2Block")
        disc("m2BlockEnd")
        if not on then return end
        cn.m2Block = UserInputService.InputBegan:Connect(function(input, gp)
            if not gp and input.UserInputType == Enum.UserInputType.MouseButton2 then sendKey(true, Enum.KeyCode.F) end
        end)
        cn.m2BlockEnd = UserInputService.InputEnded:Connect(function(input, gp)
            if not gp and input.UserInputType == Enum.UserInputType.MouseButton2 then sendKey(false, Enum.KeyCode.F) end
        end)
    end

    setM1Block = function(on)
        disc("m1Block")
        if not on then return end
        cn.m1Block = localPlayer:GetMouse().Button1Down:Connect(function()
            local c = localPlayer.Character
            local comm = c and c:FindFirstChild("Communicate")
            if comm then comm:FireServer({Goal = "KeyRelease", Key = Enum.KeyCode.F}) end
        end)
    end

    setNoClip = function(on)
        disc("noClip")
        if not on then return end
        cn.noClip = RunService.Stepped:Connect(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= localPlayer and p.Character then
                    for _, d in ipairs(p.Character:GetDescendants()) do
                        if d:IsA("BasePart") then d.CanCollide = false end
                    end
                end
            end
        end)
    end
end

el(T.Utils, "Toggle", {Title = "Invisibility", Desc = "Makes you invisible to other players", Flag = "SaveInvis", Value = false, Callback = cb(function(v)
    if v then enableInvis() else disableInvis() end
end)})
el(T.Utils, "Toggle", {Title = "Counter ESP", Flag = "Save62", Value = false, Callback = cb(function(v) setupCounterESP(v) end)})
el(T.Utils, "Colorpicker", {Title = "Highlight Color", Flag = "Save63", Desc = "Color for Counter esp", Default = Color3.fromHex(ACCENT), Callback = cb(function(c)
    local col = toColor(c)
    if col then st.sigmaColor = col end
end)})
el(T.Utils, "Toggle", {Title = "Block Indicator", Flag = "Save64", Value = false, Callback = cb(function(v) st.arrowIndicator = v; setupArrow(v) end)})
el(T.Utils, "Toggle", {Title = "No Clip Players", Flag = "Save67", Value = false, Callback = cb(function(v) st.noClip = v; setNoClip(v) end)})
el(T.Utils, "Toggle", {Title = "Enable ESP", Flag = "SaveESPEnabled", Value = false, Callback = cb(function(v)
    st.espEnabled = v
    if v then startESP() else stopESP() end
end)})
el(T.Utils, "Colorpicker", {Title = "ESP Color", Flag = "SaveESPColor", Default = Color3.fromHex(ACCENT2), Callback = cb(function(c)
    local col = toColor(c)
    if col then st.espColor = col end
end)})
el(T.Utils, "Toggle", {Title = "M2 Block", Flag = "Save72", Value = false, Callback = cb(function(v) st.m2Block = v; setM2Block(v) end)})
el(T.Utils, "Toggle", {Title = "M1 Block", Flag = "Save73", Value = false, Callback = cb(function(v) st.m1Block = v; setM1Block(v) end)})
el(T.Utils, "Toggle", {Title = "Death Counter ESP", Flag = "Save104", Value = false, Callback = cb(function(v) setupDeathCounterESP(v) end)})
el(T.Utils, "Toggle", {Title = "FPS Boost", Flag = "Save78", Value = false, Callback = cb(function(v) st.fpsBoost = v; if v then fpsBoost() end end)})
el(T.Utils, "Slider", {Title = "FOV", Flag = "Save91", Value = {Min = 0, Max = 120, Default = 70}, Callback = cb(function(v)
    local cam = Workspace.CurrentCamera
    if cam then cam.FieldOfView = tonumber(v) end
end)})

do
    local function sky(ids)
        local s = Instance.new("Sky", Lighting)
        s.SkyboxBk = "http://www.roblox.com/asset/?id=" .. ids[1]
        s.SkyboxDn = "http://www.roblox.com/asset/?id=" .. ids[2]
        s.SkyboxFt = "http://www.roblox.com/asset/?id=" .. ids[3]
        s.SkyboxLf = "http://www.roblox.com/asset/?id=" .. ids[4]
        s.SkyboxRt = "http://www.roblox.com/asset/?id=" .. ids[5]
        s.SkyboxUp = "http://www.roblox.com/asset/?id=" .. ids[6]
    end
    local function cc(b, c, tint, sat)
        local e = Instance.new("ColorCorrectionEffect", Lighting)
        e.Brightness = b or 0
        e.Contrast = c or 0
        e.Saturation = sat or 0
        e.TintColor = tint or Color3.new(1, 1, 1)
    end
    local shaders = {
        ["Rain Shader"] = function()
            sky({4495864450, 4495864887, 4495865458, 4495866035, 4495866584, 4495867486})
            cc(0.05, 0.05, Color3.fromRGB(170, 170, 170))
        end,
        ["Nebula Shader"] = function()
            sky({15983968922, 15983966825, 15983965025, 15983967420, 15983966246, 15983964246})
            cc(0.05, -0.02, Color3.fromRGB(105, 72, 255))
        end,
        ["Night Shader"] = function()
            sky({12064107, 12064152, 12064121, 12063984, 12064115, 12064131})
            cc(0.07, -0.07, Color3.fromRGB(44, 70, 187))
        end,
        ["Dark Shader"] = function()
            cc(0, 0, Color3.new(1, 1, 1), -0.3)
            local a = Instance.new("Atmosphere", Lighting)
            a.Density = 0.296
            a.Color = Color3.fromRGB(199, 170, 107)
            a.Decay = Color3.fromRGB(92, 60, 13)
            sky({245972325, 245972441, 245972389, 245972361, 245972302, 245972410})
        end,
    }
    local function clearFx()
        for _, c in ipairs(Lighting:GetChildren()) do
            if c:IsA("Sky") or c:IsA("ColorCorrectionEffect") or c:IsA("BloomEffect") or c:IsA("DepthOfFieldEffect") or c:IsA("SunRaysEffect") or c:IsA("Atmosphere") then
                pcall(function() c:Destroy() end)
            end
        end
    end
    el(T.Utils, "Dropdown", {Title = "Shader Hub", Flag = "Save55", Values = {"None", "Rain Shader", "Nebula Shader", "Night Shader", "Dark Shader"}, Value = "None", Callback = cb(function(v)
        clearFx()
        if shaders[v] then shaders[v]() end
    end)})
end

do
    local section = el(T.Utils, "Section", {Title = "Avatar Changer", Flag = "Save58", Desc = "Change your avatar", Image = "user", Opened = true, ImageSize = 20, Color = Color3.fromHex(ACCENT)})
    if section then
        el(section, "Button", {Title = "Headless Korblox", Flag = "Save61", Icon = "user-x", Callback = cb(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Headless-Korblox-47269"))()
        end)})
    else
        el(T.Utils, "Button", {Title = "Headless Korblox", Icon = "user-x", Callback = cb(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Headless-Korblox-47269"))()
        end)})
    end
end

---------------------------------------------------------------------
-- CREDITS
---------------------------------------------------------------------
el(T.Credits, "Paragraph", {Title = "Project Selam0exe", Desc = "Script made by lo6", Image = "lucide:user", ImageSize = 20, Color = Color3.fromHex(ACCENT)})
el(T.Credits, "Paragraph", {Title = "Best Supporter", Desc = "Huge Thank You to Star man", Image = "lucide:star", ImageSize = 20, Color = Color3.fromHex(ACCENT2)})
el(T.Credits, "Paragraph", {Title = "Script Testers", Desc = "Wolf Potasium (Tester)\nGrim_Reaper (Real Tester)\noqore (Madium Tester)\nDarknestKnight (Ios Delta Tester)\nIncomu (Delta Tester)\nPG (Tester)\nSomething Wawe (Tester)\nVexor (Tester)", Image = "lucide:users", ImageSize = 20, Color = Color3.fromHex(ACCENT)})

---------------------------------------------------------------------
-- CONFIGS / SETTINGS
---------------------------------------------------------------------
do
    local configName = "default"
    local cm = Window.ConfigManager

    el(T.Configs, "Paragraph", {Title = "Config Manager", Desc = "Save or Load your configs as JSON", Image = "lucide:file-json", Color = Color3.fromHex(ACCENT)})
    el(T.Configs, "Input", {Title = "Config Name", Value = "default", Callback = cb(function(txt) configName = txt end)})
    el(T.Configs, "Button", {Title = "Save Config", Icon = "save", Callback = cb(function()
        cm:CreateConfig(configName):Save()
        notify("Config Saved", "Config Saved!")
    end)})
    el(T.Configs, "Button", {Title = "Load Config", Icon = "download", Callback = cb(function()
        cm:CreateConfig(configName):Load()
        notify("Config Loaded", "Config Loaded!")
    end)})
    el(T.Configs, "Divider", {})
    el(T.Configs, "Button", {Title = "Export JSON to Clipboard", Icon = "copy", Callback = cb(function()
        local json = HttpService:JSONEncode(cm:CreateConfig(configName):GetConfig())
        setclipboard(json)
        notify("Exported", "JSON copied to clipboard!", 3)
    end)})
    el(T.Configs, "Button", {Title = "Import JSON from Clipboard", Icon = "paste", Callback = cb(function()
        local data = HttpService:JSONDecode(getclipboard())
        local cfgObj = cm:CreateConfig(configName)
        cfgObj:SetConfig(data)
        cfgObj:Load()
        notify("Imported", "Config Imported!", 3)
    end)})

    local selected = "default"
    local nameInput = el(T.Settings, "Input", {Title = "Config Name", Icon = "file-cog", Callback = cb(function(txt) selected = txt end)})
    local all = {}
    pcall(function() all = cm:AllConfigs() or {} end)
    el(T.Settings, "Dropdown", {Title = "All Configs", Desc = "Select existing configs", Values = all, Callback = cb(function(v)
        selected = v
        if nameInput then nameInput:Set(v) end
    end)})
    el(T.Settings, "Button", {Title = "Save Config", Justify = "Center", Callback = cb(function()
        Window.CurrentConfig = cm:CreateConfig(selected)
        Window.CurrentConfig:Save()
    end)})
    el(T.Settings, "Button", {Title = "Load Config", Justify = "Center", Callback = cb(function()
        Window.CurrentConfig = cm:CreateConfig(selected)
        Window.CurrentConfig:Load()
    end)})
end

---------------------------------------------------------------------
-- RE-HOOK ON RESPAWN
---------------------------------------------------------------------
localPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if st.supa then hookSupa(char) end
    if st.loop then hookLoop(char) end
    if st.yoyo then setupYOYO(char) end
    if st.techHelper then setupTechHelper() end
    if st.fastDash then setupFastDash(char) end
    if st.noEndLag then setupNoEndLag() end
    if st.autoSurf then setupAutoSurf() end
    if st.speedEnabled then local _, hum = getParts(); if hum then hum.WalkSpeed = st.speedValue end end
    if st.jumpEnabled then local _, hum = getParts(); if hum then hum.UseJumpPower = true; hum.JumpPower = st.jumpValue end end
end)

---------------------------------------------------------------------
-- 3 AM MESSAGE
---------------------------------------------------------------------
task.spawn(function()
    local MESSAGE = "I am watching ...YOU"
    local SPACING = 34
    local gui = Instance.new("ScreenGui")
    gui.Name = "ThreeAMReveal_Minimal"
    gui.ResetOnSpawn = false
    gui.Parent = localPlayer:WaitForChild("PlayerGui")
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(0, #MESSAGE * SPACING, 0, 90)
    holder.Position = UDim2.new(0.5, 0, 0.85, 0)
    holder.AnchorPoint = Vector2.new(0.5, 0.5)
    holder.BackgroundTransparency = 1
    holder.Parent = gui

    local showing, triggered = false, false
    local c1, c2 = Color3.fromHex(ACCENT), Color3.fromHex(ACCENT2)

    local function show()
        if showing then return end
        showing = true
        local labels = {}
        local n = #MESSAGE
        for i = 1, n do
            local lbl = Instance.new("TextLabel")
            lbl.BackgroundTransparency = 1
            lbl.Size = UDim2.new(0, SPACING, 0, 90)
            lbl.Position = UDim2.new(0, (i - 1) * SPACING, 0, 18)
            lbl.Font = Enum.Font.GothamBlack
            lbl.Text = MESSAGE:sub(i, i)
            lbl.TextSize = 40
            lbl.TextColor3 = c1:Lerp(c2, n == 1 and 0 or (i - 1) / (n - 1))
            lbl.TextTransparency = 1
            lbl.Parent = holder
            local stroke = Instance.new("UIStroke")
            stroke.Thickness = 2
            stroke.Transparency = 0.6
            stroke.Color = c1
            stroke.Parent = lbl
            labels[i] = lbl
            task.delay((i - 1) * 0.04, function()
                if lbl.Parent then
                    TweenService:Create(lbl, TweenInfo.new(0.28), {TextTransparency = 0}):Play()
                    TweenService:Create(lbl, TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, (i - 1) * SPACING, 0, 8)}):Play()
                end
            end)
        end
        task.delay(6, function()
            for _, lbl in ipairs(labels) do
                if lbl.Parent then
                    TweenService:Create(lbl, TweenInfo.new(0.45), {TextTransparency = 1}):Play()
                    task.delay(0.55, function() lbl:Destroy() end)
                end
            end
            showing = false
        end)
    end

    while gui.Parent do
        local t = os.date("*t")
        if t.hour == 3 and t.min >= 0 and t.min < 5 then
            if not triggered then
                triggered = true
                show()
            end
        else
            triggered = false
        end
        task.wait(10)
    end
end)

pcall(function()
    Window:Dialog({
        Icon = "rbxassetid://124836024119394",
        Title = "Change logs Beta v1.3",
        Content = "Project Selam0exe beta 1.3 !\n- Removed locked 'Coming Soon' tabs\n- Added new 'Cheats' tab (Camlock, Closest Player, Speed, Jump Boost, Infinite Jump, Fly, Fullbright, No Fog)\n- Fixed Auto Kyoto stealing your mobile buttons (no longer disables AutoRotate / camera)\n\nPlease join the discord server!",
        Buttons = {{Title = "Confirm", Callback = function() print("Welcome To Project Selam0exe :))") end}},
    })
end)

print("[Selam0exe] Loaded")
