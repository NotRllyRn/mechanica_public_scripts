local incoming = ({...})
local selfTable = {Name = "Unbreakable Parts"}
selfTable.scriptOn = incoming[1]
if selfTable.scriptOn == nil then
    selfTable.scriptOn = true
end

if game.PlaceId ~= 6609611538 then return end
if not game:IsLoaded() then
    game.Loaded:Wait() 
end
local Client = game.Players.LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")
while PlayerGui:FindFirstChild("LoadingScreenGui∙") or not PlayerGui:FindFirstChild("MainGui") do
    wait()
end

local stopped = {
    "Broken"
}

local old
old = hookmetamethod(game, "__namecall", function(...)
    local self = select(1, ...)
    local namecallmethod = getnamecallmethod()
    if selfTable.scriptOn and (namecallmethod == "FireServer") and table.find(stopped, self.Name) then
        return wait(9e9)
    end
    return old(...)
end)
local old2 
old2 = hookmetamethod(game, "__newindex", function(...)
    local self, key, value = ...
    if selfTable.scriptOn and self:IsDescendantOf(workspace.Creations[Cient.Name]) and (key == "Enabled") and (value == false) then
        return wait(9e9)
    end
    return old2(...)
end)

selfTable.stop = function()
    selfTable.scriptOn = false
end
selfTable.start = function()
    selfTable.scriptOn = true
end

return selfTable
