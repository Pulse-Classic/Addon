
local realm = GetRealmName();
local char = UnitName('player');

local tradeskillcache = nil;

function loadTradeskills ()
	local tradeskillName, currentLevel, maxLevel = GetTradeSkillLine();
	tradeskillcache = tradeskillName;
end

function saveTradeskills ()

	local hasFilter = false;

	local slots = {GetTradeSkillInvSlots()};
	for i, v in ipairs(slots) do
		if (GetTradeSkillInvSlotFilter(i) ~= 1) then
			hasFilter = true;
		end
	end
	local filters = {GetTradeSkillSubClasses()};
	for i, v in ipairs(filters) do
		if (GetTradeSkillSubClassFilter(i) ~= 1) then
			hasFilter = true;
		end
	end

	local numTradeSkills = GetNumTradeSkills();
	if (numTradeSkills ~= 0) then

		for i = 1, numTradeSkills do
			local skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps = GetTradeSkillInfo(i);
			if (skillType == 'header') then
				if (isExpanded ~= 1) then
					hasFilter = true;
				end
			end
		end

		if (hasFilter == false) then
			if (Pulse.realm[realm].char[char].tradeskills == nil) then
				Pulse.realm[realm].char[char].tradeskills = {};
			end
			if ((tradeskillcache ~= nil) and (tradeskillcache ~= '') and (tradeskillcache ~= 'UNKNOWN')) then
				local header = nil;
				local skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps = GetTradeSkillInfo(1);

				if ((skillName ~= nil) and (skillType == 'header')) then
					Pulse.realm[realm].char[char].tradeskills[tradeskillcache] = {};

					for i = 1, numTradeSkills do
						local skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps = GetTradeSkillInfo(i);

						if (skillType == 'header') then
							header = skillName;
						else
							local temp = {};
							temp.skillName = skillName;
							temp.skillType = skillType;
							temp.numAvailable = numAvailable;
							temp.altVerb = altVerb;
							temp.numSkillUps = numSkillUps;

							if (Pulse.realm[realm].char[char].tradeskills[tradeskillcache][header] == nil) then
								Pulse.realm[realm].char[char].tradeskills[tradeskillcache][header] = {};
							end

							tinsert(Pulse.realm[realm].char[char].tradeskills[tradeskillcache][header], temp);
						end
					end
				end
			end
		end
	end
end

function updateEnchanting ()
	local numCrafts = GetNumCrafts();

	if (numCrafts ~= 0) then

		if (Pulse.realm[realm].char[char].tradeskills == nil) then
			Pulse.realm[realm].char[char].tradeskills = {};
		end

		Pulse.realm[realm].char[char].tradeskills['Enchanting'] = {};
		Pulse.realm[realm].char[char].tradeskills['Enchanting']['Enchanting'] = {};
		for i = 1, numCrafts do
			local craftName, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(i);

			local temp = {};
			temp.craftName = craftName;
			temp.craftType = craftType;
			temp.numAvailable = numAvailable;

			tinsert(Pulse.realm[realm].char[char].tradeskills['Enchanting']['Enchanting'], temp);
		end
	end
end
