
local realm = GetRealmName();
local char = UnitName('player');

function updateReputation ()

	local hasFilter = false;

	local numFactions = GetNumFactions();
	if (numFactions ~= 0) then
		for i = 1, numFactions do
			local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfo(i);
			if (isHeader and isExpanded) then
				hasFilter = true;
			end
		end

		if (hasFilter == false) then
			Pulse.realm[realm].char[char].reputation = {};

			local header = nil;

			for i = 1, numFactions do
				local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfo(i);

				if (isHeader) then
					header = name;
					Pulse.realm[realm].char[char].reputation[header] = {};
				else
					local temp = {};
					temp.name = name;
					temp.description = description;
					temp.standingId = standingId;
					temp.bottomValue = bottomValue;
					temp.topValue = topValue;
					temp.earnedValue = earnedValue;
					temp.atWarWith = atWarWith;
					temp.canToggleAtWar = canToggleAtWar;
					temp.hasRep = hasRep;
					temp.isWatched = isWatched;
					temp.isChild = isChild;
					temp.factionID = factionID;
					temp.hasBonusRepGain = hasBonusRepGain;
					temp.canBeLFGBonus = canBeLFGBonus;

					tinsert(Pulse.realm[realm].char[char].reputation[header], temp);
				end
			end
		end
	end
end
