
local frame = CreateFrame('Frame');
local realm = GetRealmName();
local char = UnitName('player');

function initPulse ()
	if (Pulse == nil) then
		Pulse = {};
	end
	if (Pulse[realm] == nil) then
		Pulse[realm] = {};
	end
	if (Pulse[realm][char] == nil) then
		Pulse[realm][char] = {};
	end

	Pulse.version = 1;
end

frame:RegisterEvent('PLAYER_LOGIN');
frame:SetScript('OnEvent', function (self, event, ...)
	if (event == 'PLAYER_LOGIN') then
		initPulse();
	end
end)
