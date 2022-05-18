if game.PlaceId ~= 6609611538 then return end
if not game:IsLoaded() then
    game.Loaded:Wait() 
end
local client = game.Players.LocalPlayer
local GUI = client:WaitForChild("PlayerGui")
while GUI:FindFirstChild("LoadingScreenGui∙") or not GUI:FindFirstChild("MainGui") do
    wait()
end

local function calculateMaxLength(Model)
	local Size = Model:GetExtentsSize()
	local Max = math.max(Size.X, Size.Y, Size.Z)

	return Max / 2
end

local function getAvailableBasePart(Part)
	for _, part in ipairs(Part:GetDescendants()) do
		if part:IsA("BasePart") then
			return part
		end
	end
end

local function getPartClosestToTop(Model)
	local distance = 1000
	local part

	local list = {}

	local middle = Model:GetPivot()
	local sizeY = Model:GetExtentsSize().Y
	local top = middle * Vector3.new(0, sizeY / 2, 0)
	for _, Block in ipairs(Model:GetChildren()) do
		local BlockPart = getAvailableBasePart(Block)
		if BlockPart then
			local dis = BlockPart.Position - top

			table.insert(list, dis.Magnitude)

			if dis.Magnitude < distance and BlockPart then
				part = BlockPart
				distance = dis.Magnitude
			end
		end
	end

	table.sort(list)
	print(table.concat(list, " "))

	return part
end

local function addToPart(part, Model)
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
end

local function FlipCreation(Model)
	if not Model then
		return
	end
	local part = getPartClosestToTop(Model)
	if part then
		addToPart(part, Model)
	end
end

local creations = workspace.Creations
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
        FlipCreation(creations[client.Name])
    end
end)

