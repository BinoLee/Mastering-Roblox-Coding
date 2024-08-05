local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local screenGui = script.Parent
local purchaseButton = screenGui:WaitForChild("PurchaseButton")

function purchaseAvatarItem()
    MarketplaceService:PromptPurchase(
        -- 프롬프트를 볼 플레이어
        Players.LocalPlayer,

        -- 아바타 아이템 ID
        123456789
    )
end

purchaseButton.MouseButton1Click:Connect(purchaseAvatarItem)
