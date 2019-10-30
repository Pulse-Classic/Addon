
local frame = CreateFrame('Frame');
local realm = GetRealmName();
local char = UnitName('player');

function updateSpells ()
	Pulse[realm][char]['spells'] = {};

	i = 1;
	while true do
		local spellName, spellSubName = GetSpellBookItemName(i, BOOKTYPE_SPELL);
		if (not spellName) then
			do break end
		end

		local temp = {};
		temp.spellName = spellName;
		temp.spellSubName = spellSubName;

		tinsert(Pulse[realm][char]['spells'], temp);

		i = i + 1;
	end
end

frame:RegisterEvent('SPELLS_CHANGED');
frame:SetScript('OnEvent', function (self, event, ...)
	if (event == 'SPELLS_CHANGED') then
		updateSpells();
	end
end);
