
local frame = CreateFrame('Frame');
local realm = GetRealmName();
local char = UnitName('player');
local bank_visible = false;
local _, ns = ...;

function ns:init ()
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

	if (Pulse.version < 5.3) then
		for k in pairs(Pulse.realm[realm].char) do
			Pulse.realm[realm].char[k].talents = {};
		end
	end

	Pulse.version = 5.3;
end

frame:RegisterEvent('PLAYER_LOGIN');

frame:SetScript('OnEvent', function (self, event, ...)
	if (event == 'PLAYER_LOGIN') then

		ns:init();

		frame:RegisterEvent('BAG_UPDATE');
		frame:RegisterEvent('ITEM_UNLOCKED');
		frame:RegisterEvent('QUEST_LOG_UPDATE');
		frame:RegisterEvent('TRADE_SKILL_UPDATE');
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
		frame:RegisterEvent('MAIL_INBOX_UPDATE');
		frame:RegisterEvent('PLAYER_LEAVING_WORLD');

		frame:SetScript('OnEvent', function (self, event, bagId)
			if (event == 'BAG_UPDATE') then
				ns:updateInventory(bagId);
			end
			if (event == 'ITEM_UNLOCKED') then
				ns:updateInventory(bagId);
			end
			if (event == 'QUEST_LOG_UPDATE') then
				ns:updateQuests();
			end
			if (event == 'TRADE_SKILL_UPDATE') then
				ns:loadTradeskills();
			end
			if (event == 'TRADE_SKILL_CLOSE') then
				ns:saveTradeskills();
			end
			if (event == 'CRAFT_UPDATE') then
				if (GetCraftName() == 'Enchanting') then
					ns:updateEnchanting();
				end
			end
			if (event == 'SPELLS_CHANGED') then
				ns:updateSpells();
			end
			if (event == 'CHARACTER_POINTS_CHANGED') then
				ns:updateTalents();
			end
			if (event == 'SKILL_LINES_CHANGED') then
				ns:updateSkills();
			end
			if (event == 'PLAYER_XP_UPDATE') then
				ns:updateCharacter();
			end
			if (event == 'PLAYER_UPDATE_RESTING') then
				ns:updateCharacter();
			end
			if (event == 'PLAYER_MONEY') then
				ns:updateCharacter();
			end
			if (event == 'GUILD_ROSTER_UPDATE') then
				ns:updateCharacter();
			end
			if (event == 'PLAYER_LEAVING_WORLD') then
				ns:updateLocation();
			end
			if (event == 'UPDATE_FACTION') then
				ns:updateReputation();
			end
			if (event == 'BANKFRAME_OPENED') then
				bank_visible = true;
			end
			if (bank_visible == true and event == 'BANKFRAME_CLOSED') then
				bank_visible = false;
				ns:updateInventory(-1);
				ns:updateInventory(5);
				ns:updateInventory(6);
				ns:updateInventory(7);
				ns:updateInventory(8);
				ns:updateInventory(9);
				ns:updateInventory(10);
			end
			if (event == 'PLAYER_EQUIPMENT_CHANGED') then
				ns:getEquipment();
			end
			if (event == 'MAIL_INBOX_UPDATE') then
				ns:checkMail();
			end
		end);

		ns:updateTalents();
		ns:updateSkills();
		ns:updateCharacter();
		ns:getEquipment();
	end
end);
