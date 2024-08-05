-- 시스템 변수
local TICKET_PRICE_SPEEDING = 100
local TICKET_PRICE_NO_LICENSE = 250

local MAXIMUM_SPEED = 100
local REQUIRES_LICENSE = false

-- 사용자 변수
local currentSpeed = 101
local hasLicense = true

local ticketPrice = 0

-- 과태료 계산
if currentSpeed > MAXIMUM_SPEED then
	ticketPrice += TICKET_PRICE_SPEEDING
end
if REQUIRES_LICENSE == true and hasLicense ~= true then
	ticketPrice += TICKET_PRICE_NO_LICENSE
end

-- 과태료 출력
print("Ticket Price: " .. ticketPrice)