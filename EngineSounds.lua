local shared, selfTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotRllyRn/mechanica_public_scripts/main/loader.lua"))(...)
selfTable.Name = "Engine Sounds"

local Events, Values = shared.MainGui.Events, shared.MainGui.Values
local SpawnToggle, Configure = Events.SpawnToggle, Events.Configure
local setupEngine = function(engine)
    local Ratio, RevLength, Configuration = Instance.new("NumberValue"), Instance.new("NumberValue"), engine.Configuration

    Ratio.Name, RevLength.Name = "Ratio", "RevLength"
    Ratio.Value, RevLength.Value = 0.1, 3
    Ratio.Parent, RevLength.Parent = Configuration, Configuration

    local EngineSound = Instance.new("Sound")
    EngineSound.Name = "EngineSound"
    EngineSound.SoundId = "rbxassetid://3318619006"
    EngineSound.Looped = true
    EngineSound.Playing = true
    EngineSound.Parent = engine.WeldPoint

    local Connections = {}
    local update = function()
        if engine and engine.Parent and selfTable.scriptOn and Values.Spawned.Value then
            local roundedMagnitude = math.round(engine.WeldPoint.AssemblyLinearVelocity.Magnitude)

            EngineSound.PlaybackSpeed = roundedMagnitude * Ratio.Value / RevLength.Value
            EngineSound.Volume = 0.8 + roundedMagnitude * 0.01 / 5
        else
            EngineSound.PlaybackSpeed = 0
            EngineSound.Volume = 0
        end
    end

    local remove = function()
        table.remove(shared.RenderSteppedFunctions, table.find(shared.RenderSteppedFunctions, update))

        for _, connection in pairs(Connections) do
            if connection.Connected then
                connection:Disconnect()
            end
        end

        if EngineSound then
            EngineSound:Destroy()
        end
        if Ratio then
            Ratio:Destroy()
        end
        if RevLength then
            RevLength:Destroy()
        end
    end

    shared:BindToRenderStepped(update)
    Connections.c2 = engine.Destroying:Connect(function()
        remove()
    end)
end

local old
old = hookmetamethod(game, "__namecall", function(...)
    local method, self, t, i = getnamecallmethod(), select(1, ...)
    if method == "FireServer" then
        if self == Configure then
            if i.Name == "Gasoline Engine" then
                local Ratio, RevLength, Configuration = nil, nil, i.Configuration
                for _, v in ipairs(t) do
                    if v.valueName == "Ratio" then
                        Ratio = v.value
                    elseif v.valueName == "RevLength" then
                        RevLength = v.value
                    end

                    if Ratio and RevLength then
                        break
                    end
                end

                if Ratio and RevLength then
                    Configuration.Ratio.Value = Ratio
                    Configuration.RevLength.Value = RevLength
                end
            end
        end
    end
    return old(...)
end)

workspace.Creations.ChildAdded:Connect(function(child)
    task.wait()
    if child.Name == shared.Client.Name then
        for _, v in ipairs(child:GetChildren()) do
            if v:IsA("Model") and v.Name == "Gasoline Engine" then
                setupEngine(v)
            end
        end
    end
end)

for _, v in ipairs(workspace.Creations[shared.Client.Name]:GetChildren()) do
    if v:IsA("Model") and v.Name == "Gasoline Engine" then
        setupEngine(v)
    end
end

selfTable.stop = function()
    selfTable.scriptOn = false
end
selfTable.start = function()
    selfTable.scriptOn = true
end

return selfTable
