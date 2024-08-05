-- 9.2.1
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local screenGui = script.Parent
local purchaseButton = screenGui:WaitForChild("PurchaseButton")

function purchaseGamePass()
	MarketplaceService:PromptGamePassPurchase(
		-- 프롬프트를 볼 플레어어
		Players.LocalPlayer,

		-- 게임 패스 ID
		123456789
	)
end

purchaseButton.MouseButton1Click:Connect(purchaseGamePass)

-- 9.2.2
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local tools = ServerStorage.Tools

local gamePasses = {
	[123456789] = function(player)
		tools.GamePassTool:Clone().Parent = player.Backpack
		tools.GamePassTool:Clone().Parent = player.StarterGear
	end
}

--

-- 9.2.3
local MarketplaceService = game:GetService("MarketplaceService")

function purchaseFinished(player, gamePassId, purchased)
	if purchased == true then
		-- 게임 패스 상품 정보 받아오기
		local productInfo = MarketplaceService:GetProductInfo(
			gamePassId,
			Enum.InfoType.GamePass
		)
		
		-- 메시지 출력
		print(
			player.Name .. " just purchased a game pass"
			.. " named [" .. productInfo.Name .. "]."
		)
	end
end

MarketplaceService.PromptGamePassPurchaseFinished:Connect(purchaseFinished)

-- 전체

local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local tools = ServerStorage.Tools

local gamePasses = {
	[123456789] = function(player)
		tools.GamePassTool:Clone().Parent = player.Backpack
		tools.GamePassTool:Clone().Parent = player.StarterGear
	end
}

--

function playerJoined(player)
	-- 게임 패스 전체 반복
	for gamePassId, rewardFunction in pairs(gamePasses) do
		-- 게임 패스 구매 여부 확인
		if
			MarketplaceService:UserOwnsGamePassAsync(
				-- 사용자 ID
				player.UserId,
				
				-- 게임 패스 ID
				gamePassId
			)
		then
			-- 게임 패스 혜택 지급
			rewardFunction(player)
		end
	end
end

function purchaseFinished(player, gamePassId, purchased)
	if purchased == true then
		-- 게임 패스 혜택 구현 여부 확인
		if gamePasses[gamePassId] == nil then
			warn("GamePass [" .. gamePassId .. "] reward was not programmed")
			return
		end
		
		-- 게임 패스 혜택 지급
		gamePasses[gamePassId](player)
	end
end

--

Players.PlayerAdded:Connect(playerJoined)
MarketplaceService.PromptGamePassPurchaseFinished:Connect(purchaseFinished)