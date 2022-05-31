local shared = getgenv().MechanicaShared
if shared then
    print("Shared found!")

    if not shared.RightGame then
        return
    end
    if not shared.Loaded then
        shared.LoadedEvent.Event:Wait()
    end
else
    print("Shared not found")

    shared = {
        RightGame = game.PlaceId == 6609611538,
        Loaded = false,
        LoadedEvent = Instance.new("BindableEvent"),
    }
    getgenv().MechanicaShared = shared
    if not shared.RightGame then
        return
    end
    shared.gameLoaded = game:IsLoaded()
    if not shared.gameLoaded then
        game.Loaded:Wait() 
        shared.gameLoaded = true
    end
    shared.Client = game:GetService("Players").LocalPlayer
    shared.PlayerGui = shared.Client:WaitForChild("PlayerGui")
    while shared.PlayerGui:FindFirstChild("LoadingScreenGui∙") or not shared.PlayerGui:FindFirstChild("MainGui") do
        wait()
    end
    shared.MainGui = shared.PlayerGui.MainGui
    shared.RenderStepped = game:GetService("RunService").RenderStepped
    shared.RenderSteppedFunctions = {}
    shared.BindToRenderStepped = function(self, func)
        table.insert(self.RenderSteppedFunctions, func)
    end
    shared.RenderStepped:Connect(function()
        for _, func in ipairs(shared.RenderSteppedFunctions) do
            task.spawn(func)
        end
    end)
    shared.Loaded = true
    shared.LoadedEvent:Fire()
end

local incoming = ({...})
local selfTable = {Name = "Auto Save"}
selfTable.scriptOn = incoming[1]
if selfTable.scriptOn == nil then
    selfTable.scriptOn = true
end

wait(1)

local Save24 = shared.MainGui.DespawnedUI.SideMenu.SavesBox.Saves["24"]
local Save24Name = shared.MainGui.SavingValues["CreationName 24"]
local Spawned = shared.MainGui.Values.Spawned

if selfTable.scriptOn then
    Save24Name.Value = "AUTOSAVE"
    Save24.SaveLoad:FireServer("Load")
end

local timeoutTable = {}
local time = false
local function timeout(callback)
    for _,v in ipairs(timeoutTable) do
        v[1] = false
    end

    task.spawn(function()
        time = true
        local t = { true }
        table.insert(timeoutTable, t)
        wait(10)
        if t[1] then
            time = false
            callback()
        end

        table.remove(timeoutTable, table.find(timeoutTable, t))
    end)
end

local search = {"Build", "Paint", "Configure", "Delete"}
local old 
old = hookmetamethod(game, "__namecall", function(...)
    local self = select(1, ...)
    local namecallmethod = getnamecallmethod()
    if selfTable.scriptOn and (namecallmethod == "FireServer") then
        if table.find(search, self.Name) then
            timeout(function()
                if selfTable.scriptOn then
                    Save24.SaveLoad:FireServer("Save")
                end
            end)
        elseif self.Name == "SaveLoad" then
            local nd2 = select(2, ...)
            if nd2 == "Save" then
                timeout(function() end)
                time = false
            end
        end
    end
    return old(...)
end)

Spawned.Changed:Connect(function()
    if Spawned.Value and selfTable.scriptOn then
        Save24.SaveLoad:FireServer("Save")
        timeout(function() end)
        time = false
    end
end)

game.Players.PlayerRemoving:Connect(function(p)
    if p == shared.Client and time and selfTable.scriptOn then
        Save24.SaveLoad:FireServer("Save")
    end
end)

selfTable.stop = function()
    selfTable.scriptOn = false
end
selfTable.start = function(first)
    selfTable.scriptOn = true
    Save24Name.Value = "AUTOSAVE"
    if first then
        Save24.SaveLoad:FireServer("Load")
    end
end

return selfTable
