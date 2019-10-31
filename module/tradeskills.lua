
local realm = GetRealmName();
local char = UnitName('player');

function updateSkills ()
	Pulse.realm[realm].char[char].tradeskills = {};

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

	local header = 'undefined';
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
			for i = 1, numTradeSkills do
				local skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps = GetTradeSkillInfo(i);

				if (skillType == 'header') then
					header = skillName;
				else
					local temp = {};
					temp.skillName = skillName;
					temp.skillName = skillName;
					temp.skillType = skillType;
					temp.numAvailable = numAvailable;
					temp.isExpanded = isExpanded;
					temp.altVerb = altVerb;
					temp.numSkillUps = numSkillUps;

					if (Pulse.realm[realm].char[char].tradeskills[header] == nil) then
						Pulse.realm[realm].char[char].tradeskills[header] = {};
					end

					tinsert(Pulse.realm[realm].char[char].tradeskills[header], temp);
				end
			end
		end
	end
end

-- Need to figure out Enchanting
-- local numCrafts = GetNumCrafts();
-- print(numCrafts);
