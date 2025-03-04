local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- Create UI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Add rounded corners function
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

-- Home Tab
local homeLabel = Instance.new("TextLabel")
homeLabel.Size = UDim2.new(1, 0, 0, 50)
homeLabel.Text = "Welcome, " .. player.DisplayName .. " to EmberWare v.1"
homeLabel.TextScaled = true
homeLabel.TextColor3 = Color3.fromRGB(255, 85, 0) -- Animated later
homeLabel.Parent = tabs["Home"].Frame

local creatorLabel = Instance.new("TextLabel")
creatorLabel.Size = UDim2.new(1, 0, 0, 30)
creatorLabel.Position = UDim2.new(0, 0, 1, -30)
creatorLabel.Text = "Made by @Draco"
creatorLabel.TextScaled = true
creatorLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
creatorLabel.Parent = tabs["Home"].Frame

-- TP Tab
local tpList = Instance.new("ScrollingFrame")
tpList.Size = UDim2.new(1, 0, 1, -10)
tpList.Parent = tabs["TP"].Frame

for _, plr in ipairs(players:GetPlayers()) do
    local tpButton = Instance.new("TextButton")
    tpButton.Size = UDim2.new(1, 0, 0, 40)
    tpButton.Text = plr.DisplayName
    tpButton.Parent = tpList
    tpButton.MouseButton1Click:Connect(function()
        player.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
    end)
end

-- Misc Tab
local miscFrame = tabs["Misc"].Frame
local jumpToggle = Instance.new("TextButton")
jumpToggle.Size = UDim2.new(0, 100, 0, 50)
jumpToggle.Text = "Infinite Jump (OFF)"
jumpToggle.Parent = miscFrame
jumpToggle.MouseButton1Click:Connect(function()
    infiniteJump = not infiniteJump
    jumpToggle.Text = "Infinite Jump (" .. (infiniteJump and "ON" or "OFF") .. ")"
end)

-- Config Tab
local configFrame = tabs["Config"].Frame
local colorInput = Instance.new("TextBox")
colorInput.Size = UDim2.new(1, 0, 0, 40)
colorInput.PlaceholderText = "Enter RGB (2,255,19)"
colorInput.Parent = configFrame
colorInput.FocusLost:Connect(function()
    local r, g, b = colorInput.Text:match("(%d+),(%d+),(%d+)")
    if r and g and b then
        for _, tab in pairs(tabs) do
            tab.Button.BackgroundColor3 = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
        end
    end
end)

-- Show BedWars Tab if Game ID Matches
if game.PlaceId == 6872265039 then
    createTabButton("BedWars")
end

-- Show GUI
mainButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
