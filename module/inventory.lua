
local realm = GetRealmName();
local char = UnitName('player');

function updateInventory (bagId, siblings)
	if (Pulse.realm[realm].char[char].inventory == nil) then
		Pulse.realm[realm].char[char].inventory = {};
	end

	local bagName = GetBagName(bagId);

	if (bagId == -1) then
		bagName = 'Bank';
	end
	if (bagId == -2) then
		bagName = 'Keyring';
	end

	local numSlots = GetContainerNumSlots(bagId);

	if ((bagName ~= nil) and (numSlots > 0)) then
		Pulse.realm[realm].char[char].inventory[bagId] = {};
		Pulse.realm[realm].char[char].inventory[bagId].name = bagName;
		Pulse.realm[realm].char[char].inventory[bagId].inventory = {};

		for i = 1, numSlots do
			local icon, itemCount, locked, quality, readable, lootable, itemLink, isFiltered, noValue, itemID = GetContainerItemInfo(bagId, i);
			local temp = {};
			temp.icon = icon;
			temp.itemCount = itemCount;
			temp.locked = locked;
			temp.quality = quality;
			temp.readable = readable;
			temp.lootable = lootable;
			temp.itemLink = itemLink;
			temp.isFiltered = isFiltered;
			temp.noValue = noValue;
			temp.itemID = itemID;

			tinsert(Pulse.realm[realm].char[char].inventory[bagId].inventory, temp);
		end
	end

	-- Some times the bank does not seem to update.
	-- And for good measure, update all when there is a change.
	if (siblings == nil) then
		if (bagId > 4 or bagId == -1) then
			updateInventory(5, false);
			updateInventory(6, false);
			updateInventory(7, false);
			updateInventory(8, false);
			updateInventory(9, false);
			updateInventory(10, false);
			updateInventory(-1, false);
		else
			updateInventory(0, false);
			updateInventory(1, false);
			updateInventory(2, false);
			updateInventory(3, false);
			updateInventory(4, false);
			updateInventory(-2, false);
		end
	end
end
