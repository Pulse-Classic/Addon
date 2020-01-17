
local realm = GetRealmName();
local char = UnitName('player');
local _, ns = ...;

function ns:updateTalents ()
	Pulse.realm[realm].char[char].talents = {};

	local numTabs = GetNumTalentTabs();

	for i = 1, numTabs do
		local numTalents = GetNumTalents(i);
		for j = 1, numTalents do
			local name, icon, tier, column, rank, maxRank = GetTalentInfo(i, j);

			local temp = {};
			temp.name = name;
			temp.icon = icon;
			temp.tier = tier;
			temp.column = column;
			temp.rank = rank;
			temp.maxRank = maxRank;

			tinsert(Pulse.realm[realm].char[char].talents, temp);
		end
	end
end
