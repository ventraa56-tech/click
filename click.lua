local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "170F_WalkSpeed"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 220, 0, 150)
Main.Position = UDim2.new(0.5, -110, 0.5, -75)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.ZIndex = 1
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Main

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TitleBar.BorderSizePixel = 0
TitleBar.Active = true
TitleBar.ZIndex = 2
TitleBar.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "170F Team | WalkSpeed"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3
Title.Parent = TitleBar

-- Rainbow Text Effect
spawn(function()
    local hue = 0
    while ScreenGui.Parent do
        hue = (hue + 0.01) % 1
        Title.TextColor3 = Color3.fromHSV(hue, 1, 1)
        task.wait(0.03)
    end
end)

-- Hide Button
local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 28, 0, 28)
HideBtn.Position = UDim2.new(1, -63, 0, 3)
HideBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
HideBtn.Text = "-"
HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HideBtn.Font = Enum.Font.GothamBold
HideBtn.TextSize = 18
HideBtn.AutoButtonColor = false
HideBtn.ZIndex = 4
HideBtn.Parent = TitleBar

local HideCorner = Instance.new("UICorner")
HideCorner.CornerRadius = UDim.new(0, 6)
HideCorner.Parent = HideBtn

-- Exit Button
local ExitBtn = Instance.new("TextButton")
ExitBtn.Size = UDim2.new(0, 28, 0, 28)
ExitBtn.Position = UDim2.new(1, -32, 0, 3)
ExitBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitBtn.Font = Enum.Font.GothamBold
ExitBtn.TextSize = 15
ExitBtn.AutoButtonColor = false
ExitBtn.ZIndex = 4
ExitBtn.Parent = TitleBar

local ExitCorner = Instance.new("UICorner")
ExitCorner.CornerRadius = UDim.new(0, 6)
ExitCorner.Parent = ExitBtn

-- Content Frame
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -35)
Content.Position = UDim2.new(0, 0, 0, 35)
Content.BackgroundTransparency = 1
Content.ZIndex = 2
Content.Parent = Main

-- Speed Label
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -20, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0, 10)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "WalkSpeed: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 13
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.ZIndex = 3
SpeedLabel.Parent = Content

-- Slider Bar (touch area diperbesar)
local SliderBack = Instance.new("Frame")
SliderBack.Size = UDim2.new(1, -20, 0, 24)
SliderBack.Position = UDim2.new(0, 10, 0, 45)
SliderBack.BackgroundTransparency = 1
SliderBack.Active = true
SliderBack.ZIndex = 3
SliderBack.Parent = Content

local SliderTrack = Instance.new("Frame")
SliderTrack.Size = UDim2.new(1, 0, 0, 8)
SliderTrack.Position = UDim2.new(0, 0, 0.5, -4)
SliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SliderTrack.BorderSizePixel = 0
SliderTrack.ZIndex = 3
SliderTrack.Parent = SliderBack

local SliderTrackCorner = Instance.new("UICorner")
SliderTrackCorner.CornerRadius = UDim.new(1, 0)
SliderTrackCorner.Parent = SliderTrack

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.16, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SliderFill.BorderSizePixel = 0
SliderFill.ZIndex = 3
SliderFill.Parent = SliderTrack

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(1, 0)
SliderFillCorner.Parent = SliderFill

spawn(function()
    local hue = 0
    while ScreenGui.Parent do
        hue = (hue + 0.01) % 1
        SliderFill.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        task.wait(0.03)
    end
end)

local SliderBtn = Instance.new("Frame")
SliderBtn.Size = UDim2.new(0, 18, 0, 18)
SliderBtn.Position = UDim2.new(0.16, -9, 0.5, -9)
SliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderBtn.ZIndex = 4
SliderBtn.Parent = SliderTrack

local SliderBtnCorner = Instance.new("UICorner")
SliderBtnCorner.CornerRadius = UDim.new(1, 0)
SliderBtnCorner.Parent = SliderBtn

local minSpeed, maxSpeed = 0, 100
local sliderDragging = false

local function updateSpeed(xPos)
    local barPos = SliderTrack.AbsolutePosition.X
    local barSize = SliderTrack.AbsoluteSize.X
    local relative = math.clamp((xPos - barPos) / barSize, 0, 1)
    local speed = math.floor(minSpeed + (maxSpeed - minSpeed) * relative)

    SliderFill.Size = UDim2.new(relative, 0, 1, 0)
    SliderBtn.Position = UDim2.new(relative, -9, 0.5, -9)
    SpeedLabel.Text = "WalkSpeed: " .. speed

    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speed
    end
end

-- TOUCH handling (Delta = mobile, prioritaskan ini)
SliderBack.TouchTap:Connect(function() end) -- dummy biar Active kebaca

UserInputService.TouchStarted:Connect(function(touch, processed)
    if processed then return end
    local pos = touch.Position
    -- cek apakah titik sentuh ada di area slider
    local absPos, absSize = SliderBack.AbsolutePosition, SliderBack.AbsoluteSize
    if pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
       pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y then
        sliderDragging = true
        updateSpeed(pos.X)
    end
end)

UserInputService.TouchMoved:Connect(function(touch, processed)
    if sliderDragging then
        updateSpeed(touch.Position.X)
    end
end)

UserInputService.TouchEnded:Connect(function(touch, processed)
    sliderDragging = false
end)

-- MOUSE handling (PC)
SliderBack.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliderDragging = true
        updateSpeed(input.Position.X)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if sliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateSpeed(input.Position.X)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliderDragging = false
    end
end)

-- Auto reapply walkspeed on respawn
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").WalkSpeed = tonumber(SpeedLabel.Text:match("%d+")) or 16
end)

-- Hide/Show Logic
local hidden = false
HideBtn.MouseButton1Click:Connect(function()
    hidden = not hidden
    Content.Visible = not hidden
    TweenService:Create(Main, TweenInfo.new(0.2), {
        Size = hidden and UDim2.new(0, 220, 0, 35) or UDim2.new(0, 220, 0, 150)
    }):Play()
end)

-- Exit Logic
ExitBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 16
    end
    ScreenGui:Destroy()
end)

-- DRAG WINDOW (touch utamanya, plus mouse)
local windowDragging = false
local dragStartPos, startFramePos

local function beginDrag(pos)
    windowDragging = true
    dragStartPos = pos
    startFramePos = Main.Position
end

local function updateDrag(pos)
    if not windowDragging then return end
    local delta = pos - dragStartPos
    Main.Position = UDim2.new(
        startFramePos.X.Scale, startFramePos.X.Offset + delta.X,
        startFramePos.Y.Scale, startFramePos.Y.Offset + delta.Y
    )
end

local function endDrag()
    windowDragging = false
end

-- TOUCH drag titlebar
UserInputService.TouchStarted:Connect(function(touch, processed)
    if processed then return end
    local pos = touch.Position
    local absPos, absSize = TitleBar.AbsolutePosition, TitleBar.AbsoluteSize
    if pos.X >= absPos.X and pos.X <= absPos.X + absSize.X and
       pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y then
        beginDrag(Vector2.new(pos.X, pos.Y))
    end
end)

UserInputService.TouchMoved:Connect(function(touch, processed)
    updateDrag(Vector2.new(touch.Position.X, touch.Position.Y))
end)

UserInputService.TouchEnded:Connect(function(touch, processed)
    endDrag()
end)

-- MOUSE drag titlebar
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        beginDrag(Vector2.new(input.Position.X, input.Position.Y))
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                endDrag()
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if windowDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateDrag(Vector2.new(input.Position.X, input.Position.Y))
    end
end)
