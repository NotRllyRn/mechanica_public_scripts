local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local client = players.LocalPlayer
local mouse = client:GetMouse()

local clientValues = client.PlayerGui.MainGui.Values
local clientEvents = client.PlayerGui.MainGui.Events
local clientColor = clientValues.PaintColor
local clientMaterial = clientValues.PaintMaterial
local dragging = false

local function isOneBlock(part)
    return part:GetExtentsSize() == Vector3.new(2, 2, 2)
end

local cooldownList = {}
local function cooldown(part)
    if not table.find(cooldownList, part) then
        coroutine.resume(coroutine.create(function()
            table.insert(cooldownList, part)
            while not isOneBlock(part) do
                wait()
            end
            while isOneBlock(part) do
                wait()
            end
            table.remove(cooldownList, table.find(cooldownList, part))
        end))
    end
end

local function getPartOnMouse()
    local mousePosition = mouse.Hit.Position
    
    for _, block in pairs(workspace.Creations[client.Name]:GetChildren()) do
        local mag = block:GetPivot().Position - mousePosition
        if mag.Magnitude <= 2 then
            return block
        end
    end
end

local function checkForBaseParts(part)
    for _, part in ipairs(part:GetDescendants()) do
        if part:IsA("BasePart") then
            return true
        end
    end
end

mouse.Button1Down:Connect(function()
    dragging = true

    if clientValues.SelectedTool.Value == 'Paint' then
        local block = clientValues.TargetObject.Value
        if block and not isOneBlock(block) and not table.find(cooldownList, block) then
            cooldown(block)
        end
    end
end)

mouse.Button1Up:Connect(function()
    dragging = false
end)

local doPaint
doPaint = function(block)
    local block = block 
    local block1 = getPartOnMouse()
    local block2 = clientValues.TargetObject.Value

    if not block then
        if (not block1) or (block1 and not checkForBaseParts(block1)) then
            block = block2
        else
            block = block1
        end
    end

    if block then
        local blockColor = block.Configuration.Color
        local blockMaterial = block.Configuration.Material

        if (blockColor.Value ~= clientColor.Value) or (blockMaterial.Value ~= clientMaterial.Value) then
            if (block == block2) and not isOneBlock(block) and not table.find(cooldownList, block) then
                if not isOneBlock(block) then
                    clientEvents.Paint:FireServer(block, clientColor.Value, clientMaterial.Value)
                    cooldown(block)
                end
            elseif block == block1 then
                clientEvents.Paint:FireServer(block, clientColor.Value, clientMaterial.Value)
            end
        end
    end
end

game.RunService.Heartbeat:Connect(function()
    if dragging and clientValues.SelectedTool.Value == 'Paint' then
        doPaint()
    end
end)
