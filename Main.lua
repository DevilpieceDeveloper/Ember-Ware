local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")
local userInputService = game:GetService("UserInputService")
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

-- EmberWare Button (Opens GUI)
local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0, 150, 0, 50)
openButton.Position = UDim2.new(0, 10, 0.5, -25) -- Left side of screen
openButton.Text = "Ember-Ware"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
openButton.Font = Enum.Font.GothamBold
openButton.TextScaled = true
openButton.Parent = gui
addCorner(openButton, 15)

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

-- Sidebar for Tabs
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 100, 1, 0)
tabFrame.Position = UDim2.new(0, 0, 0, 0)
tabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tabFrame.Parent = mainFrame
addCorner(tabFrame, 15)

-- Function to create tab buttons
local function createTab(name)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(1, 0, 0, 40)
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    tab.Parent = tabFrame
    addCorner(tab, 10)
    return tab
end

local homeTab = createTab("Home")
local tpTab = createTab("TP")
local miscTab = createTab("Misc")
local configTab = createTab("Config")
local bedwarsTab

if gameID == 6872265039 then
    bedwarsTab = createTab("BedWars")
end

-- Home Tab
local homeFrame = Instance.new("Frame")
homeFrame.Size = UDim2.new(1, -100, 1, 0)
homeFrame.Position = UDim2.new(0, 100, 0, 0)
homeFrame.BackgroundTransparency = 1
homeFrame.Parent = mainFrame

local welcomeText = Instance.new("TextLabel")
welcomeText.Size = UDim2.new(1, 0, 0, 100)
welcomeText.Text = "Welcome, " .. player.DisplayName .. " to EmberWare v.1"
welcomeText.TextColor3 = Color3.fromRGB(255, 120, 0)
welcomeText.TextScaled = true
welcomeText.Parent = homeFrame

local madeByText = Instance.new("TextLabel")
madeByText.Size = UDim2.new(1, 0, 0, 30)
madeByText.Position = UDim2.new(0, 0, 0.2, 0)
madeByText.Text = "Made by @Draco"
madeByText.TextColor3 = Color3.fromRGB(200, 200, 200)
madeByText.TextScaled = true
madeByText.Parent = homeFrame

-- Function to switch tabs
local function switchTab(frame)
    for _, child in ipairs(mainFrame:GetChildren()) do
        if child:IsA("Frame") and child ~= tabFrame then
            child.Visible = false
        end
    end
    frame.Visible = true
end

homeTab.MouseButton1Click:Connect(function() switchTab(homeFrame) end)

-- TP Tab
local tpFrame = Instance.new("Frame")
tpFrame.Size = UDim2.new(1, -100, 1, 0)
tpFrame.Position = UDim2.new(0, 100, 0, 0)
tpFrame.Visible = false
tpFrame.Parent = mainFrame

tpTab.MouseButton1Click:Connect(function()
    tpFrame:ClearAllChildren()
    switchTab(tpFrame)

    for _, plr in ipairs(players:GetPlayers()) do
        if plr ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 40)
            btn.Text = plr.DisplayName
            btn.Parent = tpFrame
            addCorner(btn, 10)
            btn.MouseButton1Click:Connect(function()
                player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
            end)
        end
    end
end)

-- Config Tab
local configFrame = Instance.new("Frame")
configFrame.Size = UDim2.new(1, -100, 1, 0)
configFrame.Position = UDim2.new(0, 100, 0, 0)
configFrame.Visible = false
configFrame.Parent = mainFrame

local colorTextBox = Instance.new("TextBox")
colorTextBox.Size = UDim2.new(0.8, 0, 0, 40)
colorTextBox.Position = UDim2.new(0.1, 0, 0.2, 0)
colorTextBox.Text = "Enter RGB (e.g., 2,255,19)"
colorTextBox.Parent = configFrame

local imageTextBox = Instance.new("TextBox")
imageTextBox.Size = UDim2.new(0.8, 0, 0, 40)
imageTextBox.Position = UDim2.new(0.1, 0, 0.3, 0)
imageTextBox.Text = "Enter Roblox Image ID"
imageTextBox.Parent = configFrame

configTab.MouseButton1Click:Connect(function() switchTab(configFrame) end)

-- Make EmberWare Button Toggle GUI
openButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
