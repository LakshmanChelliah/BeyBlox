--!strict
--[[
	Gacha rolls and Robux developer product purchases.
	All grants are validated server-side; client only plays reveal animation.
]]

local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = require(ReplicatedStorage.Shared)
local Progression = Shared.Progression

local ShopService = {}

-- Register these IDs in Roblox Creator Dashboard when products are created
ShopService.PRODUCT_IDS = {
	SingleRoll = 0, -- TODO: replace with real developer product id
	FiveRollBundle = 0,
	TenRollBundle = 0,
}

function ShopService.weightedRoll(rng: Random): { beyId: string?, partId: string?, colorVariantId: string? }
	local pool = Progression.STANDARD_ROLL_POOL
	local total = 0
	for _, entry in pool do
		total += entry.weight
	end

	local roll = rng:NextInteger(1, total)
	local cumulative = 0
	for _, entry in pool do
		cumulative += entry.weight
		if roll <= cumulative then
			return {
				beyId = entry.beyId,
				partId = entry.partId,
				colorVariantId = entry.colorVariantId,
			}
		end
	end

	return {}
end

function ShopService.setupMarketplace()
	MarketplaceService.ProcessReceipt = function(receipt)
		-- TODO: grant rolls / coins based on receipt.ProductId
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
end

return ShopService
