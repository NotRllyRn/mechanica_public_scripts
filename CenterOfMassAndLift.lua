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
local selfTable = {Name = "Center of Mass and Lift"}
selfTable.scriptOn = incoming[1]
if selfTable.scriptOn == nil then
    selfTable.scriptOn = true
end

local Client = shared.Client

local ShowMarkerButton = (function()
    local TextButton = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local UIPadding = Instance.new("UIPadding")
    
    TextButton.Parent = shared.MainGui.LeftToolbar.ToolbarBackground
    TextButton.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
    TextButton.Position = UDim2.new(0.5, 0, -0.4833, 0)
    TextButton.Size = UDim2.new(0.7739, 0, 0.4166, 0)
    TextButton.Text = "Show Markers"
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.TextScaled = true
    
    UICorner.CornerRadius = UDim.new(0.25, 0)
    UICorner.Parent = TextButton
    
    UIPadding.Parent = TextButton
    UIPadding.PaddingBottom = UDim.new(0.05, 0)
    UIPadding.PaddingLeft = UDim.new(0.1, 0)
    UIPadding.PaddingRight = UDim.new(0.1, 0)
    UIPadding.PaddingTop = UDim.new(0.05, 0)

    return TextButton
end)()

local GUI = shared.MainGui
local Spawned = GUI.Values.Spawned

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
    Spawned = false,
    unSpawned = true,
    On = not Spawned.Value,
    Model = CreateMarker(Color3.fromRGB(255, 255, 0)),
    PivotTo = function(self, CF)
        local continue1 = Spawned.Value and self.Spawned or not Spawned.Value and self.unSpawned

        if continue1 and self.On ~= true then
            self.On = true
            ToggleModel(self.Model, true)
        end

        if self.On and self.Model:GetPivot() ~= CF then
            ToggleModel(self.Model, true)
            self.Model:PivotTo(CF)
        end
    end,
    Toggle = function(self, mode)
        if not selfTable.scriptOn then
            if self.On ~= false then
                self.On = false
                ToggleModel(self.Model, false)
            end
            return
        end

        if mode == nil then
            if (Spawned.Value and self.Spawned) and self.On ~= true then
                self.On = true
                ToggleModel(self.Model, true)
            elseif (Spawned.Value and self.unSpawned) and self.On ~= false then
                self.On = false
                ToggleModel(self.Model, false)
            elseif Spawned.Value and self.On ~= false then
                self.On = false
                ToggleModel(self.Model, false)
            end
        elseif mode ~= self.On then
            self.On = mode
            ToggleModel(self.Model, mode)
        end
    end,
}
local LiftMarker = {
    Spawned = false,
    unSpawned = true,
    On = not Spawned.Value,
    Model = CreateMarker(Color3.fromRGB(0, 0, 255)),
    PivotTo = function(self, CF)
        local continue1 = Spawned.Value and self.Spawned or not Spawned.Value and self.unSpawned

        if continue1 and self.On ~= true then
            self.On = true
            ToggleModel(self.Model, true)
        end

        if self.On and self.Model:GetPivot() ~= CF then
            ToggleModel(self.Model, true)
            self.Model:PivotTo(CF)
        end
    end,
    Toggle = function(self, mode)
        if not selfTable.scriptOn then
            if self.On ~= false then
                self.On = false
                ToggleModel(self.Model, false)
            end
            return
        end

        if mode == nil then
            if (Spawned.Value and self.Spawned) and self.On ~= true then
                self.On = true
                ToggleModel(self.Model, true)
            elseif (Spawned.Value and self.unSpawned) and self.On ~= false then
                self.On = false
                ToggleModel(self.Model, false)
            elseif Spawned.Value and self.On ~= false then
                self.On = false
                ToggleModel(self.Model, false)
            end
        elseif mode ~= self.On then
            self.On = mode
            ToggleModel(self.Model, mode)
        end
    end,
}

local updateMarkerPosition = function()
    if Creations:FindFirstChild(Client.Name) and #Creations[Client.Name]:GetChildren() > 0 then
        local COM = GetCenterOfMass(Creations[Client.Name])
        local COL = GetCenterOfLift(Creations[Client.Name])
        if COM and COM ~= COL then
            MassMarker:PivotTo(CFrame.new(COM))
        else
            MassMarker:Toggle(false)
        end
        if COL then
            LiftMarker:PivotTo(CFrame.new(COL))
        else
            LiftMarker:Toggle(false)
        end
    else
        MassMarker:Toggle(false)
        LiftMarker:Toggle(false)
    end
end

local updateMarkers = function()
    MassMarker:Toggle(Spawned.Value and MassMarker.Spawned or not Spawned.Value and MassMarker.unSpawned)
    LiftMarker:Toggle(Spawned.Value and LiftMarker.Spawned or not Spawned.Value and LiftMarker.unSpawned)
    updateMarkerPosition()
end

shared:BindToRenderStepped(function()
    if Spawned.Value then
        if selfTable.scriptOn then
            updateMarkerPosition()
        elseif MassMarker.On or LiftMarker.On then
            MassMarker:Toggle(false)
            LiftMarker:Toggle(false)
        end
    end
end)

workspace.Creations.DescendantAdded:Connect(function(Object)
    if Object.Parent == workspace.Creations[Client.Name] then
        updateMarkerPosition()
    end
end)
workspace.Creations.DescendantRemoving:Connect(function(Object)
    if Object:IsDescendantOf(workspace.Creations[Client.Name]) then
        for i = 1, 10 do
            wait()
            updateMarkerPosition()
        end
    end
end)

local function updateText()
    if Spawned.Value and MassMarker.Spawned then
        ShowMarkerButton.Text = "Hide Markers"
    elseif not Spawned.Value and MassMarker.unSpawned then
        ShowMarkerButton.Text = "Hide Markers"
    else
        ShowMarkerButton.Text = "Show Markers"
    end
end

ShowMarkerButton.MouseButton1Up:Connect(function()
    if Spawned.Value then
        MassMarker.Spawned = not MassMarker.Spawned
        LiftMarker.Spawned = not LiftMarker.Spawned
    else
        MassMarker.unSpawned = not MassMarker.unSpawned
        LiftMarker.unSpawned = not LiftMarker.unSpawned
    end

    updateMarkers()
    updateText()
end)

Spawned.Changed:Connect(function()
    updateMarkers()
    updateText()
end)

task.spawn(function()
    for i = 1, 100 do
        wait()
        updateText()
        updateMarkers()
    end
end)

selfTable.stop = function()
    selfTable.scriptOn = false
end
selfTable.start = function()
    selfTable.scriptOn = true
end

return selfTable
