--9.3.1

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local screenGui = script.Parent
local purchaseButton = screenGui:WaitForChild("PurchaseButton")

function purchaseProduct()
	MarketplaceService:PromptProductPurchase(
		-- Player that will receive the prompt
		Players.LocalPlayer,

		-- Developer Product ID
		123456789
	)
end

purchaseButton.MouseButton1Click:Connect(purchaseProduct)

--9.3.2
local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")

local player = Players.LocalPlayer

print(PolicyService:GetPolicyInfoForPlayerAsync(player))

-- 전체 코드
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local DataManager = require(PATH_TO_DATAMANAGER)

local developerProducts = {
	-- 500 money developer product
	[123456789] = function(player)
		-- Printing old money
		print("old: " .. DataManager:Get(player, "money"))
		
		-- Rewarding developer product
		DataManager:Increment(player, "money", 500)
		
		-- Printing new money
		print("new: " .. DataManager:Get(player, "money"))
	end
}

--

function processReceipt(receiptInfo)
	-- Getting player
	local userId = receiptInfo.PlayerId
	local player = Players:GetPlayerByUserId(userId)
	--
	if player == nil or not player:IsDescendantOf(Players) then
		-- Player is not in-game anymore
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	
	-- Checking if developer product is programmed
	local purchasedDeveloperProduct = receiptInfo.ProductId
	--
	if developerProducts[purchasedDeveloperProduct] == nil then
		-- Developer product was not programmed
		warn("Developer Product [" .. purchasedDeveloperProduct .. "] was not programmed!")
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	
	-- Rewarding developer product
	local suc, err = pcall(function()
		developerProducts[purchasedDeveloperProduct](player)
	end)
	
	-- Checking if reward was succesful
	if not suc then
		-- An error occurred while trying to reward
		warn(err)
		return Enum.ProductPurchaseDecision.NotProcessedYet
	else
		-- Rewarding successful
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
end

--

MarketplaceService.ProcessReceipt = processReceipt