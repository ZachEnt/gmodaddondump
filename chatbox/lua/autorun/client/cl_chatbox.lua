local clr = Color(255, 0, 0)

net.Receive("notice_send", function()
    local msg = net.ReadString()

    chat.AddText(clr, " [Notice] ", color_white, msg)
end)

print("cl_chatbox.lua loaded")