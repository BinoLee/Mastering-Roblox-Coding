local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local DataStoreTesting = DataStoreService:GetDataStore("LastPlayed")

--

function playerLeft(player)
    -- 플레이어가 나간 시간 저장
    -- 다시 플레이할 때 얼마만에 돌아왔는지 계산하는 데 사용
    local suc, err = pcall(function()
        DataStoreTesting:SetAsync(
        -- 키
            "Plr_" .. player.UserId,

            -- 데이터
            os.time()
        )
    end)
    if not suc then
        warn(err)
    end
end

function playerJoined(player)
    -- 데이터 저장소에서 데이터 호출
    local currentPlayingSecond = os.time()
    local lastPlayingSecond = nil

    local suc, err = pcall(function()
        lastPlayingSecond = DataStoreTesting:GetAsync(
        -- 키
            "Plr_" .. player.UserId
        )
    end)
    if not suc then
        warn(err)
    end

    -- 데이터 사용
    if lastPlayingSecond ~= nil then
        print("It has been [" .. currentPlayingSecond - lastPlayingSecond .. "] seconds since you last played!")
    else
        print("It is your first time playing!")
    end
end

--

Players.PlayerAdded:Connect(playerJoined)
Players.PlayerRemoving:Connect(playerLeft)


-- 게임머니 리더보드
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local CurrencyDataStore = DataStoreService:GetDataStore("CurrencyData")

local STARTER_MONEY = 500
local REWARD_INTERVAL = 30
local REWARD_AMOUNT = 10


-- PLAYER FUNCTIONS

function playerJoined(player)
	-- Creating Leaderstats
	createLeaderstats(player)
	
	-- Loading Data
	local loadedCurrency = nil
	
	local suc, err = pcall(function()
		-- Getting data store value
		loadedCurrency = CurrencyDataStore:GetAsync("Plr_" .. player.UserId)
	end)
	if not suc then
		-- Printing error
		warn(err)
		
		-- Making leaderstat negative
		incrementLeaderstat(player, "💸 Money", -(getLeaderstatValue(player, "💸 Money") + 1))
		
		-- Kicking player
		player:Kick("\n[Data Failed]\nFailed to load data. Please rejoin")
	else
		-- Setting default data
		if loadedCurrency == nil then
			loadedCurrency = STARTER_MONEY
		end
		
		-- Setting leaderstat
		incrementLeaderstat(player, "💸 Money", loadedCurrency)
		
		-- Interval Money
		enablePlayingReward(player)
		print("Printed when the player left!")
	end
end

function playerLeft(player)
	local suc, err = pcall(function()
		local money = getLeaderstatValue(player, "💸 Money")
		if money >= 0 then
			CurrencyDataStore:SetAsync(
				"Plr_" .. player.UserId,
				money
			)
		end
	end)
	if not suc then
		warn(err)
	end
end


-- PLAYING REWARD

function enablePlayingReward(player)
	while player:IsDescendantOf(Players) do
		task.wait(REWARD_INTERVAL)
		incrementLeaderstat(player, "💸 Money", REWARD_AMOUNT)
	end
end


-- LEADERSTAT FUNCTIONS

function createLeaderstats(player)
	local leaderstats = Instance.new("Model")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local money = Instance.new("IntValue")
	money.Name = "💸 Money"
	money.Parent = leaderstats
	money.Value = 0
end

function getLeaderstatValue(player, leaderstat)
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats ~= nil then
		local statistic = leaderstats:FindFirstChild(leaderstat)
		if statistic ~= nil then
			return statistic.Value
		else
			warn("Statistic named [" .. leaderstat .. "] does not exist!")
		end
	end
	return 0
end

function incrementLeaderstat(player, leaderstat, value)
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats ~= nil then
		local statistic = leaderstats:FindFirstChild(leaderstat)
		if statistic ~= nil then
			statistic.Value += value
		end
	end
end

--

Players.PlayerAdded:Connect(playerJoined)
Players.PlayerRemoving:Connect(playerLeft)


--8.2.6
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local TestDataStore = DataStoreService:GetDataStore("DictionaryTest")

function playerLeft(player)
	local randomDictionary = {
		["Coins"] = 5,
		["Gems"] = 0,
		["PlayTime"] = 0,
		["TimesPlayed"] = 0
	}
	
	local suc, err = pcall(function()
		TestDataStore:SetAsync(
			"Plr_" .. player.UserId,
			randomDictionary
		)
	end)
	if not suc then
		warn(err)
	end
end

Players.PlayerRemoving:Connect(playerLeft)

-- 8.2.7
DataStore:SetAsync(
	"Plr_" .. player.UserId,
	{
		[1] = {
			["item_type"] = workspace.PlacedItems.Chair,--> Error!
			["position"] = Vector3.new(0, 0, 0) --> Error!
		},
		[2] = {
			["item_type"] = "Chair", --> Allowed!
			["position"] = {0, 0, 0} --> Allowed!
		}
	}
)

local data = DataStore:GetAsync("Plr_" .. player.UserId)
local chairPosition = Vector3.new(
	data[2]["position"][1], --> 100
	data[2]["position"][2], --> 200
	data[2]["position"][3] --> 300
)

-- 8.2.8
local DataStoreService = game:GetService("DataStoreService")

local PrimaryDataStore = DataStoreService:GetDataStore("PrimaryDataStore")
local SecondaryDataStore = DataStoreService:GetDataStore("SecondaryDataStore")

function removeAllPlayerData(userId)
	local suc, err = pcall(function()
		PrimaryDataStore:RemoveAsync("Plr_" .. userId)
		SecondaryDataStore:RemoveAsync("Plr_" .. userId)
	end)
	if not suc then
		warn(err)
	end
end