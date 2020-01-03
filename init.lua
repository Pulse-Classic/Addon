
local frame = CreateFrame('Frame');
local realm = GetRealmName();
local char = UnitName('player');
local bank_visible = false;

function initPulse ()
	if ((Pulse == nil) or (Pulse.version < 5)) then
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

	Pulse.version = 5.1;
end

frame:RegisterEvent('PLAYER_LOGIN');

frame:SetScript('OnEvent', function (self, event, ...)
	if (event == 'PLAYER_LOGIN') then

		initPulse();

		frame:RegisterEvent('BAG_UPDATE');
		frame:RegisterEvent('ITEM_UNLOCKED');
		frame:RegisterEvent('QUEST_LOG_UPDATE');
		frame:RegisterEvent('TRADE_SKILL_SHOW');
		frame:RegisterEvent('TRADE_SKILL_CLOSE');
		frame:RegisterEvent('CRAFT_UPDATE');
		frame:RegisterEvent('SPELLS_CHANGED');
		frame:RegisterEvent('CHARACTER_POINTS_CHANGED');
		frame:RegisterEvent('SKILL_LINES_CHANGED');
		frame:RegisterEvent('PLAYER_XP_UPDATE');
		frame:RegisterEvent('PLAYER_UPDATE_RESTING');
		frame:RegisterEvent('PLAYER_MONEY');
		frame:RegisterEvent('GUILD_ROSTER_UPDATE');
		frame:RegisterEvent('BANKFRAME_OPENED');
		frame:RegisterEvent('BANKFRAME_CLOSED');
		frame:RegisterEvent('UPDATE_FACTION');
		frame:RegisterEvent('PLAYER_EQUIPMENT_CHANGED');

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
			if (event == 'TRADE_SKILL_SHOW') then
				loadTradeskills();
			end
			if (event == 'TRADE_SKILL_CLOSE') then
				saveTradeskills();
			end
			if (event == 'CRAFT_UPDATE') then
				if (GetCraftName() == 'Enchanting') then
					updateEnchanting();
				end
			end
			if (event == 'SPELLS_CHANGED') then
				updateSpells();
			end
			if (event == 'CHARACTER_POINTS_CHANGED') then
				updateTalents();
			end
			if (event == 'SKILL_LINES_CHANGED') then
				updateSkills();
			end
			if (event == 'PLAYER_XP_UPDATE') then
				updateCharacter();
			end
			if (event == 'PLAYER_UPDATE_RESTING') then
				updateCharacter();
			end
			if (event == 'PLAYER_MONEY') then
				updateCharacter();
			end
			if (event == 'GUILD_ROSTER_UPDATE') then
				updateCharacter();
			end
			if (event == 'UPDATE_FACTION') then
				updateReputation();
			end
			if (event == 'BANKFRAME_OPENED') then
				bank_visible = true;
			end
			if (bank_visible == true and event == 'BANKFRAME_CLOSED') then
				bank_visible = false;
				updateInventory(-1);
				updateInventory(5);
				updateInventory(6);
				updateInventory(7);
				updateInventory(8);
				updateInventory(9);
				updateInventory(10);
			end
			if (event == 'PLAYER_EQUIPMENT_CHANGED') then
				getEquipment();
			end
		end);

		updateTalents();
		updateSkills();
	end
end);
