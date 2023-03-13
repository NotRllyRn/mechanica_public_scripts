local __tape = {
    http = game:GetService'HttpService',
    chunks = {},
    require = require,
    cache = {},
    scripts = {},
}

local function require(module)
    if typeof(module) == 'Instance' then
        local name = __tape.scripts[module]

        if name then
            module = name
        end
    end
    if typeof(module) ~= 'string' then
        return __tape.require(module)
    end

    local fn = __tape.chunks[module]

    if not fn then
        error(('tape: module %s not found'):format(module))
    end

    local cache = __tape.cache[module]

    if cache then
        return cache.value
    end

    local s, e = pcall(fn, __tape.scripts[module])

    if not s then
        error(('tape: error executing %s: %s'):format(module, e))
    end

    __tape.cache[module] = {value = e}

    return e
end

__tape.json = function(str)
    return function()
        return __tape.http:JSONDecode(str)
    end
end
__tape.buildTree = function(str)
    local function recurse(t, parent)
        local pair, children = unpack(t)
        local name, link = unpack(pair)
        local proxy = Instance.new(link and 'ModuleScript' or 'Folder')

        proxy.Parent = parent
        proxy.Name = name

        if link then
            __tape.scripts[proxy] = link
            __tape.scripts[link] = proxy
        end

        for _, v in pairs(children)do
            recurse(v, proxy)
        end

        return proxy
    end

    recurse(__tape.http:JSONDecode(str))
end
__tape.chunks['init.lua'] = function(script)
    local Dependencies = require(script.Dependencies)

    if not Dependencies:isMechanica() then
        return
    else
        function Dependencies.init(self)
            self.On.Value = true
            self.SelectedObject = self.Values.SelectedObject
        end

        Dependencies:init()
    end

    local Highlight = require(script.Highlight)

    Dependencies.SelectedObject:GetPropertyChangedSignal'Value':Connect(function(
    )
        if not Dependencies.On.Value then
            return
        end

        local block = Dependencies.SelectedObject.Value

        if block then
            Highlight:New(block)
        else
            Highlight:Reset()
        end
    end)
    Dependencies.On:GetPropertyChangedSignal'Value':Connect(function()
        if not Dependencies.On.Value then
            Highlight:Reset()
        elseif Dependencies.SelectedObject.Value then
            Highlight:New(Dependencies.SelectedObject.Value)
        end
    end)

    return Dependencies
end
__tape.chunks['Dependencies.lua'] = function(script)
    local Dependencies = {}

    Dependencies.LocalPlayer = game:GetService'Players'.LocalPlayer
    Dependencies.MainGui = Dependencies.LocalPlayer:WaitForChild'PlayerGui':WaitForChild'MainGui'
    Dependencies.Values = Dependencies.MainGui:WaitForChild'Values'
    Dependencies.On = Instance.new'BoolValue'

    function Dependencies.init(self)
        self.On.Value = false
    end
    function Dependencies.isMechanica(self)
        return (game.PlaceId == 6609611538) or (game.PlaceId == 6017780414)
    end
    function Dependencies.enter(self)
        self.On.Value = true
    end
    function Dependencies.exit(self)
        self.On.Value = false
    end

    return Dependencies
end
__tape.chunks['Highlight/init.lua'] = function(script)
    local Parts, Highlight = require(script.Parts), {
        Connections = {},
        Configuration = {},
    }

    function Highlight.GetObjectConfiguration(self)
        local ConfigurationFolder = self.Block:FindFirstChild'Configuration'

        if not ConfigurationFolder then
            return
        end

        local Found = false

        for _, child in ipairs(ConfigurationFolder:GetChildren())do
            if child.ClassName ~= 'ObjectValue' then
                continue
            end

            table.insert(self.Configuration, {Instance = child})

            Found = true
        end

        return Found
    end
    function Highlight.Reset(self)
        self.Block = nil

        for _, connection in ipairs(self.Connections)do
            if connection and typeof(connection) == 'RBXScriptConnection' and connection.Connected then
                connection:Disconnect()
            end
        end

        self.Connections = {}

        for _, configuration in ipairs(self.Configuration)do
            if configuration.HighlightParts then
                configuration.HighlightParts:Reset()
            end
        end

        self.Configuration = {}
    end
    function Highlight.SetupParts(self)
        for _, configuration in ipairs(self.Configuration)do
            if configuration.Instance.Value then
                self:SetupPartsForConfiguration(configuration)
            end
        end
    end
    function Highlight.GetPlacementCFrame(self, block_model)
        local partFound

        for _, part in ipairs(block_model:GetDescendants())do
            if part.Name == 'Head' or part.Name == 'Base' then
                partFound = part

                break
            end
        end

        if not partFound then
            return block_model:GetPivot()
        end

        return partFound:IsA'BasePart' and partFound.CFrame or partFound:IsA'Model' and partFound:GetPivot() or block_model:GetPivot()
    end
    function Highlight.SetupPartsForConfiguration(self, configuration)
        local CustomName, HighlightParts = configuration.Instance:GetAttribute'CustomName' or configuration.Instance.Name, Parts.new()

        HighlightParts:Setup(self:GetPlacementCFrame(self.Block), self:GetPlacementCFrame(configuration.Instance.Value), CustomName)

        configuration.HighlightParts = HighlightParts
    end
    function Highlight.ConfigurationPropertyChanged(self, configuration)
        if configuration.Instance.Value then
            self:SetupParts()
        else
            configuration.HighlightParts:Reset()
        end
    end
    function Highlight.SetupConnections(self)
        for _, configuration in ipairs(self.Configuration)do
            local ObjectValueConnection = configuration.Instance:GetPropertyChangedSignal'Value':Connect(function(
            )
                self:ConfigurationPropertyChanged(configuration)
            end)

            table.insert(self.Connections, ObjectValueConnection)
        end
    end
    function Highlight.Setup(self)
        if not self.Block or not self:GetObjectConfiguration() then
            return
        end

        self:SetupConnections()
        self:SetupParts()
    end
    function Highlight.New(self, block)
        self:Reset()

        self.Block = block

        self:Setup()
    end

    return Highlight
end
__tape.chunks['Highlight/Parts.lua'] = function(script)
    local HighlightParts = {
        Properties = {
            Block = {
                CanCollide = false,
                Anchored = true,
                Transparency = 1,
                Size = Vector3.new(1, 1, 1),
            },
            Attachment = {},
            Display = {
                Size = UDim2.new(2, 0, 1, 0),
                AlwaysOnTop = true,
            },
            NameLabel = {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                TextColor3 = Color3.new(1, 1, 1),
                TextScaled = true,
                TextStrokeTransparency = 0,
                TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
            },
            Beam = {
                Color = ColorSequence.new(Color3.fromRGB(255, 141, 60)),
                FaceCamera = true,
                Segments = 1000,
                CurveSize0 = 2,
                CurveSize1 = 2,
                Width0 = 0.2,
                Width1 = 0.2,
                Attachment0 = function(self)
                    return self.Attachment1
                end,
                Attachment1 = function(self)
                    return self.Attachment2
                end,
                Parent = function(self)
                    return self.Block1
                end,
            },
        },
        Highlights = {},
        Folder = Instance.new('Folder', workspace),
    }

    HighlightParts.__index = HighlightParts

    function HighlightParts.new()
        local self = setmetatable({}, HighlightParts)

        for _, highlight in ipairs(self.Highlights)do
            if not highlight.BeingUsed then
                highlight.BeingUsed = true

                return highlight
            end
        end

        self:New('Part', 'Block1', self.Properties.Block, {
            self:New('Attachment', 'Attachment1'),
            self:New('BillboardGui', 'Display1', self.Properties.Display, {
                self:New('TextLabel', 'NameLabel1', self.Properties.NameLabel),
            }),
        })
        self:New('Part', 'Block2', self.Properties.Block, {
            self:New('Attachment', 'Attachment2'),
            self:New('BillboardGui', 'Display2', self.Properties.Display, {
                self:New('TextLabel', 'NameLabel2', self.Properties.NameLabel),
            }),
        })
        self:New('Beam', 'Beam', self.Properties.Beam)

        self.NameLabel1.Text = ''
        self.Attachment1.Orientation = Vector3.new(0, 0, 90)
        self.Attachment2.Orientation = Vector3.new(0, 0, -90)

        table.insert(self.Highlights, self)

        self.BeingUsed = true

        return self
    end
    function HighlightParts.New(
        self,
        type_of_instance,
        index_name,
        properties,
        children
    )
        properties = properties or {}
        children = children or {}
        self[index_name] = Instance.new(type_of_instance)

        for property, value in pairs(properties)do
            if type(value) == 'function' then
                value = value(self)
            end

            self[index_name][property] = value
        end
        for _, child in ipairs(children)do
            child.Parent = self[index_name]
        end

        return self[index_name]
    end
    function HighlightParts.Reset(self)
        self.Block1.Parent = nil
        self.Block2.Parent = nil
        self.BeingUsed = false
    end
    function HighlightParts.Setup(self, cframe1, cframe2, custom_name)
        self.Block1.CFrame = cframe1
        self.Block2.CFrame = cframe2
        self.Block1.Parent = self.Folder
        self.Block2.Parent = self.Folder
        self.NameLabel2.Text = custom_name
    end

    return HighlightParts
end

__tape.buildTree
[=[[["main","init.lua"],[[["Dependencies","Dependencies.lua"],[]],[["Highlight","Highlight/init.lua"],[[["Parts","Highlight/Parts.lua"],[]]]]]]]=]

return require'init.lua'