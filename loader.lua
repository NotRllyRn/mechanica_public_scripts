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
local selfTable = {}
selfTable.scriptOn = incoming[1]
if selfTable.scriptOn == nil then
    selfTable.scriptOn = true
end

return shared, selfTable
