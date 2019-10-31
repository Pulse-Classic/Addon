
local frame = CreateFrame('Frame');
local realm = GetRealmName();
local char = UnitName('player');

function initPulse ()
	if (Pulse == nil) then
		Pulse = {};
	elseif (Pulse.version == 1) then
		Pulse = {};
	end
	if (Pulse.realm == nil) then
		Pulse.realm = {};
	end
	if (Pulse.realm[realm] == nil) then
		Pulse.realm[realm] = {};
	end
	if (Pulse.realm[realm].char == nil) then
		Pulse.realm[realm].char = {};
	end
	if (Pulse.realm[realm].char[char] == nil) then
		Pulse.realm[realm].char[char] = {};
	end

	Pulse.version = 2;
end

frame:RegisterEvent('PLAYER_LOGIN');
frame:SetScript('OnEvent', function (self, event, ...)
	if (event == 'PLAYER_LOGIN') then

		frame:RegisterEvent('BAG_UPDATE');
		frame:RegisterEvent('ITEM_UNLOCKED');
		frame:RegisterEvent('QUEST_LOG_UPDATE');
		frame:RegisterEvent('TRADE_SKILL_CLOSE');
		frame:RegisterEvent('SPELLS_CHANGED');
		frame:RegisterEvent('CHARACTER_POINTS_CHANGED');

		frame:SetScript('OnEvent', function (self, event, bagId)
			if (event == 'BAG_UPDATE') then
				updateInventory(bagId);
			end
			if (event == 'ITEM_UNLOCKED') then
				updateInventory(bagId);
			end
			if (event == 'QUEST_LOG_UPDATE') then
				updateQuests();
			end
			if (event == 'TRADE_SKILL_CLOSE') then
				updateSkills();
			end
			if (event == 'SPELLS_CHANGED') then
				updateSpells();
			end
			if (event == 'CHARACTER_POINTS_CHANGED') then
				updateTalents();
			end
		end);

		initPulse();
		updateTalents();
	end
end);
