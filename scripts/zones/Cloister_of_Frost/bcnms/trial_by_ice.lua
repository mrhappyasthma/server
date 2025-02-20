-----------------------------------
-- Area: Cloister of Frost
-- BCNM: Trial by Ice
-----------------------------------
local ID = require("scripts/zones/Cloister_of_Frost/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local battlefield_object = {}

battlefield_object.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefield_object.onBattlefieldRegister = function(player, battlefield)
end

battlefield_object.onBattlefieldEnter = function(player, battlefield)
end

battlefield_object.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE)) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefield_object.onEventUpdate = function(player, csid, option)
end

battlefield_object.onEventFinish = function(player, csid, option)
    if csid == 32001 then
        player:delKeyItem(xi.ki.TUNING_FORK_OF_ICE)
        player:addKeyItem(xi.ki.WHISPER_OF_FROST)
        player:addTitle(xi.title.HEIR_OF_THE_GREAT_ICE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WHISPER_OF_FROST)
    end
end

return battlefield_object
