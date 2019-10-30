
local frame = CreateFrame('Frame');
local realm = GetRealmName();
local char = UnitName('player');

function updateSkills ()
	Pulse[realm][char]['skills'] = {};

	local header = 'undefined';
	local numTradeSkills = GetNumTradeSkills();
	if (numTradeSkills ~= 0) then
		print(numTradeSkills);
		for i = 1, numTradeSkills do
			local skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps = GetTradeSkillInfo(i);

			if (skillType == 'header') then
				header = skillName;
			else
				local temp = {};
				temp.header = header;
				temp.skillName = skillName;
				temp.skillName = skillName;
				temp.skillType = skillType;
				temp.numAvailable = numAvailable;
				temp.isExpanded = isExpanded;
				temp.altVerb = altVerb;
				temp.numSkillUps = numSkillUps;

				tinsert(Pulse[realm][char]['skills'], temp);
			end
		end
	end
end

-- Need to figure out Enchanting
-- local numCrafts = GetNumCrafts();
-- print(numCrafts);

frame:RegisterEvent('TRADE_SKILL_CLOSE');
frame:SetScript('OnEvent', function (self, event, ...)
	if (event == 'TRADE_SKILL_CLOSE') then
		updateSkills();
	end
end);
