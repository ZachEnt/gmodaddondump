if (not TESTADDON_ENABLED) then return end

include("autorun/sh_testaddon.lua")

util.AddNetworkString("displaymessage_update")
util.AddNetworkString("scoreboard_open")

local function SetDisplayMessage(text)
    ZACH_DISPLAYMESSAGE = text
    net.Start("displaymessage_update")
    net.WriteString(ZACH_DISPLAYMESSAGE)
    net.Broadcast()
end

hook.Add("PlayerSpawn", "PlayerSpawnNotify", function(ply)
    // Called when the player spawns in
    SetDisplayMessage(ply:Name() .. " has spawned in!")
end)

hook.Add("PlayerDisconnected", "PlayerDisconnectNotify",function(ply)
    // Called when the player leaves
    SetDisplayMessage(ply:Name() .. " has disconnected!")
end)

hook.Add("PlayerInitialSpawn", "PlayerInitialSpawnNotify", function(ply)
    // Called when the player first spawns in
    net.Start("displaymessage_update")
    net.WriteString(ZACH_DISPLAYMESSAGE)
    net.Send(ply)
end)

net.Receive("scoreboard_open", function(len, ply)
    SetDisplayMessage(ply:Name() .. " has opened the scoreboard in " .. len)
end)

// Verify file loads
print(GLOBAL_LOADEDSERVER)