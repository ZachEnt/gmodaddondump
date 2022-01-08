AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("inv_item_request")

function ENT:Initialize()
    self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()
end

function ENT:SetItem(itemData)
    self.classname = itemData.classname

    self:SetModel(itemData.model)
end

net.Receive("inv_item_request", function(len, ply)
    local ent = net.ReadEntity()

    if (ent:GetClass() != "inv_item") then return end

    if (ent.classname) then
        net.Start("inv_item_request")
        net.WriteString(ent.classname)
        net.WriteEntity(ent)
        net.Send(ply)
    end
end)

function ENT:Use(activator, caller)
    if (self.classname) then
        caller:InvGive(self.classname)
        self:Remove()
    end
end