
local frame = CreateFrame('Frame');
local realm = GetRealmName();
local char = UnitName('player');

local temp = {};
local GFORMAT = "$index $name $rank";

local function gmakeStr ()
	return GFORMAT:gsub("$(%a+)", temp);
end

SlashCmdList.PULSE_TEST = function ()
	temp.index, temp.name, temp.rank = "Index", "Name", "Rank";
	local str = gmakeStr();

	for i = 1, 40 do
		temp.name, temp.rank = GetRaidRosterInfo(i);

		if temp.name ~= nil then
			temp.index = i;
			-- temp.name = Ambiguate(temp.name, 'none');

			str = str .. "\n" .. gmakeStr();
		end

	end

	KethoEditBox_Show(str);

end
SLASH_PULSE_TEST1 = "/pt";
