--!strict
--[[
	Shared game mode identifiers.
	Mirrors BeyWeb js/game/modes.js with Roblox-specific extensions.
]]

export type GameMode =
	"Hub"
	| "Campaign"
	| "Casual"
	| "Ranked1v1"
	| "Friendly1v1"
	| "Ranked2v2"
	| "Friendly2v2"
	| "Tournament"
	| "Practice"

local GameModes = table.freeze({
	Hub = "Hub",
	Campaign = "Campaign",
	Casual = "Casual",
	Ranked1v1 = "Ranked1v1",
	Friendly1v1 = "Friendly1v1",
	Ranked2v2 = "Ranked2v2",
	Friendly2v2 = "Friendly2v2",
	Tournament = "Tournament",
	Practice = "Practice",
})

local function isRanked(mode: GameMode): boolean
	return mode == GameModes.Ranked1v1 or mode == GameModes.Ranked2v2 or mode == GameModes.Tournament
end

local function isPvP(mode: GameMode): boolean
	return mode == GameModes.Ranked1v1
		or mode == GameModes.Friendly1v1
		or mode == GameModes.Ranked2v2
		or mode == GameModes.Friendly2v2
		or mode == GameModes.Tournament
end

local function isTeamMode(mode: GameMode): boolean
	return mode == GameModes.Ranked2v2 or mode == GameModes.Friendly2v2
end

return {
	GameModes = GameModes,
	isRanked = isRanked,
	isPvP = isPvP,
	isTeamMode = isTeamMode,
}
