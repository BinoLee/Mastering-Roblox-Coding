local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local RichestPlayers = DataStoreService:GetOrderedDataStore("RichestPlayers")

local DataManager = require(PATH_TO_DATAMANAGER)

local LEADER_BOARD_SIZE = 25

--

function updatePlayer(player)
	-- 코인 정보 찾기
	local coins = nil
	--
	local suc, err = pcall(function()
		coins = DataManager:Get(player, "coins")
	end)
	
	-- 데이터 수신 확인
	if coins ~= nil then
		-- 여유가 생길 때까지 대기
		yieldUntilBudget(Enum.DataStoreRequestType.SetIncrementSortedAsync)

		-- 데이터 저장
		local suc, err
		repeat
			suc, err = pcall(function()
				RichestPlayers:SetAsync(
					player.UserId,
					coins
				)
			end)
			if not suc then
				warn(err)
				task.wait(6)
			end
		until
		suc
	end
end

function printRichestPlayers()
	-- 여유가 생길 때까지 대기
	yieldUntilBudget(Enum.DataStoreRequestType.GetSortedAsync)
	
	local richest = {}
	
	-- 가장 돈 많은 플레이어 찾기
	local suc, err
	repeat
		suc, err = pcall(function()
			local ascending = false
			local pages = RichestPlayers:GetSortedAsync(ascending, LEADER_BOARD_SIZE)
			local page = pages:GetCurrentPage()
			--
			for rank, data in pairs(page) do
				-- 데이터 선언
				local userid = data.key
				local coins = data.value
				local username = "[ Account Deleted ]"
				
				-- 사용자명 확인
				pcall(function()
					username = Players:GetNameFromUserIdAsync(userid)
				end)
				
				-- 순위 업데이트
				richest[rank] = {["username"] = username, ["coins"] = coins}
			end
		end)
		if not suc then
			warn(err)
			task.wait(6)
		end
	until
	suc
	
	-- 테이블 출력
	print(richest)
end

--

function yieldUntilBudget(dataStoreRequestType)
	while 
		DataStoreService:GetRequestBudgetForRequestType(dataStoreRequestType) <= 0
	do
		task.wait(1)
	end
end

--

printRichestPlayers()
Players.PlayerRemoving:Connect(updatePlayer)