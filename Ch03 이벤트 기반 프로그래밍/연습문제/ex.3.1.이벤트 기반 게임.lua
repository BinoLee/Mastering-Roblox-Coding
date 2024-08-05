-- EXAMPLE SOLUTION

--[[
	이것은 3장, 이벤트 기반 프로그래밍의 예제 답안입니다.
	
	이 스크립트는 게임을 완성하기 위한 예제 솔루션입니다.
	게임의 나머지 부분은 다음 링크에서 찾을 수 있습니다.
	https://www.roblox.com/games/8645775042/Event-Based-Game

	3 개의 점을 누르고 'Studio에서 편집'을 클릭하여 게임을 열 수 있습니다.
--]]

local Players = game:GetService("Players")

local map = workspace.Map


--

function setup()
	-- 워크스페이스의 "Map" 모델에 있는 모든 부분을 반복합니다.
	for _, part in pairs(map:GetChildren()) do
		
		-- 파트가 실제로 파트인지 확인합니다.
		if part:IsA("BasePart") then
			
			-- .Touched 이벤트에 연결합니다.
			part.Touched:Connect(function(hit)
				
				-- handleHit() 함수를 호출합니다.
				
				-- @1 첫 번째 인수 part는 터치된 파트입니다. handleHit() 함수는 이 파트를 색칠합니다.				
				-- @2 두 번째 인수 hit는 파트를 터치한 파트입니다.
				
				handleHit(part, hit)
				
			end)
			
		end
		
	end
	
end

function handleHit(part, hit)
	-- 캐릭터를 가져옵니다.
	local character = hit.Parent
	
	-- 플레이어를 가져옵니다.
	local player = Players:GetPlayerFromCharacter(character)
	
	-- 플레이어가 nil인지 확인합니다
	if player ~= nil then
		
		-- 플레이어의 팀 색상을 가져옵니다.
		local teamColor = player.Team.TeamColor
		
		-- 파트의 색상을 설정합니다.
		part.BrickColor = teamColor
		
	end
end


--

setup()