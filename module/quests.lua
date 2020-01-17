
local realm = GetRealmName();
local char = UnitName('player');
local _, ns = ...;

function ns:updateQuests ()
	Pulse.realm[realm].char[char].quests = {};
	Pulse.realm[realm].char[char].quests.active = {};

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
			tinsert(Pulse.realm[realm].char[char].quests.active, temp);
		end

		i = i + 1
	end

	Pulse.realm[realm].char[char].quests.completed = GetQuestsCompleted();
end
