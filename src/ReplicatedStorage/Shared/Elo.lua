--!strict
--[[
	Bey Points — competitive ELO rating for ranked play and tournament gates.
	Uses a standard Elo formula with K-factor scaling by match type.
]]

export type RatingChange = {
	before: number,
	after: number,
	delta: number,
}

local Elo = {}

local function expectedScore(ratingA: number, ratingB: number): number
	return 1 / (1 + 10 ^ ((ratingB - ratingA) / 400))
end

function Elo.kFactor(mode: string, matchesPlayed: number): number
	if mode == "Tournament" then
		return 40
	end
	if matchesPlayed < 30 then
		return 32
	end
	return 24
end

function Elo.apply(
	winnerRating: number,
	loserRating: number,
	mode: string,
	matchesPlayed: number
): (RatingChange, RatingChange)
	local k = Elo.kFactor(mode, matchesPlayed)
	local expectedWinner = expectedScore(winnerRating, loserRating)
	local expectedLoser = expectedScore(loserRating, winnerRating)

	local winnerDelta = math.floor(k * (1 - expectedWinner) + 0.5)
	local loserDelta = math.floor(k * (0 - expectedLoser) + 0.5)

	local winnerAfter = math.max(0, winnerRating + winnerDelta)
	local loserAfter = math.max(0, loserRating + loserDelta)

	return {
		before = winnerRating,
		after = winnerAfter,
		delta = winnerAfter - winnerRating,
	}, {
		before = loserRating,
		after = loserAfter,
		delta = loserAfter - loserRating,
	}
end

function Elo.defaultRating(): number
	return 1000
end

return Elo
