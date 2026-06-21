--!strict
-- Client bootstrap: hub UI, match UI, input relay.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.Shared)

print("[BeyBlox] Client loaded — modes:", Shared.GameModes.GameModes.Hub)

-- TODO: mount ScreenGuis from StarterGui, connect to Remotes folder
