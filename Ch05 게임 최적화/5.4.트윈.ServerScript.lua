local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local events = ReplicatedStorage.Events

local gateActivation = workspace.GateActivation

local DEBOUNCE_DURATION = 25
local debounceValues = {}


-- 게이트 함수

function toggleGate(hit)
	-- 서버 검사
	local distance = ( hit.Position - gateActivation.Position ).Magnitude
	if distance >= 25 then
		return
	end
	
	-- 함수 구현
	local player = getPlayerFromHit(hit)
	if player ~= nil then
		if playerHasDebounce(player) == false then
			events.ToggleGate:FireClient(player)
		end
	end
end

--

function getPlayerFromHit(hit)
	-- 변수 확인
	if hit ~= nil and hit.Parent ~= nil then
		-- 플레이어 확인
		local character = hit.Parent
		return Players:GetPlayerFromCharacter(character)
	end
	return nil
end


-- 디바운스 함수

function playerJoined(player)
	debounceValues[player.Name] = 0
end

function playerLeft(player)
	debounceValues[player.Name] = nil
end

function playerHasDebounce(player)
	if ( debounceValues[player.Name] + DEBOUNCE_DURATION ) < os.time() then
		debounceValues[player.Name] = os.time()
		return false
	end
	return true
end

--

Players.PlayerAdded:Connect(playerJoined)
Players.PlayerRemoving:Connect(playerLeft)
gateActivation.Touched:Connect(toggleGate)