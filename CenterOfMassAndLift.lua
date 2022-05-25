if game.PlaceId ~= 6609611538 then return end
if not game:IsLoaded() then
    game.Loaded:Wait() 
end
local Client = game.Players.LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")
while PlayerGui:FindFirstChild("LoadingScreenGui∙") or not PlayerGui:FindFirstChild("MainGui") do
    wait()
end

local Camera = workspace.Camera
local directions = {
    [1] = Vector3.new(0, 0, 1),
    [2] = Vector3.new(0, 0, -1),
    [3] = Vector3.new(1, 0, 0),
    [4] = Vector3.new(-1, 0, 0),
    [5] = Vector3.new(0, 1, 0),
    [6] = Vector3.new(0, -1, 0),
}
local liftParts = {
    6,
    53
}

local function createBeam(Ball, Direction, Color)
    local beam = Instance.new("Part")
    beam.Anchored = true
    beam.CanCollide = false
    beam.Color = Color
    beam.Size = Vector3.new(0.2, 6, 0.2)
    local Direction = directions[Direction]
    local Angles = Direction * 90
    beam.CFrame = Ball.CFrame * CFrame.new(Direction * 3) * CFrame.fromEulerAnglesXYZ(math.rad(Angles.Z), math.rad(Angles.Y), math.rad(Angles.X))
    return beam
end

local function CreateMarker(Color)
    local Model = Instance.new("Model")
    Model.Name = "Marker"

    local Ball = Instance.new("Part")
    Ball.Name = "Ball"
    Ball.Size = Vector3.new(1, 1, 1)
    Ball.Anchored = true
    Ball.CanCollide = false
    Ball.TopSurface = 0
    Ball.BottomSurface = 0
    Ball.Color = Color
    Ball.Shape = "Ball"
    Ball.Parent = Model

    for direction = 1, 6 do
        createBeam(Ball, direction, Color).Parent = Model
    end

    Model.Parent = Camera

    return Model
end

local function GetCenterOfMass(Model, ignoreMass)
    local center = Vector3.new()
    local totalMass = 0
    for _, part in pairs(Model:GetDescendants()) do
        if part:IsA("BasePart")then
            local partMass = part:GetMass()
            
            center = center + ((part.CFrame.Position + part.CenterOfMass) * partMass)
            totalMass = totalMass + partMass
        end
    end
    return totalMass ~= 0 and (center / totalMass) or nil
end

local function GetCenterOfLift(Model)
    local center = Vector3.new()
    local count = 0
    for _, Object in ipairs(Model:GetChildren()) do
        local ObjectId = Object:GetAttribute("ObjectId")
        if ObjectId and table.find(liftParts, ObjectId) then
            for _, part in ipairs(Object:GetDescendants()) do
                if part:IsA("BasePart") then
                    center = center + part.CFrame.Position + part.CenterOfMass
                    count = count + 1
                end
            end
        end
    end
    return count ~= 0 and (center / count) or nil
end

local function ToggleModel(Model, mode)
    for _, parts in ipairs(Model:GetChildren()) do
        if parts:IsA("BasePart") then
            parts.Transparency = mode and 0 or 1
        end
    end
end

local Creations = workspace.Creations
local MassMarker = {
    On = true,
    Model = CreateMarker(Color3.fromRGB(255, 255, 0)),
    PivotTo = function(self, CF)
        if self.On then
            self.Model:PivotTo(CF)
        end
    end,
    Toggle = function(self, mode)
        if mode == self.On then
            self.On = not mode
            ToggleModel(self.Model, not mode)
        end
    end
}
local LiftMarker = {
    On = true,
    Model = CreateMarker(Color3.fromRGB(0, 0, 255)),
    PivotTo = function(self, CF)
        if self.On then
            self.Model:PivotTo(CF)
        end
    end,
    Toggle = function(self, mode)
        if mode == self.On then
            self.On = not mode
            ToggleModel(self.Model, not mode)
        end
    end
}
local GUI = PlayerGui.MainGui
local Spawned = GUI.Values.Spawned

game:GetService("RunService").RenderStepped:Connect(function()
    MassMarker:Toggle(Spawned.Value)
    LiftMarker:Toggle(Spawned.Value)
    if not Spawned.Value and Creations:FindFirstChild(Client.Name) and #Creations[Client.Name]:GetChildren() > 0 then
        local COM = GetCenterOfMass(Creations[Client.Name])
        local COL = GetCenterOfLift(Creations[Client.Name])
        if COM and COM ~= COL then
            MassMarker:PivotTo(CFrame.new(COM))
        else
            MassMarker:Toggle(true)
        end
        if COL then
            LiftMarker:PivotTo(CFrame.new(COL))
        else
            LiftMarker:Toggle(true)
        end
    else
        MassMarker:Toggle(true)
        LiftMarker:Toggle(true)
    end
end)
