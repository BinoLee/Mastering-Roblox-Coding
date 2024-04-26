--4.4.2
--4.4.2 (1)
local Players = game:GetService("Players")
local debounceValues = {}
function playerJoined(player)
    debounceValues[player.Name] = 0
end

Players.PlayerAdded:Connect(playerJoined)

--4.4.2 (2)
function playerLeft(player)
    debounceValues[player.Name] = nil
end

Players.PlayerRemoving:Connect(playerLeft)

--4.4.2 (3)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DEBOUNCE_DURATION = 5
function debounceFunction(player)
    if (debounceValues[player.Name] + DEBOUNCE_DURATION) < os.time() then
        debounceValues[player.Name] = os.time()
        print("Allowed")
    end
end

ReplicatedStorage.DebounceTesting.OnServerEvent:Connect(debounceFunction)

-- 4.4.2 (4)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
function setup()
    while true do
        task.wait(1)
        ReplicatedStorage.DebounceTesting:FireServer()
    end
end

setup()

-- 전체
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DEBOUNCE_DURATION = 5

local debounceValues = {}

function playerJoined(player)
    debounceValues[player.Name] = 0
end

function playerLeft(player)
    debounceValues[player.Name] = nil
end

function debounceFunction(player)
    if (debounceValues[player.Name] + DEBOUNCE_DURATION) < os.time() then
        debounceValues[player.Name] = os.time()
        print("Allowed")
    end
end

Players.PlayerAdded:Connect(playerJoined)
Players.PlayerRemoving:Connect(playerLeft)
ReplicatedStorage.DebounceTesting.OnServerEvent:Connect(debounceFunction)

-- 4.4.3
local ReplicatedStorage = game:GetService("ReplicatedStorage")
function kickPlayer(player)
    player:Kick("Do not exploit in our game!")
end

ReplicatedStorage.AddMoney.OnServerEvent:Connect(kickPlayer)
