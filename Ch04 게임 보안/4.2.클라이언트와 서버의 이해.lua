-- 4.2.1
local part = Instance.new("Part")
part.Position = Vector3.new(0, 10, 0)
part.Parent = workspace

-- 4.2.2
local baseplate = workspace:WaitForChild("Baseplate")
baseplate.Material = Enum.Material.Granite

-- 4.2.3
local character = script.Parent
local rightLowerArm = character:FindFirstChild("RightLowerArm")
rightLowerArm:Destroy()
