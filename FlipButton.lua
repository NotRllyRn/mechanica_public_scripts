if game.PlaceId ~= 6609611538 then return end
if not game:IsLoaded() then
    game.Loaded:Wait() 
end
local client = game.Players.LocalPlayer
local GUI = client:WaitForChild("PlayerGui")
while GUI:FindFirstChild("LoadingScreenGui∙") or not GUI:FindFirstChild("MainGui") do
    wait()
end

local client = game.Players.LocalPlayer
local Creations = workspace.Creations

local function create()
    local part = Instance.new("Part")
    part.Anchored = true
    part.CanCollide = false
    part.Parent = workspace
    part.Size = Vector3.new(2, 2, 2)
    task.spawn(function()
        wait(3)
        part:Destroy()
    end)
    return part
end

local function getNeigboringBlocks(block, Search, Searched)
    local point = block:GetPivot().Position
    local neigboring = {}

    for _, block in ipairs(Search) do
        local blockSize = block:GetExtentsSize()
        local AverageSize = (blockSize.X + blockSize.Y + blockSize.Z) / 3
        local distance = round(math.abs((block:GetPivot().Position - point).magnitude))
        print(distance)
        if distance <= 2.5 and not table.find(Searched, block) then
            table.insert(neigboring, block)
        end
    end

    return neigboring
end

local groupArea
function groupArea(block, Searched, blocksFound, Searching)
    local newBlocks = getNeigboringBlocks(block, Searching, Searched)

    for _, newBlock in ipairs(newBlocks) do
        if not table.find(Searched, newBlock) then
            table.insert(Searched, newBlock)
            table.insert(blocksFound, newBlock)
            groupArea(newBlock, Searched, blocksFound, Searching)
        end
    end
end

local function groupAll()
    local Searching = Creations[client.Name]:GetChildren()
    local Searched = {}
    local Groups = {}

    print("Searching: " .. #Searching)

    while #Searching ~= 0 do
        local model = Instance.new("Model")
        
        local SearchBlock = Searching[math.random(1, #Searching)]
        local newBlocks = {}
        table.insert(Searched, SearchBlock)
        table.insert(newBlocks, SearchBlock)

        groupArea(SearchBlock, Searched, newBlocks, Searching)
        for _, newBlock in ipairs(newBlocks) do
            newBlock:Clone().Parent = model
            table.remove(Searching, table.find(Searching, newBlock))
        end

        table.insert(Groups, model)
    end

    return Groups
end

local function getAvailableBasePart(Part)
	for _, part in ipairs(Part:GetDescendants()) do
		if part:IsA("BasePart") then
			return part
		end
	end
end

local function getTopMostBlock(Model)
    local middle = Model:GetPivot().Position
    local YSize = Model:GetExtentsSize().Y
    local top = middle + Vector3.new(0, YSize / 2, 0)

    local block
    local distance = 1000
    for _,v in ipairs(Creations[client.Name]:GetChildren()) do
        local part = getAvailableBasePart(v)
        local newDistance = part and (part.CFrame.Position - top).magnitude
        if newDistance and newDistance < distance then
            distance = newDistance
            block = part
        end
    end

    return block 
end

local function calculateMaxLength(Model)
    local modelSize = Model:GetExtentsSize()
    return math.max(modelSize.X, modelSize.Y, modelSize.Z)
end

local function addToPart(part, Model)
    task.spawn(function()
        local Max = calculateMaxLength(Model)

        local Body = Instance.new("BodyPosition")
        local Gyro = Instance.new("BodyGyro")
        Gyro.CFrame = part.CFrame
        Gyro.MaxTorque = Vector3.new(40000, 40000, 40000)
        Body.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
        Body.Position = part.CFrame.Position + Vector3.new(0, (7.5 + Max) / 1.5, 0)
        Body.Parent = part
        Gyro.Parent = part

        wait(0.1)

        Gyro.CFrame = CFrame.new()

        wait(2.4)

        Body:Destroy()
        Gyro:Destroy()
    end)
end

local function FlipCreation()
    local groups = groupAll()
    for _,v in ipairs(groups) do
        local Part = getTopMostBlock(v)
        if Part then
            addToPart(Part, v)
        end

        v:Destroy()
    end
end

GUI = GUI.MainGui
local Spawned = GUI.Values.Spawned

local Flip = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIPadding = Instance.new("UIPadding")

Flip.Parent = GUI.LeftToolbar.ToolbarBackground
Flip.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
Flip.Position = UDim2.new(1.084, 0, 0.0416, 0)
Flip.Size = UDim2.new(0.7307, 0, 0.417, 0)
Flip.Text = "Flip"
Flip.TextColor3 = Color3.fromRGB(255, 255, 255)
Flip.TextScaled = true
Flip.Visible = Spawned.Value

UICorner.CornerRadius = UDim.new(0.25, 0)
UICorner.Parent = Flip

UIPadding.Parent = Flip
UIPadding.PaddingBottom = UDim.new(0.05, 0)
UIPadding.PaddingLeft = UDim.new(0.1, 0)
UIPadding.PaddingRight = UDim.new(0.1, 0)
UIPadding.PaddingTop = UDim.new(0.05, 0)

Spawned.Changed:Connect(function(nValue)
    Flip.Visible = nValue
end)

Flip.MouseButton1Click:Connect(function()
    if Spawned.Value then
        FlipCreation()
    end
end)
