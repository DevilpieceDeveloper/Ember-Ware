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
mainButton.Parent = guilocal player = game.Players.LocalPlayer
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
homeText.TextColor3 = Color3.fromRGB(255, 100, 50)
homeText.BackgroundTransparency = 1
homeText.TextScaled = true
homeText.Font = Enum.Font.GothamBold
homeText.Parent = homeFrame

-- TP Tab Content
local function createPlayerButton(playerName, posY)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Position = UDim2.new(0, 0, 0, posY)
    button.Text = playerName
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.Parent = tpFrame
    addCorner(button, 10)
    return button
end

local function updatePlayers()
    for _, v in pairs(tpFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    local yPos = 10
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player then
            local button = createPlayerButton(plr.DisplayName, yPos)
            button.MouseButton1Click:Connect(function()
                player.Character:SetPrimaryPartCFrame(plr.Character.PrimaryPart.CFrame)
            end)
            yPos = yPos + 50
        end
    end
end

updatePlayers()
game.Players.PlayerAdded:Connect(updatePlayers)
game.Players.PlayerRemoving:Connect(updatePlayers)

-- Misc Tab Content
local function createMiscButton(name, posY, action)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Position = UDim2.new(0.1, 0, 0, posY)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.Parent = miscFrame
    addCorner(button, 10)
    local toggled = false
    button.MouseButton1Click:Connect(function()
        toggled = not toggled
        action(toggled)
    end)
    return button
end

createMiscButton("Glow", 10, function(state)
    if state then player.Character.HumanoidRootPart.Material = Enum.Material.Neon
    else player.Character.HumanoidRootPart.Material = Enum.Material.Plastic end
end)

createMiscButton("Invisibility", 60, function(state)
    for _, part in pairs(player.Character:GetDescendants()) do
        if part:IsA("BasePart") then part.Transparency = state and 1 or 0 end
    end
end)

createMiscButton("Infinite Jump", 110, function(state)
    if state then game:GetService("UserInputService").JumpRequest:Connect(function()
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end) end
end)

-- Config Tab Content (Already Added Above)

-- Tab Switching
homeTabButton.MouseButton1Click:Connect(function() homeFrame.Visible, tpFrame.Visible, miscFrame.Visible, configFrame.Visible = true, false, false, false end)
tpTabButton.MouseButton1Click:Connect(function() homeFrame.Visible, tpFrame.Visible, miscFrame.Visible, configFrame.Visible = false, true, false, false end)
miscTabButton.MouseButton1Click:Connect(function() homeFrame.Visible, tpFrame.Visible, miscFrame.Visible, configFrame.Visible = false, false, true, false end)
configTabButton.MouseButton1Click:Connect(function() homeFrame.Visible, tpFrame.Visible, miscFrame.Visible, configFrame.Visible = false, false, false, true end)

mainButton.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)

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

-- Background Image
local backgroundImage = Instance.new("ImageLabel")
backgroundImage.Size = UDim2.new(1, 0, 1, 0)
backgroundImage.Position = UDim2.new(0, 0, 0, 0)
backgroundImage.BackgroundTransparency = 1
backgroundImage.ImageTransparency = 1 -- Hidden by default
backgroundImage.Parent = mainFrame

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
homeText.TextColor3 = Color3.fromRGB(255, 100, 50) -- Red/Orange Color
homeText.BackgroundTransparency = 1
homeText.TextScaled = true
homeText.Font = Enum.Font.GothamBold
homeText.Parent = homeFrame

-- Config Tab Content
local colorTextBox = Instance.new("TextBox")
colorTextBox.Size = UDim2.new(0.8, 0, 0, 40)
colorTextBox.Position = UDim2.new(0.1, 0, 0, 20)
colorTextBox.PlaceholderText = "Enter RGB (e.g., 2,255,19)"
colorTextBox.Text = ""
colorTextBox.Parent = configFrame
addCorner(colorTextBox, 10)

local applyColorButton = Instance.new("TextButton")
applyColorButton.Size = UDim2.new(0.8, 0, 0, 40)
applyColorButton.Position = UDim2.new(0.1, 0, 0, 70)
applyColorButton.Text = "Apply Button Color"
applyColorButton.Parent = configFrame
addCorner(applyColorButton, 10)

local imageTextBox = Instance.new("TextBox")
imageTextBox.Size = UDim2.new(0.8, 0, 0, 40)
imageTextBox.Position = UDim2.new(0.1, 0, 0, 130)
imageTextBox.PlaceholderText = "Enter Image ID"
imageTextBox.Text = ""
imageTextBox.Parent = configFrame
addCorner(imageTextBox, 10)

local applyImageButton = Instance.new("TextButton")
applyImageButton.Size = UDim2.new(0.8, 0, 0, 40)
applyImageButton.Position = UDim2.new(0.1, 0, 0, 180)
applyImageButton.Text = "Apply Background Image"
applyImageButton.Parent = configFrame
addCorner(applyImageButton, 10)

-- Change Button Color Function
applyColorButton.MouseButton1Click:Connect(function()
    local r, g, b = colorTextBox.Text:match("(%d+),(%d+),(%d+)")
    if r and g and b then
        local newColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
        for _, button in pairs(tabFrame:GetChildren()) do
            if button:IsA("TextButton") then
                button.BackgroundColor3 = newColor
            end
        end
    end
end)

-- Change Background Image Function
applyImageButton.MouseButton1Click:Connect(function()
    local imageID = imageTextBox.Text
    if imageID and imageID ~= "" then
        backgroundImage.Image = "rbxassetid://" .. imageID
        backgroundImage.ImageTransparency = 0
    end
end)

-- Tab Switching
homeTabButton.MouseButton1Click:Connect(function() homeFrame.Visible, tpFrame.Visible, miscFrame.Visible, configFrame.Visible = true, false, false, false end)
configTabButton.MouseButton1Click:Connect(function() homeFrame.Visible, tpFrame.Visible, miscFrame.Visible, configFrame.Visible = false, false, false, true end)

mainButton.MouseButton1Click:Connect(function() mainFrame.Visible = not mainFrame.Visible end)
