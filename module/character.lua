
local realm = GetRealmName();
local char = UnitName('player');

function updateCharacter ()
	Pulse.realm[realm].char[char].info = {};

	Pulse.realm[realm].char[char].info.name = UnitName('player');
	Pulse.realm[realm].char[char].info.gender = UnitSex('player');
	local raceName, raceFile, raceID = UnitRace('player');
	Pulse.realm[realm].char[char].info.raceName = raceName;
	Pulse.realm[realm].char[char].info.raceID = raceID;
	local localizedClass, englishClass, classIndex = UnitClass('player');
	Pulse.realm[realm].char[char].info.localizedClass = localizedClass;
	Pulse.realm[realm].char[char].info.englishClass = englishClass;
	Pulse.realm[realm].char[char].info.classIndex = classIndex;

	Pulse.realm[realm].char[char].info.level = UnitLevel('player');
	Pulse.realm[realm].char[char].info.xp = UnitXP('player');
	Pulse.realm[realm].char[char].info.max_xp = UnitXPMax('player');
	Pulse.realm[realm].char[char].info.rested = GetXPExhaustion();
	Pulse.realm[realm].char[char].info.is_resting = IsResting();

	Pulse.realm[realm].char[char].info.money = GetMoney();

	local guildName, guildRankName, guildRankIndex = GetGuildInfo('player');
	Pulse.realm[realm].char[char].info.guildName = guildName;
	Pulse.realm[realm].char[char].info.guildRankName = guildRankName;
	Pulse.realm[realm].char[char].info.guildRankIndex = guildRankIndex;
	Pulse.realm[realm].char[char].info.realm = realm;

	Pulse.realm[realm].char[char].info.scanned = time();
end
