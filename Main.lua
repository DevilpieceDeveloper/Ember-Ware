-- Variables
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local mainButton = Instance.new("TextButton")
mainButton.Size = UDim2.new(0, 200, 0, 60)
mainButton.Position = UDim2.new(0, 20, 0, 20)
mainButton.Text = "Ember-Ware"
mainButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainButton.TextScaled = true
mainButton.Font = Enum.Font.GothamBold
mainButton.Parent = gui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
mainFrame.Parent = gui

local tabHolder = Instance.new("Frame")
tabHolder.Size = UDim2.new(0, 600, 0, 40)
tabHolder.Position = UDim2.new(0, 0, 0, 0)
tabHolder.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tabHolder.Parent = mainFrame

local homeTabButton = Instance.new("TextButton")
homeTabButton.Size = UDim2.new(0, 150, 0, 40)
homeTabButton.Position = UDim2.new(0, 0, 0, 0)
homeTabButton.Text = "Home"
homeTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
homeTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
homeTabButton.Parent = tabHolder

local tpTabButton = Instance.new("TextButton")
tpTabButton.Size = UDim2.new(0, 150, 0, 40)
tpTabButton.Position = UDim2.new(0, 150, 0, 0)
tpTabButton.Text = "TP"
tpTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
tpTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpTabButton.Parent = tabHolder

local miscTabButton = Instance.new("TextButton")
miscTabButton.Size = UDim2.new(0, 150, 0, 40)
miscTabButton.Position = UDim2.new(0, 300, 0, 0)
miscTabButton.Text = "Misc"
miscTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
miscTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
miscTabButton.Parent = tabHolder

local configTabButton = Instance.new("TextButton")
configTabButton.Size = UDim2.new(0, 150, 0, 40)
configTabButton.Position = UDim2.new(0, 450, 0, 0)
configTabButton.Text = "Config"
configTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
configTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
configTabButton.Parent = tabHolder

-- Home Tab Content
local homeFrame = Instance.new("Frame")
homeFrame.Size = UDim2.new(0, 600, 0, 360)
homeFrame.Position = UDim2.new(0, 0, 0, 40)
homeFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
homeFrame.Parent = mainFrame
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(0, 600, 0, 360)
welcomeLabel.Position = UDim2.new(0, 0, 0, 0)
welcomeLabel.Text = "Welcome, " .. player.DisplayName .. " to Emberware v.1"
welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeLabel.TextScaled = true
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Parent = homeFrame

-- TP Tab Content
local tpFrame = Instance.new("Frame")
tpFrame.Size = UDim2.new(0, 600, 0, 360)
tpFrame.Position = UDim2.new(0, 0, 0, 40)
tpFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tpFrame.Visible = false
tpFrame.Parent = mainFrame

local playerList = Instance.new("Frame")
playerList.Size = UDim2.new(0, 600, 0, 300)
playerList.Position = UDim2.new(0, 0, 0, 0)
playerList.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
playerList.Parent = tpFrame

local function updatePlayerList()
    local yOffset = 10
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            local tpButton = Instance.new("TextButton")
            tpButton.Size = UDim2.new(0, 580, 0, 40)
            tpButton.Position = UDim2.new(0, 10, 0, yOffset)
            tpButton.Text = "Teleport to " .. otherPlayer.DisplayName
            tpButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tpButton.Parent = playerList
            tpButton.MouseButton1Click:Connect(function()
                player:MoveTo(otherPlayer.Character.PrimaryPart.Position)
            end)
            yOffset = yOffset + 50
        end
    end
end

updatePlayerList()

-- Misc Tab Content
local miscFrame = Instance.new("Frame")
miscFrame.Size = UDim2.new(0, 600, 0, 360)
miscFrame.Position = UDim2.new(0, 0, 0, 40)
miscFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
miscFrame.Visible = false
miscFrame.Parent = mainFrame

local glowButton = Instance.new("TextButton")
glowButton.Size = UDim2.new(0, 200, 0, 40)
glowButton.Position = UDim2.new(0, 10, 0, 10)
glowButton.Text = "Glow"
glowButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
glowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
glowButton.Parent = miscFrame

local invisButton = Instance.new("TextButton")
invisButton.Size = UDim2.new(0, 200, 0, 40)
invisButton.Position = UDim2.new(0, 10, 0, 60)
invisButton.Text = "Invisibility"
invisButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
invisButton.TextColor3 = Color3.fromRGB(255, 255, 255)
invisButton.Parent = miscFrame

local infiniteJumpButton = Instance.new("TextButton")
infiniteJumpButton.Size = UDim2.new(0, 200, 0, 40)
infiniteJumpButton.Position = UDim2.new(0, 10, 0, 110)
infiniteJumpButton.Text = "Infinite Jump"
infiniteJumpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
infiniteJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
infiniteJumpButton.Parent = miscFrame

local gameIdInput = Instance.new("TextBox")
gameIdInput.Size = UDim2.new(0, 200, 0, 40)
gameIdInput.Position = UDim2.new(0, 10, 0, 160)
gameIdInput.PlaceholderText = "Enter Game ID"
gameIdInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
gameIdInput.TextColor3 = Color3.fromRGB(255, 255, 255)
gameIdInput.Parent = miscFrame

local joinGameButton = Instance.new("TextButton")
joinGameButton.Size = UDim2.new(0, 200, 0, 40)
joinGameButton.Position = UDim2.new(0, 10, 0, 210)
joinGameButton.Text = "Join Game"
joinGameButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
joinGameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
joinGameButton.Parent = miscFrame

joinGameButton.MouseButton1Click:Connect(function()
    local gameId = gameIdInput.Text
    if gameId and gameId ~= "" then
        teleportService:Teleport(gameId, player)
    end
end)

-- Config Tab Content
local configFrame = Instance.new("Frame")
configFrame.Size = UDim2.new(0, 600, 0, 360)
configFrame.Position = UDim2.new(0, 0, 0, 40)
configFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
configFrame.Visible = false
configFrame.Parent = mainFrame

local buttonColorPicker = Instance.new("TextButton")
buttonColorPicker.Size = UDim2.new(0, 200, 0, 40)
buttonColorPicker.Position = UDim2.new(0, 10, 0, 10)
buttonColorPicker.Text = "Change Button Color"
buttonColorPicker.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
buttonColorPicker.TextColor3 = Color3.fromRGB(255, 255, 255)
buttonColorPicker.Parent = configFrame

buttonColorPicker.MouseButton1Click:Connect(function()
    local newColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    homeTabButton.BackgroundColor3 = newColor
    tpTabButton.BackgroundColor3 = newColor
    miscTabButton.BackgroundColor3 = newColor
    configTabButton.BackgroundColor3 = newColor
end)

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

