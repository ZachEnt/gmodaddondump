local _P = FindMetaTable("Player")

util.AddNetworkString("notice_send")

hook.Add("PlayerSpawn", "RunSomeCodeOnThePlayer", function(ply)
    ply:SendNotice("You just spawned in!")
end)

function _P:SendNotice(msg)
    net.Start("notice_send")
    net.WriteString(msg)
    net.Send(self)
end

print("sv_chatbox.lua loaded")