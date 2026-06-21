--!strict
-- Server bootstrap: load player profiles, wire remotes, start services.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ProfileService = require(script.Parent.ProfileService)
local ShopService = require(script.Parent.ShopService)

-- Profiles keyed by userId (replace with ProfileStore / DataStore wrapper in production)
local profiles: { [number]: any } = {}

local function onPlayerAdded(player: Player)
	profiles[player.UserId] = ProfileService.defaultProfile()
	-- TODO: DataStore load with retry + session lock
end

local function onPlayerRemoving(player: Player)
	-- TODO: save profile
	profiles[player.UserId] = nil
end

ShopService.setupMarketplace()
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end

print("[BeyBlox] Server started")
