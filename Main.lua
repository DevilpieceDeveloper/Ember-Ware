local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- Kick player if in the restricted game
if game.PlaceId == 4924922222 then
    player:Kick("No. Just NO")
    return
end

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

-- Main Button
local mainButton = Instance.new("TextButton")
mainButton.Size = UDim2.new(0, 150, 0, 60)
mainButton.Position = UDim2.new(0, 20, 0, 20)
mainButton.Text = "EmberWare"
mainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainButton.TextColor3 = Color3.fromRGB(255, 100, 0)
mainButton.Font = Enum.Font.GothamBold
mainButton.TextScaled = true
mainButton.AutoButtonColor = true
mainButton.Parent = gui
addCorner(mainButton, 20)

-- UI Window
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

-- Tab Container
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(0, 120, 1, 0)
tabContainer.Position = UDim2.new(0, 0, 0, 0)
tabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tabContainer.Parent = mainFrame
addCorner(tabContainer, 10)

local tabList = {
    {Name = "🏠 Home"},
    {Name = "🚀 TP"},
    {Name = "✨ Misc"},
    {Name = "⚙ Settings"},
    {Name = "📜 Changelog"}
}

if game.PlaceId == 6872265039 then
    table.insert(tabList, {Name = "⚔ BedWars"})
end

-- Tabs
local tabButtons = {}
local currentTab = nil

local function switchTab(tabName)
    for _, frame in ipairs(mainFrame:GetChildren()) do
        if frame:IsA("Frame") and frame ~= tabContainer then
            frame.Visible = false
        end
    end
    if tabButtons[tabName] then
        tabButtons[tabName].Frame.Visible = true
    end
end

for _, tabData in ipairs(tabList) do
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1, 0, 0, 40)
    tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabButton.Text = tabData.Name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Parent = tabContainer
    addCorner(tabButton, 8)

    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.Position = UDim2.new(0, 120, 0, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    tabFrame.Parent = mainFrame

    tabButton.MouseButton1Click:Connect(function()
        switchTab(tabData.Name)
    end)

    tabButtons[tabData.Name] = {Button = tabButton, Frame = tabFrame}
end

-- Home
local homeLabel = Instance.new("TextLabel")
homeLabel.Size = UDim2.new(1, -130, 0, 50)
homeLabel.Position = UDim2.new(0, 130, 0, 10)
homeLabel.Text = "Welcome, " .. player.DisplayName .. " to EmberWare v1."
homeLabel.TextColor3 = Color3.fromRGB(255, 100, 0)
homeLabel.Font = Enum.Font.GothamBold
homeLabel.TextScaled = true
homeLabel.BackgroundTransparency = 1
homeLabel.Parent = tabButtons["🏠 Home"].Frame

local madeByLabel = Instance.new("TextLabel")
madeByLabel.Size = UDim2.new(1, -130, 0, 30)
madeByLabel.Position = UDim2.new(0, 130, 0, 60)
madeByLabel.Text = "Made by @Draco"
madeByLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
madeByLabel.Font = Enum.Font.GothamBold
madeByLabel.TextScaled = true
madeByLabel.BackgroundTransparency = 1
madeByLabel.Parent = tabButtons["🏠 Home"].Frame

-- Teleport Tab
local tpList = Instance.new("ScrollingFrame")
tpList.Size = UDim2.new(1, -130, 1, -50)
tpList.Position = UDim2.new(0, 130, 0, 10)
tpList.CanvasSize = UDim2.new(0, 0, 1, 0)
tpList.Parent = tabButtons["🚀 TP"].Frame

for _, plr in ipairs(game.Players:GetPlayers()) do
    local tpButton = Instance.new("TextButton")
    tpButton.Size = UDim2.new(1, 0, 0, 40)
    tpButton.Text = plr.DisplayName
    tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tpButton.Parent = tpList
    addCorner(tpButton, 8)

    tpButton.MouseButton1Click:Connect(function()
        player.Character:MoveTo(plr.Character:GetPrimaryPartCFrame().p)
    end)
end

-- Settings
local buttonColorBox = Instance.new("TextBox")
buttonColorBox.Size = UDim2.new(1, -130, 0, 40)
buttonColorBox.Position = UDim2.new(0, 130, 0, 10)
buttonColorBox.PlaceholderText = "Enter RGB (e.g. 255,0,0)"
buttonColorBox.Parent = tabButtons["⚙ Settings"].Frame

local imageIDBox = Instance.new("TextBox")
imageIDBox.Size = UDim2.new(1, -130, 0, 40)
imageIDBox.Position = UDim2.new(0, 130, 0, 60)
imageIDBox.PlaceholderText = "Enter Image ID"
imageIDBox.Parent = tabButtons["⚙ Settings"].Frame

-- Changelog
local changelogLabel = Instance.new("TextLabel")
changelogLabel.Size = UDim2.new(1, -130, 1, -50)
changelogLabel.Position = UDim2.new(0, 130, 0, 10)
changelogLabel.Text = "Add your changelog here."
changelogLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
changelogLabel.TextScaled = true
changelogLabel.BackgroundTransparency = 1
changelogLabel.Parent = tabButtons["📜 Changelog"].Frame

-- Open UI
mainButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

switchTab("🏠 Home")
