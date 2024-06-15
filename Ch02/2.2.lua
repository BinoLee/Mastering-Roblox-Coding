-- 2.2
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

-- 2.2.1
-- 2.2.1 (1)
function printSomething()
    print("This was printed in a function!")
end

-- 2.2.1 (2)
function printSomething()
    print("This was printed in a function!")
end
printSomething()

-- 2.2.2

-- 2.2.2 (1)
local MINIMUM_PLAYERS = 1
local MAXIMUM_PLAYERS = 8
local playerPosition = 1
function givePositionFeedback()
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
end
givePositionFeedback()
playerPosition = math.random(1, 8)
givePositionFeedback()

-- 2.2.2 (2)
local MINIMUM_PLAYERS = 1
local MAXIMUM_PLAYERS = 8
function givePositionFeedback(playerPosition)
    -- 플레이어의 순위가 올바른지 확인
    if playerPosition >= MINIMUM_PLAYERS and playerPosition <= MAXIMUM_PLAYERS then
        -- 플레이어의 순위에 따른 메시지 출력
        if playerPosition <= 3 then
            print("Well done! You are in spot " .. playerPosition .. "!")
        elseif playerPosition <= 5 then
            print("You are almost there!")
        else
            print("You are not in the top three yet! going!")
        end
    else
        -- 플레이어의 순위가 올바르지 않은 경우
        warn("Incorrect player position [" .. playerPosition .. "]!")
    end
end
givePositionFeedback(math.random(1, 8))
givePositionFeedback(math.random(1, 8))

-- 2.2.3

-- 2.2.3 (1)
function add(x, y)
    print(x + y)
end
add(5, 5)

-- 2.2.3 (2)
function add(x, y)
    print(x)
    print(y)
end
add(1, 2, 3)

-- 2.2.3 (3)
function add(x, y)
    print(x, y)
end
add(1)

-- 2.2.4
function add(x, y)
    -- 매개 변수 기본값
    if x == nil or typeof(x) ~= "number" then
        x = 0
    end
    if y == nil or typeof(y) ~= "number" then
        y = 0
    end

    -- 함수 로직
    print(x + y)
end

add(1, "2")

-- 2.2.5
-- 2.2.5 (1)
function add(x, y)
    return x + y
end

function subtract(x, y)
    return x - y
end

local sum = add(5, 5)
local difference = subtract(10, 5)
print(sum)
print(difference)

-- 2.2.5 (2)
function add(x, y)
    return x + y
end

function subtract(x, y)
    return x - y
end

local result = subtract(add(5, 5), 5)
print(result)

-- 2.2.6
-- 2.2.6 (1)
function add(x, y)
    return x + y
end
function subtract(x, y)
    return x - y
end
function addAndSubstract(x, y)
    return add(x, y), subtract(x, y)
end
local sum, difference = addAndSubstract(10, 5)

-- 2.2.6 (2)
function add(x, y)
    return x + y
end

function subtract(x, y)
    return x - y
end

local sum, difference = add(10, 5), subtract(10, 5)
print(sum)
print(difference)

-- 2.2.7
-- 2.2.7 (1)
local printSomething = function(whatToPrint)
    print(whatToPrint)
end
printSomething("Hello World!")

-- 2.2.7 (2)
function addAndSubstract(x, y)
    -- 중첩된 add 함수
    local function add()
        return x + y
    end
    -- 중첩된 subtract 함수
    local function subtract()
        return x - y
    end
    -- 결과 반환
    return add(), subtract()
end
local sum, difference = addAndSubstract(10, 5)

-- 2.2.8
function setup()
    local sum = add(5, 5)
    local difference = subtract(10, 5)
    print(sum)
    print(difference)
end

function add(x, y)
    return x + y
end

function subtract(x, y)
    return x - y
end
setup()
