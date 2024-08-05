--9.3.1

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local screenGui = script.Parent
local purchaseButton = screenGui:WaitForChild("PurchaseButton")

function purchaseProduct()
	MarketplaceService:PromptProductPurchase(
		-- 프롬프트를 볼 플레이어
		Players.LocalPlayer,

		-- 개발자 상품 ID
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
	-- 500 게임 머니 개발자 상품
	[123456789] = function(player)
		print("old: " .. DataManager:Get(player, "money"))
		DataManager:Increment(player, "money", 500)
		print("new: " .. DataManager:Get(player, "money"))
	end
}

--

function processReceipt(receiptInfo)
	-- 플레이어 정보 받기
	local userId = receiptInfo.PlayerId
	local player = Players:GetPlayerByUserId(userId)
	--
	if player == nil or not player:IsDescendantOf(Players) then
		-- 플레이어가 게임 플레이 중이 아님
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	
	-- 개발자 상품 구현 여부 확인
	local purchasedDeveloperProduct = receiptInfo.ProductId
	--
	if developerProducts[purchasedDeveloperProduct] == nil then
		-- 개발자 상품 미구현
		warn("Developer Product [" .. purchasedDeveloperProduct .. "] was not programmed!")
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	
	-- 개발자 상품 혜택 지급
	local suc, err = pcall(function()
		developerProducts[purchasedDeveloperProduct](player)
	end)
	
	-- 혜택 지급 성공 여부 확인
	if not suc then
		-- 혜택 지급 중 오류 발생
		warn(err)
		return Enum.ProductPurchaseDecision.NotProcessedYet
	else
		-- 혜택 지급 성공
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
end

--

MarketplaceService.ProcessReceipt = processReceipt