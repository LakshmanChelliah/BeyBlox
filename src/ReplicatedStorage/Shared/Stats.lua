--!strict
--[[
	Converts 0–100 bey stats into physics multipliers.
	Ported from BeyWeb js/game/stats.js
]]

export type BeyStats = {
	atk: number?,
	move: number?,
	def: number?,
	sta: number?,
}

local Stats = {}

function Stats.moveSpeedMult(stats: BeyStats): number
	local move = stats.move or stats.atk or 50
	return 0.2 + move / 62.5
end

function Stats.atkCombatMult(stats: BeyStats): number
	return 0.5 + (stats.atk or 50) / 100
end

function Stats.defMult(stats: BeyStats): number
	return 0.5 + (stats.def or 50) / 100
end

function Stats.spinDefMult(stats: BeyStats): number
	local def = stats.def or 50
	return 0.5 + def / 58
end

function Stats.staMult(sta: number?): number
	return 1.5 - (sta or 50) / 100
end

return Stats
