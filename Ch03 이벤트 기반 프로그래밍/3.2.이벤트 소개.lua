-- 3.2.1 (1)
local Players = game:GetService("Players")

function findPlayer(username)
    local player = Players:FindFirstChild(username)
    if player ~= nil then
        print(player.Name .. " found!")
    else
        print(username .. " is not in-game.")
    end
end

task.wait(1)
findPlayer("YourUsername")

-- 3.2.1 (2)
local Players = game:GetService("Players")

function findPlayer()
    local player = Players:FindFirstChildOfClass("Player")
    if player ~= nil then
        print(player.Name .. " found!")
    end
end

task.wait(1)
findPlayer()

-- 3.2.1 (3)
local Players = game:GetService("Players")

function printPlayers()
    -- 게임을 플레이하는 모든 플레이어 정보를 테이블로 받음
    local players = Players:GetPlayers()

    -- 모든 플레이어 출력
    print("Current players in our game:")
    for _, player in pairs(players) do
        print("- " .. player.Name)
    end
end

task.wait(1)
printPlayers()

-- 3.2.2
-- 3.2.2 (1)
local Players = game:GetService("Players")
function playerJoined(player)
    print(player.Name .. " joined the game!")
end

Players.PlayerAdded:Connect(playerJoined)

-- 3.2.2 (2)
local Players = game:GetService("Players")
function playerJoined(player)
    print(player.Character)
end

Players.PlayerAdded:Connect(playerJoined)

-- 3.2.2 (3)
local Players = game:GetService("Players")
function playerJoined(player)
    local function characterAdded(character)
        print(character.Name)
    end
    player.CharacterAdded:Connect(characterAdded)
end

Players.PlayerAdded:Connect(playerJoined)

-- 3.2.2 (4)
local Players = game:GetService("Players")
function playerJoined(player)
    local function characterAdded(character)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid ~= nil then
            print("Humanoid found!")
        end
    end
    player.CharacterAdded:Connect(characterAdded)
end

Players.PlayerAdded:Connect(playerJoined)

-- 3.2.3
-- 3.2.3 (1)
humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
    print("Jump property changed: " .. tostring(humanoid.Jump))
end)

-- 3.2.3 (2)
humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
    if humanoid.Jump == true then
        print(player.Name .. " jumped!")
    end
end)

-- 3.2.3 (3)
local Players = game:GetService("Players")
function playerJoined(player)
    local function characterAdded(character)
        -- 새 캐릭터에서 휴머노이드 찾기
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid ~= nil then
            -- 휴머노이드에서 "Jump" 속성 변경 감지
            humanoid:GetPropertyChangedSignal("Jump"):
                Connect(function()
                    if humanoid.Jump == true then
                        -- 점프한 플레이어명 출력
                        print(player.Name .. " jumped!")
                        -- 플레이어 색상 변경
                        changeCharacterColor(character)
                    end
                end)
        end
    end
    -- 새 캐릭터 감지
    player.CharacterAdded:Connect(characterAdded)
end

function changeCharacterColor(character)
    -- 새 색상 설정
    local newColor = randomColor()
    -- 색상 변경
    for _, part in pairs(character:GetChildren()) do
        -- 파트의 클래스가 "BasePart"인지 확인
        if part:IsA("BasePart") then
            part.Color = newColor
        end
    end
end

function randomColor()
    local r = math.random(0, 255)
    local g = math.random(0, 255)
    local b = math.random(0, 255)
    return Color3.fromRGB(r, g, b)
end

Players.PlayerAdded:Connect(playerJoined)
