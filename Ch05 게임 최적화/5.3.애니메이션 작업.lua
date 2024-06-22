-- 5.3.2
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local character = script.Parent
local animations = ReplicatedStorage:WaitForChild("Animations")

--

function playAnimation()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid ~= nil then
        local animator = humanoid:FindFirstChild("Animator")
        local animation = animations:FindFirstChild("DorkyDance")
        if animator ~= nil and animation ~= nil then
            local animationTrack = animator:LoadAnimation(animation)
        end
    end
end

--

task.wait(1)
playAnimation()


-- 5.3.3.1
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local character = script.Parent
local animations = ReplicatedStorage:WaitForChild("Animations")

--

function playAnimation()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid ~= nil then
        local animator = humanoid:FindFirstChild("Animator")
        local animation = animations:FindFirstChild("DorkyDance")
        if animator ~= nil and animation ~= nil then
            local animationTrack = animator:LoadAnimation(animation)
            animationTrack.Looped = true
            animationTrack:Play()
        end
    end
end

--

task.wait(1)
playAnimation()

--5.3.3.2
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local character = script.Parent
local animations = ReplicatedStorage:WaitForChild("Animations")

--

function playAnimation()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid ~= nil then
        local animator = humanoid:FindFirstChild("Animator")
        local animation = animations:FindFirstChild("DorkyDance")
        if animator ~= nil and animation ~= nil then
            local animationTrack = animator:LoadAnimation(animation)
            --
            while true do
                animationTrack.TimePosition = 0
                animationTrack:Play()
                task.wait(10)
                animationTrack:Stop()
                task.wait(2)
            end
        end
    end
end

--

task.wait(1)
playAnimation()

--5.3.3.3
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local character = script.Parent
local animations = ReplicatedStorage:WaitForChild("Animations")

--

function playAnimation()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid ~= nil then
        local animator = humanoid:FindFirstChild("Animator")
        local animation = animations:FindFirstChild("DorkyDance")
        if animator ~= nil and animation ~= nil then
            local animationTrack = animator:LoadAnimation(animation)
            animationTrack:Play()
            animationTrack:AdjustSpeed(5)
        end
    end
end

--

task.wait(1)
playAnimation()

-- 5.3.4
-- 5.3.4 (1)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local animations = ReplicatedStorage:WaitForChild("Animations")
local npc = workspace:WaitForChild("Dummy")

--

function setup()
    playAnimation(npc, "IdleAnimation", true, Enum.AnimationPriority.Idle)
    task.wait(10)
    playAnimation(npc, "WaveAnimation", false, Enum.AnimationPriority.Action)
end

function playAnimation(character, animationName, looped, animationPriority)
    -- 휴머노이드와 애니메이션 받아오기
    local humanoid = npc:WaitForChild("Humanoid", 5)
    local animation = animations:FindFirstChild(animationName)
    if humanoid ~= nil and animation ~= nil then
        -- 애니메이터 호출
        local animator = humanoid:WaitForChild("Animator", 5)
        if animator ~= nil then
            -- 애니메이터 재생
            local animationTrack = animator:LoadAnimation(animation)
            animationTrack.Looped = looped
            animationTrack.Priority = animationPriority
            animationTrack:Play()
        end
    end
end

--

setup()

--5.3.4 (2)
local npc = workspace:WaitForChild("Dummy")
function stopAllAnimations()
    -- 휴머노이드 찾기
    local humanoid = npc:WaitForChild("Humanoid", 5)
    if humanoid ~= nil then
        -- 애니메이터 찾기
        local animator = humanoid:WaitForChild("Animator", 5)
        if animator ~= nil then
            -- 애니메이션 재생
            local animationTracks = animator:GetPlayingAnimationTracks()
            -- 애니메이션 트랙 반복
            for _, animationTrack in pairs(animationTracks)
            do
                animationTrack:Stop()
            end
        end
    end
end

stopAllAnimations()

