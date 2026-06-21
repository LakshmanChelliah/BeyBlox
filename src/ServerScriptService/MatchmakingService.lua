--!strict
--[[
	Matchmaking queues for ranked 1v1, friendly 1v1, and 2v2.
	Uses MemoryStoreService for ephemeral queues; TeleportService for arena instances.
]]

local MemoryStoreService = game:GetService("MemoryStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = require(ReplicatedStorage.Shared)
local Elo = Shared.Elo

local MatchmakingService = {}
local queueStore = MemoryStoreService:GetQueue("BeyMatchmaking_v1")

export type QueueEntry = {
	userId: number,
	mode: string,
	beyPoints: number,
	beyId: string,
	enqueuedAt: number,
	partyUserIds: { number }?,
}

function MatchmakingService.enqueue(entry: QueueEntry)
	local priority = -entry.beyPoints -- higher rating matched first within band
	queueStore:AddAsync(entry.userId, entry, 120, priority)
end

function MatchmakingService.tryPair(mode: string): ({ QueueEntry }, { QueueEntry })?
	-- TODO: read queue, pair within Elo band (±150 for 1v1, team avg for 2v2)
	return nil
end

function MatchmakingService.eloBand(mode: string, rating: number): (number, number)
	local spread = if Shared.GameModes.isTeamMode(mode) then 200 else 150
	return rating - spread, rating + spread
end

return MatchmakingService
