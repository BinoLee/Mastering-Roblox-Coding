local crimeSystem = {
	["Speeding"] = {
		ticketPrice = 100,
		isViolating = function(officerInputDictionary)
			local MAX_SPEED = 100

            -- 연습 문제 2: 필요한 데이터가 있는지 확인합니다.

            -- 연습 문제 1: 운전자가 이 위반 사항을 저지르고 있는지 확인합니다.
		end
	},
	["No License"] = {
		ticketPrice = 250,
		isViolating = function(officerInputDictionary)
			-- 연습 문제 2: 필요한 데이터가 있는지 확인합니다.

            -- 연습 문제 1: 운전자가 이 위반 사항을 저지르고 있는지 확인합니다.
		end
	},
	["Reckless Driving"] = {
		ticketPrice = 250,
		isViolating = function(officerInputDictionary)
			-- 연습 문제 2: 필요한 데이터가 있는지 확인합니다.

            -- 연습 문제 1: 운전자가 이 위반 사항을 저지르고 있는지 확인합니다.
		end
	}
}


-- SETUP FUNCTION

function setup()
    -- Tip: You do not have to change this function
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
	-- 과태료 금액
	local totalTicketPrice = 0

    -- 연습 문제 3: 위반 사항 시스템 테이블을 순회하는 루프를 생성합니다.
    -- Hint: index 변수는 위반 사항의 이름입니다.
    -- Hint: value 변수는 특정 위반 사항에 대한 딕셔너리입니다.

    -- 연습 문제 6: 루프 내에서 'isRequiredCrimeDataPresent' 함수를 호출합니다.
    -- Hint: 함수가 false를 반환하면 'continue' 문을 사용합니다.

    -- 연습 문제 7: 루프 내에서 현재 위반 사항에 대한 isViolating 함수를 호출합니다.
	-- isViolating 함수가 true를 반환하면 totalTicketPrice 변수를 증가합니다.
	-- Hint: isViolating 함수에는 officerInputDictionary를 인수로 제공합니다.

	-- 과태료 금액 반환
	return totalTicketPrice
end

--

function isRequiredCrimeDataPresent(crimeName, crimeData)
	-- 필요한 위반 사항 데이터 가져오기
	local ticketPrice = crimeData.ticketPrice
	local isViolatingFunction = crimeData.isViolating

    -- 연습 문제 4: ticketPrice 변수가 null이 아니고 0보다 큰지 확인합니다.

    -- 연습 문제 5: isViolatingFunction이 null이 아닌지 확인합니다.
	
	-- 모든 데이터가 존재합니다.
	return true
end

--

setup()
