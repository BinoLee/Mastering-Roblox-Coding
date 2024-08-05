local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

function promptPremium()
	-- 플레이어 정보 받기
	local player = Players.LocalPlayer
	
	-- 프리미엄 구독 여부 확인
	if player.MembershipType ~= Enum.MembershipType.Premium then
		-- 프리미엄 미구독 중
		MarketplaceService:PromptPremiumPurchase(player)
	else
		-- 프리미엄 구독 중
		print("You are already subscribed!")
	end
end

promptPremium()
