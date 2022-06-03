local shared, selfTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotRllyRn/mechanica_public_scripts/main/loader.lua"))(...)
selfTable.Name = "Material Tab"

local MaterialEnum = Enum.Material
local Materials = {
    Plastic = {
        Enum = MaterialEnum.Plastic,
        Name = "Plastic",
        ImageId = "9795275324",
    },
    SmoothPlastic = {
        Enum = MaterialEnum.SmoothPlastic,
        Name = "Smooth Plastic",
        ImageId = "9795275324",
    },
    Brick = {
        Enum = MaterialEnum.Brick,
        Name = "Brick",
        ImageId = "9795275614",
    },
    Cobblestone = {
        Enum = MaterialEnum.Cobblestone,
        Name = "Cobblestone",
        ImageId = "9795275969",
    },
    Concrete = {
        Enum = MaterialEnum.Concrete,
        Name = "Concrete",
        ImageId = "9795275829",
    },
    CorrodedMetal = {
        Enum = MaterialEnum.CorrodedMetal,
        Name = "Corroded Metal",
        ImageId = "5517188355",
    },
    DiamondPlate = {
        Enum = MaterialEnum.DiamondPlate,
        Name = "Diamond Plate",
        ImageId = "9795275413",
    },
    Fabric = {
        Enum = MaterialEnum.Fabric,
        Name = "Fabric",
        ImageId = "9795275485",
    },
    Foil = {
        Enum = MaterialEnum.Foil,
        Name = "Foil",
        ImageId = "1208150225",
    },
    ForceField = {
        Enum = MaterialEnum.ForceField,
        Name = "Force Field",
    },
    Glass = {
        Enum = MaterialEnum.Glass,
        Name = "Glass",
        ImageId = "empty",
    },
    Granite = {
        Enum = MaterialEnum.Granite,
        Name = "Granite",
        ImageId = "9795275643",
    },
    Grass = {
        Enum = MaterialEnum.Grass,
        Name = "Grass",
        ImageId = "9795275667",
    },
    Ice = {
        Enum = MaterialEnum.Ice,
        Name = "Ice",
        ImageId = "9795275667",
    },
    Marble = {
        Enum = MaterialEnum.Marble,
        Name = "Marble",
        ImageId = "9795275566",
    },
    Metal = {
        Enum = MaterialEnum.Metal,
        Name = "Metal",
        ImageId = "9795275293",
    },
    Neon = {
        Enum = MaterialEnum.Neon,
        Name = "Neon",
    },
    Pebble = {
        Enum = MaterialEnum.Pebble,
        Name = "Pebble",
        ImageId = "9795275434",
    },
    Sand = {
        Enum = MaterialEnum.Sand,
        Name = "Sand",
        ImageId = "9795275572",
    },
    Slate = {
        Enum = MaterialEnum.Slate,
        Name = "Slate",
        ImageId = "9795275650",
    },
    Wood = {
        Enum = MaterialEnum.Wood,
        Name = "Wood",
        ImageId = "9795275605",
    },
    WoodPlanks = {
        Enum = MaterialEnum.WoodPlanks,
        Name = "Wood Planks",
        ImageId = "9795275606",
    },
}

local PaintFrame = shared.MainGui.Tools.Paint
local PaintUi = PaintFrame.PaintUI
local GUI = (function()
    local menuOpen = false

    local Material = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local ScrollingFrame = Instance.new("ScrollingFrame")
    local UIGridLayout = Instance.new("UIGridLayout")
    local Example = Instance.new("ImageButton")
    local NameValue = Instance.new("TextLabel")
    local UIPadding = Instance.new("UIPadding")
    local Friction = Instance.new("TextLabel")
    local UIPadding_2 = Instance.new("UIPadding")
    local Densitiy = Instance.new("TextLabel")
    local UIPadding_3 = Instance.new("UIPadding")
    
    Material.Parent = PaintFrame
    Material.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
    Material.Position = UDim2.new(0.2528, 0, 0.1699, 0)
    Material.Size = UDim2.new(0.4970, 0, 0.4707, 0)
    Material.Visible = menuOpen
    
    UICorner.CornerRadius = UDim.new(0.03, 0)
    UICorner.Parent = Material
    
    ScrollingFrame.Parent = Material
    ScrollingFrame.Active = true
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Position = UDim2.new(0.0370, 0, 0.0465, 0)
    ScrollingFrame.Size = UDim2.new(0.9386, 0, 0.9068, 0)
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(197, 197, 197)
    ScrollingFrame.CanvasSize = UDim2.new(0,0,3,0)
    
    UIGridLayout.Parent = ScrollingFrame
    UIGridLayout.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
    UIGridLayout.CellSize = UDim2.new(0.171, 0,0.097, 0)
    
    Example.Parent = ScrollingFrame
    Example.BackgroundTransparency = 1
    Example.Image = "http://www.roblox.com/asset/?id=9795275413"
    Example.Visible = false
    
    NameValue.Name = "NameValue"
    NameValue.Parent = Example
    NameValue.BackgroundTransparency = 1
    NameValue.Position = UDim2.new(0, 0, 0, 0)
    NameValue.Size = UDim2.new(1, 0, 0.4345, 0)
    NameValue.Text = "Diamond Plate"
    NameValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameValue.TextScaled = true
    NameValue.TextStrokeTransparency = 0
    NameValue.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    
    UIPadding.Parent = NameValue
    UIPadding.PaddingBottom = UDim.new(0.05, 0)
    UIPadding.PaddingLeft = UDim.new(0.05, 0)
    UIPadding.PaddingRight = UDim.new(0.05, 0)
    UIPadding.PaddingTop = UDim.new(0.05, 0)
    
    Friction.Name = "Friction"
    Friction.Parent = Example
    Friction.BackgroundTransparency = 1
    Friction.Position = UDim2.new(0, 0, 0.7535, 0)
    Friction.Size = UDim2.new(1, 0, 0.246, 0)
    Friction.Text = "Friction: 0.3"
    Friction.TextColor3 = Color3.fromRGB(255, 255, 255)
    Friction.TextScaled = true
    Friction.TextStrokeTransparency = 0
    Friction.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    
    UIPadding_2.Parent = Friction
    UIPadding_2.PaddingBottom = UDim.new(0.05, 0)
    UIPadding_2.PaddingLeft = UDim.new(0.05, 0)
    UIPadding_2.PaddingRight = UDim.new(0.05, 0)
    UIPadding_2.PaddingTop = UDim.new(0.05, 0)
    
    Densitiy.Name = "Densitiy"
    Densitiy.Parent = Example
    Densitiy.BackgroundTransparency = 1
    Densitiy.Position = UDim2.new(0, 0, 0.52, 0)
    Densitiy.Size = UDim2.new(1, 0, 0.246, 0)
    Densitiy.Text = "Density: 6.7"
    Densitiy.TextColor3 = Color3.fromRGB(255, 255, 255)
    Densitiy.TextScaled = true
    Densitiy.TextStrokeTransparency = 0
    Densitiy.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    
    UIPadding_3.Parent = Densitiy
    UIPadding_3.PaddingBottom = UDim.new(0.05, 0)
    UIPadding_3.PaddingLeft = UDim.new(0.05, 0)
    UIPadding_3.PaddingRight = UDim.new(0.05, 0)
    UIPadding_3.PaddingTop = UDim.new(0.05, 0)

    local original = {
        Size = PaintUi.Material.Size,
        Position = PaintUi.Material.Position,
    }
    local MaterialTextBox = PaintUi.Material
    local function newMaterialSize()
        MaterialTextBox.Position = UDim2.new(0.3921, 0, 1, -66)
        MaterialTextBox.Size = UDim2.new(0.7315, 0, 0.2127, 0)
    end
    local function revertToOld()
        MaterialTextBox.Position = original.Position
        MaterialTextBox.Size = original.Size
    end

    local OpenButton = Instance.new("ImageButton")
    local UICorner_2 = Instance.new("UICorner")

    OpenButton.Parent = PaintUi
    OpenButton.BackgroundTransparency = 1
    OpenButton.Position = UDim2.new(0.789, 0, 0.304, 0)
    OpenButton.Size = UDim2.new(0.157, 0, 0.212, 0)
    OpenButton.Image = "rbxassetid://7072981376"
    
    UICorner_2.CornerRadius = UDim.new(0.25, 0)
    UICorner_2.Parent = OpenButton

    local function stop()
        OpenButton.Visible = false
        Material.Visible = false
        revertToOld()
    end

    local function start()
        if selfTable.scriptOn then
            newMaterialSize()
            OpenButton.Visible = true
            Material.Visible = menuOpen
        else
            stop()
        end
    end
    start()

    OpenButton.MouseButton1Click:Connect(function()
        menuOpen = not menuOpen
        Material.Visible = menuOpen
    end)

    local function onClick(material)
        MaterialTextBox.Text = material.enumName

        for _, connection in pairs(getconnections(MaterialTextBox.FocusLost)) do
            connection.Function()
        end
    end

    return {
        start = start,
        stop = stop,
        setupButton = function(material)
            local id = (material.ImageId and (material.ImageId ~= "empty") and material.ImageId) or ((material.ImageId ~= "empty") and Materials.Plastic.ImageId) or nil

            local b = Example:Clone()
            if id then
                b.Image = "http://www.roblox.com/asset/?id=" .. tostring(id)
            else
                b.Image = ""
            end
            b.NameValue.Text = material.Name
            b.Friction.Text = "Friction: " .. tostring(material.Properties.Friction)
            b.Densitiy.Text = "Density: " .. tostring(material.Properties.Density)
            b.Visible = true
            b.Parent = ScrollingFrame

            b.MouseButton1Click:connect(function()
                onClick(material)
            end)
        end,
    }
end)()

local function getMaterialProperties(Material)
    local b = PhysicalProperties.new(Material.Enum)
    return {
        Friction = math.floor(b.Friction * 100) / 100,
        Density = math.floor(b.Density * 100) / 100,
    }
end

for enumName, material in pairs(Materials) do
    material.Properties = getMaterialProperties(material)
    material.enumName = enumName

    GUI.setupButton(material)
end

selfTable.stop = function()
    selfTable.scriptOn = false
    GUI.stop()
end
selfTable.start = function()
    selfTable.scriptOn = true
    GUI.start()
end

return selfTable
