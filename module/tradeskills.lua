
local realm = GetRealmName();
local char = UnitName('player');
local _, ns = ...;

local tradeskillcache = nil;

function ns:loadTradeskills ()
	local tradeskillName, currentLevel, maxLevel = GetTradeSkillLine();
	tradeskillcache = tradeskillName;
end

function ns:saveTradeskills ()

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
							local creates = GetTradeSkillItemLink(i);
							local cooldown = GetTradeSkillCooldown(i);

							local temp = {};
							temp.skillName = skillName;
							temp.skillType = skillType;
							temp.numAvailable = numAvailable;
							temp.altVerb = altVerb;
							temp.numSkillUps = numSkillUps;
							temp.creates = creates;
							if (cooldown ~= nil) then
								temp.cooldown = math.ceil(time() + cooldown);
							end
							temp.reagents = {};

							local numReagents = GetTradeSkillNumReagents(i);
							for j = 1, numReagents do
								local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(i, j);
								local reagentLink = GetTradeSkillReagentItemLink(i, j);

								local reagenttemp = {};
								reagenttemp.reagentName = reagentName;
								reagenttemp.reagentCount = reagentCount;
								reagenttemp.reagentLink = reagentLink;

								tinsert(temp.reagents, reagenttemp);
							end

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

function ns:updateEnchanting ()
	local numCrafts = GetNumCrafts();

	if (numCrafts ~= 0) then

		if (Pulse.realm[realm].char[char].tradeskills == nil) then
			Pulse.realm[realm].char[char].tradeskills = {};
		end

		Pulse.realm[realm].char[char].tradeskills['Enchanting'] = {};
		Pulse.realm[realm].char[char].tradeskills['Enchanting']['Enchanting'] = {};
		for i = 1, numCrafts do
			local craftName, craftSubSpellName, craftType, numAvailable, isExpanded, trainingPointCost, requiredLevel = GetCraftInfo(i);
			local creates = GetCraftItemLink(i);

			local temp = {};
			temp.craftName = craftName;
			temp.craftType = craftType;
			temp.numAvailable = numAvailable;
			temp.creates = creates;
			temp.reagents = {};

			local numReagents = GetCraftNumReagents(i);
			for j = 1, numReagents do
				local reagentName, reagentTexture, reagentCount, playerReagentCount = GetCraftReagentInfo(i, j);
				local reagentLink = GetCraftReagentItemLink(i, j);

				local reagenttemp = {};
				reagenttemp.reagentName = reagentName;
				reagenttemp.reagentCount = reagentCount;
				reagenttemp.reagentLink = reagentLink;

				tinsert(temp.reagents, reagenttemp);
			end

			tinsert(Pulse.realm[realm].char[char].tradeskills['Enchanting']['Enchanting'], temp);
		end
	end
end
