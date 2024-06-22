-- 2.3
local STUDENT_NAME_1 = "William"
local STUDENT_NAME_2 = "Sophie"

-- 2.3.1
local students = {"William", "Sophie"}
local student1, student2 = "William", "Sophie"
local studentInfo = {"James", 10284281, "5’9", true}

-- 2.3.2
-- 2.3.2 (1)
local students = {"William", "Sophie"}
print(students)

-- 2.3.2 (2)
local students = {"William", "Sophie"}
print(students[1])

-- 2.3.2 (3)
local students = {"William", "Sophie"}
print(unpack(students))

-- 2.3.3
-- 2.3.3 (1)
local students = {"William", "Sophie"}
table.insert(students, "Robbert")

-- 2.3.3 (2)
local students = {"William", "Sophie", "Robbert"}
students[3] = "Robert"

-- 2.3.3 (3)
local students = {"William", "Sophie", "Robert"}
function setup()
    customTableInsert(students, "Emily")
    print(unpack(students))
end
function customTableInsert(table, newData)
    -- 인덱스 정보 얻기
    local currentIndex = #table
    local newIndex = currentIndex + 1
    -- 세 데이터 입력하기
    table[newIndex] = newData
end
setup()

-- 2.3.3 (4)
local students = {"William", "Sophie", "Robert"}
table.remove(students, 3)

-- 2.3.4
local studentInfo = {
    name = "Lauren",
    id = 12345,
    class = "H1",
    ["times late"] = 0
}
print(studentInfo)

-- 2.3.5
local students = {{
    name = "William",
    id = 1,
    class = "H1",
    ["times late"] = 0
}, {
    name = "Sophie",
    id = 2,
    class = "H1",
    ["times late"] = 0
}}

print(students)


-- 2.3.5.1
-- Workspace에서 참조
workspace.Baseplate
-- 테이블에서 참조
tableName[1]
-- 다차원 테이블에서 참조
students[1]["class"]


-- 2.3.5.2
local students = {}
function addStudent(studentName, studentClass)
    table.insert(students, {
        name = studentName,
        class = studentClass,
        ["times late"] = 0
    })
end
addStudent("Nicole", "H1")


-- 2.3.6
local calculator = {
    ["Add"] = function(x, y)
        return x + y
    end,
    Subtract = function(x, y)
        return x - y
    end
}

print(calculator["Add"](5, 5))
print(calculator.Subtract(10, 5))
