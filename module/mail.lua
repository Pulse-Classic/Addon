
local realm = GetRealmName();
local char = UnitName('player');
local _, ns = ...;

function ns:checkMail ()
	if (Pulse.realm[realm].char[char].mail == nil) then
		Pulse.realm[realm].char[char].mail = {};
	end
	Pulse.realm[realm].char[char].mail.scanned = time();
	Pulse.realm[realm].char[char].mail.inbox = {};

	local numMails = GetInboxNumItems();

	for i = 1, numMails do
		local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM = GetInboxHeaderInfo(i);
		local temp = {};
		temp.packageIcon = packageIcon;
		temp.stationeryIcon = stationeryIcon;
		temp.sender = sender;
		temp.subject = subject;
		temp.money = money;
		temp.CODAmount = CODAmount;
		temp.daysLeft = daysLeft;
		temp.hasItem = hasItem;
		temp.wasRead = wasRead;
		temp.wasReturned = wasReturned;
		temp.textCreated = textCreated;
		temp.canReply = canReply;
		temp.isGM = isGM;

		if (wasRead) then
			local text = GetInboxText(i);
			temp.text = text;
			temp.items = {};

			for j = 1, ATTACHMENTS_MAX_SEND do
				local itemName = GetInboxItem(i, j);
				local itemLink = GetInboxItemLink(i, j);

				if (itemName ~= nil) then
					local tempItem = {};
					tempItem.itemName = itemName;
					tempItem.itemLink = itemLink;
					tinsert(temp.items, tempItem);
				end
			end
		end

		tinsert(Pulse.realm[realm].char[char].mail.inbox, temp);
	end
end
