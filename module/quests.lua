
local frame = CreateFrame('Frame');
local realm = GetRealmName();
local char = UnitName('player');

function updateQuests ()
	Pulse[realm][char]['quests'] = {};
	Pulse[realm][char]['quests']['active'] = {};

	local i = 1;
	local location = 'undefined';
	while GetQuestLogTitle(i) do
		local title, level, suggestedGroup, isHeader, isCollapsed, isComplete,
			frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI,
			isTask, isStory = GetQuestLogTitle(i);

		if (isHeader) then
			location = title;
		else
			local temp = {};
			temp.location = location;
			temp.title = title;
			temp.level = level;
			temp.suggestedGroup = suggestedGroup;
			temp.isCollapsed = isCollapsed;
			temp.isComplete = isComplete;
			temp.frequency = frequency;
			temp.questID = questID;
			temp.startEvent = startEvent;
			temp.displayQuestID = displayQuestID;
			temp.isOnMap = isOnMap;
			temp.hasLocalPOI = hasLocalPOI;
			temp.isTask = isTask;
			temp.isStory = isStory;
			tinsert(Pulse[realm][char]['quests']['active'], temp);
		end

		i = i + 1
	end

	Pulse[realm][char]['quests']['completed'] = GetQuestsCompleted();
end

frame:RegisterEvent('QUEST_LOG_UPDATE');
frame:SetScript('OnEvent', function (self, event, ...)
	if (event == 'QUEST_LOG_UPDATE') then
		updateQuests();
	end
end);
