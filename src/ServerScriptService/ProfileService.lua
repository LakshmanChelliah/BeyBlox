--!strict
--[[
	Player profile schema and DataStore persistence.
	All competitive changes must be server-authoritative.
]]

export type OwnedPart = {
	partId: string,
	acquiredAt: number,
}

export type PlayerProfile = {
	version: number,
	xp: number,
	level: number,
	coins: number,
	beyPoints: number,
	matchesPlayed: number,
	ownedBeyIds: { string },
	ownedPartIds: { string },
	ownedColorVariants: { string },
	equippedBeyId: string,
	equippedParts: { [string]: string }, -- slot -> partId
	freeRolls: number,
	lastDailyRoll: number?,
	campaignStage: number,
	campaignWins: number,
}

local ProfileService = {}

local PROFILE_VERSION = 1
local DATASTORE_NAME = "BeyBloxPlayerProfiles_v1"

function ProfileService.defaultProfile(): PlayerProfile
	return {
		version = PROFILE_VERSION,
		xp = 0,
		level = 1,
		coins = 250,
		beyPoints = 1000,
		matchesPlayed = 0,
		ownedBeyIds = { "pegasus" },
		ownedPartIds = {},
		ownedColorVariants = {},
		equippedBeyId = "pegasus",
		equippedParts = {},
		freeRolls = 1,
		lastDailyRoll = nil,
		campaignStage = 0,
		campaignWins = 0,
	}
end

function ProfileService.getDatastoreName(): string
	return DATASTORE_NAME
end

return ProfileService
