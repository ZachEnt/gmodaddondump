local nets = {
    "inv_give",
    "inv_init",
    "inv_use",
    "inv_drop",
    "inv_remove",
    "inv_refresh",
}

for k, v in ipairs(nets) do
    util.AddNetworkString(v)
end

local _P = FindMetaTable("Player")

function _P:InvLog(msg)
    if (not ZACH_INV.Debugging) then return end

    self:ChatPrint(msg)
end
hook.Add("PlayerInitialSpawn", "InitInv", function(ply)
    ply:InvInit()
end)

concommand.Add("reloadinv", function(ply)
    if (not ply:IsSuperAdmin()) then return end

    ply:InvInit()
end)

function _P:InvInit()
    self.zach_inv = {}

    net.Start("inv_init")
    net.Send(self)
    
    self:InvLog("Inventory successfully initialized")
end

function _P:InvGive(classname)
    if (not ZACH_INV.Items[classname]) then 
        self:InvLog("Attempted to receive an invalid item: " .. classname)
        return
    end

    table.insert(self.zach_inv, classname)
    
    net.Start("inv_give")
    net.WriteString(classname)
    net.Send(self)

    self:InvRefresh()

    self:InvLog("Successfully picked up item: " .. classname)
end

function _P:InvHasItem(id)
    return self.zach_inv[id]
end

function _P:InvRemoveItem(id)
    self.zach_inv[id] = nil

    net.Start("inv_remove")
    net.WriteInt(id, 32)
    net.Send(self)

    self:InvRefresh()
end

function _P:InvRefresh()
    net.Start("inv_refresh")
    net.Send(self)
end

net.Receive("inv_use", function(len, ply)
    local id = net.ReadInt(32)

    if (ply:InvHasItem(id)) then
        local itemData = ZACH_INV.Items[ply.zach_inv[id]]
        local shouldRemove = ZACH_INV.UseTypes[itemData.type](itemData, ply)

        if (shouldRemove) then
            ply:InvRemoveItem(id)
        end
    end
end)

concommand.Add("inv_give", function(ply, cmd, args)
    if (not ply:IsSuperAdmin()) then return end

    local classname = args[1]

    ply:InvGive(classname)
end)

print("sv_inventory loaded")