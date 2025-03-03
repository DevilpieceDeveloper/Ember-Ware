local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")

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

-- Create Main Button
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

-- Create Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false -- Default to hidden
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
addCorner(mainFrame, 20)

-- Create Close Button (X)
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

-- Create Tab Buttons (Home, TP, Misc, Config)
local homeTabButton = Instance.new("TextButton")
homeTabButton.Size = UDim2.new(0, 120, 0, 40)
homeTabButton.Position = UDim2.new(0, 10, 0, 60)
homeTabButton.Text = "Home"
homeTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
homeTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
homeTabButton.Parent = mainFrame
addCorner(homeTabButton, 10)

local tpTabButton = Instance.new("TextButton")
tpTabButton.Size = UDim2.new(0, 120, 0, 40)
tpTabButton.Position = UDim2.new(0, 10, 0, 110)
tpTabButton.Text = "TP"
tpTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
tpTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpTabButton.Parent = mainFrame
addCorner(tpTabButton, 10)

local miscTabButton = Instance.new("TextButton")
miscTabButton.Size = UDim2.new(0, 120, 0, 40)
miscTabButton.Position = UDim2.new(0, 10, 0, 160)
miscTabButton.Text = "Misc"
miscTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
miscTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
miscTabButton.Parent = mainFrame
addCorner(miscTabButton, 10)

local configTabButton = Instance.new("TextButton")
configTabButton.Size = UDim2.new(0, 120, 0, 40)
configTabButton.Position = UDim2.new(0, 10, 0, 210)
configTabButton.Text = "Config"
configTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
configTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
configTabButton.Parent = mainFrame
addCorner(configTabButton, 10)

-- Create Tabs Content (Home, TP, Misc, Config)
local homeFrame = Instance.new("Frame")
homeFrame.Size = UDim2.new(0, 480, 0, 250)
homeFrame.Position = UDim2.new(0, 10, 0, 60)
homeFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
homeFrame.Parent = mainFrame
addCorner(homeFrame, 10)

local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(0, 480, 0, 40)
welcomeLabel.Position = UDim2.new(0, 0, 0, 10)
welcomeLabel.Text = "Welcome, " .. player.DisplayName .. " to EmberWare v.1"
welcomeLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeLabel.TextScaled = true
welcomeLabel.Font = Enum.Font.GothamBold
welcomeLabel.Parent = homeFrame

local tpFrame = Instance.new("Frame")
tpFrame.Size = UDim2.new(0, 480, 0, 250)
tpFrame.Position = UDim2.new(0, 10, 0, 60)
tpFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tpFrame.Visible = false
tpFrame.Parent = mainFrame
addCorner(tpFrame, 10)

-- Add List of Players to TP Tab
local tpList = Instance.new("ScrollingFrame")
tpList.Size = UDim2.new(0, 460, 0, 200)
tpList.Position = UDim2.new(0, 10, 0, 10)
tpList.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tpList.ScrollBarThickness = 10
tpList.Parent = tpFrame

for _, plr in ipairs(game.Players:GetPlayers()) do
    if plr ~= player then
        local tpButton = Instance.new("TextButton")
        tpButton.Size = UDim2.new(0, 460, 0, 30)
        tpButton.Text = plr.Name
        tpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tpButton.Parent = tpList

        tpButton.MouseButton1Click:Connect(function()
            teleportService:TeleportToPlaceInstance(game.PlaceId, plr.UserId)
        end)
    end
end

local miscFrame = Instance.new("Frame")
miscFrame.Size = UDim2.new(0, 480, 0, 250)
miscFrame.Position = UDim2.new(0, 10, 0, 60)
miscFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
miscFrame.Visible = false
miscFrame.Parent = mainFrame
addCorner(miscFrame, 10)

-- Add Misc Buttons (Glow, Invisibility, Infinite Jump, etc.)
local glowButton = Instance.new("TextButton")
glowButton.Size = UDim2.new(0, 200, 0, 40)
glowButton.Position = UDim2.new(0, 10, 0, 10)
glowButton.Text = "Glow"
glowButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
glowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
glowButton.Parent = miscFrame
addCorner(glowButton, 10)

local invisButton = Instance.new("TextButton")
invisButton.Size = UDim2.new(0, 200, 0, 40)
invisButton.Position = UDim2.new(0, 10, 0, 60)
invisButton.Text = "Invisibility"
invisButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
invisButton.TextColor3 = Color3.fromRGB(255, 255, 255)
invisButton.Parent = miscFrame
addCorner(invisButton, 10)

local infiniteJumpButton = Instance.new("TextButton")
infiniteJumpButton.Size = UDim2.new(0, 200, 0, 40)
infiniteJumpButton.Position = UDim2.new(0, 10, 0, 110)
infiniteJumpButton.Text = "Infinite Jump"
infiniteJumpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
infiniteJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
infiniteJumpButton.Parent = miscFrame
addCorner(infiniteJumpButton, 10)

local joinGameFrame = Instance.new("Frame")
joinGameFrame.Size = UDim2.new(0, 480, 0, 250)
joinGameFrame.Position = UDim2.new(0, 10, 0, 60)
joinGameFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
joinGameFrame.Visible = false
joinGameFrame.Parent = mainFrame
addCorner(joinGameFrame, 10)

-- Create Join Game TextBox
local joinGameTextBox = Instance.new("TextBox")
joinGameTextBox.Size = UDim2.new(0, 200, 0, 40)
joinGameTextBox.Position = UDim2.new(0, 10, 0, 10)
joinGameTextBox.PlaceholderText = "Enter ID"
joinGameTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
joinGameTextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
joinGameTextBox.Parent = joinGameFrame
addCorner(joinGameTextBox, 10)

local joinGameButton = Instance.new("TextButton")
joinGameButton.Size = UDim2.new(0, 200, 0, 40)
joinGameButton.Position = UDim2.new(0, 10, 0, 60)
joinGameButton.Text = "Join Game"
joinGameButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
joinGameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
joinGameButton.Parent = joinGameFrame
addCorner(joinGameButton, 10)

joinGameButton.MouseButton1Click:Connect(function()
    local gameId = joinGameTextBox.Text
    if gameId ~= "" then
        teleportService:Teleport(gameId, player)
    end
end)

local configFrame = Instance.new("Frame")
configFrame.Size = UDim2.new(0, 480, 0, 250)
configFrame.Position = UDim2.new(0, 10, 0, 60)
configFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
configFrame.Visible = false
configFrame.Parent = mainFrame
addCorner(configFrame, 10)

-- Tab Switching Logic
homeTabButton.MouseButton1Click:Connect(function()
    homeFrame.Visible = true
    tpFrame.Visible = false
    miscFrame.Visible = false
    configFrame.Visible = false
end)

tpTabButton.MouseButton1Click:Connect(function()
    homeFrame.Visible = false
    tpFrame.Visible = true
    miscFrame.Visible = false
    configFrame.Visible = false
end)

miscTabButton.MouseButton1Click:Connect(function()
    homeFrame.Visible = false
    tpFrame.Visible = false
    miscFrame.Visible = true
    configFrame.Visible = false
end)

configTabButton.MouseButton1Click:Connect(function()
    homeFrame.Visible = false
    tpFrame.Visible = false
    miscFrame.Visible = false
    configFrame.Visible = true
end)

-- Show Main GUI on Ember-Ware Button Click
mainButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
end)
