ZACH_INV = ZACH_INV or {}
ZACH_INV.Debugging = true

ZACH_INV.Items = {}
ZACH_INV.UseTypes = {
    weapon = function(itemData, ply)
        if (ply:HasWeapon(itemData.classname)) then return false end
        
        ply:Give(itemData.classname)
        
        return true
    end,

    model = function(itemData, ply)
        ply:SetModel(itemData.model)

        return false
    end,
}

function ZACH_INV.AddItem(data)
    local classname = data.classname

    ZACH_INV.Items[classname] = data
end

ZACH_INV.AddItem({
    name = "Revolver",
    classname = "weapon_357",
    model = "models/weapons/w_357.mdl",
    type = "weapon",
})

ZACH_INV.AddItem({
    name = "SMG",
    classname = "weapon_smg1",
    model = "models/weapons/w_smg1.mdl",
    type = "weapon",
})

ZACH_INV.AddItem({
    name = "Chell",
    classname = "model_chell",
    model = "models/player/p2_chell.mdl",
    type = "model",
})

ZACH_INV.AddItem({
    name = "Alyx",
    classname = "model_alyx",
    model = "models/player/alyx.mdl",
    type = "model",
})

print("sh_inventory loaded")