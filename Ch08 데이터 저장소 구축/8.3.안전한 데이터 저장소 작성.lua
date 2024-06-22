-- 8.3.1
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local DataStore = DataStoreService:GetDataStore("PlayerData")

local DEFAULT_PLAYER_DATA = {
	["coins"] = 500,
	["gems"] = 0,
	["times_played"] = 0
}

local playerData = {}


-- PLAYER FUNCTIONS

function playerJoined(player)
	-- Getting and Caching data
	playerData[player.Name] = get(player)
	
	-- Updating times_played
	playerData[player.Name]["times_played"] += 1
	print(playerData[player.Name]["times_played"])
end

function playerLeft(player)
	-- Saving data
	save(player)
	
	-- Removing cached data
	playerData[player.Name] = nil
end


-- DATA STORE FUNCTIONS

function get(player)
	local loaded = nil
	--
	local suc, err = pcall(function()
		loaded = DataStore:GetAsync("Plr_" .. player.UserId)
	end)
	if not suc then
		warn(err)
	end
	--
	if loaded == nil then
		return copyTable(DEFAULT_PLAYER_DATA)
	else
		return loaded
	end
end

function save(player)
	local suc, err = pcall(function()
		DataStore:SetAsync(
			-- Key
			"Plr_" .. player.UserId,
			
			-- Cached data
			playerData[player.Name]
		)
	end)
	if not suc then
		warn(err)
	end
end

-- TABLE FUNCTIONS

function copyTable(toCopy)
	-- Creating new copy table
	local copy = {}
	
	-- Looping through toCopy table
	for i, v in pairs(toCopy) do
		-- Checking if value is a nested table/dictionary
		if typeof(v) == "table" then
			-- Copying nested table/dictionary
			v = copyTable(v)
		end
		
		-- Inserting value into copied table
		copy[i] = v
	end
	
	-- Returning table copy
	return copy
end


--

Players.PlayerAdded:Connect(playerJoined)
Players.PlayerRemoving:Connect(playerLeft)

-- 8.3.2
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local DataStore = DataStoreService:GetDataStore("PlayerData")

local AUTO_SAVE_INTERVAL = 30

local DEFAULT_PLAYER_DATA = {
	["coins"] = 500,
	["gems"] = 0,
	["times_played"] = 0
}

local playerData = {}


-- PLAYER FUNCTIONS

function playerJoined(player)
	-- Getting and Caching data
	playerData[player.Name] = get(player)
	
	-- Updating times_played
	playerData[player.Name]["times_played"] += 1
	print(playerData[player.Name]["times_played"])
end

function playerLeft(player)
	-- Saving data
	save(player)
	
	-- Removing cached data
	playerData[player.Name] = nil
end

-- AUTO SAVE

function autoSave()
	while true do
		-- Waiting auto-save interval
		task.wait(AUTO_SAVE_INTERVAL)
		
		-- Getting players
		for _, player in pairs(Players:GetPlayers()) do
			-- Checking if data is cached
			if playerData[player.Name] ~= nil then
				-- Auto-Saving
				task.spawn(function()
					save(player)
				end)
			end
		end
	end
end


-- DATA STORE FUNCTIONS

function get(player)
	local loaded = nil
	--
	local suc, err = pcall(function()
		loaded = DataStore:GetAsync("Plr_" .. player.UserId)
	end)
	if not suc then
		warn(err)
	end
	--
	if loaded == nil then
		return copyTable(DEFAULT_PLAYER_DATA)
	else
		return loaded
	end
end

function save(player)
	local suc, err = pcall(function()
		DataStore:SetAsync(
			-- Key
			"Plr_" .. player.UserId,
			
			-- Cached data
			playerData[player.Name]
		)
	end)
	if not suc then
		warn(err)
	end
end

-- TABLE FUNCTIONS

function copyTable(toCopy)
	-- Creating new copy table
	local copy = {}
	
	-- Looping through toCopy table
	for i, v in pairs(toCopy) do
		-- Checking if value is a nested table/dictionary
		if typeof(v) == "table" then
			-- Copying nested table/dictionary
			v = copyTable(v)
		end
		
		-- Inserting value into copied table
		copy[i] = v
	end
	
	-- Returning table copy
	return copy
end


--

task.spawn(autoSave)
Players.PlayerAdded:Connect(playerJoined)
Players.PlayerRemoving:Connect(playerLeft)

-- 8.3.3

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local DataStore = DataStoreService:GetDataStore("PlayerData")

local AUTO_SAVE_INTERVAL = 30

local DEFAULT_PLAYER_DATA = {
	["coins"] = 500,
	["gems"] = 0,
	["times_played"] = 0
}

local playerData = {}


-- PLAYER FUNCTIONS

function playerJoined(player)
	-- Getting and Caching data
	playerData[player.Name] = get(player)

	-- Updating times_played
	playerData[player.Name]["times_played"] += 1
	print(playerData[player.Name]["times_played"])
end

function playerLeft(player)
	-- Saving data
	save(player)

	-- Removing cached data
	playerData[player.Name] = nil
end

-- AUTO SAVE

function autoSave()
	while true do
		-- Waiting auto-save interval
		task.wait(AUTO_SAVE_INTERVAL)

		-- Getting players
		for _, player in pairs(Players:GetPlayers()) do
			-- Checking if data is cached
			if playerData[player.Name] ~= nil then
				-- Auto-Saving
				save(player)
			end
		end
	end
end


-- DATA STORE FUNCTIONS

function get(player)
	local loaded = nil
	local suc, err
	--
	repeat
		suc, err = pcall(function()
			loaded = DataStore:GetAsync("Plr_" .. player.UserId)
		end)
		if not suc then
			-- Printing warning
			warn(err)

			-- Small wait period in between retries
			task.wait(6)
		end
	until
	suc
	--
	if loaded == nil then
		return copyTable(DEFAULT_PLAYER_DATA)
	else
		return loaded
	end
end

function save(player)
	local suc, err
	repeat
		suc, err = pcall(function()
			DataStore:SetAsync(
				-- Key
				"Plr_" .. player.UserId,

				-- Cached data
				playerData[player.Name]
			)
		end)
		if not suc then
			-- Printing warning
			warn(err)
			
			-- Small wait period in between retries
			task.wait(6)
		end
	until
	suc
end


-- TABLE FUNCTIONS

function copyTable(toCopy)
	-- Creating new copy table
	local copy = {}

	-- Looping through toCopy table
	for i, v in pairs(toCopy) do
		-- Checking if value is a nested table/dictionary
		if typeof(v) == "table" then
			-- Copying nested table/dictionary
			v = copyTable(v)
		end

		-- Inserting value into copied table
		copy[i] = v
	end

	-- Returning table copy
	return copy
end


--

task.spawn(autoSave)
Players.PlayerAdded:Connect(playerJoined)
Players.PlayerRemoving:Connect(playerLeft)

-- 8.3.4
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local DataStore = DataStoreService:GetDataStore("PlayerData")

local AUTO_SAVE_INTERVAL = 30

local DEFAULT_PLAYER_DATA = {
	["coins"] = 500,
	["gems"] = 0,
	["times_played"] = 0
}

local playerData = {}


-- PLAYER FUNCTIONS

function playerJoined(player)
	-- Getting and Caching data
	playerData[player.Name] = get(player)

	-- Updating times_played
	playerData[player.Name]["times_played"] += 1
	print(playerData[player.Name]["times_played"])
end

function playerLeft(player)
	-- Saving data
	save(player)

	-- Removing cached data
	playerData[player.Name] = nil
end

-- AUTO SAVE

function autoSave()
	while true do
		-- Waiting auto-save interval
		task.wait(AUTO_SAVE_INTERVAL)

		-- Getting players
		for _, player in pairs(Players:GetPlayers()) do
			-- Checking if data is cached
			if playerData[player.Name] ~= nil then
				-- Auto-Saving
				save(player)
			end
		end
	end
end


-- DATA STORE FUNCTIONS

function get(player)
	-- Waiting for budget
	yieldUntilBudget(Enum.DataStoreRequestType.Up)
	
	-- Getting data
	local loaded = nil
	local suc, err
	--
	repeat
		suc, err = pcall(function()
			loaded = DataStore:GetAsync("Plr_" .. player.UserId)
		end)
		if not suc then
			-- Printing warning
			warn(err)

			-- Small wait period in between retries
			task.wait(6)
		end
	until
	suc
	--
	if loaded == nil then
		return copyTable(DEFAULT_PLAYER_DATA)
	else
		return loaded
	end
end

function save(player)
	-- Waiting for budget
	yieldUntilBudget(Enum.DataStoreRequestType.SetIncrementAsync)
	
	-- Saving data
	local suc, err
	repeat
		suc, err = pcall(function()
			DataStore:SetAsync(
				-- Key
				"Plr_" .. player.UserId,

				-- Cached data
				playerData[player.Name]
			)
		end)
		if not suc then
			-- Printing warning
			warn(err)

			-- Small wait period in between retries
			task.wait(6)
		end
	until
	suc
end

function yieldUntilBudget(dataStoreRequestType)
	while 
		DataStoreService:GetRequestBudgetForRequestType(dataStoreRequestType) <= 0
	do
		task.wait(1)
	end
end


-- TABLE FUNCTIONS

function copyTable(toCopy)
	-- Creating new copy table
	local copy = {}

	-- Looping through toCopy table
	for i, v in pairs(toCopy) do
		-- Checking if value is a nested table/dictionary
		if typeof(v) == "table" then
			-- Copying nested table/dictionary
			v = copyTable(v)
		end

		-- Inserting value into copied table
		copy[i] = v
	end

	-- Returning table copy
	return copy
end


--

task.spawn(autoSave)
Players.PlayerAdded:Connect(playerJoined)
Players.PlayerRemoving:Connect(playerLeft)

-- 8.3.5

local DataManager = {}

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local DataStore = DataStoreService:GetDataStore("PlayerData")

local DataLoadedEvent = Instance.new("BindableEvent")

local AUTO_SAVE_INTERVAL = 30

local DEFAULT_PLAYER_DATA = {
	["coins"] = 500,
	["tools"] = {}
}

local playerData = {}


-- SETUP

function setupEvents()
	DataManager["PlayerAdded"] = DataLoadedEvent.Event
end


-- PUBLIC FUNCTIONS

function DataManager:DataLoaded(player)
	-- Checking if the data was loaded already
	return playerData[player.Name] ~= nil
end

function DataManager:Get(player, key)
	-- Checking if data is loaded
	if DataManager:DataLoaded(player) ~= true then
		error("[Data Not Loaded]: Use the DataManager.PlayerAdded event in favor of the Players.PlayerAdded event!")
	end

	-- Getting cached data
	local cachedData = playerData[player.Name]

	-- Checking if key is valid
	if cachedData[key] == nil then
		error("[Invalid Key]: Key [" .. key .. "] does not exist.")
	end

	-- Returning data
	return cachedData[key]
end

function DataManager:Set(player, key, value)
	-- Checking if data is loaded
	if DataManager:DataLoaded(player) ~= true then
		error("[Data Not Loaded]: Use the DataManager.PlayerAdded event in favor of the Players.PlayerAdded event!")
	end

	-- Setting data
	playerData[player.Name][key] = value
end

function DataManager:Increment(player, key, value)
	-- Checking if data is loaded
	if DataManager:DataLoaded(player) ~= true then
		error("[Data Not Loaded]: Use the DataManager.PlayerAdded event in favor of the Players.PlayerAdded event!")
	end

	-- Getting cached data
	local cachedData = playerData[player.Name]

	-- Checking if key is valid
	if cachedData[key] == nil then
		error("[Invalid Key]: Key [" .. key .. "] does not exist.")
	end

	-- Checking data type
	if typeof(cachedData[key]) ~= "number" then
		error("[Invalid data type]: You can only use the :Increment() function on numbers. Consider using :Set().")
	end

	-- Incrementing
	cachedData[key] += value
end


-- PLAYER FUNCTIONS

function playerJoined(player)
	-- Getting and Caching data
	playerData[player.Name] = get(player)

	-- Firing data loaded event
	DataLoadedEvent:Fire(player)
end

function playerLeft(player)
	-- Saving data
	save(player)

	-- Removing cached data
	playerData[player.Name] = nil
end


-- DATABASE FUNCTIONS

function get(player)
	-- Waiting for budget
	yieldUntilBudget(Enum.DataStoreRequestType.GetAsync)

	-- Getting data
	local loaded = nil
	local suc, err
	--
	repeat
		suc, err = pcall(function()
			loaded = DataStore:GetAsync("Plr_" .. player.UserId)
		end)
		if not suc then
			-- Printing warning
			warn(err)

			-- Small wait period in between retries
			task.wait(6)
		end
	until
	suc
	--
	if loaded == nil then
		return copyTable(DEFAULT_PLAYER_DATA)
	else
		return loaded
	end
end

function save(player)
	-- Waiting for budget
	yieldUntilBudget(Enum.DataStoreRequestType.SetIncrementAsync)

	-- Saving data
	local suc, err
	repeat
		suc, err = pcall(function()
			DataStore:SetAsync(
				-- Key
				"Plr_" .. player.UserId,
				
				-- Cached data
				playerData[player.Name]
			)
		end)
		if not suc then
			-- Printing warning
			warn(err)

			-- Small wait period in between retries
			task.wait(6)
		end
	until
	suc

end

-- ASSISTING FUNCTIONS

function autoSave()
	while true do
		-- Waiting auto-save interval
		task.wait(AUTO_SAVE_INTERVAL)

		-- Getting players
		for _, player in pairs(Players:GetPlayers()) do
			-- Checking if data is cached
			if playerData[player.Name] ~= nil then
				-- Auto-Saving
				task.spawn(function()
					save(player)
				end)
			end
		end
	end
end

function yieldUntilBudget(dataStoreRequestType)
	while 
		DataStoreService:GetRequestBudgetForRequestType(dataStoreRequestType) <= 0
	do
		task.wait(1)
	end
end


-- TABLE FUNCTIONS

function copyTable(toCopy)
	-- Creating new copy table
	local copy = {}

	-- Looping through toCopy table
	for i, v in pairs(toCopy) do
		-- Checking if value is a nested table/dictionary
		if typeof(v) == "table" then
			-- Copying nested table/dictionary
			v = copyTable(v)
		end

		-- Inserting value into copied table
		copy[i] = v
	end

	-- Returning table copy
	return copy
end


--

Players.PlayerAdded:Connect(playerJoined)
Players.PlayerRemoving:Connect(playerLeft)
setupEvents()
task.spawn(autoSave)

return DataManager

-- 8.3.6
SomeDataStore:UpdateAsync(
	-- Key
	"Plr_" .. player.UserId,

	-- Update function
	function(oldData)
		-- Getting current data
		local data = oldData or 0

		-- Updating data
		data += 1

		-- Returning new data
		return data
	end
)

