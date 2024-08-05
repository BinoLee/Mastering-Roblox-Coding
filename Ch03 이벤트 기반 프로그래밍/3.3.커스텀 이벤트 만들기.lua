-- 3.3.1

-- 3.3.1 (1)
local Players = game:GetService("Players")
function playerJoined(player)
    local function characterAdded(character)
        -- 새 캐릭터에서 휴머노이드 찾기
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid ~= nil then
            -- 커스텀 이벤트 만들기
            local customEvent = Instance
            new("BindableEvent")
            customEvent.Name = "Jumped"
            customEvent.Parent = Humanoid
            -- 휴머노이드에서 .Jumped 이벤트 감지
            humanoid:GetPropertyChangedSignal("Jump"):
                Connect(function()
                    if humanoid.Jump == true then
                        -- 커스텀 이벤트 트리거
                        customEvent:Fire()
                    end
                end)
        end
    end
    -- 새 캐릭터 감지
    player.CharacterAdded:Connect(characterAdded)
end

Players.PlayerAdded:Connect(playerJoined)

-- 3.3.1 (2)
local Players = game:GetService("Players")
function playerJoined(player)
    local function characterAdded(character)
        -- 새 캐릭터에서 휴머노이드 찾기
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid ~= nil then
            -- Jumped 이벤트 대기
            local jumpedEvent =
                humanoid:WaitForChild("Jumped")
            -- 커스텀 이벤트 감지
            jumpedEvent.Event:Connect(function()
                -- 점프한 플레이어명 출력
                print(player.Name .. " jumped!")
            end)
        end
    end
    -- 새 캐릭터 감지
    player.CharacterAdded:Connect(characterAdded)
end

Players.PlayerAdded:Connect(playerJoined)

-- 3.3.2
-- 3.3.2 (1)
local Players = game:GetService("Players")
function playerJoined(player)
    local function characterAdded(character)
        -- 새 캐릭터에서 휴머노이드 찾기
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid ~= nil then
            -- 총 점프 수 변수 선언
            local totalJumps = 0
            -- 커스텀 이벤트 생성
            local jumped, timesJumped = createCustomEvents(humanoid)
            -- 휴머노이드에서 .Jumped 이벤트 감지
            humanoid:GetPropertyChangedSignal("Jump"):
                Connect(function()
                    if humanoid.Jump == true then
                        -- 전체 점프 수 증가
                        totalJumps += 1
                        -- 커스텀 이벤트 실행
                        jumped:Fire()
                    end
                end)
            timesJumped.OnInvoke = function()
                -- 전체 점프 수 반환
                return totalJumps
            end
        end
    end
    -- 새 캐릭터 감지
    player.CharacterAdded:Connect(characterAdded)
end

function createCustomEvents(humanoid)
    local jumped = Instance.new("BindableEvent")
    jumped.Name = "Jumped"
    jumped.Parent = humanoid
    local timesJumped = Instance.new("BindableFunction")
    timesJumped.Name = "TimesJumped"
    timesJumped.Parent = humanoid
    -- 이벤트 반환
    return jumped, timesJumped
end

Players.PlayerAdded:Connect(playerJoined)

--3.3.2 (2)
-- 커스텀 이벤트 대기
local jumped = humanoid:WaitForChild("Jumped")
local timesJumped = humanoid:WaitForChild("TimesJumped")
-- 커스텀 이벤트 감지
jumped.Event:Connect(function()
    -- 점프한 플레이어명 출력
    print(player.Name .. " jumped " .. timesJumped:Invoke()
        .. " time(s)")
end)

-- 3.3.2 (3)
-- 커스텀 이벤트 대기
local jumped = humanoid:WaitForChild("Jumped")
local timesJumped = humanoid:WaitForChild("TimesJumped")
-- 커스텀 이벤트 감지
jumped.Event:Connect(function()
    -- 비율 계산
    local headScale = math.floor(timesJumped:Invoke() / 5) + 1
    -- 비율 값 획득
    local scaleValue = humanoid:FindFirstChild("HeadScale")
    if scaleValue then
        scaleValue.Value = headScale
    end
end)

-- 3.3.4
-- 3.3.4 (1)
local CharacterEvents = {}
function CharacterEvents.Jumped(player)
end

return CharacterEvents

-- 3.3.4 (2)
local CharacterEvents = {}
function CharacterEvents.Jumped(player)
    -- 이벤트 생성
    local jumped = Instance.new("BindableEvent")
    -- 이벤트: 캐릭터 추가
    local function characterAdded(character)
        -- 새 캐릭터에서 휴머노이드 찾기
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid ~= nil then
            -- 휴머노이드에서 .Jumped 이벤트 감지
            humanoid:GetPropertyChangedSignal("Jump"):
                Connect(function()
                    if humanoid.Jump == true then
                        -- 커스텀 이벤트 실행
                        jumped:Fire()
                    end
                end)
        end
    end
    -- 새 캐릭터 감지
    player.CharacterAdded:Connect(characterAdded)
    -- 리스너 반환
    return jumped.Event
end

return CharacterEvents

-- 3.3.4 (3)
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local CharacterEvents = require(ServerStorage.CharacterEvents)
function playerJoined(player)
    -- Jumped 이벤트 감지
    CharacterEvents.Jumped(player):Connect(function()
        print(player.Name .. " jumped!")
    end)
end

Players.PlayerAdded:Connect(playerJoined)
