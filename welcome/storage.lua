if (true) then return end

include("autorun/sh_welcome.lua")

surface.CreateFont("welcome_8", {
	font = "Roboto",
	size = 8,
	weight = 500,
})
surface.CreateFont("welcome_24", {
	font = "Roboto",
	size = 24,
	weight = 500,
})
surface.CreateFont("welcome_30", {
	font = "Roboto",
	size = 30,
	weight = 500,
})
surface.CreateFont("discord_40", {
	font = "Roboto",
	size = 40,
	weight = 500,
})

local frameColor = Color(47, 54, 64)
local buttonColor = Color(190, 190, 190, 200)
local discordColor = Color(88, 101, 242)

//Function to create the derma.
function ZACH_WELCOME.CreateMenu()
    print("CREATING MENU")

    local scrw, scrh = ScrW(), ScrH()
    local animTime, animDelay, animEase = .5, 0, -1
    local isAnimating = true
    local ply = LocalPlayer()

    ZACH_WELCOME.Menu = vgui.Create("DFrame")
    ZACH_WELCOME.Menu:Center()
    ZACH_WELCOME.Menu:SetTitle("")
    ZACH_WELCOME.Menu:SetDraggable(false)
    ZACH_WELCOME.Menu:MakePopup(true)
    ZACH_WELCOME.Menu:SizeTo(scrw * .4, scrh * .4, animTime, animeDelay, animEase, function()
        isAnimating = true
    end)
    ZACH_WELCOME.Menu.Paint = function(self, w, h)
        surface.SetDrawColor(frameColor)
        surface.DrawRect(0, 0, w, h)
        
        draw.SimpleText("Welcome, " .. ply:Nick() .. ", to Ridge Gaming!", "welcome_30", w / 2, h * .15, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("This server is currently under " .. ZACH_WELCOME.Status .. " development.", "welcome_24", w / 2, h * .3, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Please join the discord for updates or more information!", "welcome_24", w / 2, h * .7, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
        draw.SimpleText("ridge.gg", "welcome_8", w / 2, h * .96, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
    end

    local discordButton = ZACH_WELCOME.Menu:Add("DButton")
    discordButton:Dock(BOTTOM)
    discordButton:DockMargin(scrw * .15, 0, scrw * .15, 15)
    discordButton:SetSize(scrw * .03, scrh * .06)
    discordButton:SetText("")
    discordButton.Paint = function(self, w, h)
        surface.SetDrawColor(buttonColor)
        surface.DrawRect(0, 0, w, h)

        draw.SimpleText("Discord", "discord_40", w / 2, h / 2, discordColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    discordButton.DoClick = function(self)
        gui.OpenURL("https://ridge.gg")
    end

    ZACH_WELCOME.Menu.OnSizeChanged = function(self, w, h)
        if (isAnimating) then
            self:Center()
        end
    end
end

//Function to open the menu.
function ZACH_WELCOME.Open()
    print("OPENING MENU")

    ZACH_WELCOME.CreateMenu()
end

//Client receives server PlayerInitialSpawn and calls the menu to open.
net.Receive("zach_initial_spawn", function(ply)
    print("NET MESSAGE RECEIVED")

    //ZACH_WELCOME.Open()
end)

//Chat command to manually open the welcome menu.
hook.Add("OnPlayerChat", "WelcomeMenuCommand", function(ply, str) 
    if (ply != LocalPlayer()) then return end

	str = string.lower(str)

	if (str == "!w") then
		print("CHAT COMMAND USED")

        ZACH_WELCOME.Open()

		return false
	end
end)

print("cl_welcome.lua loaded")