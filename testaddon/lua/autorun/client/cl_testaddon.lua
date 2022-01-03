// Includes the shared
include("autorun/sh_testaddon.lua")

surface.CreateFont("zachsb_14", {
	font = "Roboto",
	size = 14,
	weight = 500,
})
surface.CreateFont("zachsb_24", {
	font = "Roboto",
	size = 24,
	weight = 500,
})

/*

hook.Add("HUDPaint", "ZachHud", function()
    local scrw, scrh = ScrW(), ScrH()
    local ply = LocalPlayer()
    local hp = ply:Health()
    local maxhp = ply:GetMaxHealth()
    local boxW = scrw * .1
    local boxH = scrh * .02

    surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(scrw / 2 - boxW / 2, scrh - boxH * 1.1, boxW, boxH)

    surface.SetDrawColor(255, 120, 120, 200)
    surface.DrawRect(scrw / 2 - boxW / 2, scrh - boxH * 1.1, boxW * (hp / maxhp), boxH)

    surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(scrw * .2, scrh * .05, scrw * .6, scrh * .05)
    draw.SimpleText(ZACH_DISPLAYMESSAGE, "zachsb_24", scrw / 2, scrh * .075, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

net.Receive("displaymessage_update", function()
    local newMessage = net.ReadString()
    ZACH_DISPLAYMESSAGE = newMessage
end)

local function CreateScoreboard()
    local scrw, scrh = ScrW(), ScrH()
    local ply = LocalPlayer()

    ZachScoreboard = vgui.Create("DFrame")
    ZachScoreboard:SetTitle("")
    ZachScoreboard:SetSize(scrw * .3, scrh * .6)
    ZachScoreboard:Center()
    ZachScoreboard:MakePopup()
    ZachScoreboard:ShowCloseButton(false)
    ZachScoreboard:SetDraggable(false)
    ZachScoreboard.Paint = function(self, w, h)
        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleText("Scoreboard", "zachsb_14", w / 2, h * .02, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local ypos = ZachScoreboard:GetTall() * .04

    local scroll = vgui.Create("DScrollPanel", ZachScoreboard)
    scroll:SetPos(0, ZachScoreboard:GetTall() * .05)
    scroll:SetSize(ZachScoreboard:GetWide(), ZachScoreboard:GetTall() * .95)
    
    for k, v in ipairs(player.GetAll()) do
        local name = v:Name()
        local ping = v:Ping()
        local PlayerPanel = vgui.Create("DPanel", scroll)
        PlayerPanel:SetPos(0, ypos)
        PlayerPanel:SetSize(ZachScoreboard:GetWide(), ZachScoreboard:GetTall() * .05)
        PlayerPanel.Paint = function(self, w, h)
            if !(IsValid(v)) then return end
            surface.SetDrawColor(0, 0, 0, 200)
            surface.DrawRect(0, 0, w, h)
            draw.SimpleText(name .. " Ping: " .. ping, "zachsb_14", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        ypos = ypos + PlayerPanel:GetTall() * 1.1
    end
end

local function ToggleScoreboard(toggle)
    if (toggle) then
        CreateScoreboard()
    else
        if IsValid(ZachScoreboard) then
            ZachScoreboard:Remove()
        end
    end
end

hook.Add("ScoreboardShow", "ZachScoreboardShow", function()
    ToggleScoreboard(true)
    net.Start("scoreboard_open")
    net.SendToServer()
    return false
end)

hook.Add("ScoreboardHide", "ZachScoreboardHide", function()
    ToggleScoreboard(false)
end)

*/


// Verify file loads
print(GLOBAL_LOADEDCLIENT)