local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedControlGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 300)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Add stroke for aesthetic
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 100, 255)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Dragging functionality
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input, gameProcessed)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

-- Rainbow text color function
local rainbowColors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 127, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(75, 0, 130),
    Color3.fromRGB(148, 0, 211)
}

local colorIndex = 1
local titleLabel = nil

-- Update rainbow effect
game:GetService("RunService").Heartbeat:Connect(function()
    if titleLabel then
        colorIndex = colorIndex + 1
        if colorIndex > #rainbowColors then
            colorIndex = 1
        end
        titleLabel.TextColor3 = rainbowColors[colorIndex]
    end
end)

-- Title
titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ SPEED CONTROL ⚡"
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Author Label
local authorLabel = Instance.new("TextLabel")
authorLabel.Name = "AuthorLabel"
authorLabel.Size = UDim2.new(1, 0, 0, 20)
authorLabel.Position = UDim2.new(0, 0, 0, 40)
authorLabel.BackgroundTransparency = 1
authorLabel.Text = "By: 170F Team"
authorLabel.TextSize = 12
authorLabel.Font = Enum.Font.Gotham
authorLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
authorLabel.Parent = mainFrame

-- Divider
local divider = Instance.new("Frame")
divider.Size = UDim2.new(0.9, 0, 0, 2)
divider.Position = UDim2.new(0.05, 0, 0, 65)
divider.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
divider.BorderSizePixel = 0
divider.Parent = mainFrame

-- Movement Speed Section
local moveSpeedLabel = Instance.new("TextLabel")
moveSpeedLabel.Name = "MoveSpeedLabel"
moveSpeedLabel.Size = UDim2.new(0.4, 0, 0, 25)
moveSpeedLabel.Position = UDim2.new(0.05, 0, 0, 80)
moveSpeedLabel.BackgroundTransparency = 1
moveSpeedLabel.Text = "Move Speed:"
moveSpeedLabel.TextSize = 14
moveSpeedLabel.Font = Enum.Font.Gotham
moveSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
moveSpeedLabel.Parent = mainFrame

local moveSpeedValue = Instance.new("TextBox")
moveSpeedValue.Name = "MoveSpeedValue"
moveSpeedValue.Size = UDim2.new(0.45, 0, 0, 25)
moveSpeedValue.Position = UDim2.new(0.5, 0, 0, 80)
moveSpeedValue.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
moveSpeedValue.TextColor3 = Color3.fromRGB(100, 200, 255)
moveSpeedValue.TextSize = 14
moveSpeedValue.Font = Enum.Font.GothamMono
moveSpeedValue.Text = "16"
moveSpeedValue.BorderSizePixel = 0
moveSpeedValue.Parent = mainFrame

local moveCorner = Instance.new("UICorner")
moveCorner.CornerRadius = UDim.new(0, 6)
moveCorner.Parent = moveSpeedValue

-- Attack Speed Section
local attackSpeedLabel = Instance.new("TextLabel")
attackSpeedLabel.Name = "AttackSpeedLabel"
attackSpeedLabel.Size = UDim2.new(0.4, 0, 0, 25)
attackSpeedLabel.Position = UDim2.new(0.05, 0, 0, 120)
attackSpeedLabel.BackgroundTransparency = 1
attackSpeedLabel.Text = "Attack Speed:"
attackSpeedLabel.TextSize = 14
attackSpeedLabel.Font = Enum.Font.Gotham
attackSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
attackSpeedLabel.Parent = mainFrame

local attackSpeedValue = Instance.new("TextBox")
attackSpeedValue.Name = "AttackSpeedValue"
attackSpeedValue.Size = UDim2.new(0.45, 0, 0, 25)
attackSpeedValue.Position = UDim2.new(0.5, 0, 0, 120)
attackSpeedValue.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
attackSpeedValue.TextColor3 = Color3.fromRGB(255, 100, 100)
attackSpeedValue.TextSize = 14
attackSpeedValue.Font = Enum.Font.GothamMono
attackSpeedValue.Text = "1"
attackSpeedValue.BorderSizePixel = 0
attackSpeedValue.Parent = mainFrame

local attackCorner = Instance.new("UICorner")
attackCorner.CornerRadius = UDim.new(0, 6)
attackCorner.Parent = attackSpeedValue

-- Apply Button
local applyButton = Instance.new("TextButton")
applyButton.Name = "ApplyButton"
applyButton.Size = UDim2.new(0.4, 0, 0, 30)
applyButton.Position = UDim2.new(0.05, 0, 0, 165)
applyButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 13
applyButton.Font = Enum.Font.GothamBold
applyButton.Text = "✓ APPLY"
applyButton.BorderSizePixel = 0
applyButton.Parent = mainFrame

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 6)
applyCorner.Parent = applyButton

-- Hide Button
local hideButton = Instance.new("TextButton")
hideButton.Name = "HideButton"
hideButton.Size = UDim2.new(0.4, 0, 0, 30)
hideButton.Position = UDim2.new(0.55, 0, 0, 165)
hideButton.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.TextSize = 13
hideButton.Font = Enum.Font.GothamBold
hideButton.Text = "👁 HIDE"
hideButton.BorderSizePixel = 0
hideButton.Parent = mainFrame

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 6)
hideCorner.Parent = hideButton

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(0.9, 0, 0, 40)
statusLabel.Position = UDim2.new(0.05, 0, 0, 210)
statusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
statusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.GothamMono
statusLabel.Text = "📊 Status: Ready"
statusLabel.TextWrapped = true
statusLabel.BorderSizePixel = 0
statusLabel.Parent = mainFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusLabel

-- Exit Button
local exitButton = Instance.new("TextButton")
exitButton.Name = "ExitButton"
exitButton.Size = UDim2.new(0, 30, 0, 30)
exitButton.Position = UDim2.new(1, -35, 0, 5)
exitButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
exitButton.TextSize = 16
exitButton.Font = Enum.Font.GothamBold
exitButton.Text = "✕"
exitButton.BorderSizePixel = 0
exitButton.Parent = mainFrame

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 6)
exitCorner.Parent = exitButton

local isHidden = false

-- Apply Button Functionality
applyButton.MouseButton1Click:Connect(function()
    local moveSpeed = tonumber(moveSpeedValue.Text) or 16
    local attackSpeed = tonumber(attackSpeedValue.Text) or 1
    
    -- Apply speeds to player character
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = moveSpeed
            statusLabel.Text = "✓ Applied: Move=" .. moveSpeed .. " | Attack=" .. attackSpeed
            
            -- You can emit a custom event or update attack speed based on your game
            game:GetService("ReplicatedStorage"):FireEvent(moveSpeed, attackSpeed) -- Example
        end
    end
end)

-- Hide/Show Button
hideButton.MouseButton1Click:Connect(function()
    isHidden = not isHidden
    mainFrame.Visible = not isHidden
    if isHidden then
        hideButton.Text = "👁 SHOW"
    else
        hideButton.Text = "👁 HIDE"
    end
end)

-- Exit Button
exitButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Reset on spawn
player.CharacterAdded:Connect(function()
    moveSpeedValue.Text = "16"
    attackSpeedValue.Text = "1"
end)

print("✓ Speed Control Panel loaded - By 170F Team")
