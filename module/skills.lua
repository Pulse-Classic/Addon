
local realm = GetRealmName();
local char = UnitName('player');

function updateSkills ()
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

	if (hasFilter == false) then
		local header = 'undefined';
		Pulse.realm[realm].char[char].skills = {};
		for i = 1, numSkills do
			local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType, skillDescription = GetSkillLineInfo(i);

			if (isHeader == 1) then
				header = skillName;
			else
				local temp = {};
				temp.skillName = skillName;
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
	end
end
