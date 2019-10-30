
local frame = CreateFrame('Frame');
local realm = GetRealmName();
local char = UnitName('player');

function updateInventory (bagId)
	if (Pulse[realm][char]['inventory'] == nil) then
		Pulse[realm][char]['inventory'] = {};
	end

	local bagName = GetBagName(bagId);

	if (bagId == -1) then
		bagName = 'Bank';
	end

	Pulse[realm][char]['inventory'][bagId] = {};
	Pulse[realm][char]['inventory'][bagId].name = bagName;
	Pulse[realm][char]['inventory'][bagId].contents = {};

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

		tinsert(Pulse[realm][char]['inventory'][bagId]['contents'], temp);
	end

end

frame:RegisterEvent('BAG_UPDATE');
frame:RegisterEvent('ITEM_UNLOCKED');
frame:SetScript('OnEvent', function (self, event, bagId)
	-- if (event == 'BAG_UPDATE') then
		updateInventory(bagId);
	-- end
end);
