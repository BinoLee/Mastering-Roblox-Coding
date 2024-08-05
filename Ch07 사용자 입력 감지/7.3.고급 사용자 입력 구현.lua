-- 7.3.1
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--

function setup()
    -- 키보드 사용 가능 여부 확인
    if UserInputService.KeyboardEnabled == true then
        -- .InputBegan 이벤트 감지
        UserInputService.InputBegan:Connect(inputBegan)
    end
end

function inputBegan(inputObject, gameProcessedEvent)
    -- 로블록스에서 해당 이벤트 사용 여부 확인
    if gameProcessedEvent == false then
        -- B 키 입력 확인
        if inputObject.KeyCode == Enum.KeyCode.B then
            -- 클라이언트 측에서 폭발 생성
            local explosion = Instance.new("Explosion")
            explosion.Parent = player.Character.PrimaryPart
            explosion.Position = explosion.Parent.Position
        end
    end
end

--

setup()

-- 7.3.2
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--

function setup()
    if
    -- 키보드 사용 가능 여부 확인
        UserInputService.KeyboardEnabled == true
        -- 게임패드 사용 가능 여부 확인
        or UserInputService.GamepadEnabled == true
    then
        -- .InputBegan 이벤트 감지
        UserInputService.InputBegan:Connect(inputBegan)
    end
end

function inputBegan(inputObject, gameProcessedEvent)
    -- Checking if Roblox used this event already
    if gameProcessedEvent == false then
        if
        -- B 키 입력 확인 (키보드)
            inputObject.KeyCode == Enum.KeyCode.B
            -- X 버튼 입력 확인 (게임패드)
            or inputObject.KeyCode == Enum.KeyCode.ButtonX
        then
            -- 클라이언트 측에서 폭발 생성
            local explosion = Instance.new("Explosion")
            explosion.Parent = player.Character.PrimaryPart
            explosion.Position = explosion.Parent.Position
        end
    end
end

--

setup()

-- 다중 게임패드 (1)
local UserInputService = game:GetService("UserInputService")

function input(inputObject, gameProcessedEvent)
    print(inputObject.UserInputType)
end

UserInputService.InputBegan:Connect(input)
UserInputService.InputChanged:Connect(input)

-- 다중 게임패드 (2)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--

function setup()
    if
    -- 키보드 사용 가능 여부 확인
        UserInputService.KeyboardEnabled == true
        -- 게임패드 사용 가능 여부 확인
        or UserInputService.GamepadEnabled == true
    then
        -- .InputBegan 이벤트 감지
        UserInputService.InputBegan:Connect(inputBegan)
    end
end

function inputBegan(inputObject, gameProcessedEvent)
    -- 로블록스에서 해당 이벤트 사용 여부 확인
    if gameProcessedEvent == false then
        if
        -- B 키 입력 확인(키보드)
            inputObject.KeyCode == Enum.KeyCode.B
            -- 게임패드 키 입력 확인
            or
            (
            -- Gamepad1에서 입력이 되었는지 확인
                inputObject.UserInputType == Enum.UserInputType.Gamepad1
                -- X 키 입력 확인(게임패드)
                and inputObject.KeyCode == Enum.KeyCode.ButtonX
            )
        then
            -- 클라이언트 측에서 폭발 생성
            local explosion = Instance.new("Explosion")
            explosion.Parent = player.Character.PrimaryPart
            explosion.Position = explosion.Parent.Position
        end
    end
end

--

setup()

-- 햅틱 피드백
local HapticService = game:GetService("HapticService")

function giveHapticFeedback(inputType, vibrationMotor, duration, ...)
    if
    -- 진동 지원 여부 확인
        HapticService:IsVibrationSupported(inputType) == true
        -- 모터 지원 확인
        and HapticService:IsMotorSupported(inputType, vibrationMotor) == true
    then
        -- 게임패드 모터 설정
        HapticService:SetMotor(inputType, vibrationMotor, ...)

        -- 대기
        if duration > 0 then
            task.wait(duration)
            HapticService:SetMotor(inputType, vibrationMotor, 0)
        end
    end
end

giveHapticFeedback(
    Enum.UserInputType.Gamepad1, -- inputType
    Enum.VibrationMotor.Large,   -- vibrationMotor
    .5,                          -- duration
    .5                           -- intensity
)


-- 7.3.3
-- 마우스 클릭 감지
local UserInputService = game:GetService("UserInputService")

function inputBegan(inputObject, gameProcessedEvent)
    print(inputObject.UserInputType)
end

UserInputService.InputBegan:Connect(inputBegan)

-- 마우스 이벤트 전체 감지
local UserInputService = game:GetService("UserInputService")

function inputChanged(inputObject, gameProcessedEvent)
    print(inputObject.UserInputType)
end

UserInputService.InputChanged:Connect(inputChanged)

-- 마우스에 따라 프레임 변경
local UserInputService = game:GetService("UserInputService")
local ui = script.Parent
local frame = ui:WaitForChild("Frame")

function setup()
    -- 마우스 연결 여부 확인
    if UserInputService.MouseEnabled == true then
        -- 마우스 입력 제어
        local function listenToMouseInput(inputObject, gameProcessedEvent)
            -- 로블록스에서 해당 이벤트 사용 여부 확인
            if gameProcessedEvent == false then
                if inputObject.UserInputType ==
                    Enum.UserInputType.MouseMovement then
                    -- 마우스 움직임
                    repositionFrame()
                elseif inputObject.UserInputType ==
                    Enum.UserInputType.MouseButton1 then
                    -- 마우스 왼쪽 버튼 클릭
                    changeFrameColor()
                end
            end
        end
        -- .InputBegan 이벤트 감지
        UserInputService.InputBegan:Connect(listenToMouseInput)
        -- .InputChanged 이벤트 감지
        UserInputService.InputChanged:Connect(listenToMouseInput)
    end
end

function changeFrameColor()
    local r = math.random(0, 255)
    local g = math.random(0, 255)
    local b = math.random(0, 255)
    frame.BackgroundColor3 = Color3.fromRGB(r, g, b)
end

function repositionFrame()
    -- 마우스 위치 감지
    local mouseLocation = UserInputService:GetMouseLocation()
    -- 프레임 위치 설정
    frame.Position = UDim2.new(0, mouseLocation.X, 0, mouseLocation.Y)
end

setup()


-- 7.3.4
local Players = game:GetService("Players")
local character = Players.LocalPlayer.Character
local humanoid = character:WaitForChild("Humanoid")
function setup()
    -- FloorMaterial 속성 변경 감지
    humanoid:GetPropertyChangedSignal("FloorMaterial"):
        Connect(function()
            -- 플레이어의 위치가 Foil 위인지 확인
            -- 플레이어가 특정 위치에 있는지 파악하는 데 사용
            if humanoid.FloorMaterial == Enum.Material.Foil
            then
                -- 플레어어가 컨텍스트 안에 있음
            else
                -- 플레이어가 컨텍스트 밖에 있음
            end
        end)
end

setup()

-- ContextActionService
local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")

local ACTION_NAME = "ToggleShop"

local ui = script.Parent
local shopFrame = ui:WaitForChild("ShopFrame")

local character = Players.LocalPlayer.Character
local humanoid = character:WaitForChild("Humanoid")

--

function setup()
    shopFrame.Visible = false

    -- FloorMaterial 속성 변경 감지
    humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()
        -- 플레이어의 위치가 Foil 위인지 확인
        if humanoid.FloorMaterial == Enum.Material.Foil then
            beginAction()
        else
            endAction()
        end
    end)
end

function beginAction()
    -- ContextAction 시작
    ContextActionService:BindAction(ACTION_NAME, toggleShop, true, Enum.KeyCode.E, Enum.KeyCode.ButtonX)

    -- 모바일 버튼 변경
    ContextActionService:SetTitle(ACTION_NAME, "Shop")
    ContextActionService:SetPosition(ACTION_NAME, UDim2.new(1, -150, 1, -77))
end

function endAction()
    -- ContextAction 중단
    ContextActionService:UnbindAction(ACTION_NAME)

    -- 상점 종료(열려 있는 경우)
    closeShop()
end

--

function toggleShop(actionName, inputState, inputObject)
    -- 액션이 Begin인지 확인
    if inputState == Enum.UserInputState.Begin then
        Enum.UserInputState.
        -- 프레임 토글
        shopFrame.Visible = not shopFrame.Visible
    end
end

function closeShop()
    -- 상점이 열려 있는지 확인
    if shopFrame.Visible == true then
        -- 상점 종료
        toggleShop(ACTION_NAME, Enum.UserInputState.Begin)
    end
end

--

setup()
