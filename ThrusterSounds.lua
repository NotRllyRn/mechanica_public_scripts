local shared, selfTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotRllyRn/mechanica_public_scripts/main/loader.lua"))(...)
selfTable.Name = "Thruster Sounds"

local Events, Values = shared.MainGui.Events, shared.MainGui.Values
local Configure = Events.Configure
local setupThruster = function(thruster)
    if thruster:FindFirstChild("Base") and thruster.Base:FindFirstChild("ThrusterSound") then
        return
    end
    local Sound = Instance.new("Sound")
    Sound.Name = "ThrusterSound"
    Sound.SoundId = "rbxassetid://9125477715"
    Sound.Looped = true
    Sound.Playing = true
    Sound.Volume = 0
    Sound.Parent = thruster.Base

    local distort = Instance.new("DistortionSoundEffect")
    distort.Name = "Distort"
    distort.Level = 0.19
    distort.Parent = Sound

    local Connections = {}
    Connections.c1 = thruster.Destroying:Connect(function()
        for _, v in pairs(Connections) do
            if v.Connected then
                v:Disconnect()
            end
        end
        Sound:Destroy()
    end)
    Connections.c2 = thruster.Base.Force:GetPropertyChangedSignal("Force"):Connect(function()
        local Force = thruster.Base.Force.Force
        if math.abs(Force.x) ~= 0 then
            Sound.Volume = 0.25
            distort.Level = 0.8
        else
            Sound.Volume = 0.1
            distort.Level = 0.19
        end
    end)
end

workspace.Creations.ChildAdded:Connect(function(child)
    task.wait()
    if child.Name == shared.Client.Name then
        for _, v in ipairs(child:GetChildren()) do
            if v:IsA("Model") and v.Name == "Thruster" then
                setupThruster(v)
            end
        end
    end
end)

for _, v in ipairs(workspace.Creations[shared.Client.Name]:GetChildren()) do
    if v:IsA("Model") and v.Name == "Thruster" then
        setupThruster(v)
    end
end

selfTable.stop = function()
    selfTable.scriptOn = false
end
selfTable.start = function()
    selfTable.scriptOn = true
end

return selfTable
