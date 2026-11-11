-- PROJECT SELAM0EXE - FIXED
-- PART 4/4 (FIXED)
-- lang: Lua, file: selam0exe_part4.lua, target: Roblox MM2, executor: universal
-- ═══════════════════════════════════════
-- 1. ESP SİSTEMİ
-- ═══════════════════════════════════════
local ESPTable = {}
local GunESPTable = {}
local CoinESPTable = {}
local ESP360Table = {}
local function fn14(player)
if not player or player == localPlayer then return end
local chr = player.Character
if not chr then return end
local root = chr:FindFirstChild("HumanoidRootPart")
if not root then return end
if ESP360Table[player] then
if ESP360Table[player].arrow and ESP360Table[player].arrow.Parent then
ESP360Table[player].arrow:Destroy()
end
ESP360Table[player] = nil
end
local gui = createScreenGui("Echaracter:FindFirstChildSP360_" .. player.Name, 5)
local arrow = Instance.new("ImageLabel")
arrow.Name = "Arrow360"
arrow.Size = UDim2.fromOffset(28, 28)Character:FindFirstChild
arrow.BackgroundTransparency = 1
arrow.Image = "rbxassetid://6031094678"
arrow.ImageColor3 = Hub.ESPColors[Hub.GetPlayerRole(player)] or Hub.ESPColors.Unknown
arrow.AnchorPoint = Vector2.new(0.5, 0.5)
arrow.Position = UDim2.new(0.5, 0, 0.5, 0)
arrow.Parent = gui
ESP360Table[player] = { gui = gui, arrow = arrow, root = root }
end
local function fn15(player)
if ESP360Table[player] then
if ESP360Table[player].gui and ESP360Table[player].gui.Parent then
pcall(function() ESP360Table[player].gui:Destroy() end)
end
ESP360Table[player] = nil
end
end
local function fn16(player, color)
if not Hub.LineESPEnabled then return end
if not player or player == localPlayer then return end
local chr = player.Character
if not chr then return end
local root = chr:FindFirstChild("HumanoidRootPart")
if not root then return end
local entry = ESPTable[player]
if not entry then return end
local cam = workspace.CurrentCamera
if not cam then return end
local screenPos, onScreen = cam:WorldToViewportPoint(root.Position)
if not onScreen then return end
local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
if not myRoot then return end
local myPos, myOnScreen = cam:WorldToViewportPoint(myRoot.Position)
if not myOnScreen then return end
if entry.line then
pcall(function()
entry.line.From = Vector2.new(myPos.X, myPos.Y)
entry.line.To = Vector2.new(screenPos.X, screenPos.Y)
entry.line.Color = color or Hub.ESPColors[Hub.GetPlayerRole(player)] or Hub.ESPColors.Unknown
entry.line.Visible = true
end)
end
end
local function fn32(player)
if ESPTable[player] then
if ESPTable[player].billboardGui and ESPTable[player].billboardGui.Parent then
pcall(function() ESPTable[player].billboardGui:Destroy() end)
end
if ESPTable[player].line then
pcall(function() ESPTable[player].line:Destroy() end)
end
ESPTable[player] = nil
end
fn15(player)
end
local function fn33(gun)
if not Hub.DroppedGunNotifyEnabled then return end
if not gun or not gun.Parent then return end
local pos = gun:FindFirstChildWhichIsA("BasePart")
if not pos then return end
WindUI:Notify({
Title = "Dropped Gun",
Content = "Gun dropped: " .. tostring(gun.Name),
Icon = "crosshair",
Duration = 3,
})
end
local function fn34(enabled)
Hub.CoinESPEnabled = enabled and true or false
if not Hub.CoinESPEnabled then
for obj, entry in pairs(CoinESPTable) do
if entry.billboard and entry.billboard.Parent then
pcall(function() entry.billboard:Destroy() end)
end
CoinESPTable[obj] = nil
end
end
end
RunService.RenderStepped:Connect(function()
if not Hub.ESP360Enabled then return end
local cam = workspace.CurrentCamera
if not cam then return end
for player, data in pairs(ESP360Table) do
if not player or not player.Parent then
fn15(player)
continue
end
local chr = player.Character
local root = chr and chr:FindFirstChild("HumanoidRootPart")
if not root or not data.arrow or not data.arrow.Parent then
fn15(player)
continue
end
local _, onScreen = cam:WorldToViewportPoint(root.Position)
if onScreen then
data.arrow.Visible = false
continue
end
local camCF = cam.CFrame
local dir = (root.Position - camCF.Position).Unit
local right = camCF.RightVector
local up = camCF.UpVector
local dotRight = dir:Dot(right)
local dotUp = dir:Dot(up)
local angle = math.atan2(dotRight, dotUp)
local vp = cam.ViewportSize
local cx, cy = vp.X / 2, vp.Y / 2
local radius = math.min(cx, cy) * 0.78
local px = cx + math.sin(angle) * radius
local py = cy - math.cos(angle) * radius
data.arrow.Position = UDim2.new(0, px - 14, 0, py - 14)
data.arrow.Rotation = math.deg(angle)
data.arrow.ImageColor3 = Hub.ESPColors[Hub.GetPlayerRole(player)] or Hub.ESPColors.Unknown
data.arrow.Visible = true
end
end)
local function setupPlayerESP(player)
if player == localPlayer then return end
fn32(player)
local billboard = Instance.new("BillboardGui")
billboard.Name = "FoxnameESP_" .. player.Name
billboard.AlwaysOnTop = true
billboard.Size = UDim2.fromOffset(100, 60)
billboard.StudsOffset = Vector3.new(0, 3.2, 0)
billboard.ResetOnSpawn = false
local nameLabel = Instance.new("TextLabel")
nameLabel.Name = "NameTag"
nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
nameLabel.Position = UDim2.new(0, 0, 0, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextSize = 14
nameLabel.TextStrokeTransparency = 0.4
nameLabel.Text = player.Name
nameLabel.Parent = billboard
local roleLabel = Instance.new("TextLabel")
roleLabel.Name = "RoleTag"
roleLabel.Size = UDim2.new(1, 0, 0.5, 0)
roleLabel.Position = UDim2.new(0, 0, 0.5, 0)
roleLabel.BackgroundTransparency = 1
roleLabel.Font = Enum.Font.Gotham
roleLabel.TextSize = 12
roleLabel.TextStrokeTransparency = 0.4
roleLabel.Text = "?"
roleLabel.Parent = billboard
local line = Drawing.new("Line")
line.Thickness = 1.5
line.Transparency = 0.3
line.Visible = false
ESPTable[player] = {
billboardGui = billboard,
nameLabel = nameLabel,
roleLabel = roleLabel,
line = line,
}
local function attachBillboard()
local chr = player.Character
if not chr then return end
local root = chr:FindFirstChild("HumanoidRootPart")
if root then
billboard.Parent = root
end
end
attachBillboard()
player.CharacterAdded:Connect(function(chr)
task.wait(0.5)
attachBillboard()
if Hub.ESP360Enabled then
fn14(player)
end
end)
if Hub.ESP360Enabled then
fn14(player)
end
end
Players.PlayerAdded:Connect(function(player)
if Hub.PlayerESPEnabled then
setupPlayerESP(player)
end
end)
Players.PlayerRemoving:Connect(function(player)
fn32(player)
fn15(player)
end)
for _, player in ipairs(Players:GetPlayers()) do
if player ~= localPlayer then
setupPlayerESP(player)
end
end
RunService.RenderStepped:Connect(function()
if not Hub.PlayerESPEnabled then
for player, entry in pairs(ESPTable) do
if entry.billboardGui then
pcall(function() entry.billboardGui.Enabled = false end)
end
if entry.line then entry.line.Visible = false end
end
return
end
for player, entry in pairs(ESPTable) do
if not player or not player.Parent then
fn32(player)
continue
end
local chr = player.Character
local humanoid = chr and chr:FindFirstChildOfClass("Humanoid")
local root = chr and chr:FindFirstChild("HumanoidRootPart")
if not chr or not humanoid or humanoid.Health <= 0 or not root then
if entry.billboardGui then
pcall(function() entry.billboardGui.Enabled = false end)
end
if entry.line then entry.line.Visible = false end
continue
end
local role = Hub.GetPlayerRole(player)
local color = Hub.ESPColors[role] or Hub.ESPColors.Unknown
if entry.billboardGui then
pcall(function()
entry.billboardGui.Enabled = true
if entry.nameLabel then
entry.nameLabel.TextColor3 = color
entry.nameLabel.Text = player.Name
entry.nameLabel.Visible = Hub.NametagESPEnabled ~= false
end
if entry.roleLabel then
entry.roleLabel.TextColor3 = color
entry.roleLabel.Text = role
end
end)
end
if Hub.LineESPEnabled then
fn16(player, color)
elseif entry.line then
entry.line.Visible = false
end
end
end)
local function setupGunESP(gun)
if not gun or not gun.Parent then return end
if GunESPTable[gun] then return end
local handle = gun:FindFirstChildWhichIsA("BasePart")
if not handle then return end
local billboard = Instance.new("BillboardGui")
billboard.Name = "FoxnameGunESP"
billboard.AlwaysOnTop = true
billboard.Size = UDim2.fromOffset(80, 30)
billboard.StudsOffset = Vector3.new(0, 1.5, 0)
billboard.Parent = handle
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(1, 0, 1, 0)
lbl.BackgroundTransparency = 1
lbl.TextColor3 = Color3.fromRGB(255, 220, 50)
lbl.Font = Enum.Font.GothamBold
lbl.TextSize = 13
lbl.TextStrokeTransparency = 0.4
lbl.Text = "🔫 " .. tostring(gun.Name)
lbl.Parent = billboard
GunESPTable[gun] = { billboard = billboard }
end
local function refreshGunESP()
for gun in pairs(GunESPTable) do
if not gun or not gun.Parent then
if GunESPTable[gun] and GunESPTable[gun].billboard then
pcall(function() GunESPTable[gun].billboard:Destroy() end)
end
GunESPTable[gun] = nil
end
end
if not Hub.GunESPEnabled then
for gun, entry in pairs(GunESPTable) do
if entry.billboard then pcall(function() entry.billboard:Destroy() end) end
GunESPTable[gun] = nil
end
return
end
local map = Hub.CoinFarm.ResolveMap() or workspace
for _, obj in ipairs(map:GetDescendants()) do
if obj:IsA("Tool") and obj.Parent and not obj.Parent:IsA("Model") then
setupGunESP(obj)
end
end
end
local function setupCoinESP(coin)
if not coin or not coin.Parent then return end
if CoinESPTable[coin] then return end
local part = coin:IsA("BasePart") and coin or coin:FindFirstChildWhichIsA("BasePart")
if not part then return end
local billboard = Instance.new("BillboardGui")
billboard.Name = "FoxnameCoinESP"
billboard.AlwaysOnTop = true
billboard.Size = UDim2.fromOffset(50, 20)
billboard.StudsOffset = Vector3.new(0, 1, 0)
billboard.Parent = part
local lbl = Instance.new("TextLabel")
lbl.Size = UDim2.new(1, 0, 1, 0)
lbl.BackgroundTransparency = 1
lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
lbl.Font = Enum.Font.GothamBold
lbl.TextSize = 11
lbl.TextStrokeTransparency = 0.5
lbl.Text = "●"
lbl.Parent = billboard
CoinESPTable[coin] = { billboard = billboard }
end
local function refreshCoinESP()
for coin in pairs(CoinESPTable) do
if not coin or not coin.Parent then
if CoinESPTable[coin] and CoinESPTable[coin].billboard then
pcall(function() CoinESPTable[coin].billboard:Destroy() end)
end
CoinESPTable[coin] = nil
end
end
if not Hub.CoinESPEnabled then return end
local map = Hub.CoinFarm.ResolveMap() or workspace
for _, obj in ipairs(map:GetDescendants()) do
if obj.Name == "Coin" or obj.Name == "CoinBag" then
setupCoinESP(obj)
end
end
end
local function fn55() refreshCoinESP() end
workspace.DescendantAdded:Connect(function(obj)
if obj.Name == "Coin" or obj.Name == "CoinBag" then
if Hub.CoinESPEnabled then setupCoinESP(obj) end
end
if obj:IsA("Tool") then setupGunESP(obj) end
if Hub.GunESPEnabled and obj.Name == "Revolver" then fn33(obj) end
end)
workspace.DescendantRemoving:Connect(function(obj)
if CoinESPTable[obj] then
if CoinESPTable[obj].billboard then pcall(function() CoinESPTable[obj].billboard:Destroy() end) end
CoinESPTable[obj] = nil
end
if GunESPTable[obj] then
if GunESPTable[obj].billboard then pcall(function() GunESPTable[obj].billboard:Destroy() end) end
GunESPTable[obj] = nil
end
end)
Hub.TakeDroppedGunOnce = function()
local chr = localPlayer.Character
local root = chr and chr:FindFirstChild("HumanoidRootPart")
if not root then return end
local map = Hub.CoinFarm.ResolveMap() or workspace
local best, bestDist = nil, math.huge
for _, obj in ipairs(map:GetDescendants()) do
if obj:IsA("Tool") and obj.Parent == map then
local handle = obj:FindFirstChildWhichIsA("BasePart")
if handle then
local dist = (handle.Position - root.Position).Magnitude
if dist < bestDist then
best = obj
bestDist = dist
end
end
end
end
if best then
local handle = best:FindFirstChildWhichIsA("BasePart")
if handle and type(firetouchinterest) == "function" then
pcall(function()
firetouchinterest(root, handle, 0)
task.wait(0.05)
firetouchinterest(root, handle, 1)
end)
end
end
end
Hub.SetAutoGunTouchSource = function(enabled)
Hub.AutoGunTouchEnabled = enabled and true or false
end
-- ═══════════════════════════════════════
-- 2. CROSSHAIR SİSTEMİ
-- ═══════════════════════════════════════
Hub.Crosshair = Hub.Crosshair or {}
Hub.Crosshair.gui = nil
Hub.Crosshair.drawing = nil
Hub.Crosshair.rgbConn = nil
Hub.Crosshair.hue = 0
local function RestoreCursor()
pcall(function()
UserInputService.MouseIconEnabled = true
end)
if Hub.Crosshair.drawing and Hub.Crosshair.drawing.Visible ~= nil then
Hub.Crosshair.drawing.Visible = false
end
end
local function HideCursor()
pcall(function()
UserInputService.MouseIconEnabled = false
end)
end
local function DestroyCrosshair()
RestoreCursor()
if Hub.Crosshair.drawing then
pcall(function() Hub.Crosshair.drawing:Remove() end)
Hub.Crosshair.drawing = nil
end
if Hub.Crosshair.gui and Hub.Crosshair.gui.Parent then
pcall(function() Hub.Crosshair.gui:Destroy() end)
Hub.Crosshair.gui = nil
end
if Hub.Crosshair.rgbConn then
Hub.Crosshair.rgbConn:Disconnect()
Hub.Crosshair.rgbConn = nil
end
if Hub.Crosshair.renderConn then
Hub.Crosshair.renderConn:Disconnect()
Hub.Crosshair.renderConn = nil
end
end
local function ApplyAppearanceCrosshair()
if not Hub.CrosshairEnabled then return end
local color = Hub.CrosshairColor or Color3.fromRGB(168, 85, 247)
local size = Hub.CrosshairSize or 20
local visibility = Hub.CrosshairVisibility or "Always"
if Hub.CrosshairRGB then
Hub.Crosshair.hue = (Hub.Crosshair.hue + 0.005) % 1
color = Color3.fromHSV(Hub.Crosshair.hue, 1, 1)
end
local cam = workspace.CurrentCamera
local vp = cam and cam.ViewportSize or Vector2.new(800, 600)
local cx, cy = vp.X / 2, vp.Y / 2
if Hub.Crosshair.drawing then
pcall(function()
Hub.Crosshair.drawing.Color = color
Hub.Crosshair.drawing.Position = Vector2.new(cx, cy)
Hub.Crosshair.drawing.Size = size
if visibility == "Always" then
Hub.Crosshair.drawing.Visible = true
elseif visibility == "While Aiming" then
Hub.Crosshair.drawing.Visible = Hub.AimEnabled == true
elseif visibility == "While Shooting" then
Hub.Crosshair.drawing.Visible = false
end
end)
end
end
local function RebuildCrosshair()
DestroyCrosshair()
if not Hub.CrosshairEnabled then return end
local style = Hub.CrosshairStyle or "crosshair"
local color = Hub.CrosshairColor or Color3.fromRGB(168, 85, 247)
local size = Hub.CrosshairSize or 20
local cam = workspace.CurrentCamera
local vp = cam and cam.ViewportSize or Vector2.new(800, 600)
local cx, cy = vp.X / 2, vp.Y / 2
HideCursor()
local customIcon = Hub.CrosshairCustomName
if customIcon and customIcon ~= "" then
pcall(function()
UserInputService.MouseIcon = customIcon
UserInputService.MouseIconEnabled = true
end)
return
end
if style == "circle-plus" then
local circle = Drawing.new("Circle")
circle.Radius = size
circle.Position = Vector2.new(cx, cy)
circle.Color = color
circle.Thickness = 1.5
circle.Filled = false
circle.Visible = true
circle.Transparency = 0.8
Hub.Crosshair.drawing = circle
elseif style == "star" then
local text = Drawing.new("Text")
text.Text = "✦"
text.Size = size
text.Position = Vector2.new(cx - size * 0.4, cy - size * 0.5)
text.Color = color
text.Outline = true
text.Visible = true
Hub.Crosshair.drawing = text
elseif style == "heart" then
local text = Drawing.new("Text")
text.Text = "♥"
text.Size = size
text.Position = Vector2.new(cx - size * 0.4, cy - size * 0.5)
text.Color = color
text.Outline = true
text.Visible = true
Hub.Crosshair.drawing = text
else
local line = Drawing.new("Line")
line.From = Vector2.new(cx - size, cy)
line.To = Vector2.new(cx + size, cy)
line.Color = color
line.Thickness = 1.5
line.Transparency = 0.1
line.Visible = true
Hub.Crosshair.drawing = line
end
Hub.Crosshair.renderConn = RunService.RenderStepped:Connect(function()
ApplyAppearanceCrosshair()
end)
end
Hub.Crosshair.SetEnabled = function(enabled)
Hub.CrosshairEnabled = enabled and true or false
if Hub.CrosshairEnabled then
RebuildCrosshair()
else
DestroyCrosshair()
end
end
Hub.Crosshair.SetCustomIcon = function(name)
Hub.CrosshairCustomName = name or ""
if Hub.CrosshairEnabled then
RebuildCrosshair()
end
end
-- ═══════════════════════════════════════
-- 3. SPINBOT, HITBOX, FLING, ANTIFLING
-- ═══════════════════════════════════════
Hub.Spinbot = Hub.Spinbot or {}
Hub.Spinbot.conn = nil
Hub.Spinbot.originalCF = nil
Hub.Spinbot.RestoreHumanoid = function()
local chr = localPlayer.Character
local root = chr and chr:FindFirstChild("HumanoidRootPart")
if root and Hub.Spinbot.originalCF then
pcall(function() root.CFrame = Hub.Spinbot.originalCF end)
end
end
Hub.Spinbot.SetEnabled = function(enabled)
Hub.SpinbotEnabled = enabled and true or false
if Hub.Spinbot.conn then
Hub.Spinbot.conn:Disconnect()
Hub.Spinbot.conn = nil
end
if not Hub.SpinbotEnabled then
Hub.Spinbot.RestoreHumanoid()
return
end
local angle = 0
Hub.Spinbot.conn = RunService.RenderStepped:Connect(function(dt)
local chr = localPlayer.Character
local root = chr and chr:FindFirstChild("HumanoidRootPart")
if not root then return end
local speed = Hub.SpinSpeed or 20
angle = angle + speed * dt
local cf = root.CFrame
root.CFrame = CFrame.new(cf.Position) * CFrame.Angles(0, math.rad(angle), 0)
end)
end
Hub.HitboxExpander = Hub.HitboxExpander or {}
Hub.HitboxExpander.originals = {}
Hub.HitboxExpander.conn = nil
Hub.HitboxExpander.Apply = function()
if not Hub.HitboxEnabled then return end
local size = Hub.HitboxSize or 8
for _, player in ipairs(Players:GetPlayers()) do
if player ~= localPlayer and player.Character then
for _, part in ipairs(player.Character:GetDescendants()) do
if part:IsA("BasePart") and not Hub.HitboxExpander.originals[part] then
Hub.HitboxExpander.originals[part] = part.Size
pcall(function() part.Size = Vector3.new(size, size, size) end)
elseif part:IsA("BasePart") and Hub.HitboxExpander.originals[part] then
pcall(function() part.Size = Vector3.new(size, size, size) end)
end
end
end
end
end
Hub.HitboxExpander.Restore = function()
for part, origSize in pairs(Hub.HitboxExpander.originals) do
if part and part.Parent then
pcall(function() part.Size = origSize end)
end
end
Hub.HitboxExpander.originals = {}
end
Hub.HitboxExpander.SetEnabled = function(enabled)
Hub.HitboxEnabled = enabled and true or false
if Hub.HitboxExpander.conn then
Hub.HitboxExpander.conn:Disconnect()
Hub.HitboxExpander.conn = nil
end
if not Hub.HitboxEnabled then
Hub.HitboxExpander.Restore()
return
end
Hub.HitboxExpander.Apply()
Hub.HitboxExpander.conn = RunService.Heartbeat:Connect(function()
if Hub.HitboxEnabled then
Hub.HitboxExpander.Apply()
end
end)
end
Hub.HitboxExpander.SetShowHitboxes = function(enabled)
Hub.ShowHitboxes = enabled and true or false
for _, player in ipairs(Players:GetPlayers()) do
if player ~= localPlayer and player.Character then
for _, part in ipairs(player.Character:GetDescendants()) do
if part:IsA("BasePart") then
pcall(function()
part.LocalTransparencyModifier = enabled and 0.6 or 0
end)
end
end
end
end
end
local function fn40_getRoot(player)
local chr = player and player.Character
return chr and chr:FindFirstChild("HumanoidRootPart")
end
local function fn39_fling(target)
if not target then return end
local root = fn40_getRoot(target)
if not root then return end
local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
if not myRoot then return end
pcall(function()
local bg = Instance.new("BodyGyro")
bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
bg.P = 1e9
bg.D = 0
bg.CFrame = CFrame.new(root.Position, myRoot.Position)
bg.Parent = root
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
bv.P = 1e9
bv.Velocity = (root.Position - myRoot.Position).Unit * 500 + Vector3.new(0, 100, 0)
bv.Parent = root
task.delay(0.2, function()
if bg and bg.Parent then bg:Destroy() end
if bv and bv.Parent then bv:Destroy() end
end)
end)
end
local function fn20_fling(target)
if not target then return end
local root = fn40_getRoot(localPlayer)
if not root then return end
local targetRoot = fn40_getRoot(target)
if not targetRoot then return end
local origPos = root.CFrame
root.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 2, 0))
task.wait(0.05)
fn39_fling(target)
task.wait(0.1)
pcall(function() root.CFrame = origPos end)
end
Hub.FlingTarget = "Sheriff"
Hub.FlingPlayer = function(target)
if not target then return end
task.spawn(function()
fn20_fling(target)
end)
end
local antiFlingConn = nil
local antiFlingEnabled = false
local function fn37_antiFling()
local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
if not root then return end
for _, obj in ipairs(root:GetChildren()) do
if obj:IsA("BodyVelocity") or obj:IsA("BodyForce") or obj:IsA("BodyThrust") then
if obj.Name ~= "FoxnameFly" then
pcall(function() obj:Destroy() end)
end
end
end
end
local function fn41_antiFling(enabled)
antiFlingEnabled = enabled and true or false
if antiFlingConn then
antiFlingConn:Disconnect()
antiFlingConn = nil
end
if not antiFlingEnabled then return end
antiFlingConn = RunService.Heartbeat:Connect(function()
fn37_antiFling()
end)
end
Hub.SetAntiFlingSource = function(enabled)
fn41_antiFling(enabled)
end
-- ═══════════════════════════════════════
-- 4. SAFEZONE + ROLE DETECTION
-- ═══════════════════════════════════════
local function fn23_tpToSafezone()
local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
if not root then return end
local map = Hub.CoinFarm.ResolveMap() or workspace
local safezoneNames = { "SafeZone", "Safezone", "Safe", "LobbySpawn", "SafeArea" }
local pos = nil
for _, name in ipairs(safezoneNames) do
local found = map:FindFirstChild(name, true)
if found and found:IsA("BasePart") then
pos = found.Position
break
end
end
if not pos then
WindUI:Notify({ Title = "Safezone", Content = "Safezone not found", Icon = "map-pin", Duration = 2 })
return
end
root.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
end
Hub.GetPlayerRole = function(player)
if not player then return "Unknown" end
if Hub.RoleCache and Hub.RoleCache[player] then
return Hub.RoleCache[player]
end
return "Unknown"
end
local function fn27_getRole(player)
return Hub.GetPlayerRole(player)
end
local function fn28_computeRole(player)
if not player then return "Unknown" end
local chr = player.Character
if not chr then return "Unknown" end
local knife = chr:FindFirstChild("Knife") or chr:FindFirstChild("knife")
if knife then return "Murderer" end
local gun = chr:FindFirstChild("Revolver") or chr:FindFirstChild("Gun")
local backpack = player:FindFirstChildOfClass("Backpack")
local backpackGun = backpack and (backpack:FindFirstChild("Revolver") or backpack:FindFirstChild("Gun"))
if gun or backpackGun then return "Sheriff" end
local heroTag = chr:FindFirstChild("HeroTag") or chr:FindFirstChild("Hero")
if heroTag then return "Hero" end
return "Innocent"
end
local function fn29_findByRole(role)
local results = {}
for _, player in ipairs(Players:GetPlayers()) do
if player ~= localPlayer and fn28_computeRole(player) == role then
table.insert(results, player)
end
end
return results
end
local function fn30_findMurderer()
return fn29_findByRole("Murderer")[1]
end
local function fn31_findSheriff()
return fn29_findByRole("Sheriff")[1]
end
-- ═══════════════════════════════════════
-- 5. PLAYER DATA LISTENERS
-- ═══════════════════════════════════════
Hub.RoleCache = Hub.RoleCache or {}
Hub.RoundTimer = 0
Hub.RoundActive = false
task.spawn(function()
local ok, CurrentRoundClient = pcall(function()
return ReplicatedStorage:WaitForChild("CurrentRoundClient", 10)
end)
if not ok or not CurrentRoundClient then return end
local function onPlayerDataChanged(obj)
if not obj then return end
if obj.Name == "Role" then
local player = Players:FindFirstChild(obj.Parent and obj.Parent.Name or "")
if player then
Hub.RoleCache[player] = obj.Value
end
end
end
for _, obj in ipairs(CurrentRoundClient:GetDescendants()) do
if obj:IsA("ValueBase") then
obj.Changed:Connect(function()
onPlayerDataChanged(obj)
end)
end
end
CurrentRoundClient.DescendantAdded:Connect(function(obj)
if obj:IsA("ValueBase") then
obj.Changed:Connect(function()
onPlayerDataChanged(obj)
end)
end
end)
local gameEvents = ReplicatedStorage:FindFirstChild("GameEvents") or ReplicatedStorage:FindFirstChild("Events")
if gameEvents then
local function bindEvent(name, fn)
local ev = gameEvents:FindFirstChild(name)
if ev and ev:IsA("RemoteEvent") then
ev.OnClientEvent:Connect(fn)
end
end
bindEvent("RoundStart", function()
Hub.RoundActive = true
Hub.RoundTimer = 0
Hub.RoleCache = {}
if Hub.CoinFarm.serverHopTimerStartedAt == 0 then
Hub.CoinFarm.serverHopTimerStartedAt = os.clock()
end
end)
bindEvent("CoinsStarted", function()
Hub.CoinFarm.coinsSpawned = true
if Hub.CoinFarm.enabled then
Hub.CoinFarm.SetEnabled(true)
end
end)
bindEvent("CoinCollected", function(player, amount)
if player == localPlayer then
Hub.CoinFarm.totalCollected = Hub.CoinFarm.totalCollected + (amount or 1)
end
end)
bindEvent("LoadingMap", function()
Hub.RoundActive = false
end)
bindEvent("VictoryScreen", function()
Hub.RoundActive = false
Hub.CoinFarm.bagWebhookSent = false
end)
bindEvent("GameOver", function()
Hub.RoundActive = false
end)
bindEvent("RoundEndFade", function()
Hub.RoundActive = false
if Hub.CoinFarm.endRoundEnabled and Hub.CoinFarm.enabled then
task.wait(2)
end
end)
end
end)
Hub.UpdateRoundTimer = function()
if not Hub.ShowTimerControl then return end
task.spawn(function()
while Hub.RoundActive do
task.wait(1)
Hub.RoundTimer = Hub.RoundTimer + 1
if Hub.ShowTimerEnabled then
local mins = math.floor(Hub.RoundTimer / 60)
local secs = Hub.RoundTimer % 60
local display = string.format("%d:%02d", mins, secs)
pcall(function()
if Hub.TimerLabel and Hub.TimerLabel.Parent then
Hub.TimerLabel.Text = display
end
end)
end
end
end)
end
-- ═══════════════════════════════════════
-- 6. AIM SİSTEMİ
-- ═══════════════════════════════════════
Hub.AimEnabled = false
Hub.AimStyle = "Aimlock"
Hub.AimPart = "Head"
Hub.AimPrediction = 0.1
Hub.AimFOV = 120
Hub.HideFOV = false
Hub.IgnoreWalls = false
Hub.OnlyAimAsSheriff = false
local aimConnection = nil
local silentAimHook = nil
local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Filled = false
fovCircle.Color = Color3.fromRGB(168, 85, 247)
fovCircle.Thickness = 1.5
fovCircle.Transparency = 0.5
RunService.RenderStepped:Connect(function()
if not Hub.AimEnabled or Hub.HideFOV then
fovCircle.Visible = false
return
end
local cam = workspace.CurrentCamera
if not cam then fovCircle.Visible = false return end
local vp = cam.ViewportSize
fovCircle.Position = Vector2.new(vp.X / 2, vp.Y / 2)
fovCircle.Radius = Hub.AimFOV
fovCircle.Visible = true
end)
local function getAimTarget()
local cam = workspace.CurrentCamera
if not cam then return nil end
local vp = cam.ViewportSize
local center = Vector2.new(vp.X / 2, vp.Y / 2)
local best, bestDist = nil, math.huge
for _, player in ipairs(Players:GetPlayers()) do
if player == localPlayer then continue end
if Hub.OnlyAimAsSheriff and fn27_getRole(localPlayer) ~= "Sheriff" then continue end
local chr = player.Character
local humanoid = chr and chr:FindFirstChildOfClass("Humanoid")
if not chr or not humanoid or humanoid.Health <= 0 then continue end
local partName = Hub.AimPart or "Head"
local part = chr:FindFirstChild(partName) or chr:FindFirstChild("HumanoidRootPart")
if not part then continue end
if not Hub.IgnoreWalls then
local origin = cam.CFrame.Position
local direction = (part.Position - origin)
local ray = workspace:Raycast(origin, direction, RaycastParams.new())
if ray and ray.Instance then
local inChar = false
for _, p in ipairs(Players:GetPlayers()) do
if p.Character and ray.Instance:IsDescendantOf(p.Character) then
inChar = true
break
end
end
if not inChar then continue end
end
end
local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
if not onScreen then continue end
local screenVec = Vector2.new(screenPos.X, screenPos.Y)
local dist = (screenVec - center).Magnitude
if dist < Hub.AimFOV and dist < bestDist then
best = part
bestDist = dist
end
end
return best
end
local function fn40_aim()
if not Hub.AimEnabled then return end
if Hub.AimStyle == "Silent Aim" then return end
local target = getAimTarget()
if not target then return end
local cam = workspace.CurrentCamera
if not cam then return end
local prediction = Hub.AimPrediction or 0.1
local velocity = target:IsA("BasePart") and target.AssemblyLinearVelocity or Vector3.zero
local predictedPos = target.Position + velocity * prediction
cam.CFrame = CFrame.new(cam.CFrame.Position, predictedPos)
end
if type(hookmetamethod) == "function" and type(getrawmetatable) == "function" then
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
silentAimHook = hookmetamethod(game, "__namecall", function(self, ...)
local method = getnamecallmethod()
local args = { ... }
if method == "FireServer" and Hub.AimEnabled and Hub.AimStyle == "Silent Aim" then
local target = getAimTarget()
if target then
local prediction = Hub.AimPrediction or 0.1
local velocity = target:IsA("BasePart") and target.AssemblyLinearVelocity or Vector3.zero
local predictedPos = target.Position + velocity * prediction
if type(args[1]) == "userdata" then
args[1] = CFrame.new(predictedPos)
end
end
end
return oldNamecall(self, table.unpack(args))
end)
end
aimConnection = RunService.RenderStepped:Connect(function()
fn40_aim()
end)
Hub.UpdateAimBinding = function() end
local gunActivatedConn = nil
local function bindGunActivated()
if gunActivatedConn then
gunActivatedConn:Disconnect()
gunActivatedConn = nil
end
local character_ = localPlayer.Character
if not character_ then return end
local gun = character_:FindFirstChildWhichIsA("Tool")
if gun then
gunActivatedConn = gun.Activated:Connect(function()
if Hub.AimEnabled and Hub.AimStyle == "Aimlock" then
fn40_aim()
end
end)
end
end
localPlayer.CharacterAdded:Connect(function(chr)
task.wait(1)
bindGunActivated()
end)
bindGunActivated()
-- ═══════════════════════════════════════
-- 7. AUTO SHOOT
-- ═══════════════════════════════════════
Hub.AutoShootState = Hub.AutoShootState or { enabled = false }
Hub.AutoShootMode = "Normal"
Hub.AutoShootPart = "Head"
local autoShootLoop = nil
local function fn41_findGun()
local character_ = localPlayer.Character
local backpack = localPlayer:FindFirstChildOfClass("Backpack")
if character_ then
local t = character_:FindFirstChildWhichIsA("Tool")
if t and (t.Name == "Revolver" or t.Name:find("Gun")) then return t end
end
if backpack then
local t = backpack:FindFirstChildWhichIsA("Tool")
if t and (t.Name == "Revolver" or t.Name:find("Gun")) then return t end
end
return nil
end
local function fn43_fire(gun, target)
if not gun or not target then return end
local fireRemote = gun:FindFirstChild("Fire") or gun:FindFirstChildWhichIsA("RemoteEvent")
if not fireRemote then return end
local prediction = Hub.AimPrediction or 0.1
local velocity = target:IsA("BasePart") and target.AssemblyLinearVelocity or Vector3.zero
local predictedPos = target.Position + velocity * prediction
pcall(function()
fireRemote:FireServer(CFrame.new(predictedPos))
end)
end
Hub.UpdateAutoShoot = function()
if autoShootLoop then
autoShootLoop:Disconnect()
autoShootLoop = nil
end
if not Hub.AutoShootState.enabled then return end
autoShootLoop = RunService.Heartbeat:Connect(function()
if not Hub.AutoShootState.enabled then return end
if fn27_getRole(localPlayer) ~= "Sheriff" and fn27_getRole(localPlayer) ~= "Hero" then return end
local gun = fn41_findGun()
if not gun then return end
local partName = Hub.AutoShootPart or "Head"
local best, bestDist = nil, math.huge
local cam = workspace.CurrentCamera
if not cam then return end
local vp = cam.ViewportSize
local center = Vector2.new(vp.X / 2, vp.Y / 2)
for _, player in ipairs(Players:GetPlayers()) do
if player == localPlayer then continue end
if fn27_getRole(player) ~= "Murderer" then continue end
local chr = player.Character
local humanoid = chr and chr:FindFirstChildOfClass("Humanoid")
if not chr or not humanoid or humanoid.Health <= 0 then continue end
local part = chr:FindFirstChild(partName) or chr:FindFirstChild("HumanoidRootPart")
if not part then continue end
if Hub.AutoShootMode ~= "Behind Walls" then
local screenPos, onScreen = cam:WorldToViewportPoint(part.Position)
if not onScreen then continue end
local dist = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
if dist < bestDist then
best = part
bestDist = dist
end
else
local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
local dist = myRoot and (part.Position - myRoot.Position).Magnitude or math.huge
if dist < bestDist then
best = part
bestDist = dist
end
end
end
if best then
fn43_fire(gun, best)
end
end)
end
Hub.TriggerAutoShootInput = function()
Hub.AutoShootState.enabled = not Hub.AutoShootState.enabled
Hub.UpdateAutoShoot()
end
Hub.ToggleAutoShoot = function(enabled)
Hub.AutoShootState.enabled = enabled and true or false
Hub.UpdateAutoShoot()
end
-- ═══════════════════════════════════════
-- 8. FLY SİSTEMİ
-- ═══════════════════════════════════════
Hub.FlyEnabled = false
Hub.FlySpeed = 50
local flyBodyGyro = nil
local flyBodyVelocity = nil
local flyRenderConn = nil
Hub.StartFly = function()
local character_ = localPlayer.Character
local humanoid = character_ and character_:FindFirstChildOfClass("Humanoid")
local root = character_ and character_:FindFirstChild("HumanoidRootPart")
if not character_ or not humanoid or not root then return end
Hub.StopFly()
humanoid.PlatformStand = true
flyBodyGyro = Instance.new("BodyGyro")
flyBodyGyro.Name = "FoxnameFlyGyro"
flyBodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
flyBodyGyro.P = 1e5
flyBodyGyro.D = 100
flyBodyGyro.CFrame = root.CFrame
flyBodyGyro.Parent = root
flyBodyVelocity = Instance.new("BodyVelocity")
flyBodyVelocity.Name = "FoxnameFly"
flyBodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
flyBodyVelocity.P = 1e5
flyBodyVelocity.Velocity = Vector3.zero
flyBodyVelocity.Parent = root
flyRenderConn = RunService.RenderStepped:Connect(function(dt)
if not Hub.FlyEnabled then
Hub.StopFly()
return
end
local cam_ = workspace.CurrentCamera
if not cam_ or not root or not root.Parent then return end
local speed = Hub.FlySpeed or 50
local dir = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam_.CFrame.LookVector end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam_.CFrame.LookVector end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam_.CFrame.RightVector end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam_.CFrame.RightVector end
if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
if dir.Magnitude > 0 then
dir = dir.Unit
end
if flyBodyVelocity and flyBodyVelocity.Parent then
flyBodyVelocity.Velocity = dir * speed
end
if flyBodyGyro and flyBodyGyro.Parent then
flyBodyGyro.CFrame = cam_.CFrame
end
end)
end
Hub.StopFly = function()
if flyRenderConn then
flyRenderConn:Disconnect()
flyRenderConn = nil
end
if flyBodyVelocity and flyBodyVelocity.Parent then
pcall(function() flyBodyVelocity:Destroy() end)
flyBodyVelocity = nil
end
if flyBodyGyro and flyBodyGyro.Parent then
pcall(function() flyBodyGyro:Destroy() end)
flyBodyGyro = nil
end
local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
if humanoid then
pcall(function() humanoid.PlatformStand = false end)
end
end
localPlayer.CharacterAdded:Connect(function()
Hub.StopFly()
Hub.FlyEnabled = false
if Hub.TouchButtons.FlyToggleControl then
Hub.TouchButtons.SetControlValue(Hub.TouchButtons.FlyToggleControl, false)
end
end)
-- ═══════════════════════════════════════
-- 9. INFINITE JUMP
-- ═══════════════════════════════════════
Hub.InfiniteJumpEnabled = false
local infiniteJumpConn = nil
Hub.SetupInfiniteJump = function()
if infiniteJumpConn then
infiniteJumpConn:Disconnect()
infiniteJumpConn = nil
end
if not Hub.InfiniteJumpEnabled then return end
infiniteJumpConn = UserInputService.JumpRequest:Connect(function()
local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
if humanoid and humanoid.Health > 0 then
local power = Hub.JumpPower or 50
humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
local root = localPlayer.Character:FindFirstChild("HumanoidRootPart")
if root then
root.AssemblyLinearVelocity = Vector3.new(
root.AssemblyLinearVelocity.X,
power,
root.AssemblyLinearVelocity.Z
)
end
end
end)
end
Hub.ToggleInfiniteJump = function(enabled)
Hub.InfiniteJumpEnabled = enabled and true or false
Hub.SetupInfiniteJump()
end
-- ═══════════════════════════════════════
-- 10. TAB WIDGET'LARI
-- ═══════════════════════════════════════
-- ───────── Visuals ─────────
Tabs.ESP:Toggle({ Title = "Player ESP", Default = false, Callback = function(v)
Hub.PlayerESPEnabled = v
if v then
for _, p in ipairs(Players:GetPlayers()) do setupPlayerESP(p) end
end
end })
Tabs.ESP:Dropdown({ Title = "Player ESP Style", Values = { "Filled", "Outline" }, Default = "Outline", Callback = function(v)
Hub.ESPStyle = v
end })
Tabs.ESP:Toggle({ Title = "Line ESP", Default = false, Callback = function(v)
Hub.LineESPEnabled = v
end })
Tabs.ESP:Toggle({ Title = "Nametag ESP", Default = true, Callback = function(v)
Hub.NametagESPEnabled = v
end })
Tabs.ESP:Toggle({ Title = "Gun ESP", Default = false, Callback = function(v)
Hub.GunESPEnabled = v
refreshGunESP()
end })
Tabs.ESP:Toggle({ Title = "Bullet Tracer", Default = false, Callback = function(v)
Hub.BulletTracerEnabled = v
end })
Tabs.ESP:Colorpicker({ Title = "Bullet Tracer Color", Default = Color3.fromRGB(168, 85, 247), Callback = function(v)
Hub.BulletTracerColor = v
end })
Tabs.ESP:Slider({ Title = "Bullet Tracer Duration", Min = 0.1, Max = 5, Default = 1, Rounding = 1, Callback = function(v)
Hub.BulletTracerDuration = v
end })
Tabs.ESP:Toggle({ Title = "Coin ESP", Default = false, Callback = function(v)
fn34(v)
if v then fn55() end
end })
Tabs.ESP:Toggle({ Title = "360 ESP", Default = false, Callback = function(v)
Hub.ESP360Enabled = v
if v then
for _, p in ipairs(Players:GetPlayers()) do fn14(p) end
else
for _, p in ipairs(Players:GetPlayers()) do fn15(p) end
end
end })
Tabs.ESP:Toggle({ Title = "Dropped Gun Notify", Default = false, Callback = function(v)
Hub.DroppedGunNotifyEnabled = v
end })
local xrayToggleControl
xrayToggleControl = Tabs.ESP:Toggle({ Title = "XRay", Default = false, Callback = function(v)
Hub.SetXRayEnabled(v)
end })
Hub.TouchButtons.XRayToggleControl = xrayToggleControl
Tabs.ESP:Keybind({ Title = "XRay Keybind", Default = Enum.KeyCode.V, Callback = function()
Hub.SetXRayEnabled(not Hub.XRayEnabled)
end })
Tabs.ESP:Toggle({ Title = "XRay Button", Default = false, Callback = function(v)
Hub.TouchButtons.ToggleXRayButton(v)
end })
Tabs.ESP:Dropdown({ Title = "XRay Button Size", Values = { "Small", "Medium", "Large" }, Default = "Medium", Callback = function(v)
Hub.XRayButtonState.size = v
if Hub.XRayButtonState.enabled then Hub.TouchButtons.ToggleXRayButton(true) end
end })
Tabs.ESP:Dropdown({ Title = "XRay Button Shape", Values = { "Square", "Round" }, Default = "Round", Callback = function(v)
Hub.XRayButtonState.shape = v
end })
Tabs.ESP:Colorpicker({ Title = "XRay Icon Color", Default = Color3.fromRGB(168, 85, 247), Callback = function(v)
Hub.XRayButtonState.outlineColor = v
local btn = Hub.XRayButtonState.button
if btn and btn.Parent then
local stroke = btn:FindFirstChildWhichIsA("UIStroke")
if stroke then stroke.Color = v end
end
end })
Tabs.ESP:Toggle({ Title = "XRay Button Draggable", Default = true, Callback = function(v)
Hub.XRayButtonState.draggable = v
Hub.TouchButtons.UpdateHoldHint(Hub.XRayButtonState.button, v)
end })
-- ───────── Combat ─────────
Tabs.Combat:Section({ Title = "Crosshair" })
Tabs.Combat:Toggle({ Title = "Custom Crosshair", Default = false, Callback = function(v)
Hub.Crosshair.SetEnabled(v)
end })
Tabs.Combat:Dropdown({ Title = "Crosshair Style", Values = { "star", "heart", "circle-plus", "crosshair" }, Default = "crosshair", Callback = function(v)
Hub.CrosshairStyle = v
if Hub.CrosshairEnabled then RebuildCrosshair() end
end })
Tabs.Combat:Dropdown({ Title = "Crosshair Visibility", Values = { "Always", "While Aiming", "While Shooting" }, Default = "Always", Callback = function(v)
Hub.CrosshairVisibility = v
end })
Tabs.Combat:Input({ Title = "Custom Cursor Name", Default = "", Callback = function(v)
Hub.Crosshair.SetCustomIcon(v)
end })
Tabs.Combat:Slider({ Title = "Crosshair Size", Min = 5, Max = 60, Default = 20, Rounding = 0, Callback = function(v)
Hub.CrosshairSize = v
if Hub.CrosshairEnabled then RebuildCrosshair() end
end })
Tabs.Combat:Toggle({ Title = "RGB Crosshair", Default = false, Callback = function(v)
Hub.CrosshairRGB = v
end })
Tabs.Combat:Colorpicker({ Title = "Crosshair Color", Default = Color3.fromRGB(168, 85, 247), Callback = function(v)
Hub.CrosshairColor = v
if Hub.CrosshairEnabled then RebuildCrosshair() end
end })
Tabs.Combat:Section({ Title = "Aim" })
local aimToggleControl
aimToggleControl = Tabs.Combat:Toggle({ Title = "Aim", Default = false, Callback = function(v)
Hub.AimEnabled = v
end })
Hub.TouchButtons.AimToggleControl = aimToggleControl
Tabs.Combat:Slider({ Title = "Prediction Strength", Min = 0, Max = 1, Default = 0.1, Rounding = 2, Callback = function(v)
Hub.AimPrediction = v
end })
Tabs.Combat:Dropdown({ Title = "Aim Style", Values = { "Aimlock", "Silent Aim" }, Default = "Aimlock", Callback = function(v)
Hub.AimStyle = v
end })
Tabs.Combat:Keybind({ Title = "Aimlock Keybind", Default = Enum.KeyCode.Q, Callback = function()
Hub.AimEnabled = not Hub.AimEnabled
if Hub.TouchButtons.AimToggleControl then
Hub.TouchButtons.SetControlValue(Hub.TouchButtons.AimToggleControl, Hub.AimEnabled)
end
end })
Tabs.Combat:Toggle({ Title = "Aimlock Button", Default = false, Callback = function(v)
Hub.TouchButtons.ToggleAimlockButton(v)
end })
Tabs.Combat:Dropdown({ Title = "Aimlock Button Size", Values = { "Small", "Medium", "Large" }, Default = "Medium", Callback = function(v)
Hub.AimlockButtonState.size = v
if Hub.AimlockButtonState.enabled then Hub.TouchButtons.ToggleAimlockButton(true) end
end })
Tabs.Combat:Dropdown({ Title = "Aimlock Button Shape", Values = { "Square", "Round" }, Default = "Round", Callback = function(v)
Hub.AimlockButtonState.shape = v
end })
Tabs.Combat:Colorpicker({ Title = "Aimlock Icon Color", Default = Color3.fromRGB(168, 85, 247), Callback = function(v)
Hub.AimlockButtonState.outlineColor = v
end })
Tabs.Combat:Toggle({ Title = "Aimlock Button Draggable", Default = true, Callback = function(v)
Hub.AimlockButtonState.draggable = v
Hub.TouchButtons.UpdateHoldHint(Hub.AimlockButtonState.button, v)
end })
Tabs.Combat:Slider({ Title = "FOV Size", Min = 10, Max = 500, Default = 120, Rounding = 0, Callback = function(v)
Hub.AimFOV = v
end })
Tabs.Combat:Dropdown({ Title = "Aimlock Part", Values = { "Head", "HumanoidRootPart", "Torso" }, Default = "Head", Callback = function(v)
Hub.AimPart = v
end })
Tabs.Combat:Toggle({ Title = "Hide FOV", Default = false, Callback = function(v)
Hub.HideFOV = v
end })
Tabs.Combat:Toggle({ Title = "Only Aim While Sheriff", Default = false, Callback = function(v)
Hub.OnlyAimAsSheriff = v
end })
Tabs.Combat:Toggle({ Title = "Ignore Walls", Default = false, Callback = function(v)
Hub.IgnoreWalls = v
end })
Tabs.Combat:Section({ Title = "Sheriff" })
local autoShootToggleControl
autoShootToggleControl = Tabs.Combat:Toggle({ Title = "Auto Shoot Button", Default = false, Callback = function(v)
Hub.TouchButtons.ToggleAutoShootButton(v)
end })
Hub.TouchButtons.AutoShootToggleControl = autoShootToggleControl
Tabs.Combat:Dropdown({ Title = "Auto Shoot Mode", Values = { "Normal", "Behind Walls" }, Default = "Normal", Callback = function(v)
Hub.AutoShootMode = v
end })
Tabs.Combat:Dropdown({ Title = "Auto Shoot Part", Values = { "Head", "HumanoidRootPart", "Torso" }, Default = "Head", Callback = function(v)
Hub.AutoShootPart = v
end })
Tabs.Combat:Dropdown({ Title = "Shoot Button Size", Values = { "Small", "Medium", "Large" }, Default = "Medium", Callback = function(v)
Hub.AutoShootDragState.size = v
if Hub.AutoShootDragState.enabled then Hub.TouchButtons.ToggleAutoShootButton(true) end
end })
Tabs.Combat:Dropdown({ Title = "Shoot Button Shape", Values = { "Square", "Round" }, Default = "Round", Callback = function(v)
Hub.AutoShootDragState.shape = v
end })
Tabs.Combat:Colorpicker({ Title = "Shoot Icon Color", Default = Color3.fromRGB(168, 85, 247), Callback = function(v)
Hub.AutoShootDragState.outlineColor = v
end })
Tabs.Combat:Toggle({ Title = "Shoot Button Draggable", Default = true, Callback = function(v)
Hub.AutoShootDragState.draggable = v
Hub.TouchButtons.UpdateHoldHint(Hub.AutoShootDragState.button, v)
end })
Tabs.Combat:Keybind({ Title = "Auto Shoot Keybind", Default = Enum.KeyCode.X, Callback = function()
Hub.TriggerAutoShootInput()
end })
Tabs.Combat:Section({ Title = "Murderer" })
Tabs.Combat:Button({ Title = "Bring + Freeze Sheriff", Callback = function()
local sheriff = fn31_findSheriff()
if not sheriff then
WindUI:Notify({ Title = "Sheriff", Content = "Sheriff not found", Icon = "user-x", Duration = 2 })
return
end
local sheriffRoot = fn40_getRoot(sheriff)
local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
if sheriffRoot and myRoot then
sheriffRoot.CFrame = myRoot.CFrame * CFrame.new(0, 0, -3)
local humanoid = sheriff.Character and sheriff.Character:FindFirstChildOfClass("Humanoid")
if humanoid then humanoid.WalkSpeed = 0 end
end
end })
Tabs.Combat:Toggle({ Title = "Spinbot", Default = false, Callback = function(v)
Hub.Spinbot.SetEnabled(v)
end })
Tabs.Combat:Slider({ Title = "Spin Speed", Min = 1, Max = 100, Default = 20, Rounding = 0, Callback = function(v)
Hub.SpinSpeed = v
end })
Tabs.Combat:Toggle({ Title = "Hitbox Expander", Default = false, Callback = function(v)
Hub.HitboxExpander.SetEnabled(v)
end })
Tabs.Combat:Slider({ Title = "Hitbox Size", Min = 1, Max = 30, Default = 8, Rounding = 0, Callback = function(v)
Hub.HitboxSize = v
if Hub.HitboxEnabled then Hub.HitboxExpander.Apply() end
end })
Tabs.Combat:Toggle({ Title = "Show Hitboxes", Default = false, Callback = function(v)
Hub.HitboxExpander.SetShowHitboxes(v)
end })
Tabs.Combat:Button({ Title = "Knife Aura", Callback = function()
local character_ = localPlayer.Character
local root = character_ and character_:FindFirstChild("HumanoidRootPart")
if not root then return end
for _, player in ipairs(Players:GetPlayers()) do
if player ~= localPlayer and fn27_getRole(player) ~= "Murderer" then
local targetRoot = fn40_getRoot(player)
if targetRoot then
local dist = (targetRoot.Position - root.Position).Magnitude
if dist < 15 then
local knife = ("Knife")
local handle = knife and knife:FindFirstChildWhichIsA("BasePart")
if handle and type(firetouchinterest) == "function" then
pcall(function()
firetouchinterest(targetRoot, handle, 0)
task.wait(0.05)
firetouchinterest(targetRoot, handle, 1)
end)
end
end
end
end
end
end })
local throwKnifeToggleControl
throwKnifeToggleControl = Tabs.Combat:Toggle({ Title = "Throw Knife Button", Default = false, Callback = function(v)
Hub.TouchButtons.ToggleThrowKnifeButton(v)
end })
Hub.TouchButtons.ThrowKnifeToggleControl = throwKnifeToggleControl
Tabs.Combat:Dropdown({ Title = "Throw Knife Mode", Values = { "Nearest", "Murderer", "All" }, Default = "Nearest", Callback = function(v)
Hub.ThrowKnifeMode = v
end })
Tabs.Combat:Dropdown({ Title = "Throw Knife Button Size", Values = { "Small", "Medium", "Large" }, Default = "Medium", Callback = function(v)
Hub.ThrowKnifeButtonState.size = v
if Hub.ThrowKnifeButtonState.enabled then Hub.TouchButtons.ToggleThrowKnifeButton(true) end
end })
Tabs.Combat:Dropdown({ Title = "Throw Knife Button Shape", Values = { "Square", "Round" }, Default = "Round", Callback = function(v)
Hub.ThrowKnifeButtonState.shape = v
end })
Tabs.Combat:Colorpicker({ Title = "Throw Knife Icon Color", Default = Color3.fromRGB(168, 85, 247), Callback = function(v)
Hub.ThrowKnifeButtonState.outlineColor = v
end })
Tabs.Combat:Toggle({ Title = "Throw Knife Button Draggable", Default = true, Callback = function(v)
Hub.ThrowKnifeButtonState.draggable = v
Hub.TouchButtons.UpdateHoldHint(Hub.ThrowKnifeButtonState.button, v)
end })
Tabs.Combat:Keybind({ Title = "Throw Knife Keybind", Default = Enum.KeyCode.Z, Callback = function()
if Hub.TriggerThrowKnifeInput then Hub.TriggerThrowKnifeInput() end
end })
-- ───────── Misc ─────────
Tabs.Misc:Section({ Title = "General" })
Tabs.Misc:Toggle({ Title = "Avoid Murderer", Default = false, Callback = function(v)
Hub.AvoidMurdererEnabled = v
end })
Tabs.Misc:Slider({ Title = "Avoid Murderer Distance", Min = 10, Max = 100, Default = 30, Rounding = 0, Callback = function(v)
Hub.AvoidMurdererDistance = v
end })
local showTimerControl
showTimerControl = Tabs.Misc:Toggle({ Title = "Show Timer", Default = false, Callback = function(v)
Hub.ShowTimerEnabled = v
if v then
Hub.UpdateRoundTimer()
else
if Hub.TimerLabel and Hub.TimerLabel.Parent then
Hub.TimerLabel.Text = ""
end
end
end })
Hub.ShowTimerControl = showTimerControl
Tabs.Misc:Toggle({ Title = "Mobile Quick Menu", Default = false, Callback = function(v)
Hub.TouchButtons.ToggleQuickMenu(v)
end })
Tabs.Misc:Toggle({ Title = "Get Gun Button", Default = false, Callback = function(v)
Hub.TouchButtons.ToggleGetGunButton(v)
end })
Tabs.Misc:Dropdown({ Title = "Get Gun Button Size", Values = { "Small", "Medium", "Large" }, Default = "Medium", Callback = function(v)
Hub.GetGunButtonState.size = v
if Hub.GetGunButtonState.enabled then Hub.TouchButtons.ToggleGetGunButton(true) end
end })
Tabs.Misc:Dropdown({ Title = "Get Gun Button Shape", Values = { "Square", "Round" }, Default = "Round", Callback = function(v)
Hub.GetGunButtonState.shape = v
end })
Tabs.Misc:Colorpicker({ Title = "Get Gun Icon Color", Default = Color3.fromRGB(168, 85, 247), Callback = function(v)
Hub.GetGunButtonState.outlineColor = v
end })
Tabs.Misc:Toggle({ Title = "Get Gun Button Draggable", Default = true, Callback = function(v)
Hub.GetGunButtonState.draggable = v
Hub.TouchButtons.UpdateHoldHint(Hub.GetGunButtonState.button, v)
end })
Tabs.Misc:Keybind({ Title = "Get Gun Keybind", Default = Enum.KeyCode.J, Callback = function()
Hub.TakeDroppedGunOnce()
end })
Tabs.Misc:Toggle({ Title = "Bomb Jump Button", Default = false, Callback = function(v)
Hub.TouchButtons.ToggleBombJumpButton(v)
end })
Tabs.Misc:Dropdown({ Title = "Bomb Jump Button Size", Values = { "Small", "Medium", "Large" }, Default = "Medium", Callback = function(v)
Hub.BombJumpButtonState.size = v
if Hub.BombJumpButtonState.enabled then Hub.TouchButtons.ToggleBombJumpButton(true) end
end })
Tabs.Misc:Dropdown({ Title = "Bomb Jump Button Shape", Values = { "Square", "Round" }, Default = "Round", Callback = function(v)
Hub.BombJumpButtonState.shape = v
end })
Tabs.Misc:Colorpicker({ Title = "Bomb Jump Icon Color", Default = Color3.fromRGB(168, 85, 247), Callback = function(v)
Hub.BombJumpButtonState.outlineColor = v
end })
Tabs.Misc:Toggle({ Title = "Bomb Jump Button Draggable", Default = true, Callback = function(v)
Hub.BombJumpButtonState.draggable = v
Hub.TouchButtons.UpdateHoldHint(Hub.BombJumpButtonState.button, v)
end })
Tabs.Misc:Keybind({ Title = "Bomb Jump Keybind", Default = Enum.KeyCode.B, Callback = function()
Hub.RunBombJump()
end })
Tabs.Misc:Dropdown({ Title = "Fling Target", Values = { "Sheriff", "Murderer", "All" }, Default = "Sheriff", Callback = function(v)
Hub.FlingTarget = v
end })
Tabs.Misc:Button({ Title = "Fling Sheriff", Callback = function()
local sheriff = fn31_findSheriff()
if sheriff then Hub.FlingPlayer(sheriff) else
WindUI:Notify({ Title = "Fling", Content = "Sheriff not found", Icon = "user-x", Duration = 2 })
end
end })
Tabs.Misc:Button({ Title = "Fling Murderer", Callback = function()
local murderer = fn30_findMurderer()
if murderer then Hub.FlingPlayer(murderer) else
WindUI:Notify({ Title = "Fling", Content = "Murderer not found", Icon = "user-x", Duration = 2 })
end
end })
Tabs.Misc:Button({ Title = "Fling All Players", Callback = function()
for _, player in ipairs(Players:GetPlayers()) do
if player ~= localPlayer then
Hub.FlingPlayer(player)
end
end
end })
Tabs.Misc:Toggle({ Title = "Anti Lag", Default = false, Callback = function(v)
Hub.AntiLagEnabled = v
end })
-- ───────── Player ─────────
local antiFlingToggleControl
antiFlingToggleControl = Tabs.Player:Toggle({ Title = "Anti Fling", Default = false, Callback = function(v)
Hub.SetAntiFlingSource(v)
end })
Hub.AntiFlingToggleControl = antiFlingToggleControl
Tabs.Player:Toggle({ Title = "Spinbot", Default = false, Callback = function(v)
Hub.Spinbot.SetEnabled(v)
end })
Tabs.Player:Slider({ Title = "Spin Speed", Min = 1, Max = 100, Default = 20, Rounding = 0, Callback = function(v)
Hub.SpinSpeed = v
end })
-- ───────── Movement ─────────
Tabs.LocalPlayer:Slider({ Title = "Field of View", Min = 50, Max = 120, Default = 70, Rounding = 0, Callback = function(v)
workspace.CurrentCamera.FieldOfView = v
end })
Tabs.LocalPlayer:Slider({ Title = "WalkSpeed", Min = 8, Max = 100, Default = 16, Rounding = 0, Callback = function(v)
local humanoid = localPlayer.Character and localPlayer.OfClass("Humanoid")
if humanoid then humanoid.WalkSpeed = v end
Hub.WalkSpeed = v
end })
Tabs.LocalPlayer:Toggle({ Title = "Speed Glitch", Default = false, Callback = function(v)
Hub.SpeedGlitchEnabled = v
end })
Tabs.LocalPlayer:Slider({ Title = "Speed Glitch Power", Min = 1, Max = 10, Default = 3, Rounding = 1, Callback = function(v)
Hub.SpeedGlitchPower = v
end })
local noclipToggleControl
noclipToggleControl = Tabs.LocalPlayer:Toggle({ Title = "Noclip", Default = false, Callback = function(v)
Hub.NoclipEnabled = v
end })
Hub.TouchButtons.NoclipToggleControl = noclipToggleControl
Tabs.LocalPlayer:Keybind({ Title = "Noclip Keybind", Default = Enum.KeyCode.N, Callback = function()
Hub.NoclipEnabled = not Hub.NoclipEnabled
if Hub.TouchButtons.NoclipToggleControl then
Hub.TouchButtons.SetControlValue(Hub.TouchButtons.NoclipToggleControl, Hub.NoclipEnabled)
end
end })
Tabs.LocalPlayer:Toggle({ Title = "Noclip Button", Default = false, Callback = function(v)
Hub.TouchButtons.ToggleNoclipButton(v)
end })
Tabs.LocalPlayer:Dropdown({ Title = "Noclip Button Size", Values = { "Small", "Medium", "Large" }, Default = "Medium", Callback = function(v)
Hub.NoclipButtonState.size = v
if Hub.NoclipButtonState.enabled then Hub.TouchButtons.ToggleNoclipButton(true) end
end })
Tabs.LocalPlayer:Dropdown({ Title = "Noclip Button Shape", Values = { "Square", "Round" }, Default = "Round", Callback = function(v)
Hub.NoclipButtonState.shape = v
end })
Tabs.LocalPlayer:Colorpicker({ Title = "Noclip Icon Color", Default = Color3.fromRGB(168, 85, 247), Callback = function(v)
Hub.NoclipButtonState.outlineColor = v
end })
Tabs.LocalPlayer:Toggle({ Title = "Noclip Button Draggable", Default = true, Callback = function(v)
Hub.NoclipButtonState.draggable = v
Hub.TouchButtons.UpdateHoldHint(Hub.NoclipButtonState.button, v)
end })
local flyToggleControl
flyToggleControl = Tabs.LocalPlayer:Toggle({ Title = "Fly", Default = false, Callback = function(v)
Hub.FlyEnabled = v
if v then Hub.StartFly() else Hub.StopFly() end
end })
Hub.TouchButtons.FlyToggleControl = flyToggleControl
Tabs.LocalPlayer:Keybind({ Title = "Fly Keybind", Default = Enum.KeyCode.F, Callback = function()
Hub.FlyEnabled = not Hub.FlyEnabled
if Hub.TouchButtons.FlyToggleControl then
Hub.TouchButtons.SetControlValue(Hub.TouchButtons.FlyToggleControl, Hub.FlyEnabled)
end
if Hub.FlyEnabled then Hub.StartFly() else Hub.StopFly() end
end })
Tabs.LocalPlayer:Toggle({ Title = "Fly Button", Default = false, Callback = function(v)
Hub.TouchButtons.ToggleFlyButton(v)
end })
Tabs.LocalPlayer:Dropdown({ Title = "Fly Button Size", Values = { "Small", "Medium", "Large" }, Default = "Medium", Callback = function(v)
Hub.FlyButtonState.size = v
if Hub.FlyButtonState.enabled then Hub.TouchButtons.ToggleFlyButton(true) end
end })
Tabs.LocalPlayer:Dropdown({ Title = "Fly Button Shape", Values = { "Square", "Round" }, Default = "Round", Callback = function(v)
Hub.FlyButtonState.shape = v
end })
Tabs.LocalPlayer:Colorpicker({ Title = "Fly Icon Color", Default = Color3.fromRGB(168, 85, 247), Callback = function(v)
Hub.FlyButtonState.outlineColor = v
end })
Tabs.LocalPlayer:Toggle({ Title = "Fly Button Draggable", Default = true, Callback = function(v)
Hub.FlyButtonState.draggable = v
Hub.TouchButtons.UpdateHoldHint(Hub.FlyButtonState.button, v)
end })
Tabs.LocalPlayer:Slider({ Title = "Fly Speed", Min = 10, Max = 300, Default = 50, Rounding = 0, Callback = function(v)
Hub.FlySpeed = v
end })
Tabs.LocalPlayer:Toggle({ Title = "Infinite Jump", Default = false, Callback = function(v)
Hub.ToggleInfiniteJump(v)
end })
Tabs.LocalPlayer:Slider({ Title = "Jump Power", Min = 10, Max = 300, Default = 50, Rounding = 0, Callback = function(v)
Hub.JumpPower = v
end })
-- ───────── Farm ─────────
Tabs.Farm:Section({ Title = "Progression" })
Tabs.Farm:Toggle({ Title = "Auto Prestige", Default = false, Callback = function(v)
Hub.AutoPrestige.SetEnabled(v)
end })
Tabs.Farm:Toggle({ Title = "Auto Claim Rewards", Default = false, Callback = function(v)
Hub.AutoClaimReward.SetEnabled(v)
end })
Tabs.Farm:Section({ Title = "Coin Farm" })
local coinFarmStatParagraph
coinFarmStatParagraph = Tabs.Farm:Paragraph({ Title = "Coin Farm Statistics", Content = "Collected: 0 | XP: 0 | Hops: 0" })
task.spawn(function()
while true do
task.wait(5)
if coinFarmStatParagraph then
pcall(function()
coinFarmStatParagraph:Set(
"Coin Farm Statistics",
"Collected: " .. tostring(Hub.CoinFarm.totalCollected)
.. " | XP: " .. tostring(Hub.CoinFarm.totalEarnedXP)
.. " | Hops: " .. tostring(Hub.CoinFarm.serverHopCount)
)
end)
end
end
end)
local coinFarmToggleControl
coinFarmToggleControl = Tabs.Farm:Toggle({ Title = "Coin Farm", Default = false, Callback = function(v)
Hub.CoinFarm.enabled = v
if v then
Hub.CoinFarm.serverHopTimerStartedAt = os.clock()
Hub.CoinFarm.SetEnabled(true)
else
Hub.CoinFarm.SetEnabled(false)
end
end })
Tabs.Farm:Input({ Title = "Coin Farm Webhook", Default = "", Callback = function(v)
Hub.CoinFarm.SaveWebhook(v)
end })
Tabs.Farm:Button({ Title = "Test Webhook", Callback = function()
local ok = Hub.CoinFarm.SendWebhook("Test", "Webhook working — Project Selam0exe", 10701977)
WindUI:Notify({
Title = "Webhook",
Content = ok and "Sent successfully" or "Failed — check URL",
Icon = ok and "check" or "x",
Duration = 3,
})
end })
Tabs.Farm:Toggle({ Title = "Black Screen", Default = false, Callback = function(v)
Hub.CoinFarm.blackScreenEnabled = v
Hub.CoinFarm.SetBlackScreen(v, false)
end })
Tabs.Farm:Toggle({ Title = "Disable 3D Rendering", Default = false, Callback = function(v)
Hub.CoinFarm.disable3DRendering = v
Hub.CoinFarm.Set3DRenderingDisabled(v)
end })
Tabs.Farm:Toggle({ Title = "Farm XP While Coin Farming", Default = false, Callback = function(v)
Hub.CoinFarm.xpFarmEnabled = v
end })
Tabs.Farm:Toggle({ Title = "End Round When Coin Bag Is Full or Died", Default = false, Callback = function(v)
Hub.CoinFarm.endRoundEnabled = v
end })
Tabs.Farm:Toggle({ Title = "Server Hop If Low Players", Default = false, Callback = function(v)
Hub.CoinFarm.serverHopLowPlayers = v
end })
Tabs.Farm:Slider({ Title = "Server Hop Player Threshold", Min = 1, Max = 10, Default = 4, Rounding = 0, Callback = function(v)
Hub.CoinFarm.serverHopPlayerThreshold = v
end })
Tabs.Farm:Slider({ Title = "Server Hop Timer", Min = 0, Max = 60, Default = 0, Rounding = 0, Callback = function(v)
Hub.CoinFarm.serverHopTimerMinutes = v
end })
Tabs.Farm:Toggle({ Title = "Anti Bot Server Hop", Default = false, Callback = function(v)
Hub.CoinFarm.antiBotEnabled = v
end })
Hub.CoinFarm.speedControl = Tabs.Farm:Slider({
Title = "Coin Farm Speed (CFrame)",
Min = 10,
Max = 100,
Default = 28,
Rounding = 0,
Callback = function(v)
Hub.CoinFarm.speed = v
end
})
Hub.CoinFarm.tweenSpeedControl = Tabs.Farm:Slider({
Title = "Tween Speed",
Min = 10,
Max = 100,
Default = 28,
Rounding = 0,
Callback = function(v)
Hub.CoinFarm.tweenSpeed = v
end
})
Tabs.Farm:Dropdown({ Title = "Coin Farm Mode", Values = { "CFrame", "Tween" }, Default = "CFrame", Callback = function(v)
Hub.CoinFarm.mode = v
end })
Tabs.Farm:Dropdown({ Title = "Coin Farm Position", Values = { "Normal", "Under" }, Default = "Normal", Callback = function(v)
Hub.CoinFarm.position = v
end })
local function UpdateXPFarmLock()
if coinFarmToggleControl then
pcall(function()
coinFarmToggleControl:SetLocked(Hub.CoinFarm.xpFarmLocked == true)
end)
end
end
Hub.CoinFarm.UpdateXPFarmLock = UpdateXPFarmLock
-- ───────── Teleports ─────────
Tabs.Teleports:Button({ Title = "TP to Murderer", Callback = function()
local murderer = fn30_findMurderer()
local root = localPlayer.Character and localPlayer.character_:FindFirstChild("HumanoidRootPart")
local targetRoot = murderer and fn40_getRoot(murderer)
if root and targetRoot then
root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
else
WindUI:Notify({ Title = "Teleport", Content = "Murderer not found", Icon = "user-x", Duration = 2 })
end
end })
Tabs.Teleports:Button({ Title = "TP to Sheriff", Callback = function()
local sheriff = fn31_findSheriff()
local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
local targetRoot = sheriff and fn40_getRoot(sheriff)
if root and targetRoot then
root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
else
WindUI:Notify({ Title = "Teleport", Content = "Sheriff not found", Icon = "user-x", Duration = 2 })
end
end })
Tabs.Teleports:Button({ Title = "TP to Gun", Callback = function()
local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
if not root then return end
local map = Hub.CoinFarm.ResolveMap() or workspace
local best, bestDist = nil, math.huge
for _, obj in ipairs(map:GetDescendants()) do
if obj:IsA("Tool") and obj.Parent == map then
local handle = obj:FindFirstChildWhichIsA("BasePart")
if handle then
local dist = (handle.Position - root.Position).Magnitude
if dist < bestDist then best = handle; bestDist = dist end
end
end
end
if best then
root.CFrame = CFrame.new(best.Position + Vector3.new(0, 3, 0))
else
WindUI:Notify({ Title = "Teleport", Content = "No gun found", Icon = "package-x", Duration = 2 })
end
end })
Tabs.Teleports:Button({ Title = "TP to Safezone", Callback = function()
fn23_tpToSafezone()
end })
Tabs.Teleports:Button({ Title = "TP to Lobby", Callback = function()
local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
if not root then return end
local lobby = workspace:FindFirstChild("Lobby") or workspace:FindFirstChild("LobbyArea")
if lobby then
local part = lobby:FindFirstChildWhichIsA("BasePart")
if part then
root.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
return
end
end
root.CFrame = CFrame.new(0, 100, 0)
end })
Tabs.Teleports:Button({ Title = "TP to Game Arena", Callback = function()
local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
if not root then return end
local map = Hub.CoinFarm.ResolveMap()
if map then
local part = map:FindFirstChildWhichIsA("BasePart")
if part then
root.CFrame = CFrame.new(part.Position + Vector3.new(0, 5, 0))
return
end
end
WindUI:Notify({ Title = "Teleport", Content = "Arena not found", Icon = "map-pin", Duration = 2 })
end })
Tabs.Teleports:Button({ Title = "TP to Voting Board", Callback = function()
local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
if not root then return end
local board = workspace:FindFirstChild("VotingBoard", true) or workspace:FindFirstChild("MapVote", true)
if board and board:IsA("BasePart") then
root.CFrame = CFrame.new(board.Position + Vector3.new(0, 5, 0))
else
WindUI:Notify({ Title = "Teleport", Content = "Voting board not found", Icon = "map-pin", Duration = 2 })
end
end })
local autoVoteEnabled = false
local selectedVoteMap = "Random"
local mapVoteOptions = { "Random", "Mansion", "Ski Lodge", "Carnival", "Forest", "Library" }
Tabs.Teleports:Toggle({ Title = "Auto Map Vote", Default = false, Callback = function(v)
autoVoteEnabled = v
end })
Tabs.Teleports:Dropdown({ Title = "Voting Board", Values = mapVoteOptions, Default = "Random", Callback = function(v)
selectedVoteMap = v
end })
local playerDropdownOptions = {}
local function refreshPlayerDropdown()
playerDropdownOptions = {}
for _, p in ipairs(Players:GetPlayers()) do
if p ~= localPlayer then
table.insert(playerDropdownOptions, p.Name)
end
end
return playerDropdownOptions
end
local tpPlayerDropdown
tpPlayerDropdown = Tabs.Teleports:Dropdown({ Title = "TP to Player", Values = refreshPlayerDropdown(), Default = "", Callback = function(v)
local root = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
local target = Players:FindFirstChild(v)
local targetRoot = target and fn40_getRoot(target)
if root and targetRoot then
root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
end
end })
Tabs.Teleports:Button({ Title = "Refresh Player List", Callback = function()
local opts = refreshPlayerDropdown()
if tpPlayerDropdown then
pcall(function() tpPlayerDropdown:Refresh(opts) end)
end
end })
-- ───────── Settings ─────────
Tabs.Settings:Section({ Title = "Mobile Button Style" })
Tabs.Settings:Colorpicker({ Title = "Mobile Button Icon Color", Default = Color3.fromRGB(168, 85, 247), Callback = function(v)
Hub.TouchButtons.SetThemeColor(v)
end })
Tabs.Settings:Section({ Title = "Theme / Background" })
Tabs.Settings:Dropdown({ Title = "Select Theme", Values = { "Purple", "Dark", "Light", "Crimson", "Ocean" }, Default = "Purple", Callback = function(v)
Hub.SelectedTheme = v
end })
Tabs.Settings:Button({ Title = "Apply Theme", Callback = function()
local themes = {
Purple  = { Primary = Color3.fromRGB(168, 85, 247),  Background = Color3.fromRGB(15, 7, 30)    },
Dark    = { Primary = Color3.fromRGB(100, 100, 100), Background = Color3.fromRGB(10, 10, 10)   },
Light   = { Primary = Color3.fromRGB(80, 80, 200),   Background = Color3.fromRGB(240, 240, 240) },
Crimson = { Primary = Color3.fromRGB(220, 50, 50),   Background = Color3.fromRGB(20, 5, 5)     },
Ocean   = { Primary = Color3.fromRGB(50, 150, 220),  Background = Color3.fromRGB(5, 15, 30)    },
}
local theme = themes[Hub.SelectedTheme] or themes.Purple
WindUI:SetTheme({ Primary = theme.Primary, Background = theme.Background })
end })
Tabs.Settings:Dropdown({ Title = "Select Background", Values = { "None", "Gradient", "Image", "Custom" }, Default = "None", Callback = function(v)
Hub.SelectedBackground = v
end })
Tabs.Settings:Input({ Title = "Background ID / URL", Default = "", Callback = function(v)
Hub.BackgroundCustomId = v
end })
Tabs.Settings:Section({ Title = "Keybind" })
Tabs.Settings:Keybind({ Title = "Keybind", Default = Enum.KeyCode.H, Callback = function()
WindUI:Toggle()
end })
Tabs.Settings:Section({ Title = "Configs" })
local configNameInput = ""
local selectedConfig = ""
local autoLoadConfig = "None"
local configList = {}
local function getConfigList()
local list = { "None" }
local ok, files = pcall(listfiles, "Foxname/configs")
if ok and files then
for _, f in ipairs(files) do
local name = f:match(([^/\\]+)%.json$")
if name then table.insert(list, name) end
end
end
configList = list
return list
end
local configDropdown
local autoLoadDropdown
Tabs.Settings:Input({ Title = "Config Name", Default = "", Callback = function(v)
configNameInput = v
end })
configDropdown = Tabs.Settings:Dropdown({ Title = "Selected Config", Values = getConfigList(), Default = "None", Callback = function(v)
selectedConfig = v
end })
autoLoadDropdown = Tabs.Settings:Dropdown({ Title = "Auto Load Config", Values = getConfigList(), Default = "None", Callback = function(v)
autoLoadConfig = v
if type(writefile) == "function" and type(makefolder) == "function" then
pcall(function()
if type(isfolder) == "function" and not isfolder("Foxname") then makefolder("Foxname") end
writefile("Foxname/autoload.txt", v)
end)
end
end })
Tabs.Settings:Button({ Title = "Save Config", Callback = function()
local name = configNameInput
if not name or name == "" then
WindUI:Notify({ Title = "Config", Content = "Enter a config name", Icon = "file-x", Duration = 2 })
return
end
if type(writefile) == "function" and type(makefolder) == "function" then
pcall(function()
if type(isfolder) == "function" and not isfolder("Foxname/configs") then
makefolder("Foxname")
makefolder("Foxname/configs")
end
local data = HttpService:JSONEncode(Hub.__Config or {})
writefile("Foxname/configs/" .. name .. ".json", data)
end)
WindUI:Notify({ Title = "Config", Content = "Saved: " .. name, Icon = "save", Duration = 2 })
end
end })
Tabs.Settings:Button({ Title = "Load Selected Config", Callback = function()
if selectedConfig == "None" or selectedConfig == "" then return end
if type(readfile) == "function" then
pcall(function()
local data = readfile("Foxname/configs/" .. selectedConfig .. ".json")
local cfg = HttpService:JSONDecode(data)
Hub.__Config = cfg
end)
WindUI:Notify({ Title = "Config", Content = "Loaded: " .. selectedConfig, Icon = "folder-open", Duration = 2 })
end
end })
Tabs.Settings:Button({ Title = "Delete Selected Config", Callback = function()
if selectedConfig == "None" or selectedConfig == "" then return end
if type(delfile) == "function" then
pcall(function() delfile("Foxname/configs/" .. selectedConfig .. ".json") end)
WindUI:Notify({ Title = "Config", Content = "Deleted: " .. selectedConfig, Icon = "trash-2", Duration = 2 })
end
end })
Tabs.Settings:Button({ Title = "Refresh Config List", Callback = function()
local list = getConfigList()
if configDropdown then pcall(function() configDropdown:Refresh(list) end) end
if autoLoadDropdown then pcall(function() autoLoadDropdown:Refresh(list) end) end
end })
Hub.ApplyAutoLoadConfig = function()
local target = autoLoadConfig
if type(target) ~= "string" or target == "None" or target == "" then
if type(readfile) == "function" then
pcall(function()
local saved = readfile("Foxname/autoload.txt")
if saved and saved ~= "None" and saved ~= "" then
target = saved
end
end)
end
end
if not target or target == "None" or target == "" then return end
if type(readfile) == "function" then
pcall(function()
local data = readfile("Foxname/configs/" .. target .. ".json")
local cfg = HttpService:JSONDecode(data)
Hub.__Config = cfg
end)
end
end
-- ═══════════════════════════════════════
-- 11. FPS BOOST + CLEANUP
-- ═══════════════════════════════════════
Hub.SetFPSBoost = function(enabled)
Hub.FPSBoostEnabled = enabled and true or false
if enabled then
pcall(function()
local Lighting = game:GetService("Lighting")
Lighting.GlobalShadows = false
end)
pcall(function()
workspace.StreamingEnabled = false
end)
else
pcall(function()
local Lighting = game:GetService("Lighting")
Lighting.GlobalShadows = true
end)
end
end
task.spawn(function()
while foxnameMM2Runtime.alive and not isTerminated do
task.wait(30)
for obj, entry in pairs(ESPTable) do
if not obj or not obj.Parent then
fn32(obj)
end
end
for gun, entry in pairs(GunESPTable) do
if not gun or not gun.Parent then
if entry.billboard and entry.billboard.Parent then
pcall(function() entry.billboard:Destroy() end)
end
GunESPTable[gun] = nil
end
end
for coin, entry in pairs(CoinESPTable) do
if not coin or not coin.Parent then
if entry.billboard and entry.billboard.Parent then
pcall(function() entry.billboard:Destroy() end)
end
CoinESPTable[coin] = nil
end
end
for player, data in pairs(ESP360Table) do
if not player or not player.Parent then
fn15(player)
end
end
if Hub.AntiLagEnabled then
local chr = localPlayer.Character
if chr then
for _, obj in ipairs(chr:GetDescendants()) do
if obj:IsA("BodyMover") and obj.Name ~= "FoxnameFly" and obj.Name ~= "FoxnameFlyGyro" then
pcall(function() obj:Destroy() end)
end
end
end
end
end
end)
-- ═══════════════════════════════════════
-- 12. FINAL
-- ═══════════════════════════════════════
WindUI:Notify({
Title = "Project Selam0exe",
Content = "discord.gg/25Rh47p3HY",
Icon = "sparkles",
Duration = 6,
})
Hub.ApplyAutoLoadConfig()
Hub.CoinFarm.ApplyResume()

