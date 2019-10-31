
local realm = GetRealmName();
local char = UnitName('player');

function updateInventory (bagId)
	if (Pulse.realm[realm].char[char].inventory == nil) then
		Pulse.realm[realm].char[char].inventory = {};
	end

	local bagName = GetBagName(bagId);

	if (bagId == -1) then
		bagName = 'Bank';
	end

	Pulse.realm[realm].char[char].inventory[bagId] = {};
	Pulse.realm[realm].char[char].inventory[bagId].name = bagName;
	Pulse.realm[realm].char[char].inventory[bagId].inventory = {};

	local numSlots = GetContainerNumSlots(bagId);
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
