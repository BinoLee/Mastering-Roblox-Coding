-- 7.2.1
-- ClickDetector
local clickDetector = workspace.ClickablePart.ClickDetector

function clicked(player)
    print(player.Name)
end

clickDetector.MouseClick:Connect(clicked)

-- leaderstats 증가
local Players = game:GetService("Players")

function newPlayer(player)
    local leaderstats = Instance.new("Model")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local statistic = Instance.new("IntValue")
    statistic.Name = "SomeStatistic"
    statistic.Parent = leaderstats
    statistic.Value = 0
end

Players.PlayerAdded:Connect(newPlayer)

--파티클 활성화
local furnace = workspace:WaitForChild("KitchenFurnace")
local clickDetector = furnace:WaitForChild("ClickDetector")
local fire = furnace:WaitForChild("Fire")

function clicked()
    fire.Enabled = not fire.Enabled
end

clickDetector.MouseClick:Connect(clicked)

--7.2.2
-- 손전등
local ServerStorage = game:GetService("ServerStorage")
local toolsStorage = ServerStorage.Tools
local flashlightGiver = workspace.FlashlightGiver
local proximityPrompt = flashlightGiver.GiveTool

function proximityPromptTriggered(player)
	if not playerHasTool(player, "Flashlight") then
		-- ServerStorage > Tools에 손전등이 있는지 확인
		local flashlight = toolsStorage:FindFirstChild("Flashlight")
		if flashlight ~= nil then
			-- 손전등 복사
			local toolClone = flashlight:Clone()
			
			-- Backpack 자녀로 설정
			toolClone.Parent = player.Backpack
		else
			warn("Flashlight tool missing!")
		end
	end
end

-- 툴 중복 방지

function playerHasTool(player, toolName)
	local character = player.Character
	local backpack = player.Backpack
	--
	local characterTool = character:FindFirstChildOfClass("Tool")
	if 
		( characterTool ~= nil and characterTool.Name == toolName )
		or
		backpack:FindFirstChild(toolName)
	then
		-- 이미 도구가 있음
		return true
	end
	-- 도구가 없음
	return false
end

--

proximityPrompt.Triggered:Connect(proximityPromptTriggered)

-- 7.2.3
local tool = script.Parent
local handle = tool.Handle

function activated()
    local spotlight = handle:FindFirstChild("SpotLight")
    if spotlight ~= nil then
        spotlight.Enabled = not spotlight.Enabled
    end
end

tool.Activated:Connect(activated)