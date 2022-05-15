if game.PlaceId ~= 6609611538 then return end
if not game:IsLoaded() then
    game.Loaded:Wait() 
end
local Client = game.Players.LocalPlayer
local GUI = Client:WaitForChild("PlayerGui")
while GUI:FindFirstChild("LoadingScreenGui∙") or not GUI:FindFirstChild("MainGui") do
    wait()
end

wait(1)

local Save24 = GUI.MainGui.DespawnedUI.SideMenu.SavesBox.Saves["24"]
local Save24Name = GUI.MainGui.SavingValues["CreationName 24"]
local Spawned = GUI.MainGui.Values.Spawned

Save24Name.Value = "AUTOSAVE"
Save24.SaveLoad:FireServer("Load")

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
    if namecallmethod == "FireServer" and table.find(search, self.Name) then
        timeout(function()
            Save24.SaveLoad:FireServer("Save")
        end)
    end
    return old(...)
end)

game.Players.PlayerRemoving:Connect(function(p)
    if p == Client and time then
        Save24.SaveLoad:FireServer("Save")
    end
end)
