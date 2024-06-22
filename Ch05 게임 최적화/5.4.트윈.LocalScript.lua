local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local events = ReplicatedStorage:WaitForChild("Events")

local INTERMISSION_TIME = 5
local TWEEN_DURATION = 2

local GATE_DATA = {
	["Open"] = {
		["LeftGatePart"] = {
			["Orientation"] = Vector3.new(-90, 90, 0),
			["Position"] = Vector3.new(-41.453, 14, 83.903)
		},
		["RightGatePart"] = {
			["Orientation"] = Vector3.new(-90, -90, 0),
			["Position"] = Vector3.new(-76.203, 14, 83.903)
		}
	},
	["Closed"]= {
		["LeftGatePart"] = {
			["Orientation"] = Vector3.new(-90, 0, 0),
			["Position"] = Vector3.new(-50.203, 14, 75.153)
		},
		["RightGatePart"] = {
			["Orientation"] = Vector3.new(-90, 0, 0),
			["Position"] = Vector3.new(-67.453, 14, 75.153)
		}
	}
}

local debounce = false

--

function toggleGate()
	if debounce == false then
		debounce = true

		-- Gate 파트 불러오기
		local leftGatePart = workspace:WaitForChild("LeftGatePart", 5)
		local rightGatePart = workspace:WaitForChild("RightGatePart", 5)
		if leftGatePart ~= nil and rightGatePart ~= nil then
			-- 문 열기
			animateGate(leftGatePart, "Open", false)
			animateGate(rightGatePart, "Open", true)

            -- 대기
			task.wait(INTERMISSION_TIME)

			-- 문 닫기
			animateGate(leftGatePart, "Closed", false)
			animateGate(rightGatePart, "Closed", true)
		end

		-- 클라이언트 디바운스 종료
		debounce = false
	end
end

function animateGate(gate, doorStatus, yield)
	-- 트윈 데이터 읽기
	local tweenData = GATE_DATA[doorStatus][gate.Name]
	
	-- 트윈 재생
	local tween = TweenService:Create(gate, TweenInfo.new(TWEEN_DURATION), tweenData)
	tween:Play()
	
	if yield == true then
		tween.Completed:Wait()
	end
end


--

events:WaitForChild("ToggleGate").OnClientEvent:Connect(toggleGate)