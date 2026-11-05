-- ===== region-join learning (TSB native region select) =====
-- TSB reportedly lets you pick a region before a match. Most Roblox games
-- implement that by firing a RemoteEvent with the region as an argument,
-- and having their server do TeleportAsync with matchmaking. If so, we can
-- capture that remote and replay it with a different region value.
-- If TSB instead sets the region inside TeleportService options locally,
-- there is no remote to capture and this whole section is a no-op.
local KNOWN_REGIONS = {
    "eu", "us", "na", "asia", "asiae", "asias", "au",
    "europe", "america", "americas", "singapore", "frankfurt",
    "sydney", "tokyo", "mumbai", "brazil", "sa", "southamerica",
    "nae", "naw", "eune", "euw", "oce", "sea",
}

local function regionRemoteScore(name)
    name = string.lower(tostring(name))
    local score = 0
    if string.find(name, "region", 1, true) then score = score + 20 end
    if string.find(name, "join", 1, true)   then score = score + 10 end
    if string.find(name, "play", 1, true)   then score = score + 10 end
    if string.find(name, "queue", 1, true)  then score = score + 10 end
    if string.find(name, "match", 1, true)  then score = score + 10 end
    if string.find(name, "teleport", 1, true) then score = score + 5 end
    return score
end

-- Returns topIndex, innerKey, currentValue OR nil.
--   topIndex   = which top-level argument holds the region
--   innerKey   = if the region is nested in a table, which key
--   currentVal = the region string we found
local function detectRegionInArgs(args)
    for i = 1, args.n do
        local a = args[i]
        if type(a) == "string" then
            local la = string.lower(a)
            for _, r in ipairs(KNOWN_REGIONS) do
                if la == r then return i, nil, a end
            end
        elseif type(a) == "table" then
            for k, v in pairs(a) do
                if type(v) == "string" then
                    local lk = string.lower(tostring(k))
                    if lk == "region" or lk == "zone" or lk == "area" then
                        return i, k, v
                    end
                    local lv = string.lower(v)
                    for _, r in ipairs(KNOWN_REGIONS) do
                        if lv == r then return i, k, v end
                    end
                end
            end
        end
    end
    return nil
end

local function dumpLearnBuf()
    print("[TSB] Region learn capture (" .. #learnBuf .. " call(s)):")
    for _, rec in ipairs(learnBuf) do
        local parts = {}
        for j = 1, rec.args.n do
            local a = rec.args[j]
            if type(a) == "string" then
                parts[j] = string.format("[%d]str=%q", j, a)
            elseif type(a) == "number" or type(a) == "boolean" then
                parts[j] = string.format("[%d]=%s", j, tostring(a))
            elseif type(a) == "table" then
                local td = {}
                for k, v in pairs(a) do td[#td + 1] = tostring(k) .. "=" .. tostring(v) end
                parts[j] = string.format("[%d]tbl{%s}", j, table.concat(td, ","))
            else
                parts[j] = string.format("[%d]%s", j, typeof(a))
            end
        end
        print(string.format("  %s -> %s", rec.name, table.concat(parts, " ")))
    end
end

function F.learnRegionJoin()
    if not installHook() then
        notify("Executor doesn't support hookmetamethod.", 5)
        return
    end
    if learning then
        notify("Already learning — wait a few seconds.", 3)
        return
    end
    learnBuf = {}
    learning = "REGION"
    notify("Tap TSB's Play/Join with your region selected — once. (10s)", 10)
    task.delay(10, function()
        learning = nil
        if #learnBuf == 0 then
            notify("Nothing captured. Tap Play again while learning is active.", 5)
            return
        end
        dumpLearnBuf()

        local best, bestScore = nil, -1
        for _, rec in ipairs(learnBuf) do
            local sc = regionRemoteScore(rec.name)
            if sc > bestScore then best, bestScore = rec, sc end
        end
        if not best then
            notify("Capture had no usable remote — check console dump.", 6)
            return
        end

        local topIndex, innerKey, curVal = detectRegionInArgs(best.args)
        regionJoin = {
            remote = best.remote,
            name = best.name,
            args = best.args,
            topIndex = topIndex,
            innerKey = innerKey,
            currentRegion = curVal,
        }

        if topIndex then
            notify(string.format(
                "Learned region join: %s (region at [%d]%s = %q)",
                best.name, topIndex,
                innerKey and ("." .. tostring(innerKey)) or "",
                tostring(curVal)), 8)
            pcall(function()
                if Options and Options.RegionValue then
                    Options.RegionValue:SetValue(tostring(curVal))
                end
            end)
        else
            notify(string.format(
                "Captured %s but couldn't find a region argument. " ..
                "See console for full dump — you may need to test the learned remote manually.",
                best.name), 10)
        end
    end)
end

function F.joinViaLearnedRegion(regionValue)
    if not regionJoin or not regionJoin.remote then
        return false, "No region join learned yet."
    end
    if not regionJoin.topIndex then
        return false, "Learned remote had no detectable region argument."
    end
    if not regionValue or regionValue == "" then
        return false, "Region value is empty — set it in the Servers tab."
    end

    local src = regionJoin.args
    local newArgs = table.pack(table.unpack(src, 1, src.n))

    if regionJoin.innerKey ~= nil then
        local inner = {}
        for k, v in pairs(newArgs[regionJoin.topIndex]) do inner[k] = v end
        inner[regionJoin.innerKey] = regionValue
        newArgs[regionJoin.topIndex] = inner
    else
        newArgs[regionJoin.topIndex] = regionValue
    end

    pcall(refreshArgs, newArgs)

    local r = regionJoin.remote
    if not (r and r.Parent) then
        local ch = lp.Character
        r = ch and ch:FindFirstChild(regionJoin.name)
    end
    if not r then
        return false, "Learned remote gone (character reset?). Re-learn."
    end

    local ok, err = pcall(function()
        r:FireServer(table.unpack(newArgs, 1, newArgs.n))
    end)
    if not ok then return false, "Fire error: " .. tostring(err) end
    return true
end

-- ===== server browser helpers =====
local fetchedServers, serverLabelMap = {}, {}

function F.fetchServers(maxPlayers)
    local ok, body = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId ..
            "/servers/Public?sortOrder=Asc&limit=100")
    end)
    if not ok then return nil, "Could not fetch the server list" end
    local ok2, data = pcall(function() return HttpService:JSONDecode(body) end)
    if not ok2 or type(data) ~= "table" or type(data.data) ~= "table" then
        return nil, "Bad server list response"
    end
    local list = {}
    for _, s in ipairs(data.data) do
        if type(s.id) == "string"
            and type(s.playing) == "number"
            and type(s.maxPlayers) == "number"
            and s.id ~= game.JobId
            and s.playing <= maxPlayers then
            list[#list + 1] = {
                id = s.id,
                playing = s.playing,
                maxPlayers = s.maxPlayers,
                ping = s.ping,
            }
        end
    end
    return list
end

function F.serverLabel(s)
    local ping = s.ping and (tostring(s.ping) .. "ms") or "?ms"
    return string.format("%d/%d | %s | %s",
        s.playing, s.maxPlayers, ping, string.sub(s.id, 1, 8))
end

function F.joinServerById(id)
    if not id or id == "" then notify("No server selected", 4) return end
    notify("Joining " .. string.sub(id, 1, 8) .. "...", 3)
    local ok = pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, id, lp)
    end)
    if not ok then notify("Join failed (teleport error)", 5) end
end

function F.refreshServerList(maxPlayers, sortMode, onStatus, picker)
    task.spawn(function()
        if onStatus then onStatus("Fetching...") end
        local list, err = F.fetchServers(maxPlayers)
        if not list then
            if onStatus then onStatus("Error: " .. tostring(err)) end
            notify(tostring(err), 5)
            return
        end
        if #list == 0 then
            if onStatus then onStatus("No servers with " .. maxPlayers .. " or fewer players.") end
            if picker then pcall(function() picker:SetValues({ "-" }) end) end
            fetchedServers, serverLabelMap = {}, {}
            return
        end
        if sortMode == "Lowest ping" then
            table.sort(list, function(a, b) return (a.ping or 999) < (b.ping or 999) end)
        elseif sortMode == "Least players" then
            table.sort(list, function(a, b) return a.playing < b.playing end)
        end
        fetchedServers = list
        serverLabelMap = {}
        local labels = {}
        for i, s in ipairs(list) do
            local base = F.serverLabel(s)
            local lbl, n = base, 2
            while serverLabelMap[lbl] do
                lbl = base .. " #" .. n
                n = n + 1
            end
            serverLabelMap[lbl] = s
            labels[i] = lbl
        end
        if picker then
            pcall(function() picker:SetValues(labels) end)
            pcall(function() picker:SetValue(labels[1]) end)
        end
        if onStatus then
            onStatus(string.format("Found %d server(s). Pick one and Join.", #list))
        end
    end)
end

function F.joinSelectedServer(selected, onStatus)
    if not selected or selected == "-" then
        notify("Pick a server from the dropdown first", 4)
        return
    end
    local s = serverLabelMap[selected]
    if not s then
        notify("Could not resolve the selected server. Refresh and try again.", 4)
        return
    end
    if onStatus then
        onStatus(string.format("Joining %d/%d | %s...", s.playing, s.maxPlayers, s.id))
    end
    F.joinServerById(s.id)
end
