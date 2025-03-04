local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local gameID = game.PlaceId

-- Create UI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Function to add rounded corners
local function addCorner(uiElement, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = uiElement
end

-- Main UI Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
addCorner(mainFrame, 20)

-- Tab List (Side Column)
local tabList = Instance.new("Frame")
tabList.Size = UDim2.new(0, 120, 1, 0)
tabList.Position = UDim2.new(0, 0, 0, 0)
tabList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tabList.Parent = mainFrame
addCorner(tabList, 15)

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -50, 0, 10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeButton.Parent = mainFrame
addCorner(closeButton, 15)
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Function to create tab buttons
local function createTabButton(name, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Position = UDim2.new(0, 5, 0, position)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Parent = tabList
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    addCorner(button, 10)
    return button
end

-- Tabs
local tabs = { "Home", "TP", "Misc", "Config" }
if gameID == 6872265039 then
    table.insert(tabs, "BedWars")
end

local tabButtons = {}
local contentFrames = {}

for i, tab in ipairs(tabs) do
    local button = createTabButton(tab, (i - 1) * 50 + 10)
    tabButtons[tab] = button

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -120, 1, 0)
    frame.Position = UDim2.new(0, 120, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = mainFrame
    frame.Visible = (tab == "Home")
    contentFrames[tab] = frame
end

-- Home Tab
local homeLabel = Instance.new("TextLabel")
homeLabel.Size = UDim2.new(1, -20, 0, 50)
homeLabel.Position = UDim2.new(0, 10, 0, 50)
homeLabel.Text = "Welcome, " .. player.DisplayName .. " to EmberWare v1."
homeLabel.TextColor3 = Color3.fromRGB(255, 100, 0) -- Red/Orange
homeLabel.TextScaled = true
homeLabel.Font = Enum.Font.GothamBold
homeLabel.Parent = contentFrames["Home"]

local madeByLabel = Instance.new("TextLabel")
madeByLabel.Size = UDim2.new(1, -20, 0, 30)
madeByLabel.Position = UDim2.new(0, 10, 0, 100)
madeByLabel.Text = "Made by @Draco"
madeByLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
madeByLabel.TextScaled = true
madeByLabel.Font = Enum.Font.Gotham
madeByLabel.Parent = contentFrames["Home"]

-- Config Tab (Color & Image ID)
local colorBox = Instance.new("TextBox")
colorBox.Size = UDim2.new(0.8, 0, 0, 40)
colorBox.Position = UDim2.new(0.1, 0, 0.2, 0)
colorBox.PlaceholderText = "Enter RGB (e.g., 2,255,19)"
colorBox.TextColor3 = Color3.fromRGB(255, 255, 255)
colorBox.Parent = contentFrames["Config"]
addCorner(colorBox, 10)

local imageBox = Instance.new("TextBox")
imageBox.Size = UDim2.new(0.8, 0, 0, 40)
imageBox.Position = UDim2.new(0.1, 0, 0.4, 0)
imageBox.PlaceholderText = "Enter Roblox Image ID"
imageBox.TextColor3 = Color3.fromRGB(255, 255, 255)
imageBox.Parent = contentFrames["Config"]
addCorner(imageBox, 10)

local function applyChanges()
    local rgb = string.split(colorBox.Text, ",")
    if #rgb == 3 then
        local r, g, b = tonumber(rgb[1]), tonumber(rgb[2]), tonumber(rgb[3])
        if r and g and b then
            for _, button in pairs(tabButtons) do
                button.BackgroundColor3 = Color3.fromRGB(r, g, b)
            end
        end
    end
    if imageBox.Text ~= "" then
        local imageId = "rbxassetid://" .. imageBox.Text
        mainFrame.BackgroundTransparency = 1
        mainFrame.BackgroundImage = imageId
    end
end

colorBox.FocusLost:Connect(applyChanges)
imageBox.FocusLost:Connect(applyChanges)

-- BedWars Tab
if gameID == 6872265039 then
    local bedwarsFrame = contentFrames["BedWars"]

    local function createBedWarsButton(name, yPos)
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.8, 0, 0, 40)
        button.Position = UDim2.new(0.1, 0, 0, yPos)
        button.Text = name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        button.Parent = bedwarsFrame
        addCorner(button, 10)
        return button
    end

    createBedWarsButton("Nametags", 50).MouseButton1Click:Connect(function()
        print("Nametags enabled") -- Implement Nametag logic
    end)

    createBedWarsButton("Spider (Wall Climb)", 100).MouseButton1Click:Connect(function()
        print("Spider mode enabled") -- Implement climbing logic
    end)

    createBedWarsButton("Hitboxes", 150).MouseButton1Click:Connect(function()
        print("Hitboxes expanded") -- Implement hitbox expansion
    end)
end

-- Tab Switching
for tab, button in pairs(tabButtons) do
    button.MouseButton1Click:Connect(function()
        for _, frame in pairs(contentFrames) do
            frame.Visible = false
        end
        contentFrames[tab].Visible = true
    end)
end
