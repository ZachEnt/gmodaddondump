include("autorun/sh_welcome.lua")

util.AddNetworkString("zach_initial_spawn")

hook.Add("PlayerInitialSpawn", "OpenWelcomeMenu", function(ply)
    net.Start("zach_initial_spawn")
    net.Send(ply)
end)

print("sv_welcome.lua loaded")