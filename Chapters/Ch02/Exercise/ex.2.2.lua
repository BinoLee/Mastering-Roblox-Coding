local spawnLocation = workspace.SpawnLocation

repeat
    spawnLocation.Orientation += Vector3.new(0, 1, 0)
    task.wait()
until false
