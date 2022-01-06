surface.CreateFont("danimations_24", {
    font = "Roboto",
    size = 24,
    weight = 1000,
})

local frameColor = Color(47, 54, 64)
local buttonColor = Color(53, 59, 72)

function DANIMATIONS.OpenMenu()
    local scrw, scrh = ScrW(), ScrH()

    if (IsValid(DANIMATIONS.Menu)) then return end

    local frameW, frameH = scrw * .5, scrh * .5
    local animTime, animDelay, animeEase = 1.2, 0, 0.1
    local isAnimating = true 

    DANIMATIONS.Menu = vgui.Create("DFrame")
    DANIMATIONS.Menu:SetTitle("")
    DANIMATIONS.Menu:MakePopup(true)
    DANIMATIONS.Menu:SetSize(0, 0)
    DANIMATIONS.Menu:Center()
    DANIMATIONS.Menu:SizeTo(frameW, frameH, animTime, animDelay, animeEase, function()
        isAnimating = false
    end)
    DANIMATIONS.Menu.Paint = function(self, w, h)
        surface.SetDrawColor(frameColor)
        surface.DrawRect(0, 0, w, h)
    end

    local speed = 30
    local rainbowColor
    local buttonRainbow = DANIMATIONS.Menu:Add("DButton")
    buttonRainbow:Dock(TOP)
    buttonRainbow:SetText("")
    buttonRainbow.Paint = function(self, w, h)
        rainbowColor = HSVToColor((CurTime() * speed) % 360, 1, 1)
        surface.SetDrawColor(rainbowColor)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("Rainbow Button", "danimations_24", w * .5, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local speed = 3
    local range = 100
    local buttonSlide = DANIMATIONS.Menu:Add("DButton")
    buttonSlide:Dock(TOP)
    buttonSlide:SetText("")
    buttonSlide.Paint = function(self, w, h)
        local offset = range * math.sin(CurTime() * speed)
        surface.SetDrawColor(buttonColor)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("Sliding Text Button", "danimations_24", w * .5 + offset, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local speed = 2
    local barStatus = 0
    local buttonHover = DANIMATIONS.Menu:Add("DButton")
    buttonHover:Dock(TOP)
    buttonHover:SetText("")
    buttonHover.Paint = function(self, w, h)
        if (self:IsHovered()) then
            barStatus = math.Clamp(barStatus + speed * FrameTime(), 0, 1)   
        else
            barStatus = math.Clamp(barStatus - speed * FrameTime(), 0, 1)  
        end

        surface.SetDrawColor(buttonColor)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(rainbowColor)
        surface.DrawRect(0, h * .9, w * barStatus, h * .1)
        draw.SimpleText("Hover Effect Button", "danimations_24", w * .5, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    isActive = false
    local buttonToggle = DANIMATIONS.Menu:Add("DButton")
    buttonToggle:Dock(TOP)
    buttonToggle:SetText("")
    buttonToggle.Paint = function(self, w, h)
        surface.SetDrawColor(buttonColor)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("Button Toggle", "danimations_24", w * .5, h * .5, (not isActive and color_white or rainbowColor), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    buttonToggle.DoClick = function(self)
        isActive = not isActive
    end

    DANIMATIONS.Menu.OnSizeChanged = function(self, w, h)
        if (isAnimating) then
            self:Center()
        end

        buttonRainbow:SetTall(h * .1)
        buttonSlide:SetTall(h * .1)
        buttonHover:SetTall(h * .1)
        buttonToggle:SetTall(h  * .1)
    end
end
concommand.Add("danimations", DANIMATIONS.OpenMenu)

print("cl_danimations loaded")