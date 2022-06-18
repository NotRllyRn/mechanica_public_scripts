local shared, selfTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/NotRllyRn/mechanica_public_scripts/main/loader.lua"))(...)
selfTable.Name = "Time Played"

local defaultTable = { loaded = 0, time = 0, start = os.time() }
local saveTable = defaultTable
pcall(function()
    if isfolder("MechanicaAddons") then
        if isfile("MechanicaAddons/TimePlayed.txt") then
            local played = readfile("MechanicaAddons/TimePlayed.txt")
            if played and tonumber(played) then
                saveTable = { loaded = tonumber(played), time = 0, start = os.time() }
            end
        else
            writefile("MechanicaAddons/TimePlayed.txt", "0")
        end
    else
        makefolder("MechanicaAddons")
        writefile("MechanicaAddons/TimePlayed.txt", "0") 
    end
end)

local function numberToTime(time)
    local days = math.floor(time / 86400)
    time = time - (days * 86400)
    local hours = math.floor(time / 3600)
    time = time - (hours * 3600)
    local minutes = math.floor(time / 60)
    time = time - (minutes * 60)
    local seconds = time
    local time = {}
    if days > 0 then
        table.insert(time, days .. " Days")
    end
    if hours > 0 then
        table.insert(time, hours .. " Hours")
    end
    if minutes > 0 then
        table.insert(time, minutes .. " Minutes")
    end
    if seconds > 0 then
        table.insert(time, seconds .. " Seconds")
    end
    return table.concat(time, ", ")
end

local TimePlayed = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Time = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local Title = Instance.new("TextLabel")

TimePlayed.Name = "TimePlayed"
TimePlayed.Parent = shared.MainGui.DespawnedUI.SideMenu.SettingsBox
TimePlayed.AnchorPoint = Vector2.new(1, 0)
TimePlayed.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TimePlayed.BorderSizePixel = 0
TimePlayed.Position = UDim2.new(0.984, 0, 0.884, 0)
TimePlayed.Size = UDim2.new(0.6142, 0, 0.094, 0)
TimePlayed.ZIndex = 11

UICorner.CornerRadius = UDim.new(0.096, 0)
UICorner.Parent = TimePlayed

Time.Parent = TimePlayed
Time.Active = true
Time.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Time.Position = UDim2.new(0.305, 0, 0.191, 0)
Time.Size = UDim2.new(0.673, 0, 0.6808, 0)
Time.ZIndex = 12
Time.TextColor3 = Color3.fromRGB(200, 200, 200)
Time.TextScaled = true

UICorner_2.CornerRadius = UDim.new(0.5, 0)
UICorner_2.Parent = Time

Title.Parent = TimePlayed
Title.AnchorPoint = Vector2.new(0.5, 0)
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.1534, 0, 0, 0)
Title.Size = UDim2.new(0.288, 0, 1, 0)
Title.ZIndex = 12
Title.Text = "Time Played:"
Title.TextColor3 = Color3.fromRGB(200, 200, 200)
Title.TextScaled = true

game.Players.PlayerRemoving:Connect(function(plr)
    if selfTable.scriptOn then
        if plr == shared.Client then
            writefile("MechanicaAddons/TimePlayed.txt", tostring(saveTable.time))
        end
    end
end)

while true do
    if selfTable.scriptOn then
        saveTable.time = (os.time() - saveTable.start) + saveTable.loaded
        Time.Text = numberToTime(saveTable.time)
    end
    wait(1)
end

selfTable.stop = function()
    selfTable.scriptOn = false
end
selfTable.start = function()
    selfTable.scriptOn = true
end

return selfTable
