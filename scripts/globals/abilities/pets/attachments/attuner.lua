-----------------------------------
-- Attachment: Attuner
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addListener("ENGAGE", "AUTO_ATTUNER_ENGAGE", function(pet, target)
        local master = pet:getMaster()
        if pet:getLocalVar("attuner") > 0 then
            pet:delMod(xi.mod.ATTP, 5) -- Ignore 5% def
            pet:delMod(xi.mod.RATTP, 5)
            for maneuvers = master:countEffect(xi.effect.FIRE_MANEUVER), 1, -1  do
                if maneuvers == 1 then
                    pet:delMod(xi.mod.ATTP, 13) -- Ignore 15% def
                    pet:delMod(xi.mod.RATTP, 13)
                elseif maneuvers == 2 then
                    pet:delMod(xi.mod.ATTP, 25) -- Ignore 30% def
                    pet:delMod(xi.mod.RATTP, 25)
                elseif maneuvers == 3 then
                    pet:delMod(xi.mod.ATTP, 39) -- Ignore 45% def
                    pet:delMod(xi.mod.RATTP, 39)
                end
            end
            pet:setLocalVar("attuner", 0)
        end

        if pet:getMainLvl() < target:getMainLvl() then
            pet:setLocalVar("attuner", 1)
            pet:addMod(xi.mod.ATTP, 5) -- Ignore 5% def
            pet:addMod(xi.mod.RATTP, 5)
            for maneuvers = 1, master:countEffect(xi.effect.FIRE_MANEUVER) do
                if maneuvers == 1 then
                    pet:addMod(xi.mod.ATTP, 13) -- Ignore 15% def
                    pet:addMod(xi.mod.RATTP, 13)
                elseif maneuvers == 2 then
                    pet:addMod(xi.mod.ATTP, 25) -- Ignore 30% def
                    pet:addMod(xi.mod.RATTP, 25)
                elseif maneuvers == 3 then
                    pet:addMod(xi.mod.ATTP, 39) -- Ignore 45% def
                    pet:addMod(xi.mod.RATTP, 39)
                end
            end
        end
    end)
    pet:addListener("DISENGAGE", "AUTO_ATTUNER_DISENGAGE", function(pet)
        if pet:getLocalVar("attuner") > 0 then
            local master = pet:getMaster()
            pet:delMod(xi.mod.ATTP, 5) -- Ignore 5% def
            pet:delMod(xi.mod.RATTP, 5)
            for maneuvers = master:countEffect(xi.effect.FIRE_MANEUVER), 1, -1  do
                if maneuvers == 1 then
                    pet:delMod(xi.mod.ATTP, 13) -- Ignore 15% def
                    pet:delMod(xi.mod.RATTP, 13)
                elseif maneuvers == 2 then
                    pet:delMod(xi.mod.ATTP, 25) -- Ignore 30% def
                    pet:delMod(xi.mod.RATTP, 25)
                elseif maneuvers == 3 then
                    pet:delMod(xi.mod.ATTP, 39) -- Ignore 45% def
                    pet:delMod(xi.mod.RATTP, 39)
                end
            end
            pet:setLocalVar("attuner", 0)
        end
    end)
end

attachment_object.onUnequip = function(pet)
    pet:removeListener("AUTO_ATTUNER_ENGAGE")
    pet:removeListener("AUTO_ATTUNER_DISENGAGE")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
    if pet:getLocalVar("attuner") > 0 then
        if maneuvers == 1 then
            pet:addMod(xi.mod.ATTP, 13) -- Ignore 15% def
            pet:addMod(xi.mod.RATTP, 13)
        elseif maneuvers == 2 then
            pet:addMod(xi.mod.ATTP, 25) -- Ignore 30% def
            pet:addMod(xi.mod.RATTP, 25)
        elseif maneuvers == 3 then
            pet:addMod(xi.mod.ATTP, 39) -- Ignore 45% def
            pet:addMod(xi.mod.RATTP, 39)
        end
    end
end

attachment_object.onManeuverLose = function(pet, maneuvers)
    if pet:getLocalVar("attuner") > 0 then
        if maneuvers == 1 then
            pet:delMod(xi.mod.ATTP, 13) -- Ignore 15% def
            pet:delMod(xi.mod.RATTP, 13)
        elseif maneuvers == 2 then
            pet:delMod(xi.mod.ATTP, 25) -- Ignore 30% def
            pet:delMod(xi.mod.RATTP, 25)
        elseif maneuvers == 3 then
            pet:delMod(xi.mod.ATTP, 39) -- Ignore 45% def
            pet:delMod(xi.mod.RATTP, 39)
        end
    end
end

return attachment_object
