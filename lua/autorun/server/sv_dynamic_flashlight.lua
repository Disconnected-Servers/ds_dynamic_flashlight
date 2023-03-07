local IsValid = IsValid
local PLAYER = FindMetaTable("Player")


function PLAYER:FlashlightIsOn()
	return self:GetNWBool("DynamicFlashlight")
end 

hook.Add("PlayerSwitchFlashlight", "dynamic_flashlight", function(ply, state)
    if not IsValid(ply) then return end
    if ply:GetObserverMode() ~= OBS_MODE_NONE then return end
    ply:SetNWBool("DynamicFlashlight", not ply:GetNWBool("DynamicFlashlight"))
    --ply:EmitSound("items/flashlight1.wav", 60, 100)
    ply:EmitSound("HL2Player.FlashLightOn")

    return false
end)

hook.Add("PlayerSpawn", "dynamic_flashlight", function(ply)
    if not IsValid(ply) then return end
    
    ply:SetNWBool("DynamicFlashlight", false)
end)

hook.Add("PlayerDeath", "dynamic_flashlight", function(ply)
    if not IsValid(ply) then return end

    ply:SetNWBool("DynamicFlashlight", false)
end)

hook.Add("PlayerSilentDeath", "dynamic_flashlight", function(ply)
    if not IsValid(ply) then return end

    ply:SetNWBool("DynamicFlashlight", false)
end)

if engine.ActiveGamemode() == "prop_hunt" then
    hook.Add("PH_OnPropKilled", "dynamic_flashlight", function(ply)
        if not IsValid(ply) then return end

        ply:SetNWBool("DynamicFlashlight", false)
    end)
end