include("autorun/sh_welcome.lua")

surface.CreateFont("welcome_36", {
	font = "Roboto",
	size = 36,
	weight = 500,
})
surface.CreateFont("welcome_48", {
	font = "Roboto",
	size = 48,
	weight = 500,
})

local frameColor = Color(47, 54, 64)
local discordColor = Color(88, 101, 242)
local scrw, scrh = ScrW(), ScrH()
local buttonColor = Color(84, 160, 255)
local frameColor = Color(34, 47, 62)
local whiteColor = Color(236, 240, 241)

//Function to create the derma.
function ZACH_WELCOME.CreateMenu()

    local ply = LocalPlayer()
    local fadeDown = 256
    local text = ""

    ZACH_WELCOME.Menu = vgui.Create("DFrame")
    ZACH_WELCOME.Menu:SetSize(scrw, scrh)
    ZACH_WELCOME.Menu:SetPos(0, 0)
    ZACH_WELCOME.Menu:SetTitle("")
    ZACH_WELCOME.Menu:SetDraggable(false)
    ZACH_WELCOME.Menu:MakePopup(true)
    ZACH_WELCOME.Menu:ShowCloseButton()
    ZACH_WELCOME.Menu.Paint = function(self, w, h)
        surface.SetDrawColor(frameColor)
        surface.DrawRect(0, 0, w, h)
        
        text = markup.Parse("<font=welcome_36>Welcome, " .. ply:Nick() .. ", to<color=120,200,255> Ridge Gaming<color=255,255,255,255>!")
        text:Draw(scrw / 2, scrh * .1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        text = markup.Parse("<font=welcome_36>This Server is currently under <color=255,0,0,255>" .. ZACH_WELCOME.Status .. "<color=255,255,255,255> development.")
        text:Draw(scrw / 2, scrh * .3, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        text = markup.Parse("<font=welcome_36>Please join the <color=120,200,255>Discord <color=255,255,255,255>for updates or more information.")
        text:Draw(scrw / 2, scrh * .5, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        //fadeDown = Lerp(1 * FrameTime(), fadeDown, 1)
        //surface.SetDrawColor(0, 0, 0, fadeDown)
        //surface.DrawRect(0, 0, scrw, scrh * .7)
    end
    
    local playButton = ZACH_WELCOME.Menu:Add("DButton")
    playButton:SetPos(scrw / 2 - 125, scrh * .8)
    playButton:SetSize(250, 100)
    playButton:SetText("")
    playButton:Show()
    playButton.barStatus = 0
    playButton.speed = 5
    playButton.Paint = function(self, w, h)
        surface.SetDrawColor(buttonColor)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("Play", "welcome_48", w / 2, h / 2, whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        if (self:IsHovered()) then
            self.barStatus = math.Clamp(self.barStatus + self.speed * FrameTime(), 0, 1)   
        else
            self.barStatus = math.Clamp(self.barStatus - self.speed * FrameTime(), 0, 1)  
        end

        surface.SetDrawColor(whiteColor)
        surface.DrawRect(w / 2 - w * self.barStatus, h * .95, w * self.barStatus * 2, h * .1)
    end
    playButton.DoClick = function(self)
        ZACH_WELCOME.Menu:Remove()
    end
    

    local discordButton = ZACH_WELCOME.Menu:Add("DButton")
    discordButton:SetPos(scrw / 2 - 500, scrh * .8)
    discordButton:SetSize(250, 100)
    discordButton:SetText("")
    discordButton:Show()
    discordButton.barStatus = 0
    discordButton.speed = 5
    discordButton.Paint = function(self, w, h)
        surface.SetDrawColor(buttonColor)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("Discord", "welcome_48", w / 2, h / 2, whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        if (self:IsHovered()) then
            self.barStatus = math.Clamp(self.barStatus + self.speed * FrameTime(), 0, 1)   
        else
            self.barStatus = math.Clamp(self.barStatus - self.speed * FrameTime(), 0, 1)  
        end

        surface.SetDrawColor(whiteColor)
        surface.DrawRect(w / 2 - w * self.barStatus, h * .95, w * self.barStatus * 2, h * .1)
    end
    discordButton.DoClick = function(self)
        gui.OpenURL("https://ridge.gg")
    end

    local aboutButton = ZACH_WELCOME.Menu:Add("DButton")
    aboutButton:SetPos(scrw / 2 + 250, scrh * .8)
    aboutButton:SetSize(250, 100)
    aboutButton:SetText("")
    aboutButton:Show()
    aboutButton.barStatus = 0
    aboutButton.speed = 5
    aboutButton.Paint = function(self, w, h)
        surface.SetDrawColor(buttonColor)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("Support Us", "welcome_48", w / 2, h / 2, whiteColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        if (self:IsHovered()) then
            self.barStatus = math.Clamp(self.barStatus + self.speed * FrameTime(), 0, 1)   
        else
            self.barStatus = math.Clamp(self.barStatus - self.speed * FrameTime(), 0, 1)  
        end

        surface.SetDrawColor(whiteColor)
        surface.DrawRect(w / 2 - w * self.barStatus, h * .95, w * self.barStatus * 2, h * .1)
    end
    aboutButton.DoClick = function(self, w, h)
        gui.OpenURL("https://ridge.gg/store")
    end
end

//Client receives server PlayerInitialSpawn and calls the menu to open.
net.Receive("zach_initial_spawn", function(ply)
    ZACH_WELCOME.CreateMenu()
end)

//Chat command to manually open the welcome menu.
hook.Add("OnPlayerChat", "WelcomeMenuCommand", function(ply, str) 
    if (ply != LocalPlayer()) then return end

	str = string.lower(str)

	if (str == "!w") then
        ZACH_WELCOME.CreateMenu()

		return false
	end
end)

print("cl_welcome.lua loaded")

// TO DO
// Add Panel for about us.
// Animate buttons in
// Remove close button
// New colors for buttons