if game.PlaceId ~= 6609611538 then return end
if not game:IsLoaded() then
    game.Loaded:Wait() 
end
local Client = game.Players.LocalPlayer
local PlayerGui = Client:WaitForChild("PlayerGui")
while PlayerGui:FindFirstChild("LoadingScreenGui∙") or not PlayerGui:FindFirstChild("MainGui") do
    wait()
end

local BlocksPlaced = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local UIPadding = Instance.new("UIPadding")

BlocksPlaced.Parent = PlayerGui.MainGui.MetersFrame.MetersBackground
BlocksPlaced.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
BlocksPlaced.Position = UDim2.new(-0.695, 0, 0.2583, 0)
BlocksPlaced.Size = UDim2.new(0.665, 0, 0.2, 0)
BlocksPlaced.Text = "Placed: 0"
BlocksPlaced.TextColor3 = Color3.fromRGB(255, 255, 255)
BlocksPlaced.TextScaled = true

UICorner.CornerRadius = UDim.new(0.25, 0)
UICorner.Parent = BlocksPlaced

UIPadding.Parent = BlocksPlaced
UIPadding.PaddingBottom = UDim.new(0.05, 0)
UIPadding.PaddingLeft = UDim.new(0.1, 0)
UIPadding.PaddingRight = UDim.new(0.1, 0)
UIPadding.PaddingTop = UDim.new(0.05, 0)

local Creations = workspace.Creations

local function updateCount()
    local numOf = Creations:FindFirstChild(Client.Name) and #Creations[Client.Name]:GetChildren() or 0
    BlocksPlaced.Text = "Placed: " .. numOf
end

Creations.DescendantRemoving:Connect(function(child)
    if child:IsDescendantOf(Creations[Client.Name]) then
        updateCount()
    end
end)
Creations.DescendantAdded:Connect(function(child)
    if child:IsDescendantOf(Creations[Client.Name]) then
        updateCount()
    end
end)

updateCount()
