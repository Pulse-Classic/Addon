
local realm = GetRealmName();
local char = UnitName('player');
local _, ns = ...;

function ns:updateSkills ()
	local hasFilter = false;

	local numSkills = GetNumSkillLines();
	for i = 1, numSkills do
		local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType, skillDescription = GetSkillLineInfo(i);
		if (isHeader == 1) then
			if (isExpanded ~= 1) then
				hasFilter = true;
			end
		end
	end

	if (numSkills > 1 and hasFilter == false) then
		local header = 'undefined';
		local names = {};
		Pulse.realm[realm].char[char].skills = {};
		for i = 1, numSkills do
			local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType, skillDescription = GetSkillLineInfo(i);

			if (isHeader == 1) then
				header = skillName;
			else
				local temp = {};
				temp.skillName = skillName;
				tinsert(names, skillName);
				temp.skillRank = skillRank;
				temp.numTempPoints = numTempPoints;
				temp.skillModifier = skillModifier;
				temp.skillMaxRank = skillMaxRank;
				temp.isAbandonable = isAbandonable;
				temp.stepCost = stepCost;
				temp.rankCost = rankCost;
				temp.minLevel = minLevel;
				temp.skillCostType = skillCostType;
				temp.skillDescription = skillDescription;

				if (Pulse.realm[realm].char[char].skills[header] == nil) then
					Pulse.realm[realm].char[char].skills[header] = {};
				end

				tinsert(Pulse.realm[realm].char[char].skills[header], temp);
			end
		end

		if (Pulse.realm[realm].char[char].tradeskills ~= nil) then
			for k in pairs(Pulse.realm[realm].char[char].tradeskills) do
				if (not tContains(names, k)) then
					Pulse.realm[realm].char[char].tradeskills[k] = nil;
				end
			end
		end
	end
end
