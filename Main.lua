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
mainButton.Size = UDim2.new(0, 200, 0, 80)
mainButton.Position = UDim2.new(0, 30, 0, 30)
mainButton.Text = "Ember-Ware"
mainButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainButton.Parent = gui
mainButton.TextScaled = true
mainButton.Font = Enum.Font.GothamBold
mainButton.AutoButtonColor = true
addCorner(mainButton, 20)

-- Create Main UI Frame
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
tabFrame.Size = UDim2.new(0, 120, 1, 0)
tabFrame.Position = UDim2.new(0, 0, 0, 0)
tabFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tabFrame.Parent = mainFrame
addCorner(tabFrame, 10)

-- Function to create tab buttons
local function createTabButton(name, posY)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Position = UDim2.new(0, 0, 0, posY)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Parent = tabFrame
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    addCorner(button, 10)
    return button
end

-- Tabs
local homeTabButton = createTabButton("Home", 10)
local tpTabButton = createTabButton("TP", 70)
local miscTabButton = createTabButton("Misc", 130)
local configTabButton = createTabButton("Config", 190)

-- Content Frames
local function createContentFrame()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -140, 1, -20)
    frame.Position = UDim2.new(0, 130, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.Parent = mainFrame
    frame.Visible = false
    addCorner(frame, 10)
    return frame
end

local homeFrame = createContentFrame()
local tpFrame = createContentFrame()
local miscFrame = createContentFrame()
local configFrame = createContentFrame()

-- Home Tab Content
local homeText = Instance.new("TextLabel")
homeText.Size = UDim2.new(1, 0, 0.2, 0)
homeText.Position = UDim2.new(0, 0, 0, 20)
homeText.Text = "Welcome, " .. player.DisplayName .. " to Emberware v.1"
homeText.TextColor3 = Color3.fromRGB(255, 255, 255)
homeText.BackgroundTransparency = 1
homeText.TextScaled = true
homeText.Font = Enum.Font.GothamBold
homeText.Parent = homeFrame

-- TP Tab Content
local tpList = Instance.new("ScrollingFrame")
tpList.Size = UDim2.new(1, 0, 1, 0)
tpList.Position = UDim2.new(0, 0, 0, 0)
tpList.CanvasSize = UDim2.new(0, 0, 2, 0)
tpList.BackgroundTransparency = 1
tpList.Parent = tpFrame

local function refreshPlayerList()
    for _, v in pairs(tpList:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end

    local yOffset = 10
    for _, plr in pairs(game.Players:GetPlayers()) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.9, 0, 0, 50)
        button.Position = UDim2.new(0.05, 0, 0, yOffset)
        button.Text = plr.DisplayName
        button.Parent = tpList
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        button.Font = Enum.Font.GothamBold
        button.TextScaled = true
        addCorner(button, 10)

        button.MouseButton1Click:Connect(function()
            player.Character:SetPrimaryPartCFrame(plr.Character.HumanoidRootPart.CFrame)
        end)

        yOffset = yOffset + 60
    end
end

-- Misc Tab Content
local function createMiscButton(name, posY)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0, 50)
    button.Position = UDim2.new(0.1, 0, 0, posY)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.Parent = miscFrame
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    addCorner(button, 10)
    return button
end

local glowButton = createMiscButton("Glow", 20)
local invisButton = createMiscButton("Invisibility", 80)
local jumpButton = createMiscButton("Infinite Jump", 140)

-- Toggle Infinite Jump
local jumpEnabled = false
jumpButton.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if jumpEnabled then
            player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)

-- Toggle Invisibility
local invisEnabled = false
invisButton.MouseButton1Click:Connect(function()
    invisEnabled = not invisEnabled
    for _, v in pairs(player.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = invisEnabled and 1 or 0
        end
    end
end)

-- Tab Switching
homeTabButton.MouseButton1Click:Connect(function() homeFrame.Visible, tpFrame.Visible, miscFrame.Visible = true, false, false end)
tpTabButton.MouseButton1Click:Connect(function() refreshPlayerList() homeFrame.Visible, tpFrame.Visible, miscFrame.Visible = false, true, false end)
miscTabButton.MouseButton1Click:Connect(function() homeFrame.Visible, tpFrame.Visible, miscFrame.Visible = false, false, true end)

mainButton.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)
