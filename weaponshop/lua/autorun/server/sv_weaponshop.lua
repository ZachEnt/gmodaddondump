include("autorun/sh_weaponshop.lua")

util.AddNetworkString("weaponshop_purchase")

net.Receive("weaponshop_purchase", function(len, ply)
    local id = net.ReadInt(32)
    local itemData = WEAPONSHOP.Items[id]

    if not itemData then return end

    local isWeapon = itemData.itemtype == "weapon"
    local isEnt = itemData.itemtype == "entity"

    local canAfford = ply:canAfford(itemData.price)
    local hasWeapon = ply:HasWeapon(itemData.classname)

    if (isWeapon and hasWeapon) then
        ply:ChatPrint("PURCHASE FAILED")
        return
    end

    if not (canAfford) then
        ply:ChatPrint("You can't afford this.")
        return
    end

    if (itemData.vip and not WEAPONSHOP.VIPGroups[ply:GetUserGroup()]) then
        ply:ChatPrint("this item is VIP only")   
        return 
    end

    ply:addMoney(-itemData.price)
    if (isWeapon) then
        ply:Give(itemData.classname)
    end

    if (isEnt) then
        local trace = {}
        trace.start = ply:EyePos()
        trace.endpos = trace.start + ply:GetAimVector() * 85
        trace.filter = ply

        local tr = util.TraceLine(trace)
        local item = ents.Create(itemData.classname)

        item:SetPos(tr.HitPos)
        item:Spawn()
    end
    ply:ChatPrint("Purchase Successful!")
end)

print("sv_weaponshop.lua loaded")