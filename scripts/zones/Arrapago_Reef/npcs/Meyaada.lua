-----------------------------------
-- Area: Arrapago Reef
--  NPC: Meyaada
-- Type: Assault
-- !pos 22.446 -7.920 573.390 54
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
local ID = require("scripts/zones/Arrapago_Reef/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local toauMission = player:getCurrentMission(TOAU)
    local beginnings = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS)

    -- IMMORTAL SENTRIES
    if (toauMission == xi.mission.id.toau.IMMORTAL_SENTRIES) then
        if (player:hasKeyItem(xi.ki.SUPPLIES_PACKAGE)) then
            player:startEvent(5)
        elseif (player:getCharVar("AhtUrganStatus") == 1) then
            player:startEvent(6)
        end

    -- BEGINNINGS
    elseif (beginnings == QUEST_ACCEPTED) then
        if (not player:hasKeyItem(xi.ki.BRAND_OF_THE_SPRINGSERPENT)) then
            player:startEvent(10) -- brands you
        else
            player:startEvent(11) -- a harsh road lies before you
        end

    -- ASSAULT
    elseif (toauMission >= xi.mission.id.toau.PRESIDENT_SALAHEEM) then
        local IPpoint = player:getCurrency("imperial_standing")
        if (player:hasKeyItem(xi.ki.ILRUSI_ASSAULT_ORDERS) and player:hasKeyItem(xi.ki.ASSAULT_ARMBAND) == false) then
            player:startEvent(223, 50, IPpoint)
        else
            player:startEvent(7)
            -- player:delKeyItem(xi.ki.ASSAULT_ARMBAND)
        end

    -- DEFAULT DIALOG
    else
        player:startEvent(4)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- IMMORTAL SENTRIES
    if (csid == 5 and option == 1) then
        player:delKeyItem(xi.ki.SUPPLIES_PACKAGE)
        player:setCharVar("AhtUrganStatus", 1)

    -- BEGINNINGS
    elseif (csid == 10) then
        player:addKeyItem(xi.ki.BRAND_OF_THE_SPRINGSERPENT)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BRAND_OF_THE_SPRINGSERPENT)

    -- ASSAULT
    elseif (csid == 223 and option == 1) then
        player:delCurrency("imperial_standing", 50)
        player:addKeyItem(xi.ki.ASSAULT_ARMBAND)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ASSAULT_ARMBAND)
    end
end

return entity
