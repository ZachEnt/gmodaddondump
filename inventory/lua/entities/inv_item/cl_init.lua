include("shared.lua")

function ENT:Initialize()
    net.Start("inv_item_request")
    net.WriteEntity(self)
    net.SendToServer()
end

net.Receive("inv_item_request", function()
    local classname = net.ReadString()
    local ent = net.ReadEntity()

    ent.classname = classname
end)

local dist = 350 ^ 2

function ENT:Draw()
    self:DrawModel()

    if (self.classname and LocalPlayer():GetPos():DistToSqr(self:GetPos()) < dist) then
        local itemData = ZACH_INV.Items[self.classname]

        local ang = self:GetAngles()
        ang:RotateAroundAxis(self:GetAngles():Right(), 90)
        ang:RotateAroundAxis(self:GetAngles():Forward(), 90)

        local z = math.sin(CurTime() * 2) * 10

        cam.Start3D2D(self:GetPos() + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.1)

        surface.SetDrawColor(0, 0, 0, 200)
        surface.SetFont("inv_24")

        local text = itemData.name
        local tW, tH = surface.GetTextSize(text) + 20

        surface.DrawRect(-tW / 2, -150 - z, tW, 50)
        draw.SimpleText(text, "inv_24", 0, -150 + 25 - z, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        cam.End3D2D()
    end
end