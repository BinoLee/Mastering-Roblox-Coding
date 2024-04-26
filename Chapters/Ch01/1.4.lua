-- 1.4
local playerPosition = 1

if playerPosition == 1 then
    print("You are in the first place!")
end

-- 1.4.1
local playerPosition = 1
print(playerPosition == 1)

-- 1.4.2

-- 1.4.2 (1)
local playerPosition = 1
if playerPosition == 1 then
    print("You are in the first place!")
end
print("Script completed.")


-- 1.4.2 (2)
local playerPosition = 1
if playerPosition <= 3 then
    print("Well done! You are in spot " .. playerPosition .. "!")
end
print("You are not in the top three yet! Keep going!")

-- 1.4.2 (3)
local playerPosition = 1
if playerPosition <= 3 then
    print("Well done! You are in spot " .. playerPosition .. "!")
end
if playerPosition > 3 then
    print("You are not in the top three yet! Keep going!")
end

-- 1.4.2 (4)
local playerPosition = 1
if playerPosition <= 3 then
    print("Well done! You are in spot " .. playerPosition .. "!")
else
    print("You are not in the top three yet! Keep going!")
end

-- 1.4.3

-- 1.4.3 (1)
local playerPosition = 1
if playerPosition <= 5 then
    if playerPosition <= 3 then
        print("Well done! You are in spot " .. playerPosition .. "!")
    else
        print("You are almost there!")
    end
else
    print("You are not in the top three yet! Keep going!")
end

-- 1.4.3 (2)
local playerPosition = 1

if playerPosition <= 3 then
    print("Well done! You are in spot" .. playerPosition .. "!")
elseif playerPosition <= 5 then
    print("You are almost there!")
else
    print("You are not in the top three yet! Keep going!")
end

-- 1.4.4

-- 1.4.4 (1)
local MINIMUM_PLAYERS = 1
local MAXIMUM_PLAYERS = 8
local playerPosition = 1

-- 플레이어 순위 확인
if playerPosition >= MINIMUM_PLAYERS and playerPosition <= 3 then
    print("Well done! You are in spot " .. playerPosition .. "!")
elseif playerPosition >= MINIMUM_PLAYERS and playerPosition <= 5 then
    print("You are almost there!")
elseif playerPosition >= MINIMUM_PLAYERS and playerPosition <= MAXIMUM_PLAYERS then
    print("You are not in the top three yet! Keep going!")
else
    warn("Incorrect player position [" .. playerPosition .. "]!")
end


-- 1.4.4 (2)
local MINIMUM_PLAYERS = 1
local MAXIMUM_PLAYERS = 8
local playerPosition = 1

-- 플레이어의 순위가 올바른지 확인
if playerPosition >= MINIMUM_PLAYERS and playerPosition <= MAXIMUM_PLAYERS then
    -- 플레이어의 순위에 따른 메시지 출력
    if playerPosition <= 3 then
        print("Well done! You are in spot " .. playerPosition .. "!")
    elseif playerPosition <= 5 then
        print("You are almost there!")
    else
        print("You are not in the top three yet! Keep going!")
    end
else
    -- 플레이어의 순위가 올바르지 않은 경우
    warn("Incorrect player position [" .. playerPosition .. "]!")
end


