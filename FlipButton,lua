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

	local middle = Model:GetPivot()
	local sizeY = Model:GetExtentsSize().Y
	local top = middle * Vector3.new(0, sizeY / 2, 0)
	for _, Block in ipairs(Model:GetChildren()) do
		local BlockPart = getAvailableBasePart(Block)
		if BlockPart then
			local dis = BlockPart.Position - top

			if dis.Magnitude < distance and BlockPart then
				part = BlockPart
				distance = dis.Magnitude
			end
		end
	end

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
		local part2 = Instance.new("Part")
		part2.Anchored = true
		part2.Transparency = 0.3
		part2.CanCollide = false
		part2.CFrame = part.CFrame
		part2.Parent = workspace

		addToPart(part, Model)
	end
end

local client = game.Players.LocalPlayer
local creations = workspace.Creations

local GUI = client.PlayerGui.MainGui
local Spawned = GUI.Values.Spawned
local Frame = GUI.LeftToolbar.ToolbarBackground
local Button = Instance.new("TextButton")

Button.Size = UDim2.new(1, 0, 0.5, 0)
Button.Position = UDim2.new(1, 0, 0, 0)
Button.Text = "Flip"
Button.Visible = Spawned.Value

Spawned.Changed:Connect(function(nValue)
    Button.Visible = nValue
end)

Button.MouseButton1Click:Connect(function()
    if Spawned.Value then
        FlipCreation(creations[client.Name])
    end
end)

