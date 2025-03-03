local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")

-- Ensure PlayerGui is ready
local playerGui = player:WaitForChild("PlayerGui")

-- Create UI
local gui = Instance.new("ScreenGui")
gui.Parent = playerGui
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
mainFrame.Visible = false -- Default to hidden
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

-- Open GUI on Button Click
mainButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Debugging: Make sure the elements are being created and parented correctly
print("UI Loaded")
