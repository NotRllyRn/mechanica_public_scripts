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
local selfTable = {Name = "Highlight Connections"}
selfTable.scriptOn = incoming[1]
if selfTable.scriptOn == nil then
    selfTable.scriptOn = true
end

local GUI = shared.MainGui
local values = GUI.Values
local currentBlock = values.SelectedObject
local HighlightFolder = Instance.new("Folder", workspace.Camera)
HighlightFolder.Name = "HighlightConnections"

local created = {}
local connections = {}

local setupBlock, setupConnection

local function findConnection(connection)
    for index, c in ipairs(connections) do
        if c.Connection == connection then
            return index
        end
    end
    return false
end

local function checkForConnectionObject(part)
    for _, c in ipairs(connections) do
        if c.Part == part then
            return c
        end
    end
    return false
end

local function create(partName, parented)
	local instance = Instance.new(partName)
	if parented ~= nil and typeof(parented) == "Instance" then
		instance.Parent = parented
	end
	table.insert(created, instance)
	return instance
end

local function clear()
    for _, part in ipairs(created) do
        table.remove(created, table.find(created, part))
        part:Destroy()
    end
    for _, c in ipairs(connections) do
        local position = findConnection(c.Connection)
        c.Connection:Disconnect()
        table.remove(connections, position)
    end
end

local getHead
function getHead(part)
    if part:FindFirstChild("Head") then
        return part.Head
    else
        local parts = part:GetChildren()
        if #parts > 0 then
            for _, v in ipairs(parts) do
                local head = getHead(v)
                if head then
                    return head
                end
            end
        end
    end
end

local function createDisplay(block, name)
	local base = create("Part")
	base.CanCollide = false
	base.Anchored = true
	base.Transparency = 1
	base.CFrame = block:GetPivot()

	local bill = create("BillboardGui", base)
	bill.Size = UDim2.new(2, 0, 1, 0)
	bill.AlwaysOnTop = true

	local text = create("TextLabel", bill)
	text.Size = UDim2.new(1, 0, 1, 0)
	text.BackgroundTransparency = 1
	text.TextScaled = true
	text.TextColor3 = Color3.new(1, 1, 1)
	text.TextStrokeTransparency = 0
	text.TextStrokeColor3 = Color3.new(0, 0, 0)
	text.Text = name

	base.Parent = HighlightFolder
end

local function createBeam(block1, block2)
    local block1 = getHead(block1)
    local block2 = getHead(block2)
    
    if not block1 or not block2 then
        return false
    end
    
	local attachment1 = create("Attachment", block1)
	local attachment2 = create("Attachment", block2)
	local beam = create("Beam")

	attachment1.Orientation = Vector3.new(0, 0, 90)
	attachment2.Orientation = Vector3.new(0, 0, -90)

    beam.Color = ColorSequence.new(Color3.fromRGB(255, 141, 60))
	beam.Attachment0 = attachment1
	beam.Attachment1 = attachment2
	beam.FaceCamera = true
    beam.Segments = 1000
    beam.CurveSize0 = 2
    beam.CurveSize1 = 2
	beam.Width0 = 0.2
	beam.Width1 = 0.2

    beam.Parent = HighlightFolder
    return true
end

function setupBlock(value)
    clear()

    if value == nil then
        return
    end

    local block1 = value
    for _, block2 in ipairs(block1.Configuration:GetChildren()) do
        local customName = block2:GetAttribute("CustomName") or block2.Name

        if block2.ClassName == 'ObjectValue' then
            setupConnection(block2)

            if block2.Value ~= nil and createBeam(block1, block2.Value) then
                createDisplay(block2.Value, customName)
            end
        end
    end
end

function setupConnection(Value)
    if not checkForConnectionObject(Value) then
        local connection
        connection = Value.Changed:Connect(function()
            if currentBlock.Value then
                setupBlock(currentBlock.Value)
            else
                local position = findConnection(connection)
                if position then
                    table.remove(connections, position)
                    connection:Disconnect() 
                end
            end
        end)
        table.insert(connections, {
            Connection = connection,
            Part = Value
        })
    end
end

currentBlock.Changed:Connect(function(value)
    if selfTable.scriptOn then
        if value ~= nil and value:FindFirstChild("Configuration") then
            setupBlock(value)
        else
            clear()
        end
    end
end)

selfTable.stop = function()
    selfTable.scriptOn = false
    clear()
end
selfTable.start = function()
    selfTable.scriptOn = true
    if currentBlock.Value and currentBlock.Value:FindFirstChild("Configuration") then
        setupBlock(currentBlock.Value)
    end
end

return selfTable
