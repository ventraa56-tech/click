-- Roblox Fly Mode Script with Modern UI
-- Author: 170F Team
-- Features: Fly mode, Modern UI, Draggable, Minimizable, Rainbow Text, Aesthetic Design

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- UI Configuration
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyModeUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add Stroke for modern look
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 100, 255)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Corner Radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Rainbow Text Colors
local rainbowColors = {
    Color3.fromRGB(255, 0, 127),    -- Pink
    Color3.fromRGB(255, 0, 255),    -- Magenta
    Color3.fromRGB(127, 0, 255),    -- Purple
    Color3.fromRGB(0, 0, 255),      -- Blue
    Color3.fromRGB(0, 255, 255),    -- Cyan
    Color3.fromRGB(0, 255, 0),      -- Green
    Color3.fromRGB(255, 255, 0),    -- Yellow
    Color3.fromRGB(255, 127, 0),    -- Orange
    Color3.fromRGB(255, 0, 0)       -- Red
}

local colorIndex = 1

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- Title Text (Rainbow animated)
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0.7, 0, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(255, 0, 127)
titleText.TextSize = 18
titleText.Font = Enum.Font.GothamBold
titleText.Text = "🚀 FLY MODE"
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Author Text
local authorText = Instance.new("TextLabel")
authorText.Name = "AuthorText"
authorText.Size = UDim2.new(0.7, 0, 0.5, 0)
authorText.Position = UDim2.new(0, 10, 0.5, 0)
authorText.BackgroundTransparency = 1
authorText.TextColor3 = Color3.fromRGB(150, 150, 255)
authorText.TextSize = 10
authorText.Font = Enum.Font.Gotham
authorText.Text = "Author: 170F Team"
authorText.TextXAlignment = Enum.TextXAlignment.Left
authorText.Parent = titleBar

-- Hide Button
local hideButton = Instance.new("TextButton")
hideButton.Name = "HideButton"
hideButton.Size = UDim2.new(0, 30, 1, 0)
hideButton.Position = UDim2.new(1, -70, 0, 0)
hideButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.TextSize = 14
hideButton.Font = Enum.Font.GothamBold
hideButton.Text = "━"
hideButton.BorderSizePixel = 0
hideButton.Parent = titleBar

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 8)
hideCorner.Parent = hideButton

-- Exit Button
local exitButton = Instance.new("TextButton")
exitButton.Name = "ExitButton"
exitButton.Size = UDim2.new(0, 30, 1, 0)
exitButton.Position = UDim2.new(1, -35, 0, 0)
exitButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
exitButton.TextSize = 14
exitButton.Font = Enum.Font.GothamBold
exitButton.Text = "✕"
exitButton.BorderSizePixel = 0
exitButton.Parent = titleBar

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 8)
exitCorner.Parent = exitButton

-- Content Frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.Position = UDim2.new(0, 0, 0, 40)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Padding
local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 15)
padding.PaddingRight = UDim.new(0, 15)
padding.PaddingTop = UDim.new(0, 15)
padding.PaddingBottom = UDim.new(0, 15)
padding.Parent = contentFrame

-- List Layout
local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 12)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
listLayout.Parent = contentFrame

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = "Status: ⚫ OFF"
statusLabel.BorderSizePixel = 0
statusLabel.Parent = contentFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusLabel

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(1, 0, 0, 40)
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 14
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "▶ START FLY"
toggleButton.BorderSizePixel = 0
toggleButton.Parent = contentFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Speed Label
local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(1, 0, 0, 25)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
speedLabel.TextSize = 12
speedLabel.Font = Enum.Font.Gotham
speedLabel.Text = "Speed: 50"
speedLabel.BorderSizePixel = 0
speedLabel.Parent = contentFrame

-- Speed Slider
local speedSlider = Instance.new("Frame")
speedSlider.Name = "SpeedSlider"
speedSlider.Size = UDim2.new(1, 0, 0, 20)
speedSlider.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
speedSlider.BorderSizePixel = 0
speedSlider.Parent = contentFrame

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 10)
sliderCorner.Parent = speedSlider

local speedBar = Instance.new("Frame")
speedBar.Name = "SpeedBar"
speedBar.Size = UDim2.new(0.5, 0, 1, 0)
speedBar.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
speedBar.BorderSizePixel = 0
speedBar.Parent = speedSlider

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 10)
barCorner.Parent = speedBar

-- Info Labels
local keysLabel = Instance.new("TextLabel")
keysLabel.Name = "KeysLabel"
keysLabel.Size = UDim2.new(1, 0, 0, 60)
keysLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
keysLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
keysLabel.TextSize = 11
keysLabel.Font = Enum.Font.Gotham
keysLabel.Text = "📌 W/A/S/D - Move\n📌 SPACE - Up\n📌 CTRL - Down"
keysLabel.TextWrapped = true
keysLabel.BorderSizePixel = 0
keysLabel.Parent = contentFrame

local keysCorner = Instance.new("UICorner")
keysCorner.CornerRadius = UDim.new(0, 8)
keysCorner.Parent = keysLabel

-- Fly System Variables
local flying = false
local speed = 50
local direction = Vector3.new(0, 0, 0)
local bodyVelocity
local bodyGyro

-- Functions
local function startFly()
    if flying then return end
    flying = true
    
    character = player.Character
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Create BodyVelocity
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Parent = humanoidRootPart
    
    -- Create BodyGyro
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
    bodyGyro.Parent = humanoidRootPart
    bodyGyro.CFrame = humanoidRootPart.CFrame
    
    statusLabel.Text = "Status: 🟢 FLYING"
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    toggleButton.Text = "⏹ STOP FLY"
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
end

local function stopFly()
    flying = false
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    
    statusLabel.Text = "Status: ⚫ OFF"
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    toggleButton.Text = "▶ START FLY"
    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
end

-- Input Handling
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.W then
        direction = direction + (humanoidRootPart.CFrame.LookVector)
    elseif input.KeyCode == Enum.KeyCode.A then
        direction = direction - (humanoidRootPart.CFrame.RightVector)
    elseif input.KeyCode == Enum.KeyCode.S then
        direction = direction - (humanoidRootPart.CFrame.LookVector)
    elseif input.KeyCode == Enum.KeyCode.D then
        direction = direction + (humanoidRootPart.CFrame.RightVector)
    elseif input.KeyCode == Enum.KeyCode.Space then
        direction = direction + Vector3.new(0, 1, 0)
    elseif input.KeyCode == Enum.KeyCode.LeftControl then
        direction = direction - Vector3.new(0, 1, 0)
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    direction = Vector3.new(0, 0, 0)
end)

-- Button Connections
toggleButton.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)

hideButton.MouseButton1Click:Connect(function()
    contentFrame.Visible = not contentFrame.Visible
    titleBar.BackgroundColor3 = contentFrame.Visible and Color3.fromRGB(25, 25, 40) or Color3.fromRGB(35, 35, 55)
end)

exitButton.MouseButton1Click:Connect(function()
    if flying then stopFly() end
    screenGui:Destroy()
    script:Destroy()
end)

-- Slider Interaction
local sliderDragging = false
speedSlider.MouseButton1Down:Connect(function()
    sliderDragging = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliderDragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if sliderDragging and flying then
        local mouseLocation = UserInputService:GetMouseLocation()
        local sliderPosition = speedSlider.AbsolutePosition.X
        local sliderSize = speedSlider.AbsoluteSize.X
        
        local relativeX = math.clamp(mouseLocation.X - sliderPosition, 0, sliderSize)
        speed = math.floor((relativeX / sliderSize) * 100)
        
        speedBar.Size = UDim2.new(relativeX / sliderSize, 0, 1, 0)
        speedLabel.Text = "Speed: " .. speed
    end
end)

-- Draggable UI
local dragging = false
local dragStart = Vector2.new(0, 0)
local frameStart = UDim2.new(0, 0, 0, 0)

titleBar.MouseButton1Down:Connect(function()
    dragging = true
    dragStart = UserInputService:GetMouseLocation()
    frameStart = mainFrame.Position
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    -- Rainbow Title Animation
    colorIndex = colorIndex + 1
    if colorIndex > #rainbowColors then colorIndex = 1 end
    titleText.TextColor3 = rainbowColors[colorIndex]
    
    -- Dragging
    if dragging then
        local currentMouse = UserInputService:GetMouseLocation()
        local delta = currentMouse - dragStart
        mainFrame.Position = frameStart + UDim2.new(0, delta.X, 0, delta.Y)
    end
    
    -- Fly Movement
    if flying and bodyVelocity then
        bodyVelocity.Velocity = direction * (speed / 10)
        bodyGyro.CFrame = humanoidRootPart.CFrame
    end
end)

-- Character Respawn Handler
player.CharacterAdded:Connect(function(newCharacter)
    if flying then
        stopFly()
    end
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end)

print("✅ FLY MODE SCRIPT LOADED - Author: 170F Team")
