surface.CreateFont( "inv_24", {
    font = "Roboto",
    extended = false,
    size = 24,
    weight = 500,
})

concommand.Add("zach_model", function(ply)
    local wep = ply:GetActiveWeapon()

    if (not IsValid(wep)) then return end

    print(wep:GetWeaponWorldModel())
end)

net.Receive("inv_init", function()
    LocalPlayer().zach_inv = {}
end)

net.Receive("inv_give", function()
    local classname = net.ReadString()
    table.insert(LocalPlayer().zach_inv, classname)
end)

net.Receive("inv_remove", function()
    local id = net.ReadInt(32)

    LocalPlayer().zach_inv[id] = nil
end)

function ZACH_INV.Open()
    local ply = LocalPlayer()
    local plyInv = ply.zach_inv

    if (not ply.zach_inv) then return end

    local scrw, scrh = ScrW(), ScrH()

    ZACH_INV.Menu = vgui.Create("DFrame")
    local inv = ZACH_INV.Menu
    inv:SetSize(scrw * .4, scrh * .6)
    inv:Center()
    inv:SetTitle("")
    inv:MakePopup()
    inv.Paint = function(self, w, h)
        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawRect(0, 0, w, h)
    end

    local scroll = inv:Add("DScrollPanel")
    scroll:Dock(FILL)
    scroll.panels = {}

    local yPad = scrh * .01
    for k, classname in pairs(plyInv) do
        local itemData = ZACH_INV.Items[classname]
        
        local ItemPanel = scroll:Add("DPanel")
        ItemPanel:Dock(TOP)
        ItemPanel:DockMargin(0, yPad, 0, 0)
        ItemPanel.Paint = function(self, w, h)
            surface.SetDrawColor(0, 0, 0, 200)
            surface.DrawRect(0, 0, w, h)
            draw.SimpleText(itemData.name, "inv_24", w * .15, h * .2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        local icon = vgui.Create("DModelPanel", ItemPanel)
        icon:Dock(LEFT)
        icon:SetModel(itemData.model)
        icon.Entity:SetPos(icon.Entity:GetPos() - Vector(0, 0, 4))
        icon:SetFOV(50)
        local num = .7
        local min, max = icon.Entity:GetRenderBounds()
        icon:SetCamPos(min:Distance(max) * Vector(num, num, num))
        icon:SetLookAt((max + min) / 2)
        function icon:LayoutEntity(Entity) return end
        local oldPaint = icon.Paint
        icon.Paint = function(self, w, h)
            surface.SetDrawColor(0, 0, 0, 100)
            surface.DrawRect(0, 0, w, h)
            oldPaint(self, w, h)
        end

        local useButton = ItemPanel:Add("DButton")
        useButton:Dock(RIGHT)
        useButton:SetText("")
        useButton.Paint = function(self, w, h)
            surface.SetDrawColor(0, 0, 0, 200)
            surface.DrawRect(0, 0, w, h)
            draw.SimpleText("Use", "inv_24", w * .5, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        useButton.DoClick = function()
            net.Start("inv_use")
            net.WriteInt(k, 32)
            net.SendToServer()
        end

        local dropButton = ItemPanel:Add("DButton")
        dropButton:Dock(RIGHT)
        dropButton:SetText("")
        dropButton.Paint = function(self, w, h)
            surface.SetDrawColor(0, 0, 0, 200)
            surface.DrawRect(0, 0, w, h)
            draw.SimpleText("Drop", "inv_24", w * .5, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        dropButton.DoClick = function()

        end

        scroll.panels[ItemPanel] = true 
    end

    scroll.OnSizeChanged = function(self, w, h)
        for k, v in pairs(self.panels) do
            k:SetTall(h * .1)
        end
    end
end

hook.Add("OnPlayerChat", "InvOpen", function(ply, strText, bTeam, bDead)
    if (ply != LocalPlayer()) then return end
    if (string.lower(strText) != "!inv") then return end

    ZACH_INV.Open()
end)

print("cl_inventory loaded")