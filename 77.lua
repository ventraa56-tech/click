local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdvancedSpeedControlGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame dengan gradient border effect
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 600)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

-- Gradient border effect
local borderGradient = Instance.new("UIStroke")
borderGradient.Color = Color3.fromRGB(100, 50, 200)
borderGradient.Thickness = 3
borderGradient.Parent = mainFrame

-- Dragging
local dragging = false
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

mainFrame.InputEnded:Connect(function(input)
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

-- Rainbow effect variables
local rainbowColors = {
    Color3.fromRGB(255, 0, 127),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(127, 0, 255),
    Color3.fromRGB(0, 127, 255),
    Color3.fromRGB(0, 255, 255),
}
local colorIndex = 1

-- ===================== TITLE SECTION =====================
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ SPEED CONTROL ⚡"
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

local authorLabel = Instance.new("TextLabel")
authorLabel.Name = "AuthorLabel"
authorLabel.Size = UDim2.new(1, 0, 0, 25)
authorLabel.Position = UDim2.new(0, 0, 0, 48)
authorLabel.BackgroundTransparency = 1
authorLabel.Text = "By: 170F Team | Advanced Testing Panel"
authorLabel.TextSize = 11
authorLabel.Font = Enum.Font.Gotham
authorLabel.TextColor3 = Color3.fromRGB(180, 150, 255)
authorLabel.Parent = mainFrame

-- Divider
local divider = Instance.new("Frame")
divider.Size = UDim2.new(0.95, 0, 0, 2)
divider.Position = UDim2.new(0.025, 0, 0, 78)
divider.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
divider.BorderSizePixel = 0
divider.Parent = mainFrame

-- ===================== MOVEMENT SPEED SECTION =====================
local moveLabel = Instance.new("TextLabel")
moveLabel.Name = "MoveLabel"
moveLabel.Size = UDim2.new(1, 0, 0, 25)
moveLabel.Position = UDim2.new(0.05, 0, 0, 95)
moveLabel.BackgroundTransparency = 1
moveLabel.Text = "🚶 MOVEMENT SPEED"
moveLabel.TextSize = 13
moveLabel.Font = Enum.Font.GothamBold
moveLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
moveLabel.Parent = mainFrame

-- Movement Input
local moveInputLabel = Instance.new("TextLabel")
moveInputLabel.Name = "MoveInputLabel"
moveInputLabel.Size = UDim2.new(0.4, 0, 0, 25)
moveInputLabel.Position = UDim2.new(0.05, 0, 0, 125)
moveInputLabel.BackgroundTransparency = 1
moveInputLabel.Text = "Value:"
moveInputLabel.TextSize = 12
moveInputLabel.Font = Enum.Font.Gotham
moveInputLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
moveInputLabel.Parent = mainFrame

local moveInput = Instance.new("TextBox")
moveInput.Name = "MoveInput"
moveInput.Size = UDim2.new(0.5, 0, 0, 28)
moveInput.Position = UDim2.new(0.45, 0, 0, 123)
moveInput.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
moveInput.TextColor3 = Color3.fromRGB(100, 200, 255)
moveInput.TextSize = 14
moveInput.Font = Enum.Font.GothamMono
moveInput.Text = "16"
moveInput.BorderSizePixel = 0
moveInput.Parent = mainFrame

local moveInputCorner = Instance.new("UICorner")
moveInputCorner.CornerRadius = UDim.new(0, 8)
moveInputCorner.Parent = moveInput

-- Movement Slider
local moveSliderBg = Instance.new("Frame")
moveSliderBg.Name = "MoveSliderBg"
moveSliderBg.Size = UDim2.new(0.9, 0, 0, 8)
moveSliderBg.Position = UDim2.new(0.05, 0, 0, 162)
moveSliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
moveSliderBg.BorderSizePixel = 0
moveSliderBg.Parent = mainFrame

local moveSliderCorner = Instance.new("UICorner")
moveSliderCorner.CornerRadius = UDim.new(0, 4)
moveSliderCorner.Parent = moveSliderBg

local moveSlider = Instance.new("Frame")
moveSlider.Name = "MoveSlider"
moveSlider.Size = UDim2.new(0.3, 0, 1, 0)
moveSlider.Position = UDim2.new(0, 0, 0, 0)
moveSlider.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
moveSlider.BorderSizePixel = 0
moveSlider.Parent = moveSliderBg

local moveSliderCorner2 = Instance.new("UICorner")
moveSliderCorner2.CornerRadius = UDim.new(0, 4)
moveSliderCorner2.Parent = moveSlider

-- ===================== ATTACK SPEED SECTION =====================
local attackLabel = Instance.new("TextLabel")
attackLabel.Name = "AttackLabel"
attackLabel.Size = UDim2.new(1, 0, 0, 25)
attackLabel.Position = UDim2.new(0.05, 0, 0, 190)
attackLabel.BackgroundTransparency = 1
attackLabel.Text = "⚔️ ATTACK SPEED"
attackLabel.TextSize = 13
attackLabel.Font = Enum.Font.GothamBold
attackLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
attackLabel.Parent = mainFrame

-- Attack Input
local attackInputLabel = Instance.new("TextLabel")
attackInputLabel.Name = "AttackInputLabel"
attackInputLabel.Size = UDim2.new(0.4, 0, 0, 25)
attackInputLabel.Position = UDim2.new(0.05, 0, 0, 220)
attackInputLabel.BackgroundTransparency = 1
attackInputLabel.Text = "Value:"
attackInputLabel.TextSize = 12
attackInputLabel.Font = Enum.Font.Gotham
attackInputLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
attackInputLabel.Parent = mainFrame

local attackInput = Instance.new("TextBox")
attackInput.Name = "AttackInput"
attackInput.Size = UDim2.new(0.5, 0, 0, 28)
attackInput.Position = UDim2.new(0.45, 0, 0, 218)
attackInput.BackgroundColor3 = Color3.fromRGB(50, 25, 25)
attackInput.TextColor3 = Color3.fromRGB(255, 100, 100)
attackInput.TextSize = 14
attackInput.Font = Enum.Font.GothamMono
attackInput.Text = "1"
attackInput.BorderSizePixel = 0
attackInput.Parent = mainFrame

local attackInputCorner = Instance.new("UICorner")
attackInputCorner.CornerRadius = UDim.new(0, 8)
attackInputCorner.Parent = attackInput

-- Attack Slider
local attackSliderBg = Instance.new("Frame")
attackSliderBg.Name = "AttackSliderBg"
attackSliderBg.Size = UDim2.new(0.9, 0, 0, 8)
attackSliderBg.Position = UDim2.new(0.05, 0, 0, 257)
attackSliderBg.BackgroundColor3 = Color3.fromRGB(70, 40, 40)
attackSliderBg.BorderSizePixel = 0
attackSliderBg.Parent = mainFrame

local attackSliderCorner = Instance.new("UICorner")
attackSliderCorner.CornerRadius = UDim.new(0, 4)
attackSliderCorner.Parent = attackSliderBg

local attackSlider = Instance.new("Frame")
attackSlider.Name = "AttackSlider"
attackSlider.Size = UDim2.new(0.2, 0, 1, 0)
attackSlider.Position = UDim2.new(0, 0, 0, 0)
attackSlider.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
attackSlider.BorderSizePixel = 0
attackSlider.Parent = attackSliderBg

local attackSliderCorner2 = Instance.new("UICorner")
attackSliderCorner2.CornerRadius = UDim.new(0, 4)
attackSliderCorner2.Parent = attackSlider

-- ===================== PRESET BUTTONS =====================
local presetLabel = Instance.new("TextLabel")
presetLabel.Name = "PresetLabel"
presetLabel.Size = UDim2.new(1, 0, 0, 20)
presetLabel.Position = UDim2.new(0.05, 0, 0, 285)
presetLabel.BackgroundTransparency = 1
presetLabel.Text = "⚙️ PRESETS"
presetLabel.TextSize = 12
presetLabel.Font = Enum.Font.GothamBold
presetLabel.TextColor3 = Color3.fromRGB(200, 200, 100)
presetLabel.Parent = mainFrame

local function createPresetButton(name, moveSpeed, attackSpeed, xPos, yPos)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Preset"
    btn.Size = UDim2.new(0.28, 0, 0, 28)
    btn.Position = UDim2.new(xPos, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
    btn.TextColor3 = Color3.fromRGB(200, 200, 255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.Text = name .. "\n(" .. moveSpeed .. "," .. attackSpeed .. ")"
    btn.BorderSizePixel = 0
    btn.Parent = mainFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        moveInput.Text = tostring(moveSpeed)
        attackInput.Text = tostring(attackSpeed)
        moveSlider.Size = UDim2.new(math.min(moveSpeed / 100, 1), 0, 1, 0)
        attackSlider.Size = UDim2.new(math.min(attackSpeed / 5, 1), 0, 1, 0)
    end)
    
    return btn
end

createPresetButton("NORMAL", 16, 1, 0.05, 310)
createPresetButton("FAST", 50, 2, 0.36, 310)
createPresetButton("INSANE", 100, 5, 0.67, 310)

-- ===================== ACTION BUTTONS =====================
local applyButton = Instance.new("TextButton")
applyButton.Name = "ApplyButton"
applyButton.Size = UDim2.new(0.43, 0, 0, 35)
applyButton.Position = UDim2.new(0.05, 0, 0, 360)
applyButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.TextSize = 14
applyButton.Font = Enum.Font.GothamBold
applyButton.Text = "✓ APPLY CHANGES"
applyButton.BorderSizePixel = 0
applyButton.Parent = mainFrame

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 8)
applyCorner.Parent = applyButton

local resetButton = Instance.new("TextButton")
resetButton.Name = "ResetButton"
resetButton.Size = UDim2.new(0.43, 0, 0, 35)
resetButton.Position = UDim2.new(0.52, 0, 0, 360)
resetButton.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resetButton.TextSize = 14
resetButton.Font = Enum.Font.GothamBold
resetButton.Text = "↺ RESET"
resetButton.BorderSizePixel = 0
resetButton.Parent = mainFrame

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 8)
resetCorner.Parent = resetButton

-- ===================== STATUS DISPLAY =====================
local statusBg = Instance.new("Frame")
statusBg.Name = "StatusBg"
statusBg.Size = UDim2.new(0.9, 0, 0, 70)
statusBg.Position = UDim2.new(0.05, 0, 0, 405)
statusBg.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
statusBg.BorderSizePixel = 0
statusBg.Parent = mainFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusBg

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, 0, 1, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "📊 STATUS: Ready\n\n💾 Move Speed: 16 | ⚔️ Attack Speed: 1"
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.GothamMono
statusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
statusLabel.TextWrapped = true
statusLabel.Parent = statusBg

-- ===================== CONTROL BUTTONS =====================
local hideButton = Instance.new("TextButton")
hideButton.Name = "HideButton"
hideButton.Size = UDim2.new(0.2, 0, 0, 30)
hideButton.Position = UDim2.new(0.05, 0, 0, 485)
hideButton.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.TextSize = 12
hideButton.Font = Enum.Font.GothamBold
hideButton.Text = "👁 HIDE"
hideButton.BorderSizePixel = 0
hideButton.Parent = mainFrame

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 6)
hideCorner.Parent = hideButton

local exitButton = Instance.new("TextButton")
exitButton.Name = "ExitButton"
exitButton.Size = UDim2.new(0.2, 0, 0, 30)
exitButton.Position = UDim2.new(0.75, 0, 0, 485)
exitButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
exitButton.TextSize = 14
exitButton.Font = Enum.Font.GothamBold
exitButton.Text = "✕ EXIT"
exitButton.BorderSizePixel = 0
exitButton.Parent = mainFrame

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 6)
exitCorner.Parent = exitButton

-- ===================== FUNCTIONALITY =====================

-- Rainbow title animation
RunService.Heartbeat:Connect(function()
    colorIndex = colorIndex + 1
    if colorIndex > #rainbowColors then
        colorIndex = 1
    end
    titleLabel.TextColor3 = rainbowColors[colorIndex]
end)

-- Update sliders from input
moveInput.Changed:Connect(function()
    local val = tonumber(moveInput.Text) or 16
    moveSlider.Size = UDim2.new(math.min(val / 100, 1), 0, 1, 0)
end)

attackInput.Changed:Connect(function()
    local val = tonumber(attackInput.Text) or 1
    attackSlider.Size = UDim2.new(math.min(val / 5, 1), 0, 1, 0)
end)

-- Apply Button
applyButton.MouseButton1Click:Connect(function()
    local moveSpeed = tonumber(moveInput.Text) or 16
    local attackSpeed = tonumber(attackInput.Text) or 1
    
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = moveSpeed
            statusLabel.Text = "✓ APPLIED!\n\n💾 Move: " .. moveSpeed .. " | ⚔️ Attack: " .. attackSpeed
        end
    end
end)

-- Reset Button
resetButton.MouseButton1Click:Connect(function()
    moveInput.Text = "16"
    attackInput.Text = "1"
    moveSlider.Size = UDim2.new(0.16, 0, 1, 0)
    attackSlider.Size = UDim2.new(0.2, 0, 1, 0)
    statusLabel.Text = "↺ RESET\n\n💾 Move: 16 | ⚔️ Attack: 1"
end)

-- Hide/Show
local isHidden = false
hideButton.MouseButton1Click:Connect(function()
    isHidden = not isHidden
    mainFrame.Visible = not isHidden
end)

-- Exit
exitButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

print("✓ Advanced Speed Control Panel v2 loaded - By 170F Team")
