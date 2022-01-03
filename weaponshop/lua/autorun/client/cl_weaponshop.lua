include("autorun/sh_weaponshop.lua")

surface.CreateFont("weaponshop_24", {
    font = "Roboto",
    extended = false,
    size = 24,
    weight = 500,
})
surface.CreateFont("weaponshop_18", {
    font = "Roboto",
    extended = false,
    size = 18,
    weight = 500,
})

function WEAPONSHOP.Open()
    local scrw, scrh = ScrW(), ScrH()

    WEAPONSHOP.Menu = vgui.Create("DFrame")
    WEAPONSHOP.Menu:SetSize(scrw * .35, scrh * .8)
    WEAPONSHOP.Menu:Center()
    WEAPONSHOP.Menu:SetTitle("")
    WEAPONSHOP.Menu:MakePopup()
    WEAPONSHOP.Menu.Paint = function(self, w, h)
        surface.SetDrawColor(WEAPONSHOP.Theme["background"])
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("SHOP", "weaponshop_24", w / 2, h * .02, WEAPONSHOP.Theme["text"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local scroll = vgui.Create("DScrollPanel", WEAPONSHOP.Menu)
    scroll:Dock(FILL)

    local frameW = WEAPONSHOP.Menu:GetWide()
    local frameH = WEAPONSHOP.Menu:GetTall()
    local yspace = frameH * .01

    for k, itemData in pairs(WEAPONSHOP.Items) do
        local ItemPanel = vgui.Create("DPanel", scroll)
        ItemPanel:DockMargin(0, 0, 0, yspace)
        ItemPanel:Dock(TOP)
        ItemPanel:SetTall(frameH * .1)
        ItemPanel.Paint = function(self, w, h)
            draw.SimpleText(itemData.name, "weaponshop_18", w * .02, h * .15, WEAPONSHOP.Theme["text"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText(itemData.description, "weaponshop_18", w * .02, h * .35, WEAPONSHOP.Theme["text"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
            draw.SimpleText(DarkRP.formatMoney(itemData.price), "weaponshop_18", w * .02, h * .55, WEAPONSHOP.Theme["text"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
        end

        local marginSpace = frameW * .03

        local PurchaseButton = vgui.Create("DButton", ItemPanel)
        PurchaseButton:Dock(RIGHT)
        PurchaseButton:SetWide(frameW * .2)
        PurchaseButton:DockMargin(0, marginSpace, marginSpace, marginSpace)
        PurchaseButton:SetText("")
        PurchaseButton.Paint = function(self, w, h)
            surface.SetDrawColor(WEAPONSHOP.Theme["purchasebutton"])
            surface.DrawRect(0, 0, w, h)
            draw.SimpleText("Purchase", "weaponshop_18", w / 2, h / 2, WEAPONSHOP.Theme["text"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        PurchaseButton.DoClick = function()
            net.Start("weaponshop_purchase")
            net.WriteInt(k, 32)
            net.SendToServer()
        end
    end
end

concommand.Add("weaponshop", function()
    WEAPONSHOP.Open()
end)

print("cl_weaponshop.lua loaded")