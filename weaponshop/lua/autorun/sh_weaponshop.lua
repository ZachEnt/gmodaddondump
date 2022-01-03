WEAPONSHOP = WEAPONSHOP or {}
WEAPONSHOP.Theme = {
    ["background"] = Color(0, 0, 0, 200),
    ["text"] = Color(255, 255, 255, 255),
    ["purchasebutton"] = Color(0, 200, 0 ,255),
} 
WEAPONSHOP.VIPGroups = {
    ["vip"] = true,
    ["superadmin"] = true,
    ["founder"] = true,
    ["user"] = true,
}

WEAPONSHOP.Items = {
    {name = "smg", itemtype = "weapon", classname = "weapon_smg1", price = 1000, description = "This is a good gun"},
    {name = "pistol", itemtype = "weapon", classname = "weapon_pistol", price = 100, description = "This is a good gun"},
    {name = "revolver", itemtype = "weapon", classname = "weapon_357", price = 500, description = "This is a good gun"},
    {name = "357 Ammo", itemtype = "entity", classname = "item_ammo_357", price = 1000, description = "Ammo for 357", vip = true},
}

print("sv_weaponshop.lua loaded")