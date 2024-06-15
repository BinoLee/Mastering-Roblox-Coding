-- 1.3.1
print("Hello world!")

-- 1.3.2
print("Mark")

-- 1.3.3
print("8")
print(8)

-- 1.3.4
print(8 + 3)
print(8 - 3)
print(8 * 3)
print(8 / 3)
print(8 ^ 3)

-- 1.3.5
print(8 + 3 * 2)
print((8 + 3) * 2)

-- 1.3.6
print("Hello " .. "Laura")
print("Hello " .. "Laura" .. "!")

-- 1.3.7
print("Hello Peter!\nToday is Monday!")
print("Shopping List:\n\t- Bread,\n\t- Butter,\n\t- Milk.")

-- 1.3.8
print("4" .. 5)
print("4" .. tostring(5))
print("4" + 5)
print(tonumber("4") + 5)
print(tonumber("4" .. tostring(5)))
print(tonumber("a5")) -- nil을 반환합니다.
print(tonumber("a5") + 6) -- 오류가 발생합니다.

-- 1.3.9
print(true) -- > true
print(false) -- > true

-- 1.3.10

-- 1.3.10 (1)
print(true and true) -- > true
print(true and false) -- > false
print(false and true) -- > false
print(false and false) -- > false

-- 1.3.10 (2)
print(true or true) -- > true
print(true or false) -- > true
print(false or true) -- > true
print(false or false) -- > false

-- 1.3.11
local name = "Emma"

-- 1.3.12
local firstName = "Emma"
local randomNumbers = 125
local isThePlayerAFK = false

-- 1.3.13

-- 1.3.13 (1)
local firstName = "Alexander"
print(firstName) -- > Alexander

-- 1.3.13 (2)
local currentNumber = 0

print(currentNumber)
currentNumber = currentNumber + 1
print(currentNumber)
currentNumber = currentNumber + 1
print(currentNumber)
currentNumber = currentNumber + 1
print(currentNumber)
currentNumber = currentNumber + 1
print(currentNumber)
currentNumber = currentNumber + 1
print(currentNumber)

currentNumber = 1

-- 1.3.14

-- 1.3.14 (1)
local currentNumber = 0
local incrementValue = 2

print(currentNumber)
currentNumber = currentNumber + incrementValue
print(currentNumber)
currentNumber = currentNumber + incrementValue
print(currentNumber)
currentNumber = currentNumber + incrementValue
print(currentNumber)
currentNumber = currentNumber + incrementValue
print(currentNumber)
currentNumber = currentNumber + incrementValue
print(currentNumber)

-- 1.3.14 (2)
local currentNumber = 0
local incrementValue = 2

print(currentNumber)
currentNumber += incrementValue
print(currentNumber)
currentNumber += incrementValue
print(currentNumber)
currentNumber += incrementValue
print(currentNumber)
currentNumber += incrementValue
print(currentNumber)
currentNumber += incrementValue
print(currentNumber)

-- 1.3.15
local INCREMENT_VALUE = 2
local currentNumber = 0
print (currentNumber)
currentNumber += INCREMENT_VALUE
print (currentNumber)
currentNumber += INCREMENT_VALUE
print (currentNumber)
currentNumber += INCREMENT_VALUE
print (currentNumber)
currentNumber += INCREMENT_VALUE
print (currentNumber)
currentNumber += INCREMENT_VALUE
print (currentNumber)