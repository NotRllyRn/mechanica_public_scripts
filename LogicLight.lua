local shared, selfTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotRllyRn/mechanica_public_scripts/main/loader.lua"))(...)
selfTable.Name = "Logic Light"

local CreationScripts = shared.MainGui.CreationScripts
local Creations = workspace.Creations

local clearConnections = function(t)
    for i, c in pairs(t) do
        if c.Connected then
            c:Disconnect()
        end
        t[i] = nil
    end
end
local apply = function(Changable, material)
    for _, v in ipairs(Changable) do
        v.Material = material
    end
end
local setup = function(Model)
    local Output = Model.Output
    local Changable, oldColor, oldMaterial = {}
    for _, v in ipairs(Model:GetDescendants()) do
        if v:GetAttribute("ApplyMaterial") then
            oldMaterial = v.Material
            table.insert(Changable, v)
        end
    end

    local Connections = {}
    local onEnd = function()
        clearConnections(Connections)
        apply(Changable, oldMaterial)
    end
    Connections.c1 = Model.Destroying:Connect(onEnd)
    Connections.c3 = Output.Event:Connect(function(v)
        if v and v ~= 0 then
            apply(Changable, Enum.Material.Neon)
        else
            apply(Changable, oldMaterial)
        end
    end)
end

CreationScripts.ChildAdded:Connect(function(script)
    local object = script:FindFirstChild("Object")
    if object then
        while not object.Value do
            task.wait()
        end

        local Main = object.Value
        if Main:FindFirstChild("Output") then
            setup(Main)
        end
    end
end)

selfTable.stop = function()
    selfTable.scriptOn = false
end
selfTable.start = function()
    selfTable.scriptOn = true
end

return selfTable
