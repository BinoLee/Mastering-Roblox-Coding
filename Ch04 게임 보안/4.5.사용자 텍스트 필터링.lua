-- 4.5.1
-- 4.5.1 (1)
function getTextObject(player, inputMessage)
    -- TextObject용 변수 선언
    local textObject = nil
    -- ‘:FilterStringAsync()’ 함수에서
    -- 오류가 발생할 수 있으므로 pcall 사용
    local success, err = pcall(function()
        -- 변수 textObject 초기화
        textObject = TextService:FilterStringAsync(
            inputMessage,
            player.UserId
        )
    end)
    -- ‘:FilterStringAsync()’ 함수에서 발생하는지 확인
    if err then
        warn("Something went wrong creating text object.\nError: " .. err)
    end
    -- textObject 반환
    return textObject
end

-- 4.5.1 (2)
function messageReceived(player, inputMessage)
    -- ... 서버 및 디바운스 검사 ...
    -- 함수 구현
    local textObject = getTextObject(player, inputMessage)
    if textObject ~= nil then
        -- ... 추후 작업
    end
end

-- 4.5.2
-- 4.5.2 (1)
function filterBroadcastString(textObject)
    -- 필터링된 메시지를 저장하는 변수 선언
    local filteredMessage = nil
    -- ‘:GetNonChatStringForBroadcastAsync()’에서
    -- 오류가 발생할 수 있으니 pcall 사용
    local success, err = pcall(function()
        filteredMessage = textObject:
        GetNonChatStringForBroadcastAsync()
    end)
    -- ‘:GetNonChatStringForBroadcastAsync()’에서 오류 발생 확인
    if err then
        warn("Something went wrong while filtering message. Error: " .. err)
        return "[Failed to filter message]"
    end
    -- 필터링된 메시지 반환
    return filteredMessage
end

-- 4.5.2 (2)
function messageReceived(player, inputMessage)
    -- ... 서버 및 디바운스 검사 ...
    -- 함수 구현
    local textObject = getTextObject(player, inputMessage)
    if textObject ~= nil then
        local filteredMessage =
            filterBroadcastString(textObject)
        ReplicatedStorage.ReceivedMessage:FireAllClients(
            player, filteredMessage)
    end
end

-- 4.5.3
function filterPrivateMessage(textObject, recipient)
    -- 필터링된 메시지를 저장하는 변수 선언
    local filteredMessage = nil
    --’:GetChatForUserAsync()’에서 오류가 발생할 수 있으니 pcall 사용
    local success, err = pcall(function()
        filteredMessage = textObject:GetChatForUserAsync(
            recipient.UserId)
    end)
    -- ‘:GetChatForUserAsync()’에서 오류 발생 확인
    if err then
        warn("Something went wrong while filtering private message. Error: " .. err)
        return "[ Failed to filter message ]"
    end
    -- 필터링된 메시지 반환
    return filteredMessage
end

