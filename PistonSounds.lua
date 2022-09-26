local shared, selfTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotRllyRn/mechanica_public_scripts/main/loader.lua"))(...)
selfTable.Name = "Piston Sounds"

local Events, Values = shared.MainGui.Events, shared.MainGui.Values
local Configure = Events.Configure
local setupPiston = function(piston)
    local Sound = Instance.new("Sound")
    Sound.Name = "PistonSound"
    Sound.SoundId = "rbxassetid://11077629936"
    Sound.Looped = true
    Sound.Playing = true
    Sound.Volume = 0
    Sound.Parent = piston.Base

    local Connections = {}
    Connections.c1 = piston.Destroying:Connect(function()
        for _, v in pairs(Connections) do
            if v.Connected then
                v:Disconnect()
            end
        end
        Sound:Destroy()
    end)
    Connections.c2 = piston.Base.PrismaticConstraint:GetPropertyChangedSignal("Velocity"):Connect(function()
        local velocity = piston.Base.PrismaticConstraint.Velocity
        local neg = velocity < 0
        velocity = math.abs(velocity)

        Sound.PlaybackSpeed = 0.3 + velocity / 50 - (neg and 0.1 or 0)
        Sound.Volume = (0.8 + velocity * 0.01 / 5) * (velocity == 0 and 0 or 1)
    end)
end

workspace.Creations.ChildAdded:Connect(function(child)
    task.wait()
    if child.Name == shared.Client.Name then
        for _, v in ipairs(child:GetChildren()) do
            if v:IsA("Model") and v.Name == "Piston" then
                setupPiston(v)
            end
        end
    end
end)

for _, v in ipairs(workspace.Creations[shared.Client.Name]:GetChildren()) do
    if v:IsA("Model") and v.Name == "Piston" then
        setupPiston(v)
    end
end

selfTable.stop = function()
    selfTable.scriptOn = false
end
selfTable.start = function()
    selfTable.scriptOn = true
end

return selfTable
