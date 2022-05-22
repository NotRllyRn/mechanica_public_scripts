if game.PlaceId ~= 6609611538 then return end
if not game:IsLoaded() then
    game.Loaded:Wait() 
end
local client = game.Players.LocalPlayer
local GUI = client:WaitForChild("PlayerGui")
while GUI:FindFirstChild("LoadingScreenGui∙") or not GUI:FindFirstChild("MainGui") do
    wait()
end
GUI = GUI.MainGui

local ENUM_MATERIALS = {
    [1] = 'Plastic',
    [2] = 'Wood',
    [3] = 'Slate',
    [4] = 'Concrete',
    [5] = 'CorrodedMetal',
    [6] = 'DiamondPlate',
    [7] = 'Foil',
    [8] = 'Grass',
    [9] = 'Ice',
    [10] = 'Marble',
    [11] = 'Granite',
    [12] = 'Brick',
    [13] = 'Pebble',
    [14] = 'Sand',
    [15] = 'Fabric',
    [16] = 'SmoothPlastic',
    [17] = 'Metal',
    [18] = 'WoodPlanks',
    [19] = 'Cobblestone',
    [20] = 'Air',
    [21] = 'Water',
    [22] = 'Rock',
    [23] = 'Glacier',
    [24] = 'Snow',
    [25] = 'Sandstone',
    [26] = 'Mud',
    [27] = 'Basalt',
    [28] = 'Ground',
    [29] = 'CrackedLava',
    [30] = 'Neon',
    [31] = 'Glass',
    [32] = 'Asphalt',
    [33] = 'LeafyGrass',
    [34] = 'Salt',
    [35] = 'Limestone',
    [36] = 'Pavement',
    [37] = 'ForceField',
}

local ENUM_KEYCODES = {
    [2] = 'Backspace',
    [3] = 'Tab',
    [4] = 'Clear',
    [5] = 'Return',
    [6] = 'Pause',
    [7] = 'Escape',
    [8] = ' ',
    [9] = '"',
    [10] = '#',
    [11] = '$',
    [12] = '%',
    [14] = "'",
    [15] = '(',
    [16] = ')',
    [17] = '*',
    [18] = '+',
    [19] = ',',
    [20] = '-',
    [21] = '.',
    [22] = '/',
    [23] = '0',
    [24] = '1',
    [25] = '2',
    [26] = '3',
    [27] = '4',
    [28] = '5',
    [29] = '6',
    [30] = '7',
    [31] = '8',
    [32] = '9',
    [33] = ':',
    [34] = ';',
    [35] = '<',
    [36] = '=',
    [37] = '>',
    [38] = '?',
    [39] = '@',
    [40] = ']',
    [41] = '\\',
    [42] = '[',
    [43] = 'Caret',
    [44] = '_',
    [45] = '`',
    [46] = 'A',
    [47] = 'B',
    [48] = 'C',
    [49] = 'D',
    [50] = 'E',
    [51] = 'F',
    [52] = 'G',
    [53] = 'H',
    [54] = 'I',
    [55] = 'J',
    [56] = 'K',
    [57] = 'L',
    [58] = 'M',
    [59] = 'N',
    [60] = 'O',
    [61] = 'P',
    [62] = 'Q',
    [63] = 'R',
    [64] = 'S',
    [65] = 'T',
    [66] = 'U',
    [67] = 'V',
    [68] = 'W',
    [69] = 'X',
    [70] = 'Y',
    [71] = 'Z',
    [72] = '}',
    [74] = '{',
    [75] = '~',
    [76] = 'Delete',
    [77] = 'KeypadZero',
    [78] = 'KeypadOne',
    [79] = 'KeypadTwo',
    [80] = 'KeypadThree',
    [81] = 'KeypadFour',
    [82] = 'KeypadFive',
    [83] = 'KeypadSix',
    [84] = 'KeypadSeven',
    [85] = 'KeypadEight',
    [86] = 'KeypadNine',
    [87] = 'KeypadPeriod',
    [88] = 'KeypadDivide',
    [89] = 'KeypadMultiply',
    [90] = 'KeypadMinus',
    [91] = 'KeypadPlus',
    [92] = 'KeypadEnter',
    [93] = 'KeypadEquals',
    [94] = 'Up',
    [95] = 'Down',
    [96] = 'Right',
    [97] = 'Left',
    [98] = 'Insert',
    [99] = 'Home',
    [100] = 'End',
    [101] = 'PageUp',
    [102] = 'PageDown',
    [103] = 'LeftShift',
    [104] = 'RightShift',
    [105] = 'LeftMeta',
    [106] = 'RightMeta',
    [107] = 'LeftAlt',
    [108] = 'RightAlt',
    [109] = 'LeftCtrl',
    [110] = 'RightCtrl',
    [111] = 'CapsLock',
    [112] = 'NumLock',
    [113] = 'ScrollLock',
    [114] = 'LeftSuper',
    [115] = 'RightSuper',
    [126] = 'F1',
    [127] = 'F2',
    [128] = 'F3',
    [129] = 'F4',
    [130] = 'F5',
    [131] = 'F6',
    [132] = 'F7',
    [133] = 'F8',
    [134] = 'F9',
    [135] = 'F10',
    [136] = 'F11',
    [137] = 'F12',
    [138] = 'F13',
    [139] = 'F14',
    [140] = 'F15',
}

local VALUES_TYPES_CONSTANTS = {
    ["string"] = 1,
    ["number"] = 2,
    ["boolean"] = 3,
    ["Vector3"] = 4,
    ["Color3"] = 5,
    ["Instance"] = 6,
    ["KeyCode"] = 7,
    ["Material"] = 8,
}
local VALUES_CONFIGURATIONS_CONSTANTS = {
    ["Color"] = 1,
    ["Material"] = 2,
    ["TargetLength"] = 3,
    ["Speed"] = 4,
    ["Strength"] = 5,
    ["DespawnedLength"] = 6,
    ["Input"] = 7,
    ["YSize"] = 8,
    ["ZSize"] = 9,
    ["Size"] = 10,
    ["Thickness"] = 11,
    ["Brightness"] = 12,
    ["CastShadows"] = 13,
    ["Range"] = 14,
    ["Delay"] = 15,
    ["IgnoreWater"] = 16,
    ["OutputDistance"] = 17,
    ["HeadWeldsOnSides"] = 18,
    ["FireRate"] = 19,
    ["AmmoSource"] = 20,
    ["LightColor"] = 21,
    ["Channel"] = 22,
    ["XSize"] = 23,
    ["Stiffness"] = 24,
    ["Dampening"] = 25,
    ["SpawnedLength"] = 26,
    ["SmartDamping"] = 27,
    ["Input1"] = 28,
    ["Input2"] = 29,
    ["TeethThickness"] = 30,
    ["Teeth"] = 31,
    ["RotationOffset"] = 32,
    ["TeethHeight"] = 33,
    ["PositionOffset"] = 34,
    ["Length"] = 35,
    ["Power"] = 36,
    ["ActivationKey"] = 37,
    ["Torque"] = 38,
    ["BackwardInput"] = 39,
    ["ForwardInput"] = 40,
    ["Angle"] = 41,
    ["Source"] = 42,
    ["Input3"] = 43,
    ["Input4"] = 44,
    ["Input5"] = 45,
    ["Input6"] = 46,
    ["XOffset"] = 47,
    ["YOffset"] = 48,
    ["ZOffset"] = 49,
    ["MaxTwistAngle"] = 50,
    ["AutomaticBraking"] = 51,
    ["Acceleration"] = 52,
    ["SnapToGrid"] = 53,
    ["AutoWeldToBlocks"] = 54,
    ["Shape"] = 55,
    ["PrintSize"] = 56,
    ["ZAngle"] = 57,
    ["Blades"] = 58,
    ["BladeAngle"] = 59,
    ["BladeWidth"] = 60,
    ["HalfLength"] = 61,
    ["AmmoType"] = 62,
    ["ButtonColor"] = 63,
    ["Toggle"] = 64,
    ["HighlightColor"] = 65,
    ["AllowOtherPlayerInput"] = 66,
    ["TargetColor"] = 67,
    ["OutputAmountOfColor"] = 68,  
}

-- // define and initialize common usage variables
local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runservice = game:GetService("RunService")
local userInput = game:GetService("UserInputService")

local EventsFolder = client.PlayerGui.MainGui.Events
local camera = workspace.Camera
local mouse = client:GetMouse()

local build = EventsFolder.Build
local paint = EventsFolder.Paint
local configure = EventsFolder.Configure

--// defining ram usage variables
local RAM = {
    CopyTool = false,
    Selecting = false,
    Placing = false,
    MouseInfo = { Start = 0, End = 0 },
    SpeedBlockPlace = 5
}

-- // define in game folders
local ObjectFolder = replicatedStorage:WaitForChild("Objects")
local ClientCreation = workspace.Creations[client.Name]
local ModelPreview
local SelectionHighlight

-- // define script tables 
local blocks, conversion, valueCodes, clientBounds, actionService, modelService, selectionService, copyService, stringService, pasteService = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
local RadiansToVector3, Vector3ToRadians, round, reserve, CorrectDegrees, getMousePoint

-- // define screengui and selection frame
local GUI = (function()
    local PaintUI = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TextLabel = Instance.new("TextLabel")
    local Copy = Instance.new("TextButton")
    local UICorner_2 = Instance.new("UICorner")
    local NumberOf = Instance.new("TextLabel")
    local Import = Instance.new("TextButton")
    local UICorner_3 = Instance.new("UICorner")
    local Export = Instance.new("TextButton")
    local UICorner_4 = Instance.new("UICorner")
    local TextBox = Instance.new("TextBox")
    local UICorner_5 = Instance.new("UICorner")
    local Status = Instance.new("TextLabel")
    local Paste = Instance.new("TextButton")
    local UICorner_6 = Instance.new("UICorner")
    local Speed = Instance.new("TextBox")
    local UICorner_7 = Instance.new("UICorner")
    local UIPadding = Instance.new("UIPadding")
    local UIPadding_2 = Instance.new("UIPadding")

    local CopyToolLasso = Instance.new("Frame")
    
    PaintUI.Name = "PaintUI"
    PaintUI.Parent = GUI.DespawnedUI.Toolbar.ToolbarBackground
    PaintUI.AnchorPoint = Vector2.new(0.5, 0)
    PaintUI.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
    PaintUI.Position = UDim2.new(0.502, 0, -1.5, 0)
    PaintUI.Size = UDim2.new(0.985, 0, 1.4, 0)
    PaintUI.ZIndex = -999999
    PaintUI.Visible = false
    
    UICorner.CornerRadius = UDim.new(0.08, 0)
    UICorner.Parent = PaintUI
    
    TextLabel.Parent = PaintUI
    TextLabel.AnchorPoint = Vector2.new(0, 1)
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.Position = UDim2.new(0.018, 0, 1, 0)
    TextLabel.Size = UDim2.new(0.981, 0, 0.22, 0)
    TextLabel.ZIndex = -1
    TextLabel.Text = "Click and drag to select blocks. Shift+V to paste."
    TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    TextLabel.TextScaled = true
    TextLabel.ZIndex = -999999

    Copy.Parent = PaintUI
    Copy.BackgroundColor3 = Color3.fromRGB(16, 240, 68)
    Copy.Position = UDim2.new(0.039, 0, 0.085, 0)
    Copy.Size = UDim2.new(0.288, 0, 0.205, 0)
    Copy.Text = "Copy"
    Copy.TextColor3 = Color3.fromRGB(0, 0, 0)
    Copy.TextScaled = true
    Copy.ZIndex = -999999
    
    UICorner_2.CornerRadius = UDim.new(0.12, 0)
    UICorner_2.Parent = Copy
    
    NumberOf.Parent = PaintUI
    NumberOf.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NumberOf.BackgroundTransparency = 1
    NumberOf.Position = UDim2.new(0.345, 0, 0.042, 0)
    NumberOf.Size = UDim2.new(0.654, 0, 0.141, 0)
    NumberOf.Text = "Blocks Selected: 0"
    NumberOf.TextColor3 = Color3.fromRGB(255, 255, 255)
    NumberOf.TextScaled = true
    NumberOf.TextXAlignment = Enum.TextXAlignment.Left
    NumberOf.ZIndex = -999999
    
    Import.Parent = PaintUI
    Import.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
    Import.Position = UDim2.new(0.354, 0, 0.234, 0)
    Import.Size = UDim2.new(0.288, 0, 0.163, 0)
    Import.Text = "Import"
    Import.TextColor3 = Color3.fromRGB(255, 255, 255)
    Import.TextScaled = true
    Import.ZIndex = -999999
    
    UICorner_3.CornerRadius = UDim.new(0.2, 0)
    UICorner_3.Parent = Import
    
    Export.Parent = PaintUI
    Export.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
    Export.Position = UDim2.new(0.684, 0, 0.234, 0)
    Export.Size = UDim2.new(0.288, 0, 0.163, 0)
    Export.Text = "Export"
    Export.TextColor3 = Color3.fromRGB(255, 255, 255)
    Export.TextScaled = true
    Export.ZIndex = -999999
    
    UICorner_4.CornerRadius = UDim.new(0.2, 0)
    UICorner_4.Parent = Export
    
    TextBox.Parent = PaintUI
    TextBox.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
    TextBox.Position = UDim2.new(0.363, 0, 0.460, 0)
    TextBox.Size = UDim2.new(0.618, 0, 0.312, 0)
    TextBox.MultiLine = true
    TextBox.PlaceholderText = "Creation Data"
    TextBox.Text = "0:29,0,39:0:1=3:2=9_0:29,0,40:0:1=3:2=9_0:29,0,41:0:1=3:2=9_0:29,0,38:0:1=3:2=9_0:30,0,38:0:1=3:2=9_0:30,0,40:0:1=3:2=9_0:30,0,42:0:1=3:2=9_0:29,0,42:0:1=3:2=9_0:31,0,42:0:1=3:2=9_0:31,0,40:0:1=3:2=9_0:31,0,38:0:1=3:2=9_0:27,0,42:0:1=0:2=12_0:27,0,41:0:1=0:2=12_0:27,0,40:0:1=0:2=12_0:27,0,39:0:1=0:2=12_0:27,0,38:0:1=0:2=12_0:25,0,38:0:1=0:2=12_0:25,0,39:0:1=0:2=12_0:25,0,40:0:1=0:2=12_0:25,0,41:0:1=0:2=12_0:25,0,42:0:1=0:2=12_0:26,0,40:0:1=0:2=12_0:33,0,38:0:1=2A,255,2A:2=3_0:33,0,39:0:1=2A,255,2A:2=3_0:33,0,40:0:1=2A,255,2A:2=3_0:33,0,41:0:1=2A,255,2A:2=3_0:33,0,42:0:1=2A,255,2A:2=3_0:34,0,42:0:1=2A,255,2A:2=3_0:35,0,42:0:1=2A,255,2A:2=3_0:37,0,38:0:1=2A,1A,2A_0:37,0,39:0:1=2A,1A,2A_0:37,0,40:0:1=2A,1A,2A_0:37,0,41:0:1=2A,1A,2A_0:38,0,42:0:1=2A,1A,2A_0:37,0,42:0:1=2A,1A,2A_0:39,0,42:0:1=2A,1A,2A_0:41,0,38:0:1=2A,2A,1A:2=6_0:41,0,39:0:1=2A,2A,1A:2=6_0:41,0,40:0:1=2A,2A,1A:2=6_0:41,0,41:0:1=2A,2A,1A:2=6_0:42,0,42:0:1=2A,2A,1A:2=6_0:41,0,42:0:1=2A,2A,1A:2=6_0:43,0,42:0:1=2A,2A,1A:2=6_0:43,0,41:0:1=2A,2A,1A:2=6_0:43,0,40:0:1=2A,2A,1A:2=6_0:43,0,39:0:1=2A,2A,1A:2=6_0:43,0,38:0:1=2A,2A,1A:2=6_0:42,0,38:0:1=2A,2A,1A:2=6"
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.TextWrapped = true
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    TextBox.TextYAlignment = Enum.TextYAlignment.Top
    TextBox.ZIndex = -999999
    
    UICorner_5.CornerRadius = UDim.new(0.12, 0)
    UICorner_5.Parent = TextBox
    
    Status.Parent = PaintUI
    Status.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Status.BackgroundTransparency = 1
    Status.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Status.BorderSizePixel = 0
    Status.Position = UDim2.new(0, 0, -0.248, 0)
    Status.Size = UDim2.new(1, 0, 0.15, 0)
    Status.Text = ""
    Status.TextColor3 = Color3.fromRGB(255, 255, 255)
    Status.TextScaled = true
    Status.TextStrokeTransparency = 0
    Status.ZIndex = -999999
    
    Paste.Parent = PaintUI
    Paste.BackgroundColor3 = Color3.fromRGB(16, 240, 68)
    Paste.Position = UDim2.new(0.0390, 0, 0.347, 0)
    Paste.Size = UDim2.new(0.288, 0, 0.205, 0)
    Paste.Text = "Paste"
    Paste.TextColor3 = Color3.fromRGB(0, 0, 0)
    Paste.TextScaled = true
    Paste.ZIndex = -999999
    
    UICorner_6.CornerRadius = UDim.new(0.12, 0)
    UICorner_6.Parent = Paste
    
    Speed.Parent = PaintUI
    Speed.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
    Speed.Position = UDim2.new(0.042, 0, 0.624, 0)
    Speed.Size = UDim2.new(0, 95, 0, 24)
    Speed.Text = "Speed: " .. RAM.SpeedBlockPlace
    Speed.TextColor3 = Color3.fromRGB(255, 255, 255)
    Speed.TextScaled = true
    Speed.ZIndex = -999999
    
    UICorner_7.CornerRadius = UDim.new(0.2, 0)
    UICorner_7.Parent = Speed

    UIPadding.Parent = Speed
    UIPadding.PaddingBottom = UDim.new(0.05, 0)
    UIPadding.PaddingLeft = UDim.new(0.1, 0)
    UIPadding.PaddingRight = UDim.new(0.1, 0)
    UIPadding.PaddingTop = UDim.new(0.05, 0)

    UIPadding_2.Parent = TextBox
    UIPadding_2.PaddingBottom = UDim.new(0.05, 0)
    UIPadding_2.PaddingLeft = UDim.new(0.025, 0)
    UIPadding_2.PaddingRight = UDim.new(0.025, 0)
    UIPadding_2.PaddingTop = UDim.new(0.05, 0)

    local sg = Instance.new("ScreenGui")
    CopyToolLasso.Size = UDim2.new(0, 0, 0, 0)
    CopyToolLasso.Position = UDim2.new(0.5, 0, 0.5, 0)
    CopyToolLasso.BackgroundTransparency = 0.75
    CopyToolLasso.BackgroundColor3 = Color3.new(0, 0, 1)
    CopyToolLasso.BorderSizePixel = 0
    CopyToolLasso.Parent = sg
    sg.Parent = game.CoreGui

    local oldValue = RAM.SpeedBlockPlace

    Speed.Focused:Connect(function()
        oldValue = RAM.SpeedBlockPlace
    end)
    Speed.FocusLost:Connect(function()
        local speed = tonumber(Speed.Text)
        if speed then
            speed = math.floor(math.clamp(speed, 1, 50))
            Speed.Text = "Speed: " .. speed
            RAM.SpeedBlockPlace = speed
        else
            Speed.Text = "Speed: " .. oldValue
        end
    end)

    local stopFunction 
    local permenant = ""

    return {
        Lasso = CopyToolLasso,
        ChangeStatus = function(text, time)
            Status.Text = text
            if time then
                if stopFunction then
                    stopFunction()
                end

                local t = true
                stopFunction = function()
                    t = false
                    stopFunction = nil
                end

                task.spawn(function()
                    wait(time)
                    if t then
                        stopFunction = nil
                        Status.Text = permenant
                    end
                end)
            end
        end,
        UpdateSelected = function()
            NumberOf.Text = "Blocks Selected: " .. #selectionService.CurrentSelection
        end,
        SetPerm = function(status)
            permenant = status
            if not stopFunction then
                Status.Text = permenant
            end
        end,    
        MainFrame = PaintUI,
        Import = Import,
        Export = Export,
        Box = TextBox,
        Copy = Copy,
        Paste = Paste,
    }
end)()
local MainUi = client.PlayerGui.MainGui

-- // set the values of the script tables
blocks = (function()
    local self = { Content = {}, DefaultConfigs = {} }
    local metadata = { __index = {
        CreateBlock = function(self, ObjectId)
            local BlockTable = self.Content[ObjectId]
            if BlockTable then
                local Block = BlockTable.Model:Clone()
                return Block
            end
        end,
        DefaultValueOf = function(self, ObjectId, Property)
            local BlockData = self.Content[ObjectId]
            if BlockData then
                return BlockData.DefaultConfigs[Property]
            end
        end,
        IsDefaultValue = function(self, ObjectId, Property, Value)
            return (self:DefaultValueOf(ObjectId, Property) == Value)
        end,
        FindBlockAt = function(self, Position, other)
            local Position = Position
            if not other then
               Position = clientBounds:GetAbsolutePosition(Position)
            end
            for _, block in ipairs(ClientCreation:GetChildren()) do
                if block:GetPivot().Position == Position then
                    return block
                end
            end
        end
    }}

    for _, block in ipairs(ObjectFolder:GetChildren()) do
        local ObjectId = block:GetAttribute("ObjectId")
        if ObjectId and block:FindFirstChild("Configuration") then
            local blockData = {
                Model = block,
                ObjectId = ObjectId,
                DefaultConfigs = {}
            }

            for _, config in ipairs(block.Configuration:GetChildren()) do
                local configName = config.Name
                local configValue = config.Value
                blockData.DefaultConfigs[configName] = configValue

                local customName = configName
                if not self.DefaultConfigs[customName] and customName == "ActivationKey"  then
                    self.DefaultConfigs[customName] = "KeyCode"
                elseif not self.DefaultConfigs[customName] and customName == "Material"  then
                    self.DefaultConfigs[customName] = "Material"
                elseif configValue ~= nil and not self.DefaultConfigs[customName] then
                    self.DefaultConfigs[customName] = typeof(configValue)
                elseif not self.DefaultConfigs[customName] then
                    if config.ClassName == "ObjectValue" then
                        self.DefaultConfigs[customName] = "Instance"
                    elseif config.ClassName == "NumberValue" then
                        self.DefaultConfigs[customName] = "number"
                    elseif config.ClassName == "BoolValue" then
                        self.DefaultConfigs[customName] = "boolean"
                    elseif config.ClassName == "StringValue" then
                        self.DefaultConfigs[customName] = "string"
                    elseif config.ClassName == "Color3Value" then
                        self.DefaultConfigs[customName] = "Color3"
                    end
                end
            end

            self.Content[ObjectId] = blockData
        end
    end

    setrawmetatable(self, metadata)
    return self
end)()

conversion = (function()
    local self
    self = {
        ["string"] = {
            Encode = tostring,
            Decode = tostring,
        }, ["number"] = {
            Encode = function(value)
                if string.len(tostring(value)) > 2 then
                    local split = tostring(value):split("")
                    local firstNum = table.remove(split, 1)
                    local rest = table.concat(split)
                    if rest == "00" then
                        return firstNum .. "A"
                    elseif rest == "000" then
                        return firstNum .. "B"
                    elseif rest == "0000" then
                        return firstNum .. "C"
                    elseif rest == "00000" then
                        return firstNum .. "D"
                    end
                end

                return tostring(value)
            end,
            Decode = function(value)
                local number = tonumber(value)
                if not number then
                    local firstNum = tonumber(string.sub(value, 1, 1))
                    local rest = string.sub(value, 2)
                    if rest == "A" then
                        return firstNum * 100
                    elseif rest == "B" then
                        return firstNum * 1000
                    elseif rest == "C" then
                        return firstNum * 10000
                    elseif rest == "D" then
                        return firstNum * 100000
                    end
                else
                    return number 
                end
            end,
        }, ["boolean"] = {
            Encode = function(value)
                return value and "t" or "f"
            end,
            Decode = function(value)
                return value == "t"
            end,
        }, ["Vector3"] = {
            Encode = function(value)
                local x = self:EncodeValue("number", value.X, true)
                local y = self:EncodeValue("number", value.Y, true)
                local z = self:EncodeValue("number", value.Z, true)

                return string.format("%s,%s,%s", x, y, z)
            end,
            Decode = function(value)
                local x, y, z = table.unpack(string.split(value, ","))

                return Vector3.new(
                    self:DecodeValue("number", x),
                    self:DecodeValue("number", y),
                    self:DecodeValue("number", z)
                )
            end,
        }, ["Color3"] = {
            Encode = function(value)
                local r = math.floor(value.R * 255)
                local g = math.floor(value.G * 255)
                local b = math.floor(value.B * 255)
                if r == 0 and g == 0 and b == 0 then
                    return "0"
                elseif r == 255 and g == 255 and b == 255 then
                    return "1"
                elseif r == 255 and g == 0 and b == 0 then
                    return "2"
                elseif r == 0 and g == 255 and b == 0 then
                    return "3"
                elseif r == 0 and g == 0 and b == 255 then
                    return "4"
                end

                r = self:EncodeValue("number", r, true)
                g = self:EncodeValue("number", g, true)
                b = self:EncodeValue("number", b, true)

                return string.format('%s,%s,%s', r, g, b)
            end,
            Decode = function(value)
                if value == "0" then
                    return Color3.new(0, 0, 0)
                elseif value == "1" then
                    return Color3.new(1, 1, 1)
                elseif value == "2" then
                    return Color3.new(1, 0, 0)
                elseif value == "3" then
                    return Color3.new(0, 1, 0)
                elseif value == "4" then
                    return Color3.new(0, 0, 1)
                end
                local r, g, b = table.unpack(string.split(value, ","))

                r = self:DecodeValue("number", r)
                g = self:DecodeValue("number", g)
                b = self:DecodeValue("number", b)

                return Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
            end,
        }, ["Instance"] = {
            Encode = function(value)
                local ObjectId = value:GetAttribute("ObjectId")
                local pivot = value:GetPivot()
                local Position = self:EncodeValue("Vector3", clientBounds:GetRelativePosition(pivot.Position), true)
                local Rotation = CorrectDegrees(RadiansToVector3(pivot:ToOrientation()))
                Rotation = self:EncodeValue("Rotation", Rotation, true)

                return tostring(ObjectId) .. '*' .. Position .. '*' .. Rotation
            end,
            Decode = function(value)
                local ObjectId, Position, Rotation = table.unpack(string.split(value, "*"))
                local tempPosition = clientBounds:GetAbsolutePosition(Vector3.new(table.unpack(string.split(Position, ","))))
                local tempRotation = self:DecodeValue("Rotation", Rotation)

                return {
                    ObjectId = tonumber(ObjectId),
                    Position = tempPosition,
                    Rotation = tempRotation
                }
            end
        }, ["KeyCode"] = {
            Encode = function(value)
                return self:KeyCodeToNumber(value)
            end,
            Decode = function(value)
                return self:NumberToKeyCode(value)
            end
        }, ["Material"] = {
            Encode = function(value)
                return self:MaterialToNumber(value)
            end,
            Decode = function(value)
                return self:NumberToMaterial(value)
            end
        }, ["Rotation"] = {
            Encode = function(value)
                local x = value.X / 90
                local y = value.Y / 90
                local z = value.Z / 90

                if x == y and y == z then
                    return tostring(x)
                end

                return string.format('%d,%d,%d', x, y, z)
            end,
            Decode = function(value)
                if string.len(value) < 3 and tonumber(value) then
                    local num = tonumber(value) * 90
                    return Vector3.new(num, num, num)
                end

                local x, y, z = table.unpack(string.split(value, ","))
                return Vector3.new(x * 90, y * 90, z * 90)
            end
        }
    }
    local metadata = { __index = {
        EncodeValue = function(self, Key, Value, check)
            local Key = Key
            if check == nil then
                Key = valueCodes:GetConfigValueType(Key)
            end
            return self[Key].Encode(Value)
        end,
        DecodeValue = function(self, Key, Value)
            return self[Key].Decode(Value)
        end,
        ENUM_MATERIALS = ENUM_MATERIALS,
        ENUM_KEYCODES = ENUM_KEYCODES,
        reverseMaterials = {},
        reverseKeyCodes = {},
        NumberToMaterial = function(self, Number)
            return self.ENUM_MATERIALS[tonumber(Number)]
        end,
        NumberToKeyCode = function(self, Number)
            return self.ENUM_KEYCODES[tonumber(Number)]
        end,
        MaterialToNumber = function(self, Material)
            return self.reverseMaterials[tostring(Material)]
        end,
        KeyCodeToNumber = function(self, KeyCode)
            return self.reverseKeyCodes[tostring(KeyCode)]
        end,
    }}

    setrawmetatable(self, metadata)

    for number, material in pairs(ENUM_MATERIALS) do
        self.reverseMaterials[tostring(material)] = number
    end
    for number, keyCode in pairs(ENUM_KEYCODES) do
        self.reverseKeyCodes[tostring(keyCode)] = number
    end

    return self
end)()

valueCodes = (function()
    local self = { ReverseTypesTable = {}, ReverseConfigurationsTable = {} }
    local metadata = { __index = {
        GetNumFromConfig = function(self, Config)
            return VALUES_CONFIGURATIONS_CONSTANTS[Config]
        end,
        GetConfigFromNum = function(self, Value)
            return self.ReverseConfigurationsTable[Value]
        end,
        GetNumFromType = function(self, Type)
            return VALUES_TYPES_CONSTANTS[Type]
        end,
        GetTypeFromNum = function(self, Value)
            return self.ReverseTypesTable[Value]
        end,
        GetConfigValueType = function(self, Config)
            return blocks.DefaultConfigs[Config]
        end
    }}

    for Key, Value in pairs(VALUES_TYPES_CONSTANTS) do self.ReverseTypesTable[Value] = Key end
    for Key, Value in pairs(VALUES_CONFIGURATIONS_CONSTANTS) do self.ReverseConfigurationsTable[Value] = Key end

    setrawmetatable(self, metadata)
    return self
end)()

actionService = (function()
    local self = {}

    userInput.InputBegan:Connect(function(input)
        local keyCode = input.KeyCode
        for _, action in pairs(self) do
            if action.KeyCode == keyCode then
                task.spawn(function()
                    action.callback()
                end)
            end
        end
    end)

    local metadata = { __index = {
        Bind = function(self, actionName, callback, KeyCode)
            self[actionName] = {
                callback = callback,
                KeyCode = KeyCode
            }
        end,
        Unbind = function(self, actionName)
            self[actionName] = nil
        end
    }}

    setrawmetatable(self, metadata)
    return self
end)()

selectionService = (function()
    local self = { CurrentSelection = {} }

    SelectionHighlight = (function()
        if not camera:FindFirstChild("SelectionHighlight") then
            local folder = Instance.new("Folder")
            folder.Name = "SelectionHighlight"
            folder.Parent = camera
            return folder
        else
            return camera.SelectionHighlight
        end
    end)()

    local metadata = { __index = {
        NewSelection = function(self)
            self:ClearHighlights()
            self.CurrentSelection = {}
            self:AddToSelection()
        end,
        AddToSelection = function(self)
            local MouseStart = RAM.MouseInfo.Start
            local MouseEnd = RAM.MouseInfo.End

            local Point1 = Vector2.new(math.min(MouseStart.X, MouseEnd.X), math.min(MouseStart.Y, MouseEnd.Y))
            local Point2 = Vector2.new(math.max(MouseStart.X, MouseEnd.X), math.max(MouseStart.Y, MouseEnd.Y))

            local Relative, X, Y
            for _, Object in ipairs(ClientCreation:GetChildren()) do
                local ObjectId = Object:GetAttribute("ObjectId")
                if ObjectId and Object:IsA("Model") and not table.find(self.CurrentSelection, Object) then
                    local WorldPosition = Object:GetPivot().Position
        
                    Relative = camera.CoordinateFrame:pointToObjectSpace(WorldPosition)
                    X, Y = Relative.x / -Relative.z, Relative.y / -Relative.z
                    
                    if Point1.x < X and X < Point2.x and Point1.y < Y and Y < Point2.y and Relative.z < 0 then
                        table.insert(self.CurrentSelection, Object)
                        self:HighlightBlock(Object)
                    end
                end
            end

            GUI.UpdateSelected()
        end,
        HighlightCurrentSelection = function(self)
            for _, Object in ipairs(self.CurrentSelection) do
                self:HighlightBlock(Object)
            end
        end,
        HighlightBlock = function(self, Block)
            if Block:GetAttribute("ObjectId") ~= 10 and not Block:GetAttribute("Highlight") then
                Block:SetAttribute("Highlight", true)

                local BlockSize = Block:GetExtentsSize()
                local BlockCFrame = Block:GetBoundingBox()
    
                local HighlightBlock = Instance.new("Part")
                HighlightBlock.Size = BlockSize
                HighlightBlock.CFrame = BlockCFrame
                HighlightBlock.Anchored = true
                HighlightBlock.CanCollide = false
                HighlightBlock.Transparency = 0.75
                HighlightBlock.Color = Color3.new(0, 0, 1)
                HighlightBlock.Parent = SelectionHighlight
                local ObjectValue = Instance.new("ObjectValue")
                ObjectValue.Name = "ParentedTo"
                ObjectValue.Value = Block
                ObjectValue.Parent = HighlightBlock
            end
        end,
        HighlightHovered = function(self)
            local block = self:GetCurrentHoveredObject()
            if block then
                if block:GetAttribute("Highlight") then
                    for _, Highlight in ipairs(SelectionHighlight:GetChildren()) do
                        if Highlight.ParentedTo.Value == block then
                            block:SetAttribute("Highlight", false)
                            Highlight:Destroy()
                            break
                        end
                    end
                    local pos = table.find(self.CurrentSelection, block)
                    if pos then
                        table.remove(self.CurrentSelection, pos)
                    end
                else
                    self:HighlightBlock(block)
                    table.insert(self.CurrentSelection, block)
                end
            end
        end,
        GetCurrentHoveredObject = function(self)
            return MainUi.Values.TargetObject.Value
        end,
        ClearHighlights = function(self, ignore)
            if not ignore then
                for _, Block in ipairs(ClientCreation:GetChildren()) do
                    Block:SetAttribute("Highlight", false)
                end
            end
            for _, Highlight in ipairs(SelectionHighlight:GetChildren()) do
                Highlight:Destroy()
            end
        end,
    }}

    setrawmetatable(self, metadata)
    return self
end)()

modelService = (function()
    local TweenService = game:GetService("TweenService")

    local self = { 
        ShowingModel = false, 
        UpdatePosition = true, 
        ModelData = {}, 
        Rotation = CFrame.fromEulerAnglesXYZ(0,0,0),
        Offset = 0,
        SavedBlocks = {},
    }

    ModelPreview = (function()
        if not camera:FindFirstChild("ModelPreview") then
            local Model = Instance.new("Model")
            Model.Name = "ModelPreview"
            Model.Parent = camera
            return Model
        else
            return camera.ModelPreview
        end
    end)()

    local PrimaryPart = Instance.new("Part")
    PrimaryPart.Name = "PrimaryPart"
    PrimaryPart.CanCollide = false
    PrimaryPart.Anchored = true
    PrimaryPart.Transparency = 0.80
    PrimaryPart.Size = Vector3.new(0,0,0)
    PrimaryPart.Parent = ModelPreview

    ModelPreview.PrimaryPart = PrimaryPart

    local metadata = { __index = {
        CurrentTween = {},
        ClearTween = function(self)
            if self.CurrentTween.Tween then
                self.CurrentTween.Tween:Pause()
                pcall(function()
                    self.CurrentTween.CFrameValue:Destroy()
                end)
                pcall(function()
                    self.CurrentTween.Connection:Disconnect()
                end)
            end
            self.CurrentTween = {}
        end,
        SetModelCFrame = function(self, CF)
            if ModelPreview.PrimaryPart and PrimaryPart then
                self:ClearTween()
                local current = self.CurrentTween
                current.ObjectiveCFrame = CF

                current.CFrameValue = Instance.new("CFrameValue")
                current.CFrameValue.Value = PrimaryPart.CFrame

                current.Connection = current.CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
                    if ModelPreview and ModelPreview.PrimaryPart then
                        ModelPreview:PivotTo(current.CFrameValue.Value)
                    else
                        self:ClearTween()
                    end
                end)

                current.Tween = TweenService:Create(current.CFrameValue, TweenInfo.new(0.1), {Value = CF})
                current.Tween:Play()
            end
        end,
        AddBlock = function(self, ObjectData)
            if ObjectData.ObjectId == 10 then
                return 
            end
            local block = blocks:CreateBlock(ObjectData.ObjectId)
            block.Parent = ModelPreview
            return self:ConfigureBlock(block, ObjectData)
        end,
        RotateAxis = function(self, axis)
            local modifier = axis == "X" and CFrame.fromEulerAnglesXYZ(-math.pi/2,0,0)
            or axis == "Y" and CFrame.fromEulerAnglesXYZ(0,math.pi/2,0)
            or axis == "Z" and CFrame.fromEulerAnglesXYZ(0,0,-math.pi/2)
            
            self.Rotation = modifier * self.Rotation
        end,
        ConfigureBlock = function(self, Block, BlockData)
            local WorldPosition = clientBounds:GetAbsolutePosition(BlockData.Position)

            local angle = CFrame.fromEulerAnglesYXZ(Vector3ToRadians(BlockData.Rotation))
            local WorldCFrame = CFrame.new(WorldPosition) * angle

            local Primary = Instance.new("Part")
            Primary.CanCollide = false
            Primary.Anchored = true
            Primary.Transparency = 1
            Primary.CFrame = WorldCFrame
            Primary.Name = "_SKIP_"

            if #BlockData.Paint > 0 then
                local Color, Material
                for _, data in ipairs(BlockData.Paint) do
                    if data.valueName == "Color" then
                        Color = data.value
                    elseif data.valueName == "Material" then
                        Material = data.value
                    end
                end

                for _, Part in ipairs(Block:GetDescendants()) do
                    if Part:GetAttribute("ApplyColor") and Color then
                        Part.Color = Color
                    end
                    if Part:GetAttribute("ApplyMaterial") and Material then
                        Part.Material = Material
                    end
                end
            end

            for _, Config in ipairs(BlockData.Configurations) do
                local configName = Config.valueName
                local configValue = Config.value

                pcall(function()
                    Block.Configuration[configName].Value = configValue
                end)
            end

            Block:PivotTo(WorldCFrame)

            if Block:FindFirstChild("SettingsModule") then
                require(Block.SettingsModule).run()
            end

            local BlockSize = Block:GetExtentsSize()
            BlockSize =  Vector3.new(math.max(2, round(BlockSize.X / 2) * 2), math.max(2, round(BlockSize.Y / 2) * 2), math.max(2, round(BlockSize.Z / 2) * 2))
            local x = BlockSize.X
            local y = BlockSize.Y
            local z = BlockSize.Z
            if (x / 2) % 2 == 0 then
                x = x + 2
            end
            if (y / 2) % 2 == 0 then
                y = y + 2
            end
            if (z / 2) % 2 == 0 then
                z = z + 2
            end
            BlockSize = Vector3.new(x, y, z)
            Primary.Size = BlockSize

            Primary.Parent = Block
            Block.PrimaryPart = Primary
            Block.Parent = ModelPreview

            Block:SetAttribute("OriginalPosition", WorldPosition)
            Block:SetAttribute("OriginalRotation", BlockData.Rotation)

            return Block
        end,
        ConfigureBlockForModel = function(self, Block)
            for _, Part in ipairs(Block:GetDescendants()) do
                if Part:IsA("BasePart") then
                    Part.Transparency = Part.Transparency + 0.25
                    Part.CanCollide = false
                end
            end
        end,
        ClearModel = function(self)
            if ModelPreview then
                self:ClearTween()
                ModelPreview:Destroy()
                ModelPreview = nil
                PrimaryPart = nil
                self.SavedBlocks = {}
            end
        end,
        CreateModel = function(self, SaveData)
            self.UpdatePosition = false
            self:ClearModel()
            
            ModelPreview = Instance.new("Model")
            ModelPreview.Name = "ModelPreview"

            PrimaryPart = Instance.new("Part")
            PrimaryPart.Name = "PrimaryPart"
            PrimaryPart.Anchored = true
            PrimaryPart.CanCollide = false

            for _, BlockData in ipairs(SaveData) do
                local block = self:AddBlock(BlockData)
                if block then
                    table.insert(self.SavedBlocks, {
                        Block = block,
                        Data = BlockData
                    })

                    self:ConfigureBlockForModel(block)
                end
            end

            local Position, Size = ModelPreview:GetPivot(), ModelPreview:GetExtentsSize()
            Size = Vector3.new(round(Size.X / 2) * 2, round(Size.Y / 2) * 2, round(Size.Z / 2) * 2)
            Position = CFrame.new(round(Position.X), round(Position.Y), round(Position.Z)) * CFrame.fromEulerAnglesYXZ(Position:ToOrientation())

            PrimaryPart.Size = Size
            PrimaryPart.CFrame = Position
            ModelPreview.Parent = camera
            PrimaryPart.Parent = ModelPreview
            ModelPreview.PrimaryPart = PrimaryPart

            self.UpdatePosition = true
        end,
        GetSaveData = function(self)
            if ModelPreview and RAM.CopyTool and RAM.Placing then
                if self.CurrentTween and self.CurrentTween.ObjectiveCFrame then
                    local target = self.CurrentTween.ObjectiveCFrame
                    self:ClearTween()
                    ModelPreview:SetPrimaryPartCFrame(target)
                end
                local data = copyService:GenerateSaveTable(ModelPreview:GetChildren(), true, reserve(self.SavedBlocks))
                return data
            end
        end
    }}  

    setrawmetatable(self, metadata)

    runservice.Heartbeat:Connect(function()
        if not ModelPreview or not RAM.CopyTool or not ModelPreview.PrimaryPart then return end
        if #ModelPreview:GetChildren() > 0 then
            self.ShowingModel = true
            PrimaryPart.Transparency = 0.80
        else
            self.ShowingModel = false
            PrimaryPart.Transparency = 1
        end

        if self.UpdatePosition and self.ShowingModel then
            local mousePosition = getMousePoint()
            if mousePosition then
                local BoundBox = clientBounds.BoundaryBox
                local boundaryCFrame = BoundBox.CFrame
                local boundarySize = BoundBox.Size
                -------------------------------------------------
                local rotatedModelSize=self.Rotation*PrimaryPart.Size
                rotatedModelSize=Vector3.new(math.abs(rotatedModelSize.X),math.abs(rotatedModelSize.Y),math.abs(rotatedModelSize.Z))
        
                local halfSize=(boundarySize-rotatedModelSize)/2
                local localPosition=boundaryCFrame:PointToObjectSpace(mousePosition)

                local x=math.clamp(localPosition.X,-halfSize.X,halfSize.X)
                local z=math.clamp(localPosition.Z,-halfSize.Z,halfSize.Z)
                
                x=math.sign(x)*((math.abs(x)-math.abs(x)%2)+(halfSize.X%2))
                z=math.sign(z)*((math.abs(z)-math.abs(z)%2)+(halfSize.Z%2))

                local finalCFrame=boundaryCFrame*CFrame.new(x,-boundarySize.Y/2+rotatedModelSize.Y/2+self.Offset,z)*self.Rotation

                self:SetModelCFrame(finalCFrame)
            end
        end
    end)

    return self
end)()

clientBounds = (function()
    local self = {}

    local clientBoundary
    for _, playerBound in ipairs(workspace.Boundaries:GetChildren()) do
        if playerBound:FindFirstChild("Owner") and playerBound.Owner.Value then
            if playerBound.Owner.Value == client then
                clientBoundary = playerBound
                break
            end
        end
    end

    self.BoundaryBox = clientBoundary
    local tempSize = clientBoundary.Size / 2
    local tempPosition = clientBoundary.Position - tempSize
    self.ZeroZero = tempPosition + Vector3.new(1, 1, 1)
    self.Max = self.ZeroZero + Vector3.new(252, 504, 252)
    self.Min = self.ZeroZero

    local metadata = { __index = {
        GetRelativePosition = function(self, Position)
            local tempPosition = Position - self.ZeroZero

            return tempPosition / 2
        end,
        GetAbsolutePosition = function(self, Position)
            local tempPosition = Position * 2

            return tempPosition + self.ZeroZero
        end,
        GetPartAt = function(self, Position, FindId)
            local WorldPos = self:GetAbsolutePosition(Position)

            for _, Object in ipairs(ClientCreation:GetChildren()) do
                local ObjectId = Object:GetAttribute("ObjectId")
                if ObjectId and Object:IsA("Model") and (not FindId or (FindId == ObjectId)) then
                    local WorldPosition = Object:GetPivot().Position
                   
                    if WorldPosition == WorldPos then
                        return Object
                    end
                end
            end
        end,
    }}
    
    setrawmetatable(self, metadata)
    return self
end)()

copyService = (function()
    local self = { CurrentSaveTable = {}}
    local metadata = { __index = {
        GenerateSaveTable = function(self, Selection, returnData, mergeData)
            if returnData == nil then
                self.CurrentSaveTable = {}
            end

            local findFromMergeData = function(block)
                if not mergeData then
                    return false
                end

                for _, data in ipairs(mergeData) do
                    if data.Block == block then
                        return data.Data
                    end
                end
            end

            local selection = Selection or selectionService.CurrentSelection
            local saveData = returnData and {} or self.CurrentSaveTable
            
            for _, Object in ipairs(selection) do
                if not Object or not Object.Parent then return end
                local ObjectId = Object:GetAttribute("ObjectId")
                if ObjectId then
                    local ObjectData = { 
                        ObjectId = ObjectId, 
                        Position = clientBounds:GetRelativePosition(Object:GetPivot().Position), 
                        Rotation = CorrectDegrees(RadiansToVector3(Object:GetPivot():ToOrientation())),
                        Configurations = {},
                        Paint = {},
                    }

                    local merge = findFromMergeData(Object)
                    if merge then
                        ObjectData.Configurations = reserve(merge.Configurations)
                        ObjectData.Paint = reserve(merge.Paint)
                    else
                        for _, Configuration in ipairs(Object.Configuration:GetChildren()) do
                            local configData = { valueName = Configuration.Name }
                            local configName = configData.valueName
                            local configValue = Configuration.Value
    
                            if configValue ~= nil and not blocks:IsDefaultValue(ObjectId, configName, configValue) then
                                configData.value = configValue
                            end
    
                            if table.find({ "Color", "Material"}, configName) and configValue ~= nil then
                                table.insert(ObjectData.Paint, configData)
                            end
                            if not blocks:IsDefaultValue(ObjectId, configName, configValue) then
                                table.insert(ObjectData.Configurations, configData)
                            end
                        end
                    end

                    if Object:GetAttribute("OriginalPosition") then
                        ObjectData.OriginalPosition = Object:GetAttribute("OriginalPosition")
                    else
                        ObjectData.OriginalPosition = Object:GetPivot().Position
                    end

                    if Object:GetAttribute("OriginalRotation") then
                        ObjectData.OriginalRotation = Object:GetAttribute("OriginalRotation")
                    else
                        ObjectData.OriginalRotation = CorrectDegrees(RadiansToVector3(Object:GetPivot():ToOrientation()))
                    end

                    table.insert(saveData, ObjectData)
                end
            end

            if returnData then
                return saveData
            end
        end,
    }}

    setrawmetatable(self, metadata)
    return self
end)()

stringService = (function()
    local self = {}
    local metadata = { __index = {
        GenerateString = function(self)
            local SaveData = copyService.CurrentSaveTable
            local OutputTable = {}

            local success, err = pcall(function()
                for _, ObjectData in ipairs(SaveData) do
                    local ObjectString = ObjectData.ObjectId

                    ObjectString = ObjectString..":".. conversion:EncodeValue("Vector3", ObjectData.Position, true)
                    ObjectString = ObjectString..":".. conversion:EncodeValue("Rotation", ObjectData.Rotation, true)

                    for _, ConfigData in ipairs(ObjectData.Configurations) do
                        local ConfigurationName = ConfigData.valueName
                        local ConfigurationValue = ConfigData.value

                        if ConfigurationValue ~= nil then
                            local EncodedConfigurationString = ("%d=%s"):format(valueCodes:GetNumFromConfig(ConfigurationName), conversion:EncodeValue(ConfigurationName, ConfigurationValue))
                            ObjectString = ObjectString .. ":" .. EncodedConfigurationString
                        end
                    end

                    table.insert(OutputTable, ObjectString)
                end
            end)

            local returnee = {success and #OutputTable > 0 and table.concat(OutputTable, "_") or false, err}

            return table.unpack(returnee)
        end,
        ReadString = function(self, String)
            local DecodedObjectsData = {}

            local success, err = pcall(function()
                for _, CurrentDataBlockString in ipairs(String:split("_")) do
                    local CurrentObjectData = {}

                    local CurrentDataBlockValues = string.split(CurrentDataBlockString, ":")

                    CurrentObjectData.ObjectId = tonumber(table.remove(CurrentDataBlockValues, 1))
                    CurrentObjectData.Position = conversion:DecodeValue("Vector3", table.remove(CurrentDataBlockValues, 1))
                    CurrentObjectData.Rotation = conversion:DecodeValue("Rotation", table.remove(CurrentDataBlockValues, 1))
                    CurrentObjectData.OriginalPosition = CurrentObjectData.Position
                    CurrentObjectData.OriginalRotation = CurrentObjectData.Rotation

                    CurrentObjectData.Configurations = {}
                    CurrentObjectData.Paint = {}

                    while #CurrentDataBlockValues > 0 do
                        local ConfigurationNumber, ConfigurationValueString = string.match(table.remove(CurrentDataBlockValues, 1), "(%w+)=(.+)")
                        if ConfigurationNumber ~= "" and ConfigurationValueString ~= "" then
                            local ConfigurationType = valueCodes:GetConfigFromNum(tonumber(ConfigurationNumber))
                            local ConfigurationValue = conversion:DecodeValue(valueCodes:GetConfigValueType(ConfigurationType), ConfigurationValueString)

                            local ConfigData = { valueName = ConfigurationType }
                            if ConfigurationValue ~= nil then
                                ConfigData.value = ConfigurationValue
                            end

                            if table.find({ "Color", "Material"}, ConfigurationType) then
                                table.insert(CurrentObjectData.Paint, ConfigData)
                            end
                            table.insert(CurrentObjectData.Configurations, ConfigData)
                        end
                    end

                    table.insert(DecodedObjectsData, CurrentObjectData)
                end
            end)

            local returnee = { success and DecodedObjectsData or false, err}

            return table.unpack(returnee)
        end
    }}

    setrawmetatable(self, metadata)
    return self
end)()

pasteService = (function()
    local self = { Events = {}, PlacedBlocks = {}, blockPlaceCount = 0 }

    workspace.Creations.DescendantAdded:Connect(function(Child)
        if Child.Parent == ClientCreation then
            local name = tostring(Child:GetPivot().Position)
            if self.Events[name] then
                self.Events[name]:Fire(Child)
                self.Events[name] = nil
            end
        end
    end)

    local metadata = { __index = {
        WaitForChildAdd = function(self, Position, func, lastBlock)
            self.blockPlaceCount = self.blockPlaceCount >= RAM.SpeedBlockPlace and 0 or self.blockPlaceCount + 1
            local WaitForBlock = self.blockPlaceCount == 0

            local Event = Instance.new("BindableEvent")
            self.Events[tostring(Position)] = Event

            if WaitForBlock or lastBlock then
                local block = Event.Event:Wait()
                func(block)
            else
                task.spawn(function()
                    local block = Event.Event:Wait()
                    func(block)
                end)
            end

            if lastBlock then
                self.blockPlaceCount = 0
            end
        end,
        PlaceBlock = function(self, BlockData, func, lastBlock)
            local BlockId = BlockData.ObjectId
            local TP = clientBounds:GetAbsolutePosition(BlockData.Position)
            local BlockPosition = Vector3.new(round(TP.X), round(TP.Y), round(TP.Z))
            local BlockRotation = BlockData.Rotation

            if not clientBounds:GetPartAt(BlockData.Position) then
                build:FireServer(BlockId, BlockPosition, BlockRotation) 

                self:WaitForChildAdd(BlockPosition, func, lastBlock)
            else
                return false
            end
        end,
        ConfigureBlock = function(self, Block, BlockData)
            local isDefault = true

            for index, ConfigData in ipairs(BlockData.Configurations) do
                local ConfigurationValue = ConfigData.value

                if ConfigurationValue ~= nil and typeof(ConfigurationValue) == "table" then
                    local pivot = CFrame.new(ConfigurationValue.Position) * CFrame.Angles(Vector3ToRadians(ConfigurationValue.Rotation))

                    local angle = CFrame.Angles(Vector3ToRadians(BlockData.OriginalRotation))
                    local OriginalCFrame = CFrame.new(BlockData.OriginalPosition) * angle
                    local Offset = OriginalCFrame:ToObjectSpace(pivot)
                    local BlockPosition = (Block:GetPivot() * Offset)
                    BlockPosition = Vector3.new(round(BlockPosition.X), round(BlockPosition.Y), round(BlockPosition.Z))

                    local block = blocks:FindBlockAt(BlockPosition, true)
                    if block and block:GetAttribute("ObjectId") == ConfigurationValue.ObjectId then
                        BlockData.Configurations[index].value = block
                    else
                        block = blocks:FindBlockAt(pivot.Position, true)
                        if block and block:GetAttribute("ObjectId") == ConfigurationValue.ObjectId then
                            BlockData.Configurations[index].value = block
                        end
                    end
                elseif ConfigurationValue ~= nil and typeof(ConfigurationValue) == "Instance" then
                    local angle = CFrame.Angles(Vector3ToRadians(BlockData.OriginalRotation))
                    local OriginalCFrame = CFrame.new(BlockData.OriginalPosition) * angle
                    local Offset = OriginalCFrame:ToObjectSpace(ConfigurationValue:GetPivot())
                    local BlockPosition = (Block:GetPivot() * Offset)
                    BlockPosition = Vector3.new(round(BlockPosition.X), round(BlockPosition.Y), round(BlockPosition.Z))

                    local block = blocks:FindBlockAt(BlockPosition, true)
                    if block and block:GetAttribute("ObjectId") == ConfigurationValue:GetAttribute("ObjectId") then
                        BlockData.Configurations[index].value = block
                    end
                elseif ConfigurationValue ~= nil then
                    BlockData.Configurations[index].value = ConfigurationValue
                end

                if isDefault and not blocks:IsDefaultValue(BlockData.ObjectId, ConfigData.valueName, ConfigurationValue) then
                    isDefault = false
                end
            end

            if not isDefault then
                configure:FireServer(BlockData.Configurations, Block)
            end

            Block:SetAttribute("OriginalPosition", nil)
            Block:SetAttribute("OriginalRotation", nil)
        end,
        PasteData = function(self, PastingData)
            self.PlacedBlocks = {}

            for index, BlockData in ipairs(PastingData) do
                self:PlaceBlock(BlockData, function(Block)
                    table.insert(self.PlacedBlocks, { Block = Block, BlockData = BlockData })
                end, index == #PastingData)
                GUI.ChangeStatus("" .. #self.PlacedBlocks .. "/" .. #PastingData .. " Blocks pasted")
            end

            for _, Block in ipairs(self.PlacedBlocks) do
                self:ConfigureBlock(Block.Block, Block.BlockData)
            end

            GUI.ChangeStatus("Pasted " .. #self.PlacedBlocks .. " blocks.", 2)
            GUI.SetPerm("Copying")
        end,
    }}

    setrawmetatable(self, metadata)
    return self
end)()

RadiansToVector3 = function(x, y, z)
    return Vector3.new(round(math.deg(x)), round(math.deg(y)), round(math.deg(z)))
end
Vector3ToRadians = function(Vector)
    return math.rad(Vector.X), math.rad(Vector.Y), math.rad(Vector.Z)
end

round = function(v)
    return math.floor(v + 0.5)
end

reserve = function(t)
    if t and typeof(t) == 'table' then
        local r = {}

        for index, value in pairs(t) do
            r[index] = reserve(value)
        end

        return r
    else
        return t
    end
end

CorrectDegrees = function(v)
    local X = v.X
    local Y = v.Y
    local Z = v.Z

    if X == 360 or X == -360 then
        X = 0
    end
    if Y == 360 or Y == -360 then
        Y = 0
    end
    if Z == 360 or Z == -360 then
        Z = 0
    end

    X = math.floor(X / 90) * 90
    Y = math.floor(Y / 90) * 90
    Z = math.floor(Z / 90) * 90

    return Vector3.new(X,Y,Z)
end

getMousePoint = function(v)
    local direction = mouse.UnitRay.Direction
    local distance = 2000
    local origin = mouse.UnitRay.Origin

    local raycastParams = RaycastParams.new()
    if not v then
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = { camera, ModelPreview, client.Character, ClientCreation }
    end

    local ray = workspace:Raycast(origin, (direction * distance), raycastParams)
    if ray and not v then
        return ray.Position
    elseif ray then
        return ray.Instance
    end
end

mouse.Button1Down:Connect(function()
    if RAM.CopyTool and not RAM.Placing then
        RAM.Selecting = true

        local Relative = camera.CoordinateFrame:pointToObjectSpace(mouse.Hit.p)
        RAM.MouseInfo.Start = Vector2.new(Relative.x / -Relative.z, Relative.y / -Relative.z)
        
        RAM.MouseInfo.X = mouse.X
        RAM.MouseInfo.Y = mouse.Y
    elseif RAM.CopyTool and RAM.Placing then
        local data = modelService:GetSaveData()
        if data then
            modelService:ClearModel()
            pasteService:PasteData(data)
        end
        RAM.Placing = false
    end
end)

mouse.Move:Connect(function()
    if not RAM.Placing and RAM.Selecting and RAM.MouseInfo.X and RAM.MouseInfo.Y then
        GUI.Lasso.Size = UDim2.new(0, mouse.X - RAM.MouseInfo.X, 0, mouse.Y - RAM.MouseInfo.Y)
        GUI.Lasso.Position = UDim2.new(0, RAM.MouseInfo.X, 0, RAM.MouseInfo.Y)
    end
    GUI.Lasso.Visible = RAM.CopyTool and RAM.Selecting
end)

mouse.Button1Up:Connect(function()
    if RAM.CopyTool and RAM.Selecting then
        RAM.Selecting = false

        local Relative = camera.CoordinateFrame:pointToObjectSpace(mouse.Hit.p)
        RAM.MouseInfo.End = Vector2.new(Relative.x / -Relative.z, Relative.y / -Relative.z)
        
        if userInput:IsKeyDown(Enum.KeyCode.LeftShift) then
            local before = #selectionService.CurrentSelection
            selectionService:AddToSelection()
            if #selectionService.CurrentSelection == before then
                selectionService:HighlightHovered()
            end
        else
            selectionService:NewSelection()
        end
        GUI.UpdateSelected()
    end
    RAM.Selecting = false

    RAM.MouseInfo.X = nil
    RAM.MouseInfo.Y = nil

    GUI.Lasso.Visible = false
end)

-- // main part of script

actionService:Bind('1CopyToolShowGui_', function()
    RAM.CopyTool = not RAM.CopyTool
    GUI.MainFrame.Visible = RAM.CopyTool

    GUI.SetPerm("")
    if RAM.CopyTool then
        selectionService:HighlightCurrentSelection()
        if RAM.Placing then
            GUI.SetPerm("Pasting")

            RAM.Selecting = false
            if ModelPreview then
                ModelPreview.Parent = camera
            else
                modelService:CreateModel(copyService.CurrentSaveTable)
            end
        else
            GUI.SetPerm("Copying")
        end
    else
        RAM.Selecting = false
        selectionService:ClearHighlights()
        if ModelPreview then
            ModelPreview.Parent = nil
        end
    end
end, Enum.KeyCode.Six)

local PasteFunction = function()
    if RAM.CopyTool then
        RAM.Placing = not RAM.Placing

        if RAM.Placing then
            GUI.SetPerm("Pasting")
            RAM.Selecting = false

            modelService:CreateModel(copyService.CurrentSaveTable)
        else
            GUI.SetPerm("Copying")
            modelService:ClearModel()
        end
    end
end

local CopyFunction = function()
    if RAM.CopyTool and not RAM.Placing then
        copyService:GenerateSaveTable()
        GUI.ChangeStatus("Copied " .. #copyService.CurrentSaveTable .. " blocks.", 2)
    end
end

actionService:Bind('1CopyToolPaste_', function()
    if userInput:IsKeyDown(Enum.KeyCode.LeftShift) then
        PasteFunction()
    end
end, Enum.KeyCode.V)
GUI.Paste.MouseButton1Up:Connect(PasteFunction)

actionService:Bind('1CopyToolCopy_', function()
    if userInput:IsKeyDown(Enum.KeyCode.LeftShift) then
        CopyFunction()
    end
end, Enum.KeyCode.C)
GUI.Copy.MouseButton1Up:Connect(CopyFunction)

actionService:Bind('1CopyToolOffsetUp_', function()
    if RAM.CopyTool and RAM.Placing and ModelPreview then
        modelService.Offset = math.min(modelService.Offset + 2, 126)
    end
end, Enum.KeyCode.E)
actionService:Bind('1CopyToolOffsetDown_', function()
    if RAM.CopyTool and RAM.Placing and ModelPreview then
        modelService.Offset = math.max(modelService.Offset - 2, 0)
    end
end, Enum.KeyCode.Q)

actionService:Bind('1CopyToolRotateX_', function()
    if RAM.CopyTool and RAM.Placing then
        modelService:RotateAxis("X")
    end
end, Enum.KeyCode.Y)
actionService:Bind('1CopyToolRotateY_', function()
    if RAM.CopyTool and RAM.Placing then
        modelService:RotateAxis("Y")
    end
end, Enum.KeyCode.R)
actionService:Bind('1CopyToolRotateZ_', function()
    if RAM.CopyTool and RAM.Placing then
        modelService:RotateAxis("Z")
    end
end, Enum.KeyCode.T)

GUI.Export.MouseButton1Click:Connect(function()
    local CreationCode, err = stringService:GenerateString()
    if CreationCode then
        setclipboard(CreationCode)
        GUI.ChangeStatus("Copied Creation Data to Clipboard.", 2)
    elseif err then
        GUI.ChangeStatus("Please Screenshot! Error: " .. err, 10)
    else
        GUI.ChangeStatus("Failed to copy Creation Code.", 2)
    end
end)

GUI.Import.MouseButton1Click:Connect(function()
    local CreationCode = GUI.Box.Text
    if #CreationCode > 0 then
        local GeneratedData, err = stringService:ReadString(CreationCode)
        if GeneratedData then
            modelService:CreateModel(GeneratedData)
            RAM.Selecting = false
            RAM.Placing = true
            GUI.ChangeStatus("Imported " .. #GeneratedData .. " blocks.", 2)
        elseif err then
            GUI.ChangeStatus("Please Screenshot! Error: " .. err, 10)
        else
            GUI.ChangeStatus("Failed to import Creation Code.", 2)
        end
    end
end)

workspace.Creations.ChildAdded:Connect(function(Child)
    if Child.Name == client.Name then
        ClientCreation = Child
    end
end)

local old 
old = hookmetamethod(game, "__namecall", function(...)
    local self = select(1, ...)
    local name = getnamecallmethod()
    if name == "FireServer" and (self.Name == "DeleteCreation") or (self.Name == "LoadSave") then
        task.spawn(function()
            selectionService:ClearHighlights(self.Name == "LoadSave")
            selectionService.CurrentSelection = {}
            GUI.UpdateSelected()
        end)
    end
    return old(...)
end)

local function close()
    if RAM.CopyTool then
        RAM.CopyTool = false
        GUI.MainFrame.Visible = false
        selectionService:ClearHighlights()
        modelService:ClearModel()
    end
end

MainUi.Values.Spawned.Changed:Connect(function(newv)
    if newv then
        close()
    end
end)
if MainUi.Values.Spawned.Value then
    close()
end

for i,v in ipairs(MainUi.Tools:GetChildren()) do
    if v:FindFirstChild("Open") then
        v.Open.Changed:Connect(function()
            if v.Open.Value then
                close()
            end
        end)

        if v.Open.Value  then
            close()
        end
    end
end
