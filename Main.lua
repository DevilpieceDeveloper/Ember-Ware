local player = game.Players.LocalPlayer
local teleportService = game:GetService("TeleportService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

-- Game ID Check
local gameId = game.GameId
if gameId == 4924922222 then
    player:Kick("No. Just NO")
    return
end

-- UI Setup
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Function to add rounded corners
local function addCorner(uiElement, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = uiElement
end

-- Function to create a button with hover effects
local function createButton(parent, text, position, size)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.AutoButtonColor = true
    button.Parent = parent
    addCorner(button, 10)

    -- Glowing hover effect
    local uiStroke = Instance.new("UIStroke", button)
    uiStroke.Thickness = 3
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uiStroke.Color = Color3.fromRGB(255, 85, 0)
    uiStroke.Enabled = false

    button.MouseEnter:Connect(function()
        uiStroke.Enabled = true
    end)
    button.MouseLeave:Connect(function()
        uiStroke.Enabled = false
    end)

    return button
end

-- Create EmberWare Button
local emberButton = createButton(gui, "EmberWare", UDim2.new(0, 20, 0, 20), UDim2.new(0, 150, 0, 60))
emberButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
emberButton.TextColor3 = Color3.fromRGB(255, 85, 0)

-- Create UI Window
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui
addCorner(mainFrame, 15)

-- Close Button
local closeButton = createButton(mainFrame, "X", UDim2.new(1, -50, 0, 10), UDim2.new(0, 40, 0, 40))
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Sidebar for Tabs
local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
addCorner(sidebar, 10)

-- Tab Buttons
local tabs = {
    {name = "🏠 Home"},
    {name = "🚀 TP"},
    {name = "🔧 Misc"},
    {name = "⚙️ Settings"},
    {name = "📝 Changelog"}
}
if gameId == 6872265039 then
    table.insert(tabs, {name = "🛏️ BedWars"})
end

local tabButtons = {}
for i, tab in ipairs(tabs) do
    local button = createButton(sidebar, tab.name, UDim2.new(0, 10, 0, 10 + (i - 1) * 50), UDim2.new(1, -20, 0, 40))
    tabButtons[tab.name] = button
end

-- Create Tab Pages
local pages = {}

local function createPage(name)
    local page = Instance.new("Frame", mainFrame)
    page.Size = UDim2.new(1, -160, 1, 0)
    page.Position = UDim2.new(0, 150, 0, 0)
    page.Visible = false
    pages[name] = page
    return page
end

-- Home Tab
local homePage = createPage("🏠 Home")
local homeText = Instance.new("TextLabel", homePage)
homeText.Size = UDim2.new(1, 0, 0.2, 0)
homeText.Text = "Welcome, " .. player.DisplayName .. " to EmberWare v.1"
homeText.TextColor3 = Color3.fromRGB(255, 85, 0)
homeText.BackgroundTransparency = 1
homeText.TextScaled = true
homeText.Font = Enum.Font.GothamBold

local madeBy = Instance.new("TextLabel", homePage)
madeBy.Size = UDim2.new(1, 0, 0.1, 0)
madeBy.Position = UDim2.new(0, 0, 0.2, 0)
madeBy.Text = "Made by @Draco"
madeBy.TextColor3 = Color3.fromRGB(0, 150, 255)
madeBy.BackgroundTransparency = 1
madeBy.TextScaled = true
madeBy.Font = Enum.Font.GothamBold

-- BedWars Tab
if gameId == 6872265039 then
    local bedWarsPage = createPage("🛏️ BedWars")
    local nametagsButton = createButton(bedWarsPage, "Nametags", UDim2.new(0, 10, 0, 10), UDim2.new(0, 200, 0, 50))
    local spiderButton = createButton(bedWarsPage, "Spider", UDim2.new(0, 10, 0, 70), UDim2.new(0, 200, 0, 50))
    local hitboxesButton = createButton(bedWarsPage, "Hitboxes", UDim2.new(0, 10, 0, 130), UDim2.new(0, 200, 0, 50))
    local goHomeButton = createButton(bedWarsPage, "Go Home", UDim2.new(0, 10, 0, 190), UDim2.new(0, 200, 0, 50))

    goHomeButton.MouseButton1Click:Connect(function()
        local char = player.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.Position = root.Position + Vector3.new(0, 10, 0)
                wait(0.5)
                root.Position = workspace.SpawnLocation.Position
            end
        end
    end)
end

-- Tab Switching
for tabName, button in pairs(tabButtons) do
    button.MouseButton1Click:Connect(function()
        for name, page in pairs(pages) do
            page.Visible = (name == tabName)
        end
    end)
end

-- Open GUI
emberButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
