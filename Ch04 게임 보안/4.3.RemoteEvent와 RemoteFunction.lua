-- 4.3.2
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Teams = game:GetService("Teams")
local blueTeamButton = script.Parent.MainFrame.BlueTeam
local redTeamButton = script.Parent.MainFrame.RedTeam
function switchTeam(teamName)
    -- 팀 정보 받아오기
    local team = Teams:FindFirstChild(teamName)
    -- 팀이 있는지 확인
    if team ~= nil then
        player.Team = team
    else
        warn("Team [" .. teamName .. "] does not exist!")
    end
end

function swichBlueTeam()
    switchTeam("Blue")
end

function switchRedTeam()
    switchTeam("Red")
end

blueTeamButton.MouseButton1Click:Connect(swichBlueTeam)
redTeamButton.MouseButton1Click:Connect(switchRedTeam)

-- 4.3.3
-- 4.3.3 (1)
local Teams = game:GetService("Teams")
function switchTeam(player, teamName)
    -- 팀 정보 받아오기
    local team = Teams:FindFirstChild(teamName)
    -- 팀이 있는지 확인
    if team ~= nil then
        player.Team = team
    else
        warn("Team [" .. teamName .. "] does not exist!")
    end
end

-- 4.3.3 (2)
local Teams = game:GetService("Teams")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
function switchTeam(player, teamName)
    -- 팀 정보 받아오기
    local team = Teams:FindFirstChild(teamName)
    -- 팀이 있는지 확인
    if team ~= nil then
        player.Team = team
    else
        warn("Team [" .. teamName .. "] does not exist!")
    end
end

ReplicatedStorage.ChangeTeam.OnServerEvent:Connect(switchTeam)

-- 4.3.3 (3)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local blueTeamButton = script.Parent.MainFrame.BlueTeam
local redTeamButton = script.Parent.MainFrame.RedTeam
function switchBlueTeam()
    ReplicatedStorage.ChangeTeam:FireServer("Blue")
end

function switchRedTeam()
    ReplicatedStorage.ChangeTeam:FireServer("Red")
end

blueTeamButton.MouseButton1Click:Connect(switchBlueTeam)
redTeamButton.MouseButton1Click:Connect(switchRedTeam)

-- 4.3.4
-- 4.3.4 (1)
local Teams = game:GetService("Teams")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
function switchTeam(player, teamName)
    -- 팀 정보 받아오기
    local team = Teams:FindFirstChild(teamName)
    -- 팀이 있는지 확인
    if team ~= nil then
        if player.Team ~= team then
            -- 플레이어가 아직 팀에 없음
            player.Team = team
        else
            -- 플레이어가 이미 팀에 있음
            ReplicatedStorage.TeamChangerNotification:
                FireClient(player, "You are already on this team!")
        end
    else
        ReplicatedStorage.TeamChangerNotification:
            FireClient(player, "Team does not exist!")
    end
end

ReplicatedStorage.ChangeTeam.OnServerEvent:Connect(switchTeam)

-- 4.3.4 (2)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local notificationLabel = script.Parent.MainFrame.NotificationMessage
function showNotification(message)
    notificationLabel.Text = message
end

ReplicatedStorage.TeamChangerNotification.OnClientEvent:Connect(showNotification)

-- 4.3.5
-- 4.3.5 (1)
local Teams = game:GetService("Teams")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
function switchTeam(player, teamName)
    -- 팀 정보 받아오기
    local team = Teams:FindFirstChild(teamName)
    -- 팀이 있는지 확인
    if team ~= nil then
        if player.Team ~= team then
            -- 플레이어를 팀에 배치
            player.Team = team
            -- 성공 반환
            return true
        else
            return "You are already on this team!"
        end
    else
        return "Team does not exist!"
    end
end

ReplicatedStorage.ChangeTeam.OnServerInvoke = switchTeam

-- 4.3.5 (2)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local blueTeamButton = script.Parent.MainFrame.BlueTeam
local redTeamButton = script.Parent.MainFrame.RedTeam
local notificationLabel = script.Parent.MainFrame.NotificationMessage
function switchTeam(teamName)
    local result = ReplicatedStorage.ChangeTeam:
    InvokeServer(teamName)
    if result ~= true then
        showNotification(result)
    end
end

function swichBlueTeam()
    switchTeam("Blue")
end

function switchRedTeam()
    switchTeam("Red")
end

function showNotification(message)
    notificationLabel.Text = tostring(message)
end

blueTeamButton.MouseButton1Click:Connect(swichBlueTeam)
redTeamButton.MouseButton1Click:Connect(switchRedTeam)

