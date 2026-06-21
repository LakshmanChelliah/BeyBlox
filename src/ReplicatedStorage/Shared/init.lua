--!strict
-- Barrel export for shared modules consumed by server and client.

local Shared = script.Parent

return {
	GameModes = require(Shared.GameModes),
	Stats = require(Shared.Stats),
	BeyCatalog = require(Shared.BeyCatalog),
	Rules = require(Shared.Rules),
	Elo = require(Shared.Elo),
	Progression = require(Shared.Progression),
}
