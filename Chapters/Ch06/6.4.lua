-- 6.4.2
local UserInputService = game:GetService("UserInputService")
local ui = script.Parent
local controlsText = ui:WaitForChild("ControlsText")
local previousInputType = nil

function updateControls(lastInputType)
    -- 변경 사항을 확인할 것
    -- 약간의 최적화로 엄청난 효과를 볼 수 있음
    if previousInputType == lastInputType then
        return
    end

    -- 컨트롤 변경
    if lastInputType == Enum.UserInputType.Gamepad1 then
        -- 플레이어가 게임패드를 사용 중
        previousInputType = lastInputType
        controlsText.Text = "Press [X] to confirm"
    elseif lastInputType == Enum.UserInputType.Touch then
        --플레이어가 터치스크린을 사용 중
        previousInputType = lastInputType
        controlsText.Text = "Click here to confirm"
    elseif lastInputType == Enum.UserInputType.Keyboard then
        -- 플레이어가 키보드를 사용 중
        previousInputType = lastInputType
        controlsText.Text = "Press Enter to confirm"
    end
end

UserInputService.LastInputTypeChanged:Connect(updateControls)

--6.4.5

--6.4.5 (1)
local TweenService = game:GetService("TweenService")
local ui = script.Parent
local frame = ui:WaitForChild("SomeFrame")

function openMenu()
    -- 화면 밖 프레임 설정
    frame.Position = UDim2.new(0.5, 0, 1.5, 0)

    -- 프레임 표시
    frame.Visible = true

    -- TweenInfo 설정
    local tweenInfo = TweenInfo.new(
    -- 트윈 길이
        1,

        -- 트윈 스타일(EasingStyle)
        Enum.EasingStyle.Quad,

        -- EasingStyle 방향
        Enum.EasingDirection.Out,

        -- 트윈 반복 횟수
        0,

        -- 트윈 반전
        false,

        -- 트윈 시작 전 대기 시간
        0
    )

    local tween = TweenService:Create(frame, tweenInfo, { Position = UDim2.new(0.5, 0, 0.5, 0) })
    tween:Play()
end

openMenu()

--6.4.5 (2)
local StarterGui = game:GetService("StarterGui")

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
--                           Enum.CoreGuiType.Health
--                           Enum.CoreGuiType.PlayerList
--                           Enum.CoreGuiType.Backpack
--                           Enum.CoreGuiType.EmotesMenu
--                           Enum.CoreGuiType.All

