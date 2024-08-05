local crimeSystem = {
    ["Speeding"] = {
        ticketPrice = 100,
        isViolating = function(officerInputDictionary)
            -- 최고 속도
            local MAX_SPEED = 100

            -- 시스템에 필요한 데이터 확인
            local speed = officerInputDictionary.speed

            -- 필요한 데이터 존재 여부 확인
            if speed == nil or typeof(speed) ~= "number" then
                warn("Speed data missing.")
                return false
            end

            -- 사용자가 최고 속도를 넘었는지 확인
            return officerInputDictionary.speed > MAX_SPEED
        end
    },
    ["No License"] = {
        ticketPrice = 250,
        isViolating = function(officerInputDictionary)
            -- 시스템에 필요한 데이터 확인
            local hasLicense = officerInputDictionary.hasLicense

            -- 필요한 데이터 존재 여부 확인
            if hasLicense == nil or typeof(hasLicense) ~= "boolean" then
                warn("Has License data missing.")
                return false
            end

            -- 사용자가 최고 속도를 넘었는지 확인
            return not hasLicense
        end
    },
    ["Reckless Driving"] = {
        ticketPrice = 250,
        isViolating = function(officerInputDictionary)
            -- 시스템에 필요한 데이터 확인
            local isRecklessDriving = officerInputDictionary.isRecklessDriving

            -- 필요한 데이터 존재 여부 확인
            if isRecklessDriving == nil or typeof(isRecklessDriving) ~= "boolean" then
                warn("Is Reckless Driving data missing.")
                return false
            end

            -- 사용자가 최고 속도를 넘었는지 확인
            return isRecklessDriving
        end
    }
}


-- SETUP FUNCTION

function setup()
    print("Ticket Price: " .. calculateTicketPrice(
        {
            speed = 90,
            hasLicense = true,
            isRecklessDriving = false
        }
    )
    )
end

-- TICKET FUNCTION

function calculateTicketPrice(officerInputDictionary)
    -- 과태료
    local totalTicketPrice = 0

    -- 위반 사항 반복
    for crimeName, crimeData in pairs(crimeSystem) do
        -- 위반 사항 데이터 확인
        if not isRequiredCrimeDataPresent(crimeName, crimeData) then
            -- 미위반 시 continue, 반복은 끝내야 함.
            continue
        end

        -- 위반사항 데이터 가져오기
        local ticketPrice = crimeData.ticketPrice
        local isViolatingFunction = crimeData.isViolating

        -- 플레이어 위반 여부 확인
        if isViolatingFunction(officerInputDictionary) == true then
            totalTicketPrice += ticketPrice
        end
    end

    return totalTicketPrice
end

--

function isRequiredCrimeDataPresent(crimeName, crimeData)
    -- 필요한 데이터 가져오기
    local ticketPrice = crimeData.ticketPrice
    local isViolatingFunction = crimeData.isViolating

    -- 과태료 설정
    if ticketPrice == nil or ticketPrice < 0 then
        warn("Ticket Price for crime [" .. crimeName .. "] is missing.")
        return false
    end

    -- 위반 여부 함수 설정
    if isViolatingFunction == nil then
        warn("Is Violating function for crime [" .. crimeName .. "] is missing.")
        return false
    end

    -- 모든 데이터 존재
    return true
end

--

setup()
