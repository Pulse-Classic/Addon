
local realm = GetRealmName();
local char = UnitName('player');

function updateTradeskills ()

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
			local header = 'undefined';
			local tradeskillName, currentLevel, maxLevel = GetTradeSkillLine();
			if (Pulse.realm[realm].char[char].tradeskills == nil) then
				Pulse.realm[realm].char[char].tradeskills = {};
			end
			if ((tradeskillName ~= nil) and (tradeskillName ~= '')) then

				Pulse.realm[realm].char[char].tradeskills[tradeskillName] = {};

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

						if (Pulse.realm[realm].char[char].tradeskills[tradeskillName][header] == nil) then
							Pulse.realm[realm].char[char].tradeskills[tradeskillName][header] = {};
						end

						tinsert(Pulse.realm[realm].char[char].tradeskills[tradeskillName][header], temp);
					end
				end
			end
		end
	end
end

-- Need to figure out Enchanting
-- local numCrafts = GetNumCrafts();
-- print(numCrafts);
