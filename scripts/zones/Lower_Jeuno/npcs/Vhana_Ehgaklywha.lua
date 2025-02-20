-----------------------------------
-- Area: Lower Jeuno
--  NPC: Vhana Ehgaklywha
-- Lights lamps in Lower Jeuno if nobody accepts Community Service by 1AM.
-- !pos -122.853 0.000 -195.605 245
-----------------------------------
require("scripts/zones/Lower_Jeuno/globals")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- speaking to pathing NPCs stops their progress, and they never resume
    -- so let's comment this out

    -- player:showText(npc, 7160)
end

entity.onPath = function(npc)
    if (npc:isFollowingPath()) then

        -- if vasha reaches the end node, halt and disappear her.
        -- do this at node 48 instead of 49 because isFollowingPath will be false by 49.
        -- if we remove the isFollowingPath check, this code runs every second forever.
        -- once a pathThrough begins, there doesn't seem to be a clean way to stop onPath
        -- from being called forever.

        if (npc:atPoint(xi.path.get(LOWER_JEUNO.lampPath, 48))) then
            npc:clearPath()
            npc:setStatus(2)

        -- if vasha is at one of the lamp points, turn on that lamp.
        -- she reaches the lamps in reverse order of their npcIds, hence (12 - i).

        else
            for i, v in ipairs(LOWER_JEUNO.lampPoints) do
                local lampPos = xi.path.get(LOWER_JEUNO.lampPath, v)
                if (npc:atPoint(lampPos)) then
                    -- Vhana is at a lamp (she reaches them in reverse order)
                    local lampId = ID.npc.STREETLAMP_OFFSET + (12 - i)
                    GetNPCByID(lampId):setAnimation(xi.anim.OPEN_DOOR)
                    break
                end
            end

        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
