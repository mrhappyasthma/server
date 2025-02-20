-----------------------------------
-- Area: Western Altepa Desert
--  NPC: qm2 (???)
-- Involved in Mission: Bastok 6-1
-- !pos -325 0 -111 125
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(BASTOK) == xi.mission.id.bastok.RETURN_OF_THE_TALEKEEPER and
        player:getMissionStatus(player:getNation()) == 2 and
        not player:hasKeyItem(xi.ki.ALTEPA_MOONPEBBLE)
    then
        if not GetMobByID(ID.mob.EASTERN_SPHINX):isSpawned() and not GetMobByID(ID.mob.WESTERN_SPHINX):isSpawned() then
            if player:getCharVar("Mission6-1MobKilled") > 0 then
                player:addKeyItem(xi.ki.ALTEPA_MOONPEBBLE)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ALTEPA_MOONPEBBLE)
                player:setCharVar("Mission6-1MobKilled", 0)
                player:setMissionStatus(player:getNation(), 3)
            else
                SpawnMob(ID.mob.EASTERN_SPHINX)
                SpawnMob(ID.mob.WESTERN_SPHINX)
            end
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
