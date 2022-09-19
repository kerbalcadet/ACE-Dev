AddCSLuaFile ("cl_init.lua")
AddCSLuaFile ("shared.lua")

include ("shared.lua")

SWEP.DeployDelay = 6 --No more rocket 2 taps or sprinting lawnchairs

function SWEP:DoAmmoStatDisplay()


	local sendInfo = string.format( "Anti Personel Mine")

			sendInfo = sendInfo .. string.format(", %.1fm blast", 2 ^ 0.33 * 8) --4 taken from mine entity



	self:GetOwner():SendLua(string.format("GAMEMODE:AddNotify(%q, \"NOTIFY_HINT\", 10)", sendInfo))
end

function SWEP:Equip()
	self:DoAmmoStatDisplay()
	self:SetNextPrimaryFire( CurTime() + self.DeployDelay )
end