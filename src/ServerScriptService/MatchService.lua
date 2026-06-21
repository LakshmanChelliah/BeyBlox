--!strict
--[[
	Authoritative match simulation host.
	Runs fixed 60 Hz tick; clients send steer + ability inputs only.
	Port physics from BeyWeb js/game/simulation.js + js/physics/* incrementally.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.Shared)

local MatchService = {}
MatchService.__index = MatchService

export type MatchParticipant = {
	userId: number,
	team: number,
	beyId: string,
}

export type MatchOptions = {
	mode: string,
	participants: { MatchParticipant },
	seed: number,
}

function MatchService.new(options: MatchOptions)
	local self = setmetatable({}, MatchService)
	self.options = options
	self.tick = 0
	self.running = false
	self.winsNeeded = 2
	self.seriesScore = {}
	for _, p in options.participants do
		self.seriesScore[p.userId] = 0
	end
	return self
end

function MatchService:start()
	self.running = true
	self.tick = 0
	-- TODO: spawn arena instance, create bey bodies, begin launch grace
end

function MatchService:applyInput(userId: number, steer: Vector2, abilitySlot: string?)
	-- TODO: queue input for next sim tick (see BeyWeb remoteInput.js)
end

function MatchService:step(dt: number)
	if not self.running then
		return
	end
	self.tick += 1
	-- TODO: physics step, ability hooks, Rules.evaluate
end

function MatchService:getSnapshot()
	return {
		tick = self.tick,
		-- bodies, spins, ability states
	}
end

return MatchService
