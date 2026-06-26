-- Walk Speed Editor UI | Author: 170F Team
-- Support: Delta Executor

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")
local rootPart = player.Character:WaitForChild("HumanoidRootPart")

-- Variables
local walkSpeed = 16
local isDragging = false
local dragStart
local uiOffset
local isVisible = true

-- Rainbow Color Function
local function getRainbowColor(hue)
    hue = hue % 1
    local r = math.abs(math.sin(hue * math.pi)) 
    local g = math.abs(math.sin((hue + 1/3) * math.pi))
    local b = math.abs(math.sin((hue + 2/3) * math.pi))
    return Color3.fromRGB(r * 255, g * 255, b * 255)
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "WalkSpeedUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- Title Text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0.7, 0, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 14
titleText.Font = Enum.Font.GothamBold
titleText.Text = "Walk Speed Editor"
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Hide Button
local hideButton = Instance.new("TextButton")
hideButton.Name = "HideButton"
hideButton.Size = UDim2.new(0, 30, 0, 30)
hideButton.Position = UDim2.new(1, -65, 0, 5)
hideButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.TextSize = 12
hideButton.Font = Enum.Font.Gotham
hideButton.Text = "−"
hideButton.BorderSizePixel = 0
hideButton.Parent = titleBar

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 6)
hideCorner.Parent = hideButton

-- Exit Button
local exitButton = Instance.new("TextButton")
exitButton.Name = "ExitButton"
exitButton.Size = UDim2.new(0, 30, 0, 30)
exitButton.Position = UDim2.new(1, -30, 0, 5)
exitButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
exitButton.TextSize = 12
exitButton.Font = Enum.Font.Gotham
exitButton.Text = "✕"
exitButton.BorderSizePixel = 0
exitButton.Parent = titleBar

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 6)
exitCorner.Parent = exitButton

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Speed Label
local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(1, -20, 0, 30)
speedLabel.Position = UDim2.new(0, 10, 0, 15)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.TextSize = 12
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = contentFrame

-- Speed TextBox
local speedTextBox = Instance.new("TextBox")
speedTextBox.Name = "SpeedTextBox"
speedTextBox.Size = UDim2.new(1, -20, 0, 30)
speedTextBox.Position = UDim2.new(0, 10, 0, 50)
speedTextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speedTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedTextBox.TextSize = 14
speedTextBox.Font = Enum.Font.Gotham
speedTextBox.Text = tostring(walkSpeed)
speedTextBox.BorderSizePixel = 0
speedTextBox.Parent = contentFrame

local speedBoxCorner = Instance.new("UICorner")
speedBoxCorner.CornerRadius = UDim.new(0, 8)
speedBoxCorner.Parent = speedTextBox

-- Apply Button
local applyButton = Instance.new("TextButton")
applyButton.Name = "ApplyButton"
applyButton.Size = UDim2.new(1, -20, 0, 35)
applyButton.Position = UDim2.new(0, 10, 0, 90)
applyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 13
applyButton.Font = Enum.Font.GothamBold
applyButton.Text = "APPLY SPEED"
applyButton.BorderSizePixel = 0
applyButton.Parent = contentFrame

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 8)
applyCorner.Parent = applyButton

-- Author Label
local authorLabel = Instance.new("TextLabel")
authorLabel.Name = "AuthorLabel"
authorLabel.Size = UDim2.new(1, -20, 0, 15)
authorLabel.Position = UDim2.new(0, 10, 1, -20)
authorLabel.BackgroundTransparency = 1
authorLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
authorLabel.TextSize = 10
authorLabel.Font = Enum.Font.Gotham
authorLabel.Text = "Author: 170F Team"
authorLabel.TextXAlignment = Enum.TextXAlignment.Center
authorLabel.Parent = contentFrame

-- Rainbow Text Animation
local rainbowHue = 0
local function updateRainbowText()
    rainbowHue = (rainbowHue + 0.01) % 1
    titleText.TextColor3 = getRainbowColor(rainbowHue)
    authorLabel.TextColor3 = getRainbowColor((rainbowHue + 0.5) % 1)
end

-- Drag Functionality
titleBar.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        uiOffset = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(uiOffset.X.Scale, uiOffset.X.Offset + delta.X, uiOffset.Y.Scale, uiOffset.Y.Offset + delta.Y)
    end
end)

-- Hide/Show Functionality
local isHidden = false
hideButton.MouseButton1Click:Connect(function()
    isHidden = not isHidden
    contentFrame.Visible = not isHidden
    hideButton.Text = isHidden and "+" or "−"
end)

-- Exit Functionality
exitButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Apply Speed Functionality
local function applyWalkSpeed()
    local newSpeed = tonumber(speedTextBox.Text)
    if newSpeed then
        walkSpeed = newSpeed
        speedLabel.Text = "Walk Speed: " .. tostring(walkSpeed)
        humanoid.WalkSpeed = walkSpeed
    else
        speedTextBox.Text = tostring(walkSpeed)
    end
end

applyButton.MouseButton1Click:Connect(applyWalkSpeed)
speedTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        applyWalkSpeed()
    end
end)

-- Initialize
speedLabel.Text = "Walk Speed: " .. tostring(walkSpeed)
humanoid.WalkSpeed = walkSpeed

-- Update Rainbow Effect
RunService.RenderStepped:Connect(function()
    updateRainbowText()
    if humanoid then
        humanoid.WalkSpeed = walkSpeed
    end
end)

-- Handle Character Respawn
player.CharacterAdded:Connect(function(character)
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    humanoid.WalkSpeed = walkSpeed
end)

print("✓ Walk Speed Editor Loaded | Author: 170F Team")
