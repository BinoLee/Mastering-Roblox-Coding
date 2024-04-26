-- 2.5.1

local StudentSystem = {}

local students = {
    {
        name = "William",
        class = "H1",
        ["times_late"] = 0,
        grades = {}
    },
    {
        name = "Sophie",
        class = "H1",
        ["times late"] = 0,
        grades = {}
    },
}

function StudentSystem:GetStudentInfo(studentName)
    -- students를 반복
    for _, studentInfo in ipairs(students) do
        -- 학생 id에 속한 이름을 받아오기
        local currentStudentName = studentInfo["name"]

        -- 학생의 이름이 찾는 이름인지 확인
        if currentStudentName == studentName then
            return studentInfo
        end
    end

    -- 학생을 찾지 못함
    warn("Student [" .. studentName .. "] does not exist.")
end

return StudentSystem

-- 2.5.2
local ServerStorage = game:GetService("ServerStorage")
local StudentSystem = require(ServerStorage.StudentSystem)

print(StudentSystem:GetStudentInfo("William"))