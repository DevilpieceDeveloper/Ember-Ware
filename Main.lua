local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- Create UI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Function to Add Rounded Corners
local function addCorner(uiElement, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = uiElement
end

-- Main Button
local mainButton = Instance.new("TextButton")
mainButton.Size = UDim2.new(0, 150, 0, 60)
mainButton.Position = UDim2.new(0, 20, 0, 20)
mainButton.Text = "EmberWare"
mainButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainButton.Parent = gui
mainButton.TextScaled = true
mainButton.Font = Enum.Font.GothamBold
mainButton.AutoButtonColor = true
addCorner(mainButton, 20)

-- Main GUI Window
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
addCorner(mainFrame, 20)

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

-- Tab Buttons Container
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(0, 120, 1, -20)
tabContainer.Position = UDim2.new(0, 10, 0, 10)
tabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tabContainer.Parent = mainFrame
addCorner(tabContainer, 15)

-- Function to Create Tabs
local tabs = {}
local function createTabButton(name)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Text = name
    button.TextScaled = true
    button.Parent = tabContainer
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    addCorner(button, 10)
    
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, -130, 1, -20)
    tabFrame.Position = UDim2.new(0, 130, 0, 10)
    tabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    tabFrame.Visible = false
    tabFrame.Parent = mainFrame
    addCorner(tabFrame, 15)

    button.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.Frame.Visible = false
        end
        tabFrame.Visible = true
    end)

    tabs[name] = {Button = button, Frame = tabFrame}
end

-- Create Tabs
createTabButton("Home")
createTabButton("TP")
createTabButton("Misc")
createTabButton("Config")
createTabButton("Changelog")

-- Home Tab
local homeLabel = Instance.new("TextLabel")
homeLabel.Size = UDim2.new(1, 0, 0, 50)
homeLabel.Text = "Welcome, " .. player.DisplayName .. " to EmberWare v.1"
homeLabel.TextScaled = true
homeLabel.TextColor3 = Color3.fromRGB(255, 85, 0) -- Animated later
homeLabel.BackgroundTransparency = 1
homeLabel.Parent = tabs["Home"].Frame

local creatorLabel = Instance.new("TextLabel")
creatorLabel.Size = UDim2.new(1, 0, 0, 30)
creatorLabel.Position = UDim2.new(0, 0, 1, -30)
creatorLabel.Text = "Made by @Draco"
creatorLabel.TextScaled = true
creatorLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
creatorLabel.Parent = tabs["Home"].Frame

-- Changelog Tab (Editable Text)
local changelogText = [[
Released!)
]]

local changelogBox = Instance.new("TextLabel")
changelogBox.Size = UDim2.new(1, -20, 1, -20)
changelogBox.Position = UDim2.new(0, 10, 0, 10)
changelogBox.Text = changelogText
changelogBox.TextScaled = false
changelogBox.TextWrapped = true
changelogBox.TextYAlignment = Enum.TextYAlignment.Top
changelogBox.BackgroundTransparency = 1
changelogBox.TextColor3 = Color3.fromRGB(255, 255, 255)
changelogBox.Parent = tabs["Changelog"].Frame

-- Show BedWars Tab if Game ID Matches
if game.PlaceId == 6872265039 then
    createTabButton("BedWars")
end

-- Show GUI
mainButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
