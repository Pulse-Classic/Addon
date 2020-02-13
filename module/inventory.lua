
local realm = GetRealmName();
local char = UnitName('player');
local _, ns = ...;

function ns:updateInventory (bagId)
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
			if (itemID ~= nil) then
				local spellName, spellID = GetItemSpell(itemID);
				local startTime, duration = GetContainerItemCooldown(bagId, i);
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
				temp.itemSpell = spellID;
				if (duration ~= 0) then
					local cooldown = time() + duration - (GetTime() - startTime);
					temp.cooldown = cooldown;
				end

				tinsert(Pulse.realm[realm].char[char].inventory[bagId].inventory, temp);
			end
		end
	end
end
