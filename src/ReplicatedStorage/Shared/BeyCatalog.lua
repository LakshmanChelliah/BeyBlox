--!strict
--[[
	Bey roster — declarative data ported from BeyWeb.
	Unlock levels and rarity are Roblox-specific extensions.
]]

export type BeyType = "Attack" | "Defense" | "Stamina" | "Balance"
export type BeyRarity = "Common" | "Uncommon" | "Rare" | "Epic" | "Legendary"

export type BeyGimmicks = {
	power: string?,
	special: string?,
	passive: string?,
}

export type BeyDefinition = {
	id: string,
	name: string,
	type: BeyType,
	desc: string,
	packagingStars: { atk: number, def: number, sta: number }?,
	atk: number?,
	move: number?,
	def: number?,
	sta: number?,
	color: string,
	gimmicks: BeyGimmicks,
	unlockLevel: number,
	rarity: BeyRarity,
	available: boolean?,
}

local BEYS: { BeyDefinition } = {
	{
		id = "pegasus",
		name = "STORM PEGASUS",
		type = "Attack",
		desc = "A relentless tornado assault. Rubber-flat tip makes it the fastest, most aggressive bey on the field.",
		packagingStars = { atk = 5, def = 1, sta = 1 },
		atk = 83,
		move = 92,
		def = 28,
		sta = 22,
		color = "#3b82f6",
		gimmicks = { power = "pegasus_speed_boost", special = "pegasus_star_blast", passive = nil },
		unlockLevel = 1,
		rarity = "Rare",
		available = true,
	},
	{
		id = "ldrago",
		name = "METEO L-DRAGO",
		type = "Attack",
		desc = "Left-spin dragon. Spin Steal drains the opponent's spin on every clash.",
		packagingStars = { atk = 4, def = 2, sta = 3 },
		atk = 77,
		move = 85,
		def = 32,
		sta = 52,
		color = "#ef4444",
		gimmicks = { power = "ldrago_spin_steal", special = "ldrago_supreme_flight", passive = nil },
		unlockLevel = 15,
		rarity = "Legendary",
		available = true,
	},
	{
		id = "leone",
		name = "ROCK LEONE",
		type = "Defense",
		desc = "Kyoya's fortress bey. Wide Ball anchors the dish; Lion Gale Force Wall repels rushdown.",
		packagingStars = { atk = 1, def = 4, sta = 2 },
		atk = 18,
		move = 22.58,
		def = 91,
		sta = 46,
		color = "#22c55e",
		gimmicks = { power = "leone_wide_ball", special = "leone_lion_wall", passive = nil },
		unlockLevel = 8,
		rarity = "Epic",
		available = true,
	},
	{
		id = "libra",
		name = "FLAME LIBRA",
		type = "Stamina",
		desc = "Stamina fortress. ES tip holds spin; Sonic Shield repels rushdown and Sonic Buster drags rivals to center.",
		packagingStars = { atk = 2, def = 1, sta = 5 },
		atk = 42,
		def = 28,
		sta = 88,
		color = "#84cc16",
		gimmicks = { power = "libra_sonic_shield", special = "libra_sonic_buster", passive = nil },
		unlockLevel = 5,
		rarity = "Rare",
		available = true,
	},
	{
		id = "bull",
		name = "DARK BULL",
		type = "Balance",
		desc = "Maximum Stampede boosts speed and knockback; Red Horn Uppercut charges and launches foes near the rim.",
		packagingStars = { atk = 4, def = 2, sta = 3 },
		atk = 70,
		move = 18,
		def = 38,
		sta = 34,
		color = "#dc2626",
		gimmicks = { power = "bull_maximum_stampede", special = "bull_red_horn_uppercut", passive = nil },
		unlockLevel = 3,
		rarity = "Uncommon",
		available = true,
	},
}

local byId: { [string]: BeyDefinition } = {}
for _, bey in BEYS do
	byId[bey.id] = bey
end

local BeyCatalog = {}

function BeyCatalog.all(): { BeyDefinition }
	return BEYS
end

function BeyCatalog.get(id: string): BeyDefinition?
	return byId[id]
end

function BeyCatalog.isPlayable(bey: BeyDefinition?): boolean
	return bey ~= nil and (bey.available ~= false) and bey.atk ~= nil
end

function BeyCatalog.playable(): { BeyDefinition }
	local list = {}
	for _, bey in BEYS do
		if BeyCatalog.isPlayable(bey) then
			table.insert(list, bey)
		end
	end
	return list
end

return BeyCatalog
