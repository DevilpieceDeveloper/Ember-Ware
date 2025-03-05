local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local gameId = game.GameId

-- **Kick player if in blacklisted game**
if gameId == 4924922222 then
    player:Kick("No. Just NO")
    return
end

-- **Create UI**
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- **Function to add rounded corners**
local function addCorner(uiElement, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = uiElement
end

-- **Draggable function**
local function makeDraggable(ui)
    local dragging, dragInput, startPos
    ui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = input.Position
        end
    end)
    ui.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - startPos
            ui.Position = UDim2.new(0, ui.Position.X.Offset + delta.X, 0, ui.Position.Y.Offset + delta.Y)
            startPos = input.Position
        end
    end)
    ui.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- **Create Main Button**
local mainButton = Instance.new("TextButton")
mainButton.Size = UDim2.new(0, 150, 0, 60)
mainButton.Position = UDim2.new(0, 20, 0, 20)
mainButton.Text = "EMBERWARE"
mainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainButton.TextColor3 = Color3.fromRGB(255, 85, 0)
mainButton.Parent = gui
mainButton.TextScaled = true
mainButton.Font = Enum.Font.GothamBold
mainButton.AutoButtonColor = true
addCorner(mainButton, 20)

-- **Glowing Effect for Main Button**
local glow = Instance.new("UIStroke", mainButton)
glow.Thickness = 2
glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glow.Color = Color3.fromRGB(255, 85, 0)
glow.Transparency = 0.3

local function animateGlow()
    while true do
        for i = 0, 1, 0.05 do
            glow.Color = Color3.fromHSV(i, 1, 1)
            wait(0.1)
        end
    end
end
spawn(animateGlow)

-- **Main UI Frame**
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 350)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
mainFrame.Active = true
makeDraggable(mainFrame)
mainFrame.Parent = gui
addCorner(mainFrame, 20)

-- **Close Button**
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

-- **Sidebar for Tabs**
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 100, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sidebar.Parent = mainFrame
addCorner(sidebar, 10)

-- **Tab Buttons**
local tabs = {"🏠 Home", "📍 TP", "🔧 Misc", "⚙️ Settings", "📜 Changelog"}
if gameId == 6872265039 then
    table.insert(tabs, "⚔️ BedWars")
end

local tabFrames = {}

local function createTab(name, index)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(1, 0, 0, 50)
    tab.Position = UDim2.new(0, 0, 0, 50 * (index - 1))
    tab.Text = name
    tab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Font = Enum.Font.GothamBold
    tab.TextScaled = true
    tab.Parent = sidebar
    addCorner(tab, 10)

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -100, 1, 0)
    frame.Position = UDim2.new(0, 100, 0, 0)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = mainFrame
    tabFrames[name] = frame

    -- Hover Effect
    local uiStroke = Instance.new("UIStroke", tab)
    uiStroke.Thickness = 3
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Color = Color3.fromRGB(255, 85, 0)
    uiStroke.Transparency = 1

    tab.MouseEnter:Connect(function()
        for i = 1, 10 do
            uiStroke.Transparency = 1 - (i / 10)
            wait(0.02)
        end
    end)

    tab.MouseLeave:Connect(function()
        for i = 1, 10 do
            uiStroke.Transparency = i / 10
            wait(0.02)
        end
    end)

    tab.MouseButton1Click:Connect(function()
        for _, f in pairs(tabFrames) do
            f.Visible = false
        end
        frame.Visible = true
    end)
end

for i, name in ipairs(tabs) do
    createTab(name, i)
end

-- **Show UI when EmberWare button is clicked**
mainButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
