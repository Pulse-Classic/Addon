
local realm = GetRealmName();
local char = UnitName('player');
local _, ns = ...;

function ns:updateSpells ()
	Pulse.realm[realm].char[char].spells = {};

	i = 1;
	while true do
		local spellName, spellSubName = GetSpellBookItemName(i, BOOKTYPE_SPELL);
		if (not spellName) then
			do break end
		end

		local temp = {};
		temp.spellName = spellName;
		temp.spellSubName = spellSubName;

		tinsert(Pulse.realm[realm].char[char].spells, temp);

		i = i + 1;
	end
end
