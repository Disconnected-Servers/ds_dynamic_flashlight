local cache = {}

local insert = table.insert
local remove = table.remove
local PLAYER = FindMetaTable("Player")


function PLAYER:FlashlightIsOn()
	return self:GetNWBool("DynamicFlashlight")
end 

local function UpdateCache(entity, state)
    if not entity:IsPlayer() then return end

    if state then
        insert(cache, entity)
    else
        for i = 1, #cache do
            if cache[i] == entity then
                remove(cache, i)
            end
        end
    end
end

hook.Add("NotifyShouldTransmit", "dynamic_flashlight", UpdateCache)

hook.Add("EntityRemoved", "dynamic_flashlight", function(entity)
    UpdateCache(entity, false)
end)

hook.Add("Think", "dynamic_flashlight", function()
    for i = 1, #cache do
        local target = cache[i]

        if target:GetNWBool("DynamicFlashlight") and target:Alive() then
            if target.DynamicFlashlight then
                local position = target:GetPos()
                target.DynamicFlashlight:SetPos(Vector(position[1], position[2], position[3] + 40) + target:GetForward() * 20)
                target.DynamicFlashlight:SetAngles(target:EyeAngles())
                target.DynamicFlashlight:Update()
            else
                target.DynamicFlashlight = ProjectedTexture()
                target.DynamicFlashlight:SetTexture("effects/flashlight001")
                target.DynamicFlashlight:SetFarZ(900)
                target.DynamicFlashlight:SetFOV(70)
            end
        else
            if target.DynamicFlashlight then
                target.DynamicFlashlight:Remove()
                target.DynamicFlashlight = nil
            end
        end
    end
end)