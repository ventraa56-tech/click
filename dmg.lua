-- Roblox Kill Aura Script with Modern UI
-- Author: 170F Team
-- Features: Kill Aura, Modern UI, Draggable, Minimizable, Rainbow Text, Settings

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- Aura System Variables
local auraActive = false
local auraRadius = 20
local auraDamage = 10
local auraDamageDelay = 0.5
local lastDamageTime = {}

-- UI Configuration
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KillAuraUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340, 0, 500)
mainFrame.Position = UDim2.new(0, 20, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add Stroke
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 50, 100)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Corner Radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Rainbow Colors
local rainbowColors = {
    Color3.fromRGB(255, 0, 127),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(127, 0, 255),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(255, 127, 0),
    Color3.fromRGB(255, 0, 0)
}

local colorIndex = 1

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 15, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- Title Text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0.6, 0, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(255, 0, 127)
titleText.TextSize = 20
titleText.Font = Enum.Font.GothamBold
titleText.Text = "⚔️ KILL AURA"
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Author Text
local authorText = Instance.new("TextLabel")
authorText.Name = "AuthorText"
authorText.Size = UDim2.new(0.7, 0, 0.5, 0)
authorText.Position = UDim2.new(0, 10, 0.5, 0)
authorText.BackgroundTransparency = 1
authorText.TextColor3 = Color3.fromRGB(255, 100, 150)
authorText.TextSize = 9
authorText.Font = Enum.Font.Gotham
authorText.Text = "by 170F Team"
authorText.TextXAlignment = Enum.TextXAlignment.Left
authorText.Parent = titleBar

-- Hide Button
local hideButton = Instance.new("TextButton")
hideButton.Name = "HideButton"
hideButton.Size = UDim2.new(0, 32, 1, 0)
hideButton.Position = UDim2.new(1, -70, 0, 0)
hideButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.TextSize = 16
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
exitButton.Size = UDim2.new(0, 32, 1, 0)
exitButton.Position = UDim2.new(1, -35, 0, 0)
exitButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
exitButton.TextSize = 16
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
contentFrame.Size = UDim2.new(1, 0, 1, -50)
contentFrame.Position = UDim2.new(0, 0, 0, 50)
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
statusLabel.Size = UDim2.new(1, 0, 0, 40)
statusLabel.BackgroundColor3 = Color3.fromRGB(25, 15, 30)
statusLabel.TextColor3 = Color3.fromRGB(255, 100, 150)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.GothamBold
statusLabel.Text = "Status: ⚫ OFF"
statusLabel.BorderSizePixel = 0
statusLabel.Parent = contentFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusLabel

-- Toggle Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(1, 0, 0, 50)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 16
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "▶ ACTIVATE AURA"
toggleButton.BorderSizePixel = 0
toggleButton.Parent = contentFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Radius Label
local radiusLabel = Instance.new("TextLabel")
radiusLabel.Name = "RadiusLabel"
radiusLabel.Size = UDim2.new(1, 0, 0, 28)
radiusLabel.BackgroundTransparency = 1
radiusLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
radiusLabel.TextSize = 13
radiusLabel.Font = Enum.Font.GothamBold
radiusLabel.Text = "📏 Radius: 20m"
radiusLabel.BorderSizePixel = 0
radiusLabel.Parent = contentFrame

-- Radius Slider
local radiusSlider = Instance.new("Frame")
radiusSlider.Name = "RadiusSlider"
radiusSlider.Size = UDim2.new(1, 0, 0, 24)
radiusSlider.BackgroundColor3 = Color3.fromRGB(25, 15, 30)
radiusSlider.BorderSizePixel = 0
radiusSlider.Parent = contentFrame

local radiusCorner = Instance.new("UICorner")
radiusCorner.CornerRadius = UDim.new(0, 10)
radiusCorner.Parent = radiusSlider

local radiusBar = Instance.new("Frame")
radiusBar.Name = "RadiusBar"
radiusBar.Size = UDim2.new(0.4, 0, 1, 0)
radiusBar.BackgroundColor3 = Color3.fromRGB(100, 255, 150)
radiusBar.BorderSizePixel = 0
radiusBar.Parent = radiusSlider

local radiusBarCorner = Instance.new("UICorner")
radiusBarCorner.CornerRadius = UDim.new(0, 10)
radiusBarCorner.Parent = radiusBar

-- Damage Label
local damageLabel = Instance.new("TextLabel")
damageLabel.Name = "DamageLabel"
damageLabel.Size = UDim2.new(1, 0, 0, 28)
damageLabel.BackgroundTransparency = 1
damageLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
damageLabel.TextSize = 13
damageLabel.Font = Enum.Font.GothamBold
damageLabel.Text = "⚡ Damage: 10"
damageLabel.BorderSizePixel = 0
damageLabel.Parent = contentFrame

-- Damage Slider
local damageSlider = Instance.new("Frame")
damageSlider.Name = "DamageSlider"
damageSlider.Size = UDim2.new(1, 0, 0, 24)
damageSlider.BackgroundColor3 = Color3.fromRGB(25, 15, 30)
damageSlider.BorderSizePixel = 0
damageSlider.Parent = contentFrame

local damageCorner = Instance.new("UICorner")
damageCorner.CornerRadius = UDim.new(0, 10)
damageCorner.Parent = damageSlider

local damageBar = Instance.new("Frame")
damageBar.Name = "DamageBar"
damageBar.Size = UDim2.new(0.2, 0, 1, 0)
damageBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
damageBar.BorderSizePixel = 0
damageBar.Parent = damageSlider

local damageBarCorner = Instance.new("UICorner")
damageBarCorner.CornerRadius = UDim.new(0, 10)
damageBarCorner.Parent = damageBar

-- Speed Label
local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(1, 0, 0, 28)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
speedLabel.TextSize = 13
speedLabel.Font = Enum.Font.GothamBold
speedLabel.Text = "⏱️ Speed: 0.5s"
speedLabel.BorderSizePixel = 0
speedLabel.Parent = contentFrame

-- Speed Slider
local speedSlider = Instance.new("Frame")
speedSlider.Name = "SpeedSlider"
speedSlider.Size = UDim2.new(1, 0, 0, 24)
speedSlider.BackgroundColor3 = Color3.fromRGB(25, 15, 30)
speedSlider.BorderSizePixel = 0
speedSlider.Parent = contentFrame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 10)
speedCorner.Parent = speedSlider

local speedBar = Instance.new("Frame")
speedBar.Name = "SpeedBar"
speedBar.Size = UDim2.new(0.5, 0, 1, 0)
speedBar.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
speedBar.BorderSizePixel = 0
speedBar.Parent = speedSlider

local speedBarCorner = Instance.new("UICorner")
speedBarCorner.CornerRadius = UDim.new(0, 10)
speedBarCorner.Parent = speedBar

-- Info Label
local infoLabel = Instance.new("TextLabel")
infoLabel.Name = "InfoLabel"
infoLabel.Size = UDim2.new(1, 0, 0, 70)
infoLabel.BackgroundColor3 = Color3.fromRGB(25, 15, 30)
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
infoLabel.TextSize = 11
infoLabel.Font = Enum.Font.Gotham
infoLabel.Text = "💀 KILL AURA INFO\n\n🎯 Damages all nearby enemies\n👥 Targets: 0\n💔 Targets Damaged: 0"
infoLabel.TextWrapped = true
infoLabel.BorderSizePixel = 0
infoLabel.Parent = contentFrame

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 8)
infoCorner.Parent = infoLabel

-- Targets Count
local targetsCount = 0
local damageCount = 0

-- ===== TOUCH DRAG SYSTEM =====
local dragging = false
local dragStart = Vector2.new(0, 0)
local startPos = UDim2.new(0, 0, 0, 0)

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- ===== AURA FUNCTIONS =====
local function damageNearbyTargets()
    if not auraActive or not character or not humanoidRootPart then return end
    
    targetsCount = 0
    local damaged = 0
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Humanoid") then
            local targetCharacter = obj.Parent
            local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
            
            -- Check if it's not the player's own humanoid
            if obj ~= humanoid and obj.Health > 0 and targetRootPart then
                local distance = (targetRootPart.Position - humanoidRootPart.Position).Magnitude
                
                if distance < auraRadius then
                    targetsCount = targetsCount + 1
                    
                    -- Check damage cooldown for this target
                    local lastDamage = lastDamageTime[obj] or 0
                    if tick() - lastDamage >= auraDamageDelay then
                        obj:TakeDamage(auraDamage)
                        lastDamageTime[obj] = tick()
                        damaged = damaged + 1
                    end
                end
            end
        end
    end
    
    if damaged > 0 then
        damageCount = damageCount + damaged
        infoLabel.Text = "💀 KILL AURA INFO\n\n🎯 Damages all nearby enemies\n👥 Targets: " .. targetsCount .. "\n💔 Targets Damaged: " .. damageCount
    else
        infoLabel.Text = "💀 KILL AURA INFO\n\n🎯 Damages all nearby enemies\n👥 Targets: " .. targetsCount .. "\n💔 Targets Damaged: " .. damageCount
    end
end

local function toggleAura()
    auraActive = not auraActive
    
    if auraActive then
        statusLabel.Text = "Status: 🔴 ACTIVE"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        toggleButton.Text = "⏹ DEACTIVATE AURA"
        toggleButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
        damageCount = 0
    else
        statusLabel.Text = "Status: ⚫ OFF"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 150)
        toggleButton.Text = "▶ ACTIVATE AURA"
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 100)
        lastDamageTime = {}
        targetsCount = 0
    end
end

-- Button Connections
toggleButton.MouseButton1Click:Connect(function()
    toggleAura()
end)

hideButton.MouseButton1Click:Connect(function()
    contentFrame.Visible = not contentFrame.Visible
    titleBar.BackgroundColor3 = contentFrame.Visible and Color3.fromRGB(25, 15, 30) or Color3.fromRGB(35, 20, 40)
end)

exitButton.MouseButton1Click:Connect(function()
    if auraActive then toggleAura() end
    screenGui:Destroy()
    script:Destroy()
end)

-- Slider Interactions
local radiusSliding = false
local damageSliding = false
local speedSliding = false

radiusSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        radiusSliding = true
    end
end)

radiusSlider.InputEnded:Connect(function()
    radiusSliding = false
end)

damageSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        damageSliding = true
    end
end)

damageSlider.InputEnded:Connect(function()
    damageSliding = false
end)

speedSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        speedSliding = true
    end
end)

speedSlider.InputEnded:Connect(function()
    speedSliding = false
end)

-- Main Loop
RunService.RenderStepped:Connect(function()
    if not character or not humanoidRootPart then return end
    
    -- Rainbow Title Animation
    colorIndex = colorIndex + 1
    if colorIndex > #rainbowColors then colorIndex = 1 end
    titleText.TextColor3 = rainbowColors[colorIndex]
    
    -- Radius Slider
    if radiusSliding then
        local mouseLocation
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            mouseLocation = UserInputService:GetMouseLocation()
        else
            mouseLocation = Vector2.new(radiusSlider.AbsolutePosition.X + radiusSlider.AbsoluteSize.X / 2, 0)
        end
        
        local sliderPos = radiusSlider.AbsolutePosition.X
        local sliderSize = radiusSlider.AbsoluteSize.X
        local relativeX = math.clamp(mouseLocation.X - sliderPos, 0, sliderSize)
        
        auraRadius = math.floor((relativeX / sliderSize) * 50) + 5
        radiusBar.Size = UDim2.new(relativeX / sliderSize, 0, 1, 0)
        radiusLabel.Text = "📏 Radius: " .. auraRadius .. "m"
    end
    
    -- Damage Slider
    if damageSliding then
        local mouseLocation
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            mouseLocation = UserInputService:GetMouseLocation()
        else
            mouseLocation = Vector2.new(damageSlider.AbsolutePosition.X + damageSlider.AbsoluteSize.X / 2, 0)
        end
        
        local sliderPos = damageSlider.AbsolutePosition.X
        local sliderSize = damageSlider.AbsoluteSize.X
        local relativeX = math.clamp(mouseLocation.X - sliderPos, 0, sliderSize)
        
        auraDamage = math.floor((relativeX / sliderSize) * 100) + 1
        damageBar.Size = UDim2.new(relativeX / sliderSize, 0, 1, 0)
        damageLabel.Text = "⚡ Damage: " .. auraDamage
    end
    
    -- Speed Slider
    if speedSliding then
        local mouseLocation
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            mouseLocation = UserInputService:GetMouseLocation()
        else
            mouseLocation = Vector2.new(speedSlider.AbsolutePosition.X + speedSlider.AbsoluteSize.X / 2, 0)
        end
        
        local sliderPos = speedSlider.AbsolutePosition.X
        local sliderSize = speedSlider.AbsoluteSize.X
        local relativeX = math.clamp(mouseLocation.X - sliderPos, 0, sliderSize)
        
        auraDamageDelay = (relativeX / sliderSize) * 2
        speedBar.Size = UDim2.new(relativeX / sliderSize, 0, 1, 0)
        speedLabel.Text = "⏱️ Speed: " .. string.format("%.2f", auraDamageDelay) .. "s"
    end
    
    -- Apply Aura Damage
    if auraActive then
        damageNearbyTargets()
    end
end)

-- Character Respawn Handler
player.CharacterAdded:Connect(function(newCharacter)
    if auraActive then
        toggleAura()
    end
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
    lastDamageTime = {}
end)

print("✅ KILL AURA SCRIPT LOADED - Author: 170F Team")
print("⚔️ Activate to damage nearby targets!")
