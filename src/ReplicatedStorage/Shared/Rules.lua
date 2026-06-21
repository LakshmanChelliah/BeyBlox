--!strict
--[[
	Match win evaluation — KO, Sleep Out, Draw.
	Ported from BeyWeb js/game/rules.js (logic only; arena checks live in Arena module).
]]

export type WinOutcome = "KO" | "SO" | "DRAW"
export type WinResult = {
	outcome: WinOutcome,
	winner: number?,
	loser: number?,
	cinematic: boolean?,
}

export type MatchConfig = {
	spinStopped: number,
	deathAnimDur: number,
	sleepOutDelay: number,
}

local DEFAULT_CONFIG: MatchConfig = {
	spinStopped = 0.001,
	deathAnimDur = 1.0,
	sleepOutDelay = 1.0,
}

local Rules = {}

function Rules.isSleepOutReady(spin: number, deathAnimT: number, sleepOutDelay: number?, config: MatchConfig?): boolean
	local cfg = config or DEFAULT_CONFIG
	if spin > cfg.spinStopped then
		return false
	end
	if deathAnimT < cfg.deathAnimDur then
		return false
	end
	return sleepOutDelay ~= nil and sleepOutDelay <= 0
end

export type BeyState = {
	spin: number,
	deathAnimT: number,
	sleepOutDelay: number?,
	onPlatform: boolean,
	ringOut: boolean,
}

function Rules.evaluate(
	player: BeyState,
	opponent: BeyState,
	frozen: boolean,
	launchGrace: number
): WinResult?
	if frozen or launchGrace > 0 then
		return nil
	end

	if player.ringOut then
		return { outcome = "KO", winner = 2, loser = 1, cinematic = true }
	end
	if opponent.ringOut then
		return { outcome = "KO", winner = 1, loser = 2, cinematic = true }
	end

	local pSleep = Rules.isSleepOutReady(player.spin, player.deathAnimT, player.sleepOutDelay)
	local aSleep = Rules.isSleepOutReady(opponent.spin, opponent.deathAnimT, opponent.sleepOutDelay)

	if pSleep and aSleep and player.onPlatform and opponent.onPlatform then
		return { outcome = "DRAW", winner = nil, loser = nil }
	end
	if pSleep and not aSleep and player.onPlatform then
		return { outcome = "SO", winner = 2, loser = 1 }
	end
	if aSleep and not pSleep and opponent.onPlatform then
		return { outcome = "SO", winner = 1, loser = 2 }
	end

	return nil
end

return Rules
