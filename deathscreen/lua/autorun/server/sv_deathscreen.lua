if (DEATHSCREEN.Disabled) then return end

local nets = {
    "deathscreen_sendDeath",
    "deathscreen_removeDeath",
}

for k, v in pairs(nets) do
    util.AddNetworkString(v)
end

hook.Add("PlayerDeathThink", "NoNormalRespawn", function(ply)
    if (not timer.Exists(ply:SteamID() .. "respawnTime")) then
        return 
    else
        return false
    end
end)

hook.Add("PlayerDeath", "DeathScreenHandleDeath", function(victim, inflictor, attacker)
    net.Start("deathscreen_sendDeath")
    net.Send(victim)

    timer.Create(victim:SteamID() .. "respawnTime", DEATHSCREEN.RespawnTime, 1, function() end)
end)

hook.Add("PlayerSpawn", "DeathscreenRemove", function(ply)
    net.Start("deathscreen_removeDeath")
    net.Send(ply)

end)

hook.Add("PlayerDeathSound", "DisableDeathSound", function(ply)
    return true
end)

print("sv_deathscreen loaded")