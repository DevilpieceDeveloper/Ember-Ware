local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")
local playerGui = player:WaitForChild("PlayerGui")
local gameID = game.PlaceId

-- Create the main UI
local gui = Instance.new("ScreenGui")
gui.Parent = playerGui
gui.ResetOnSpawn = false

-- Function to add rounded corners
local function addCorner(uiElement, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = uiElement
end

-- Main button for EmberWare
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

-- Create the tabs container frame
local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(0, 200, 1)
tabsFrame.Position = UDim2.new(0, 0, 0, 0)
tabsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tabsFrame.Parent = gui
addCorner(tabsFrame, 20)

-- Create the content frame for tabs
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -200, 1, 0)
contentFrame.Position = UDim2.new(0, 200, 0, 0)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentFrame.Parent = gui
addCorner(contentFrame, 20)

-- Create tab buttons in the side panel
local tabButtons = {}
local currentTab = nil

local function createTabButton(name, tabContent)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = tabsFrame
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.AutoButtonColor = true
    addCorner(button, 10)

    button.MouseButton1Click:Connect(function()
        if currentTab then
            currentTab.Visible = false
        end
        tabContent.Visible = true
        currentTab = tabContent
    end)

    tabButtons[name] = {Button = button, TabFrame = tabContent}
end

-- Home Tab content
local homeTab = Instance.new("Frame")
homeTab.Size = UDim2.new(1, 0, 1, 0)
homeTab.Position = UDim2.new(0, 0, 0, 0)
homeTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
homeTab.Visible = false
homeTab.Parent = contentFrame
addCorner(homeTab, 20)

local welcomeText = Instance.new("TextLabel")
welcomeText.Size = UDim2.new(1, 0, 0, 50)
welcomeText.Position = UDim2.new(0, 0, 0, 0)
welcomeText.Text = "Welcome, " .. player.DisplayName .. " to EmberWare v.1"
welcomeText.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
welcomeText.TextColor3 = Color3.fromRGB(255, 69, 0)  -- Red/Orange Color
welcomeText.TextScaled = true
welcomeText.Font = Enum.Font.GothamBold
welcomeText.Parent = homeTab

local madeByText = Instance.new("TextLabel")
madeByText.Size = UDim2.new(1, 0, 0, 50)
madeByText.Position = UDim2.new(0, 0, 0, 60)
madeByText.Text = "Made by @Draco"
madeByText.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
madeByText.TextColor3 = Color3.fromRGB(0, 255, 255)  -- Neon Blue
madeByText.TextScaled = true
madeByText.Font = Enum.Font.GothamBold
madeByText.Parent = homeTab

-- TP Tab content
local tpTab = Instance.new("Frame")
tpTab.Size = UDim2.new(1, 0, 1, 0)
tpTab.Position = UDim2.new(0, 0, 0, 0)
tpTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tpTab.Visible = false
tpTab.Parent = contentFrame
addCorner(tpTab, 20)

local tpList = Instance.new("ScrollingFrame")
tpList.Size = UDim2.new(1, 0, 1, -50)
tpList.Position = UDim2.new(0, 0, 0, 50)
tpList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tpList.CanvasSize = UDim2.new(0, 0, 10, 0)
tpList.Parent = tpTab
addCorner(tpList, 20)

local tpButtonList = {}
for _, p in pairs(game.Players:GetPlayers()) do
    local tpButton = Instance.new("TextButton")
    tpButton.Size = UDim2.new(1, 0, 0, 50)
    tpButton.Text = p.Name
    tpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpButton.Parent = tpList
    tpButton.TextScaled = true
    tpButton.Font = Enum.Font.GothamBold
    tpButton.AutoButtonColor = true
    addCorner(tpButton, 10)

    tpButton.MouseButton1Click:Connect(function()
        teleportService:TeleportToPlaceInstance(game.PlaceId, p.UserId)
    end)
end

-- Misc Tab content
local miscTab = Instance.new("Frame")
miscTab.Size = UDim2.new(1, 0, 1, 0)
miscTab.Position = UDim2.new(0, 0, 0, 0)
miscTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
miscTab.Visible = false
miscTab.Parent = contentFrame
addCorner(miscTab, 20)

-- Glow, Invisibility, Infinite Jump Buttons (toggleable)
local glowButton = Instance.new("TextButton")
glowButton.Size = UDim2.new(0, 200, 0, 50)
glowButton.Text = "Glow"
glowButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
glowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
glowButton.Parent = miscTab
glowButton.TextScaled = true
glowButton.Font = Enum.Font.GothamBold
glowButton.AutoButtonColor = true
addCorner(glowButton, 10)

local invisibleButton = Instance.new("TextButton")
invisibleButton.Size = UDim2.new(0, 200, 0, 50)
invisibleButton.Text = "Invisibility"
invisibleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
invisibleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
invisibleButton.Parent = miscTab
invisibleButton.TextScaled = true
invisibleButton.Font = Enum.Font.GothamBold
invisibleButton.AutoButtonColor = true
addCorner(invisibleButton, 10)

local jumpButton = Instance.new("TextButton")
jumpButton.Size = UDim2.new(0, 200, 0, 50)
jumpButton.Text = "Infinite Jump"
jumpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
jumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpButton.Parent = miscTab
jumpButton.TextScaled = true
jumpButton.Font = Enum.Font.GothamBold
jumpButton.AutoButtonColor = true
addCorner(jumpButton, 10)

local jumpEnabled = false
local glowEnabled = false
local invisibleEnabled = false

glowButton.MouseButton1Click:Connect(function()
    glowEnabled = not glowEnabled
    -- Add glow effect here
end)

invisibleButton.MouseButton1Click:Connect(function()
    invisibleEnabled = not invisibleEnabled
    -- Add invisibility effect here
end)

jumpButton.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled
    -- Add infinite jump effect here
end)

-- Config Tab content
local configTab = Instance.new("Frame")
configTab.Size = UDim2.new(1, 0, 1, 0)
configTab.Position = UDim2.new(0, 0, 0, 0)
configTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
configTab.Visible = false
configTab.Parent = contentFrame
addCorner(configTab, 20)

local configTitle = Instance.new("TextLabel")
configTitle.Size = UDim2.new(1, 0, 0, 50)
configTitle.Text = "Config"
configTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
configTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
configTitle.TextScaled = true
configTitle.Font = Enum.Font.GothamBold
configTitle.Parent = configTab

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, 0, 0, 50)
keyInput.Position = UDim2.new(0, 0, 0, 60)
keyInput.PlaceholderText = "Enter key to activate"
keyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextScaled = true
keyInput.Font = Enum.Font.GothamBold
keyInput.Parent = configTab
addCorner(keyInput, 10)

local saveButton = Instance.new("TextButton")
saveButton.Size = UDim2.new(1, 0, 0, 50)
saveButton.Position = UDim2.new(0, 0, 0, 120)
saveButton.Text = "Save"
saveButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
saveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveButton.Parent = configTab
saveButton.TextScaled = true
saveButton.Font = Enum.Font.GothamBold
saveButton.AutoButtonColor = true
addCorner(saveButton, 10)

saveButton.MouseButton1Click:Connect(function()
    -- Save config settings here
end)

-- Function to show tabs based on the game ID
if gameID == 6872265039 then
    createTabButton("Home", homeTab)
    createTabButton("TP", tpTab)
    createTabButton("Misc", miscTab)
    createTabButton("Config", configTab)
else
    createTabButton("Config", configTab)
end

-- Set the default tab to Home or Config
if gameID == 6872265039 then
    currentTab = homeTab
    homeTab.Visible = true
else
    currentTab = configTab
    configTab.Visible = true
end
