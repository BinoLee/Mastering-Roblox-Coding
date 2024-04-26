-- 2.4.1
function randomBoolean()
    return math.random(0, 5) == 0
end

function countTries()
    -- 카운터 변수
    local tries = 0

    -- while문
    while randomBoolean() == false do
        tries += 1
    end

    -- 반복문이 끝날 때까지 실행된 횟수를 출력
    print("It took " .. tries .. " tries to end the loop.")
end

countTries()

-- 2.4.2
function randomBoolean()
    return math.random(0, 5) == 0
end

function countTries()
    -- 카운터 변수
    local tries = 0

    -- repeat until문
    repeat
        tries += 1
    until
        randomBoolean() == true

    -- Prints the tries it took for the loop to end
    print("It took " .. tries .. " tries to end the loop.")
end

countTries()

-- 2.4.3
-- 2.4.3 (1)
for i = 1, 10 do
    print(i)
end

-- 2.4.3 (2)
for numberCounter = 1, 10, 2 do
    print(numberCounter)
end

-- 2.4.3 (3)
local messages = { "Hello", "how", "are", "you" }
for i, v in pairs(messages) do
    print(i, v)
end

-- 2.4.4
local students = {
    { name = "William", class = "H1", ["times late"] = 0 },
    { name = "Sophie",  class = "H1", ["times late"] = 0 },
}

-- 2.4.4 (1)
function findStudent(studentName)
    -- students를 반복
    for studentId, studentInfo in pairs(students) do
        print("Current Student Id: " .. studentId)

        --학생 id에 속한 이름을 받아오기
        local currentStudentName = studentInfo["name"]

        -- 학생의 이름이 찾는 이름인지 확인
        if currentStudentName == studentName then
            print("Found!")
        else
            print("Someone else.")
        end
    end
end

findStudent("William")

-- 2.4.4 (2)
local students = {
    { name = "William", class = "H1", times_late = 0 },
    { name = "Sophie",  class = "H1", times_late = 0 },
}

function findStudent(studentName)
    -- students를 반복
    for studentId, studentInfo in pairs(students) do
        print("Current Student Id: " .. studentId)

        --학생 id에 속한 이름을 받아오기
        local currentStudentName = studentInfo["name"]

        -- 학생의 이름이 찾는 이름인지 확인
        if currentStudentName == studentName then
            print("Found! Stopping loop")
            break
        else
            print("Someone else, continuing.")
            continue
        end
    end
end

findStudent("William")

-- 2.4.4 (3)
local students = {
    { name = "William", class = "H1", times_late = 0 },
    { name = "Sophie",  class = "H1", times_late = 0 },
}

function findStudent(studentName)
    -- students를 반복
    for studentId, studentInfo in pairs(students) do
        print("Current Student Id: " .. studentId)

        -- 학생 id에 속한 이름을 받아오기
        local currentStudentName = studentInfo["name"]

        -- 학생의 이름이 찾는 이름인지 확인
        if currentStudentName == studentName then
            print("Found! Stopping function")
            return
        else
            print("Someone else, continuing.")
            continue
        end
    end

    -- 학생을 찾지 못함
    warn("Student [" .. studentName .. "] does not exist.")
end

findStudent("William")
findStudent("NotExistingStudent")


-- 2.4.5
while true do
    print("Loop is running.")
    task.wait(1)
end

print(task.wait())