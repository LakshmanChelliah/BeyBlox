--!strict
--[[
	XP curve, level unlocks, tournament entry gates, and gacha roll tables.
	See docs/PROGRESSION_ECONOMY.md for full design rationale.
]]

export type TournamentTier = {
	id: string,
	name: string,
	minBeyPoints: number,
	minLevel: number,
	rewardMultiplier: number,
}

export type GachaPoolEntry = {
	beyId: string?,
	partId: string?,
	colorVariantId: string?,
	weight: number,
}

local Progression = {}

-- XP required to reach level N (cumulative from level 1)
function Progression.xpForLevel(level: number): number
	if level <= 1 then
		return 0
	end
	return math.floor(100 * (level - 1) ^ 1.65)
end

function Progression.levelFromXp(xp: number): number
	local level = 1
	while Progression.xpForLevel(level + 1) <= xp do
		level += 1
		if level >= 100 then
			break
		end
	end
	return level
end

function Progression.xpReward(mode: string, won: boolean): number
	local base = if mode == "Campaign" then 120 elseif mode == "Tournament" then 200 else 80
	if not won then
		base = math.floor(base * 0.35)
	end
	return base
end

Progression.TOURNAMENT_TIERS: { TournamentTier } = {
	{ id = "bronze", name = "Bronze Cup", minBeyPoints = 0, minLevel = 3, rewardMultiplier = 1.0 },
	{ id = "silver", name = "Silver Cup", minBeyPoints = 1100, minLevel = 8, rewardMultiplier = 1.25 },
	{ id = "gold", name = "Gold Cup", minBeyPoints = 1300, minLevel = 12, rewardMultiplier = 1.5 },
	{ id = "platinum", name = "Platinum Cup", minBeyPoints = 1500, minLevel = 18, rewardMultiplier = 2.0 },
	{ id = "champion", name = "Champion League", minBeyPoints = 1700, minLevel = 25, rewardMultiplier = 3.0 },
}

function Progression.canEnterTournament(beyPoints: number, level: number, tierId: string): (boolean, string?)
	for _, tier in Progression.TOURNAMENT_TIERS do
		if tier.id == tierId then
			if level < tier.minLevel then
				return false, `Reach level {tier.minLevel} to enter {tier.name}`
			end
			if beyPoints < tier.minBeyPoints then
				return false, `Need {tier.minBeyPoints} Bey Points for {tier.name}`
			end
			return true, nil
		end
	end
	return false, "Unknown tournament tier"
end

-- Standard gacha pool (weights are relative)
Progression.STANDARD_ROLL_POOL: { GachaPoolEntry } = {
	{ beyId = "bull", weight = 28 },
	{ beyId = "libra", weight = 22 },
	{ beyId = "leone", weight = 14 },
	{ beyId = "pegasus", weight = 8 },
	{ beyId = "ldrago", weight = 3 },
	{ colorVariantId = "pegasus_chrome", weight = 12 },
	{ colorVariantId = "bull_shadow", weight = 10 },
	{ partId = "track_145", weight = 3 },
}

function Progression.rollCostCoins(): number
	return 500
end

function Progression.rollCostRobux(): number
	return 49
end

return Progression
