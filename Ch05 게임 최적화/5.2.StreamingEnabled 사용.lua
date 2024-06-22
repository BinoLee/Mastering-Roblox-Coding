-- 5.2.2
-- 5.2.2.1 (1)
local spawnLocation = workspace:FindFirstChild("SpawnLocation")
print(tostring(spawnLocation))

-- 5.2.2.1 (2)
local spawnLocation = workspace:WaitForChild("SomethingThatDoesNotExist")
if spawnLocation ~= nil then
    print("Found!")
else
    print("Couldn’t find!")
end

-- 5.2.2.1 (3)
local spawnLocation = workspace:WaitForChild("SomethingThatDoesNotExist", 5)
if spawnLocation ~= nil then
    print("Found!")
else
    print("Couldn’t find!")
end

-- 5.2.2.2
-- 5.2.2.2 (1)
local Players = game:GetService("Players")
local partA = workspace.PartA
local partB = workspace.PartB
function teleportPlayer(player, position)
    if playerHasDebounce(player) == false then
        -- 공간 미리 로드
        player:RequestStreamAroundAsync(position)
        -- 플레이어 순간이동
        player.Character:SetPrimaryPartCFrame(CFrame.new(
            position + Vector3.new(0, 5, 0)))
    end
end

function teleportA(hit)
    local player = wasHit(hit)
    if player then
        teleportPlayer(player, partA.Position)
    end
end

function teleportB(hit)
    local player = wasHit(hit)
    if player then
        teleportPlayer(player, partB.Position)
    end
end

function wasHit(hit)
    -- 캐릭터 확인
    local character = hit.Parent
    if character ~= nil then
        -- 플레이어 확인
        local player =
            Players:GetPlayerFromCharacter(character)
        if player ~= nil then
            return player
        end
    end
    return false
end

partA.Touched:Connect(teleportB)
partB.Touched:Connect(teleportA)






-- 전체 코드
local BLOCK_SIZE = 25
local AMOUNT_OF_BLOCKS = 50
local folder = Instance.new("Folder")
folder.Name = "ColoredParts"
folder.Parent = workspace
for x = 1, AMOUNT_OF_BLOCKS do
    for y = 1, AMOUNT_OF_BLOCKS do
        local part = Instance.new("Part")
        part.Parent = folder
        part.Name = x .. ", " .. y
        part.Anchored = true
        part.Size = Vector3.new(BLOCK_SIZE, .25,
            BLOCK_SIZE)
        local positionToCenter = ((BLOCK_SIZE * AMOUNT_OF_BLOCKS) / 2)
        part.Position = Vector3.new(x * BLOCK_SIZE - positionToCenter, 1, y * BLOCK_SIZE - positionToCenter)
    end
    task.wait()
end
print("Command completed!")

-- 5.2.2.2 (2)
local coloredParts = workspace:WaitForChild("ColoredParts")
function randomRGB()
    local r = math.random(0, 255)
    local g = math.random(0, 255)
    local b = math.random(0, 255)
    return Color3.fromRGB(r, g, b)
end

coloredParts.ChildAdded:Connect(function(addedInstance)
    if addedInstance:IsA("BasePart") then
        addedInstance.Color = randomRGB()
        print("New instance colored!")
    end
end)

-- 5.2.2.3
-- 5.2.2.3 (1)
local Players = game:GetService("Players")

local DEBOUNCE_DURATION = 5

local partA = workspace.PartA
local partB = workspace.PartB

local debounceValues = {}


-- TELEPORTING

function teleportPlayer(player, position)
    if playerHasDebounce(player) == false then
        -- Preloading Area
        player:RequestStreamAroundAsync(position)

        -- Teleporting player
        player.Character:SetPrimaryPartCFrame(CFrame.new(position + Vector3.new(0, 5, 0)))
    end
end

--

function teleportA(hit)
    local player = wasHit(hit)
    if player then
        teleportPlayer(player, partA.Position)
    end
end

function teleportB(hit)
    local player = wasHit(hit)
    if player then
        teleportPlayer(player, partB.Position)
    end
end

--

function wasHit(hit)
    -- Getting Character
    local character = hit.Parent
    if character ~= nil then
        -- Getting Player
        local player = Players:GetPlayerFromCharacter(character)
        if player ~= nil then
            return player
        end
    end
    return false
end

-- DEBOUNCE

function playerJoined(player)
    debounceValues[player.Name] = 0
end

function playerLeft(player)
    debounceValues[player.Name] = nil
end

function playerHasDebounce(player)
    if (debounceValues[player.Name] + DEBOUNCE_DURATION) < os.time() then
        debounceValues[player.Name] = os.time()
        return false
    end
    return true
end

--

Players.PlayerAdded:Connect(playerJoined)
Players.PlayerRemoving:Connect(playerLeft)
partA.Touched:Connect(teleportB)
partB.Touched:Connect(teleportA)
