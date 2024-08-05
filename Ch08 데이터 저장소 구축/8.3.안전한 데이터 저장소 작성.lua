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
	-- 데이터 호출 및 캐시
	playerData[player.Name] = get(player)
	
	-- times_played 업데이트
	playerData[player.Name]["times_played"] += 1
	print(playerData[player.Name]["times_played"])
end

function playerLeft(player)
	-- 데이터 저장
	save(player)
	
	-- 캐시된 데이터 삭제
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
			-- 키
			"Plr_" .. player.UserId,
			
			-- 캐시된 데이터
			playerData[player.Name]
		)
	end)
	if not suc then
		warn(err)
	end
end

-- TABLE FUNCTIONS

function copyTable(toCopy)
	local copy = {}
	
	-- toCopy 테이블 반복
	for i, v in pairs(toCopy) do
		-- 중첩된 테이블/딕셔너리 복사
		if typeof(v) == "table" then
			-- 중첩된 테이블/딕셔너리 복사
			v = copyTable(v)
		end
		
		-- 복사된 테이블에 값 입력
		copy[i] = v
	end
	
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
	-- 데이터 호출 및 캐시
	playerData[player.Name] = get(player)
	
	-- times_played 업데이트
	playerData[player.Name]["times_played"] += 1
	print(playerData[player.Name]["times_played"])
end

function playerLeft(player)
	-- 데이터 저장
	save(player)
	
	-- 캐시된 데이터 삭제
	playerData[player.Name] = nil
end

-- AUTO SAVE

function autoSave()
	while true do
		-- 자동 저장 간격만큼 대기
		task.wait(AUTO_SAVE_INTERVAL)
		
		-- 플레이어 정보 호출
		for _, player in pairs(Players:GetPlayers()) do
			-- 데이터 캐시 여부 확인
			if playerData[player.Name] ~= nil then
				-- 자동 저장
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
			-- 키
			"Plr_" .. player.UserId,
			
			-- 캐시된 데이터
			playerData[player.Name]
		)
	end)
	if not suc then
		warn(err)
	end
end

-- TABLE FUNCTIONS

function copyTable(toCopy)
	local copy = {}
	
	-- toCopy 테이블 반복
	for i, v in pairs(toCopy) do
		if typeof(v) == "table" then
			-- 중첩된 테이블/딕셔너리 복사
			v = copyTable(v)
		end
		
		-- 복사된 테이블에 값 입력
		copy[i] = v
	end
	
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
	-- 데이터 호출 및 캐시
	playerData[player.Name] = get(player)

	-- times_played 업데이트
	playerData[player.Name]["times_played"] += 1
	print(playerData[player.Name]["times_played"])
end

function playerLeft(player)
	-- 데이터 저장
	save(player)

	-- 캐시된 데이터 삭제
	playerData[player.Name] = nil
end

-- AUTO SAVE

function autoSave()
	while true do
		-- 자동 저장 간격만큼 대기
		task.wait(AUTO_SAVE_INTERVAL)

		-- 플레이어 정보 호출
		for _, player in pairs(Players:GetPlayers()) do
			-- 데이터 캐시 여부 확인
			if playerData[player.Name] ~= nil then
				-- 자동 저장
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
			-- 경고 출력
			warn(err)

			-- 재시도 전 잠시 대기
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
				-- 키
				"Plr_" .. player.UserId,

				-- 캐시된 데이터
				playerData[player.Name]
			)
		end)
		if not suc then
			-- 경고 출력
			warn(err)
			
			-- 재시도 전 잠시 대기
			task.wait(6)
		end
	until
	suc
end


-- TABLE FUNCTIONS

function copyTable(toCopy)
	local copy = {}

	-- toCopy 테이블 반복
	for i, v in pairs(toCopy) do
		if typeof(v) == "table" then
			-- 중첩된 테이블/딕셔너리 복사
			v = copyTable(v)
		end

		-- 복사된 테이블에 값 입력
		copy[i] = v
	end

	-- 테이블 복사 반환
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
	-- 데이터 호출 및 캐시
	playerData[player.Name] = get(player)

	-- times_played 업데이트
	playerData[player.Name]["times_played"] += 1
	print(playerData[player.Name]["times_played"])
end

function playerLeft(player)
	-- 데이터 저장
	save(player)

	-- 캐시된 데이터 삭제
	playerData[player.Name] = nil
end

-- AUTO SAVE

function autoSave()
	while true do
		-- 자동 저장 간격만큼 대기
		task.wait(AUTO_SAVE_INTERVAL)

		-- 플레이어 정보 호출
		for _, player in pairs(Players:GetPlayers()) do
			-- 데이터 캐시 여부 확인
			if playerData[player.Name] ~= nil then
				-- 자동 저장
				save(player)
			end
		end
	end
end


-- DATA STORE FUNCTIONS

function get(player)
	-- 여유량이 생길 때까지 대기
	yieldUntilBudget(Enum.DataStoreRequestType.Up)
	
	-- 데이터 저장
	local loaded = nil
	local suc, err
	--
	repeat
		suc, err = pcall(function()
			loaded = DataStore:GetAsync("Plr_" .. player.UserId)
		end)
		if not suc then
			-- 경고 출력
			warn(err)

			-- 재시도 전 잠시 대기
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
	-- 여유량이 생길 때까지 대기
	yieldUntilBudget(Enum.DataStoreRequestType.SetIncrementAsync)
	
	-- 데이터 저장
	local suc, err
	repeat
		suc, err = pcall(function()
			DataStore:SetAsync(
				-- 키
				"Plr_" .. player.UserId,

				-- 캐시된 데이터
				playerData[player.Name]
			)
		end)
		if not suc then
			-- 경고 출력
			warn(err)

			-- 재시도 전 잠시 대기
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
	local copy = {}

	-- toCopy 테이블 반복
	for i, v in pairs(toCopy) do
		if typeof(v) == "table" then
			-- 중첩된 테이블/딕셔너리 복사
			v = copyTable(v)
		end

		-- 복사된 테이블에 값 입력
		copy[i] = v
	end

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
	-- 데이터 로드 여부 확인
	return playerData[player.Name] ~= nil
end

function DataManager:Get(player, key)
	-- 데이터 로드 여부 확인
	if DataManager:DataLoaded(player) ~= true then
		error("[Data Not Loaded]: Use the DataManager.PlayerAdded event in favor of the Players.PlayerAdded event!")
	end

	-- 캐시된 데이터 호출
	local cachedData = playerData[player.Name]

	-- 키 유효성 확인
	if cachedData[key] == nil then
		error("[Invalid Key]: Key [" .. key .. "] does not exist.")
	end

	return cachedData[key]
end

function DataManager:Set(player, key, value)
	-- 데이터 로드 여부 확인
	if DataManager:DataLoaded(player) ~= true then
		error("[Data Not Loaded]: Use the DataManager.PlayerAdded event in favor of the Players.PlayerAdded event!")
	end

	-- 데이터 설정
	playerData[player.Name][key] = value
end

function DataManager:Increment(player, key, value)
	-- 데이터 로드 여부 확인
	if DataManager:DataLoaded(player) ~= true then
		error("[Data Not Loaded]: Use the DataManager.PlayerAdded event in favor of the Players.PlayerAdded event!")
	end

	-- 캐시된 데이터 호출
	local cachedData = playerData[player.Name]

	-- 키 유효성 확인
	if cachedData[key] == nil then
		error("[Invalid Key]: Key [" .. key .. "] does not exist.")
	end

	-- 데이터 유형 확인
	if typeof(cachedData[key]) ~= "number" then
		error("[Invalid data type]: You can only use the :Increment() function on numbers. Consider using :Set().")
	end

	-- 데이터 증가
	cachedData[key] += value
end


-- PLAYER FUNCTIONS

function playerJoined(player)
	-- 데이터 호출 및 캐시
	playerData[player.Name] = get(player)

	-- 데이터 로드 이벤트 발생
	DataLoadedEvent:Fire(player)
end

function playerLeft(player)
	-- 데이터 저장
	save(player)

	-- 캐시된 데이터 삭제
	playerData[player.Name] = nil
end


-- DATABASE FUNCTIONS

function get(player)
	-- 여유량이 생길 때까지 대기
	yieldUntilBudget(Enum.DataStoreRequestType.GetAsync)

	-- 데이터 저장
	local loaded = nil
	local suc, err
	--
	repeat
		suc, err = pcall(function()
			loaded = DataStore:GetAsync("Plr_" .. player.UserId)
		end)
		if not suc then
			-- 경고 출력
			warn(err)

			-- 재시도 전 잠시 대기
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
	-- 여유량이 생길 때까지 대기
	yieldUntilBudget(Enum.DataStoreRequestType.SetIncrementAsync)

	-- 데이터 저장
	local suc, err
	repeat
		suc, err = pcall(function()
			DataStore:SetAsync(
				-- 키
				"Plr_" .. player.UserId,
				
				-- 캐시된 데이터
				playerData[player.Name]
			)
		end)
		if not suc then
			-- 경고 출력
			warn(err)

			-- 재시도 전 잠시 대기
			task.wait(6)
		end
	until
	suc

end

-- ASSISTING FUNCTIONS

function autoSave()
	while true do
		-- 자동 저장 간격만큼 대기
		task.wait(AUTO_SAVE_INTERVAL)

		-- 플레이어 정보 호출
		for _, player in pairs(Players:GetPlayers()) do
			-- 데이터 캐시 여부 확인
			if playerData[player.Name] ~= nil then
				-- 자동 저장
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
	local copy = {}

	-- toCopy 테이블 반복
	for i, v in pairs(toCopy) do
		if typeof(v) == "table" then
			-- 중첩된 테이블/딕셔너리 복사
			v = copyTable(v)
		end

		-- 복사된 테이블에 값 입력
		copy[i] = v
	end

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
	-- 키
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

