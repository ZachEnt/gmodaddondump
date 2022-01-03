if (DEATHSCREEN.Disabled) then return end

surface.CreateFont("deathscreen_24", {
    font = "Roboto",
    size = 24,
    weight = 1000,
})

surface.CreateFont("deathscreen_90", {
    font = "Roboto",
    size = 90,
    weight = 1000,
})

local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0, -- Target -.2
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 1, -- Target 0.1
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

local deathT
local fadeT = 4
local camDist = 0

net.Receive("deathscreen_sendDeath", function()
	ply = LocalPlayer()
    deathT = CurTime()
	camDist = 0
	
	timer.Create(ply:SteamID() .. "respawnTime", DEATHSCREEN.RespawnTime, 1, function() end)
end)

net.Receive("deathscreen_removeDeath", function()
	deathT = nil
	tab["$pp_colour_brightness"] = 0
	tab["$pp_colour_colour"] = 1
end)

hook.Add("RenderScreenspaceEffects", "DeathScreenColorMods", function()
	if (deathT && deathT + fadeT > CurTime()) then
		local colorSub = (0.9 / fadeT) * FrameTime()
		local brightnessSub = (.2 / fadeT) * FrameTime()

		tab["$pp_colour_brightness"] = tab["$pp_colour_brightness"] - brightnessSub
		tab["$pp_colour_colour"] = tab["$pp_colour_colour"] - colorSub
	end
    DrawColorModify(tab)
end)

local red = Color(203, 91, 82)
hook.Add("HUDPaint", "DrawDeathScreen", function()
	local ply = LocalPlayer()
	if (ply:Alive()) then return end
	if (not deathT) then return end
	
	local scrw, scrh = ScrW(), ScrH()
	local r = camDist / 25

	surface.SetAlphaMultiplier(r)
	draw.SimpleText("WASTED", "deathscreen_90", scrw * 0.5 - 2, scrh * 0.5 - 2, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText("WASTED", "deathscreen_90", scrw * 0.5, scrh * 0.5, red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	if (not timer.Exists(ply:SteamID() .. "respawnTime")) then
		draw.SimpleText("PRESS THE SPACE BAR TO RESPAWN.", "deathscreen_24", scrw * 0.5, scrh * 0.55, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)

hook.Add("CalcView", "DeathscreenCalcView", function(ply, origin, angles, fov, znear, zfar)
	if (ply:Alive()) then return end

	local view = {}
	camDist = math.Clamp(camDist + 5 * FrameTime(), 0, 50)
	local newAng = Angle(angles.x + 5 * math.sin(CurTime() * .5), angles.y, angles.z + 10 * math.sin(CurTime() * .5))
	view.origin = origin - (angles:Forward() * camDist)
	view.angles = newAng
	view.fov = fov
	view.drawviewer = true

	return view
end)

print("cl_deathscreen loaded")