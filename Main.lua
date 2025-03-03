local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")

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

-- Create UI Window
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
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

-- Create Tab Holder
local tabHolder = Instance.new("Frame")
tabHolder.Size = UDim2.new(1, 0, 0, 50)
tabHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tabHolder.Parent = mainFrame
addCorner(tabHolder, 15)

-- Create Content Frames
local contentFrames = {}
local tabs = {"Home", "TP", "Misc", "Config"}

for i, tabName in ipairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0.25, -5, 1, 0)
    tabButton.Position = UDim2.new((i - 1) * 0.25, 5, 0, 0)
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    tabButton.Parent = tabHolder
    tabButton.Font = Enum.Font.GothamBold
    addCorner(tabButton, 10)

    -- Create Content Frame for each tab
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -50)
    contentFrame.Position = UDim2.new(0, 0, 0, 50)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame
    contentFrame.Visible = (i == 1) -- Only Home is visible by default
    contentFrames[tabName] = contentFrame

    tabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(contentFrames) do
            frame.Visible = false
        end
        contentFrame.Visible = true
    end)
end

-- Home Tab Content
local homeText = Instance.new("TextLabel")
homeText.Size = UDim2.new(1, 0, 0, 50)
homeText.Position = UDim2.new(0, 0, 0, 10)
homeText.Text = "Welcome, " .. player.DisplayName .. " to EmberWare v.1!"
homeText.TextColor3 = Color3.fromRGB(255, 255, 255)
homeText.BackgroundTransparency = 1
homeText.TextScaled = true
homeText.Font = Enum.Font.GothamBold
homeText.Parent = contentFrames["Home"]

-- TP Tab Content
local playerList = Instance.new("ScrollingFrame")
playerList.Size = UDim2.new(1, 0, 1, -10)
playerList.Position = UDim2.new(0, 0, 0, 10)
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)
playerList.Parent = contentFrames["TP"]

local function updatePlayerList()
    for _, child in ipairs(playerList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    for _, plr in ipairs(game.Players:GetPlayers()) do
        local tpButton = Instance.new("TextButton")
        tpButton.Size = UDim2.new(1, 0, 0, 50)
        tpButton.Text = "Teleport to " .. plr.DisplayName
        tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tpButton.Parent = playerList
        addCorner(tpButton, 10)

        tpButton.MouseButton1Click:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
            end
        end)
    end
end

game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

-- Misc Tab Content
local miscOptions = {"Glow", "Invisibility", "Infinite Jump", "Join Game ID"}
for i, option in ipairs(miscOptions) do
    local miscButton = Instance.new("TextButton")
    miscButton.Size = UDim2.new(1, 0, 0, 50)
    miscButton.Position = UDim2.new(0, 0, 0, (i - 1) * 55)
    miscButton.Text = option
    miscButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    miscButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    miscButton.Parent = contentFrames["Misc"]
    addCorner(miscButton, 10)
end

-- Config Tab Content
local configText = Instance.new("TextLabel")
configText.Size = UDim2.new(1, 0, 0, 50)
configText.Position = UDim2.new(0, 0, 0, 10)
configText.Text = "Configuration Settings (Coming Soon)"
configText.TextColor3 = Color3.fromRGB(255, 255, 255)
configText.BackgroundTransparency = 1
configText.TextScaled = true
configText.Font = Enum.Font.GothamBold
configText.Parent = contentFrames["Config"]

-- Open GUI on Button Click
mainButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
