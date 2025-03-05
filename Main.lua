local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")
local userInputService = game:GetService("UserInputService")

-- Kick player if in restricted game
if game.PlaceId == 4924922222 then
    player:Kick("No. Just NO")
    return
end

-- UI Setup
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- UI Window
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 450) -- Increased UI size
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -50, 0, 10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeButton.Parent = mainFrame

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Tabs
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(0, 140, 1, 0)
tabContainer.Position = UDim2.new(0, 0, 0, 0)
tabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tabContainer.Parent = mainFrame

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
    tabButton.Size = UDim2.new(1, 0, 0, 50)
    tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabButton.Text = tabData.Name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Parent = tabContainer

    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1, -150, 1, 0)
    tabFrame.Position = UDim2.new(0, 150, 0, 0)
    tabFrame.BackgroundTransparency = 0
    tabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    tabFrame.Visible = false
    tabFrame.Parent = mainFrame

    tabButton.MouseButton1Click:Connect(function()
        switchTab(tabData.Name)
    end)

    tabButtons[tabData.Name] = {Button = tabButton, Frame = tabFrame}
end

-- Home
local homeLabel = Instance.new("TextLabel")
homeLabel.Size = UDim2.new(1, -150, 0, 70)
homeLabel.Position = UDim2.new(0, 150, 0, 10)
homeLabel.Text = "Welcome, " .. player.DisplayName .. " to EmberWare v1."
homeLabel.TextColor3 = Color3.fromRGB(255, 100, 0)
homeLabel.Font = Enum.Font.GothamBold
homeLabel.TextScaled = true
homeLabel.TextWrapped = true
homeLabel.BackgroundTransparency = 1
homeLabel.Parent = tabButtons["🏠 Home"].Frame

local madeByLabel = Instance.new("TextLabel")
madeByLabel.Size = UDim2.new(1, -150, 0, 40)
madeByLabel.Position = UDim2.new(0, 150, 0, 80)
madeByLabel.Text = "Made by @Draco"
madeByLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
madeByLabel.Font = Enum.Font.GothamBold
madeByLabel.TextScaled = true
madeByLabel.TextWrapped = true
madeByLabel.BackgroundTransparency = 1
madeByLabel.Parent = tabButtons["🏠 Home"].Frame

-- Changelog
local changelogLabel = Instance.new("TextLabel")
changelogLabel.Size = UDim2.new(1, -150, 1, -50)
changelogLabel.Position = UDim2.new(0, 150, 0, 10)
changelogLabel.Text = "V 1.2: Added Bedwars and Brookhaven functionality, and reworked UI. Version 2 is the next update!"
changelogLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
changelogLabel.Font = Enum.Font.GothamBold
changelogLabel.TextScaled = true
changelogLabel.TextWrapped = true
changelogLabel.BackgroundTransparency = 1
changelogLabel.Parent = tabButtons["📜 Changelog"].Frame

-- Teleport Tab
local tpList = Instance.new("ScrollingFrame")
tpList.Size = UDim2.new(1, -150, 1, -50)
tpList.Position = UDim2.new(0, 150, 0, 10)
tpList.CanvasSize = UDim2.new(0, 0, 1, 0)
tpList.Parent = tabButtons["🚀 TP"].Frame

for _, plr in ipairs(game.Players:GetPlayers()) do
    local tpButton = Instance.new("TextButton")
    tpButton.Size = UDim2.new(1, 0, 0, 50)
    tpButton.Text = plr.DisplayName
    tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tpButton.Parent = tpList

    tpButton.MouseButton1Click:Connect(function()
        player.Character:MoveTo(plr.Character:GetPrimaryPartCFrame().p)
    end)
end

-- BedWars Tab Features
if game.PlaceId == 6872265039 then
    local bedWarsFrame = Instance.new("Frame")
    bedWarsFrame.Size = UDim2.new(1, -150, 1, -50)
    bedWarsFrame.Position = UDim2.new(0, 150, 0, 10)
    bedWarsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    bedWarsFrame.Visible = true
    bedWarsFrame.Parent = tabButtons["⚔ BedWars"].Frame

    -- No CPS Limit
    local noCpsLimitButton = Instance.new("TextButton")
    noCpsLimitButton.Size = UDim2.new(1, 0, 0, 50)
    noCpsLimitButton.Text = "No CPS Limit"
    noCpsLimitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    noCpsLimitButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    noCpsLimitButton.Parent = bedWarsFrame

    -- Wall Climb
    local wallClimbButton = Instance.new("TextButton")
    wallClimbButton.Size = UDim2.new(1, 0, 0, 50)
    wallClimbButton.Text = "Wall Climb"
    wallClimbButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    wallClimbButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    wallClimbButton.Parent = bedWarsFrame

    -- Go Home (Teleport)
    local goHomeButton = Instance.new("TextButton")
    goHomeButton.Size = UDim2.new(1, 0, 0, 50)
    goHomeButton.Text = "Go Home"
    goHomeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    goHomeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    goHomeButton.Parent = bedWarsFrame

    goHomeButton.MouseButton1Click:Connect(function()
        local character = player.Character
        if character then
            -- Teleport upwards by 10 meters, freeze, then teleport to original position
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            local originalPosition = humanoidRootPart.Position
            humanoidRootPart.CFrame = CFrame.new(originalPosition + Vector3.new(0, 10, 0))
            wait(0.5)
            humanoidRootPart.CFrame = CFrame.new(originalPosition)
        end
    end)
end

-- Initial Tab (Home)
switchTab("🏠 Home")

-- Open EmberWare Button
local mainButton = Instance.new("TextButton")
mainButton.Size = UDim2.new(0, 200, 0, 50)
mainButton.Position = UDim2.new(0, 10, 0, 10)
mainButton.Text = "Open EmberWare"
mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainButton.Font = Enum.Font.GothamBold
mainButton.TextSize = 24
mainButton.Parent = player.PlayerGui

mainButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
end)

-- Add Animation
local function animateButton(button)
    button.MouseButton1Click:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        wait(0.1)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
end

animateButton(mainButton)
animateButton(closeButton)
animateButton(tabButtons["🏠 Home"].Button)
animateButton(tabButtons["🚀 TP"].Button)
animateButton(tabButtons["✨ Misc"].Button)
animateButton(tabButtons["⚙ Settings"].Button)
animateButton(tabButtons["📜 Changelog"].Button)
