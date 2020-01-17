
local realm = GetRealmName();
local char = UnitName('player');
local _, ns = ...;

function ns:updateCharacter ()
	Pulse.realm[realm].char[char].info = {};

	Pulse.realm[realm].char[char].info.name = UnitName('player');
	Pulse.realm[realm].char[char].info.gender = UnitSex('player');
	local raceName, raceFile, raceID = UnitRace('player');
	Pulse.realm[realm].char[char].info.raceName = raceName;
	Pulse.realm[realm].char[char].info.raceID = raceID;
	local localizedClass, englishClass, classIndex = UnitClass('player');
	Pulse.realm[realm].char[char].info.localizedClass = localizedClass;
	Pulse.realm[realm].char[char].info.englishClass = englishClass;
	Pulse.realm[realm].char[char].info.classIndex = classIndex;

	Pulse.realm[realm].char[char].info.level = UnitLevel('player');
	Pulse.realm[realm].char[char].info.xp = UnitXP('player');
	Pulse.realm[realm].char[char].info.max_xp = UnitXPMax('player');
	Pulse.realm[realm].char[char].info.rested = GetXPExhaustion();
	Pulse.realm[realm].char[char].info.is_resting = IsResting();

	Pulse.realm[realm].char[char].info.money = GetMoney();

	local guildName, guildRankName, guildRankIndex = GetGuildInfo('player');
	Pulse.realm[realm].char[char].info.guildName = guildName;
	Pulse.realm[realm].char[char].info.guildRankName = guildRankName;
	Pulse.realm[realm].char[char].info.guildRankIndex = guildRankIndex;
	Pulse.realm[realm].char[char].info.realm = realm;

	Pulse.realm[realm].char[char].info.scanned = time();
end

function ns:updateLocation ()
	if (Pulse.realm[realm].char[char].info ~= nil) then
		local zoneName = GetRealZoneText();
		Pulse.realm[realm].char[char].info.location = {};
		Pulse.realm[realm].char[char].info.location.name = zoneName;
	end
end

function ns:getEquipment ()
	Pulse.realm[realm].char[char].equipment = {};
	for i = 0, 19 do
		local itemId = GetInventoryItemID('player', i);
		local itemLink = GetInventoryItemLink('player', i);
		local temp = {};
		temp.itemLink = itemLink;
		temp.itemId = itemId;

		if (i == INVSLOT_AMMO) then
			Pulse.realm[realm].char[char].equipment['ammo'] = temp;
		elseif (i == INVSLOT_HEAD) then
			Pulse.realm[realm].char[char].equipment['head'] = temp;
		elseif (i == INVSLOT_NECK) then
			Pulse.realm[realm].char[char].equipment['neck'] = temp;
		elseif (i == INVSLOT_SHOULDER) then
			Pulse.realm[realm].char[char].equipment['shoulder'] = temp;
		elseif (i == INVSLOT_BODY) then
			Pulse.realm[realm].char[char].equipment['shirt'] = temp;
		elseif (i == INVSLOT_CHEST) then
			Pulse.realm[realm].char[char].equipment['chest'] = temp;
		elseif (i == INVSLOT_WAIST) then
			Pulse.realm[realm].char[char].equipment['waist'] = temp;
		elseif (i == INVSLOT_LEGS) then
			Pulse.realm[realm].char[char].equipment['legs'] = temp;
		elseif (i == INVSLOT_FEET) then
			Pulse.realm[realm].char[char].equipment['feet'] = temp;
		elseif (i == INVSLOT_WRIST) then
			Pulse.realm[realm].char[char].equipment['wrist'] = temp;
		elseif (i == INVSLOT_HAND) then
			Pulse.realm[realm].char[char].equipment['hand'] = temp;
		elseif (i == INVSLOT_FINGER1) then
			Pulse.realm[realm].char[char].equipment['finger1'] = temp;
		elseif (i == INVSLOT_FINGER2) then
			Pulse.realm[realm].char[char].equipment['finger2'] = temp;
		elseif (i == INVSLOT_TRINKET1) then
			Pulse.realm[realm].char[char].equipment['trinket1'] = temp;
		elseif (i == INVSLOT_TRINKET2) then
			Pulse.realm[realm].char[char].equipment['trinket2'] = temp;
		elseif (i == INVSLOT_BACK) then
			Pulse.realm[realm].char[char].equipment['back'] = temp;
		elseif (i == INVSLOT_MAINHAND) then
			Pulse.realm[realm].char[char].equipment['mainhand'] = temp;
		elseif (i == INVSLOT_OFFHAND) then
			Pulse.realm[realm].char[char].equipment['offhand'] = temp;
		elseif (i == INVSLOT_RANGED) then
			Pulse.realm[realm].char[char].equipment['ranged'] = temp;
		elseif (i == INVSLOT_TABARD) then
			Pulse.realm[realm].char[char].equipment['tabard'] = temp;
		end
	end
end
