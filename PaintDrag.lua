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
local selfTable = {Name = "Paint Drag"}
selfTable.scriptOn = incoming[1]
if selfTable.scriptOn == nil then
    selfTable.scriptOn = true
end

local workspace = game:GetService("Workspace")
local mouse = shared.Client:GetMouse()
local camera = workspace.CurrentCamera

local clientValues = shared.MainGui.Values
local clientEvents = shared.MainGui.Events
local clientColor = clientValues.PaintColor
local clientMaterial = clientValues.PaintMaterial
local dragging = false

local ObjectsList = {}
for _,Object in ipairs(game:GetService("ReplicatedStorage").Objects:GetChildren()) do
    local id = Object:GetAttribute("ObjectId")
    ObjectsList[id] = Object
end

local function getAverageSize(part)
    local size = part:GetExtentsSize()
    return (size.X + size.Y + size.Z) / 3
end

local function isOneBlock(part)
    return part:GetExtentsSize() == ObjectsList[part:GetAttribute("ObjectId")]:GetExtentsSize()
end

local getParentModel
function getParentModel(part)
    local parent = part.Parent
    if parent.Parent == workspace.Creations[shared.Client.Name] then
        return parent
    elseif parent:IsDescendantOf(workspace.Creations[shared.Client.Name]) then
        return getParentModel(parent)
    end
end

local cooldownList = {}
local function cooldown(part)
    if not table.find(cooldownList, part) then
        coroutine.resume(coroutine.create(function()
            table.insert(cooldownList, part)
            while not isOneBlock(part) do
                wait()
            end
            table.remove(cooldownList, table.find(cooldownList, part))
        end))
    end
end

local function RayCastToMouse()
    if shared.Client.Character and mouse.Hit then
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Blacklist
        params.FilterDescendantsInstances = {shared.Client.Character}

        local ray = workspace:Raycast(camera.CFrame.Position, (mouse.Hit.Position - camera.CFrame.Position).Unit * 999)
        return ray or nil
    end
end

local function getPartOnMouse()
    local mousePosition = mouse.Hit.Position
    
    for _, block in ipairs(workspace.Creations[shared.Client.Name]:GetChildren()) do
        local Position = block:GetPivot().Position - mousePosition

        if Position.Magnitude <= getAverageSize(block) + 1 then
            local rayCast = RayCastToMouse()
            local whole = isOneBlock(block)
            local instance = rayCast and getParentModel(rayCast.Instance)

            if (whole and instance == block) then
                return block
            end
        end
    end
end

local function checkForBaseParts(part)
    return (part:FindFirstChildWhichIsA("BasePart") and true) or false
end

mouse.Button1Down:Connect(function()
    dragging = true

    if clientValues.SelectedTool.Value == 'Paint' then
        local block = clientValues.TargetObject.Value
        if block and not isOneBlock(block) and not table.find(cooldownList, block) then
            cooldown(block)
        end
    end
end)

mouse.Button1Up:Connect(function()
    dragging = false
end)

local doPaint
doPaint = function(block)
    local block = block 
    local block1, block2

    if not block then
        block2 = RayCastToMouse()
        block2 = block2 and getParentModel(block2.Instance)

        if block2 and not isOneBlock(block2) then
            block = block2
        end
        
        if not block then
            block1 = getPartOnMouse()

            if block1 and checkForBaseParts(block1) then
                block = block1
            end
        end
    end

    if block then
        local blockColor = block.Configuration.Color
        local blockMaterial = block.Configuration.Material

        if (blockColor.Value ~= clientColor.Value) or (blockMaterial.Value ~= clientMaterial.Value) then
            if not isOneBlock(block) and not table.find(cooldownList, block) then
                clientEvents.Paint:FireServer(block, clientColor.Value, clientMaterial.Value)
                cooldown(block)
                if block1 then
                    doPaint(block1)
                end
            elseif isOneBlock(block) then
                clientEvents.Paint:FireServer(block, clientColor.Value, clientMaterial.Value)
            end
        end
    end
end

shared:BindToRenderStepped(function()
    if selfTable.scriptOn then
        if dragging and clientValues.SelectedTool.Value == 'Paint' then
            doPaint()
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