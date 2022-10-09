local shared, selfTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotRllyRn/mechanica_public_scripts/main/loader.lua"))(...)
selfTable.Name = "Angular To RPM"

local RotSpeed = shared.MainGui.MetersFrame.MetersBackground.RotSpeed

local RPMText = Instance.new("TextLabel")
RPMText.Size = UDim2.new(0, 100, 0, 18)
RPMText.Position = UDim2.new(1, -220, 1, -18)
RPMText.BorderSizePixel = 0
RPMText.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
RPMText.TextColor3 = Color3.fromRGB(200, 200, 200)
RPMText.Text = "RPM: 0"
RPMText.TextXAlignment = Enum.TextXAlignment.Left

local UiCorner = Instance.new("UICorner")
UiCorner.CornerRadius = UDim.new(0.25, 0)
UiCorner.Parent = RPMText
RPMText.Parent = shared.MainGui.MetersFrame

RotSpeed:GetPropertyChangedSignal("Text"):Connect(function()
    local rpm = tonumber(RotSpeed.Text:match("%d+")) * 9.549297
    RPMText.Text = "RPM: " .. math.floor(rpm * 10) / 10
end)

selfTable.stop = function()
    selfTable.scriptOn = false
    RPMText.Visible = false
end
selfTable.start = function()
    selfTable.scriptOn = true
    RPMText.Visible = true
end

return selfTable
