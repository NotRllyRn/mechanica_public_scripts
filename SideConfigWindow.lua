local shared, selfTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotRllyRn/mechanica_public_scripts/main/loader.lua"))(...)
selfTable.Name = "Side Config Window"

local newSize = UDim2.new(0.226, 0,0.552, 0)

local configMenu = shared.MainGui.Tools.Configure
local configWindow
local originalPosition
configMenu.ChildAdded:Connect(function(c)
    if selfTable.scriptOn and (c.Name == "ConfigWindow") then
        originalPosition = c.Position
        c.Position = newSize
        configWindow = c
    end
end)
configMenu.ChildRemoved:Connect(function(c)
    if c == configWindow then
        configWindow = nil
    end
end)

local TweenService = game:GetService("TweenService")
local size = UDim2.fromScale(0.5, 0.5)

local old
old = hookmetamethod(game, "__namecall", function(...)
    local self, instance, tweenInfo, tweening = ...
    if not instance or not tweenInfo or not tweening or not self or not configMenu then
        return old(...)
    end
    local namecallmethod = getnamecallmethod()
    if selfTable.scriptOn and namecallmethod == "Create" and self == TweenService and configWindow == instance and typeof(tweening) == "table" and rawget(tweening, "Position") and tweening.Position == size then
        rawset(tweening, "Position", newSize)
        return old(self, instance, tweenInfo, tweening)
    end
    return old(...)
end)

if configMenu:FindFirstChild("ConfigWindow") then
    configMenu.ConfigWindow.Position = newSize
end

selfTable.stop = function()
    selfTable.scriptOn = false
    if configMenu:FindFirstChild("ConfigWindow") then
        configMenu.ConfigWindow.Position = originalPosition
    end
end
selfTable.start = function()
    selfTable.scriptOn = true
    if configMenu:FindFirstChild("ConfigWindow") then
        configMenu.ConfigWindow.Position = newSize
    end
end

return selfTable
