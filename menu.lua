-- Roblox Godmode Script with Modern UI
-- Author: 170F Team
-- Type: Tes/Testing Script

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Colors for Rainbow Effect
local RainbowColors = {
	Color3.fromRGB(255, 0, 127),    -- Pink
	Color3.fromRGB(255, 0, 255),    -- Magenta
	Color3.fromRGB(127, 0, 255),    -- Purple
	Color3.fromRGB(0, 0, 255),      -- Blue
	Color3.fromRGB(0, 127, 255),    -- Cyan
	Color3.fromRGB(0, 255, 255),    -- Aqua
	Color3.fromRGB(0, 255, 127),    -- Green-Cyan
	Color3.fromRGB(0, 255, 0),      -- Green
	Color3.fromRGB(127, 255, 0),    -- Yellow-Green
	Color3.fromRGB(255, 255, 0),    -- Yellow
	Color3.fromRGB(255, 127, 0),    -- Orange
	Color3.fromRGB(255, 0, 0)       -- Red
}

local GodmodeScript = {}
GodmodeScript.Enabled = true
GodmodeScript.Speed = 50
GodmodeScript.JumpPower = 50
GodmodeScript.Invisible = false

-- Create Main GUI
local function CreateUI()
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "GodmodeUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = Player:WaitForChild("PlayerGui")

	-- Main Frame
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 350, 0, 500)
	MainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
	MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = ScreenGui

	-- Add corner radius effect
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 12)
	UICorner.Parent = MainFrame

	-- Add stroke for modern look
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.fromRGB(100, 50, 200)
	UIStroke.Thickness = 2
	UIStroke.Parent = MainFrame

	-- Title Bar
	local TitleBar = Instance.new("Frame")
	TitleBar.Name = "TitleBar"
	TitleBar.Size = UDim2.new(1, 0, 0, 50)
	TitleBar.BackgroundColor3 = Color3.fromRGB(30, 15, 60)
	TitleBar.BorderSizePixel = 0
	TitleBar.Parent = MainFrame

	local TitleCorner = Instance.new("UICorner")
	TitleCorner.CornerRadius = UDim.new(0, 12)
	TitleCorner.Parent = TitleBar

	-- Title Text
	local TitleText = Instance.new("TextLabel")
	TitleText.Name = "TitleText"
	TitleText.Size = UDim2.new(0.7, 0, 1, 0)
	TitleText.Position = UDim2.new(0, 10, 0, 0)
	TitleText.BackgroundTransparency = 1
	TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleText.TextSize = 16
	TitleText.Font = Enum.Font.GothamBold
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.Text = "✨ GODMODE ✨"
	TitleText.Parent = TitleBar

	-- Author Text
	local AuthorText = Instance.new("TextLabel")
	AuthorText.Name = "AuthorText"
	AuthorText.Size = UDim2.new(1, -20, 0, 18)
	AuthorText.Position = UDim2.new(0, 10, 0.05, 25)
	AuthorText.BackgroundTransparency = 1
	AuthorText.TextColor3 = Color3.fromRGB(200, 150, 255)
	AuthorText.TextSize = 12
	AuthorText.Font = Enum.Font.Gotham
	AuthorText.TextXAlignment = Enum.TextXAlignment.Left
	AuthorText.Text = "Author: 170F Team"
	AuthorText.Parent = MainFrame

	-- Hide Button
	local HideButton = Instance.new("TextButton")
	HideButton.Name = "HideButton"
	HideButton.Size = UDim2.new(0, 30, 0, 30)
	HideButton.Position = UDim2.new(1, -70, 0, 10)
	HideButton.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
	HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	HideButton.TextSize = 14
	HideButton.Font = Enum.Font.GothamBold
	HideButton.Text = "−"
	HideButton.Parent = TitleBar

	local HideCorner = Instance.new("UICorner")
	HideCorner.CornerRadius = UDim.new(0, 6)
	HideCorner.Parent = HideButton

	-- Exit Button
	local ExitButton = Instance.new("TextButton")
	ExitButton.Name = "ExitButton"
	ExitButton.Size = UDim2.new(0, 30, 0, 30)
	ExitButton.Position = UDim2.new(1, -35, 0, 10)
	ExitButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	ExitButton.TextSize = 14
	ExitButton.Font = Enum.Font.GothamBold
	ExitButton.Text = "✕"
	ExitButton.Parent = TitleBar

	local ExitCorner = Instance.new("UICorner")
	ExitCorner.CornerRadius = UDim.new(0, 6)
	ExitCorner.Parent = ExitButton

	-- Content Frame
	local ContentFrame = Instance.new("Frame")
	ContentFrame.Name = "ContentFrame"
	ContentFrame.Size = UDim2.new(1, 0, 1, -50)
	ContentFrame.Position = UDim2.new(0, 0, 0, 50)
	ContentFrame.BackgroundTransparency = 1
	ContentFrame.Parent = MainFrame

	-- ScrollingFrame untuk konten
	local ScrollingFrame = Instance.new("ScrollingFrame")
	ScrollingFrame.Name = "ScrollingFrame"
	ScrollingFrame.Size = UDim2.new(1, -10, 1, -10)
	ScrollingFrame.Position = UDim2.new(0, 5, 0, 5)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.ScrollBarThickness = 6
	ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 50, 200)
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 450)
	ScrollingFrame.Parent = ContentFrame

	-- Godmode Toggle
	local GodmodeLabel = Instance.new("TextLabel")
	GodmodeLabel.Name = "GodmodeLabel"
	GodmodeLabel.Size = UDim2.new(1, -40, 0, 20)
	GodmodeLabel.Position = UDim2.new(0, 15, 0, 10)
	GodmodeLabel.BackgroundTransparency = 1
	GodmodeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	GodmodeLabel.TextSize = 13
	GodmodeLabel.Font = Enum.Font.Gotham
	GodmodeLabel.TextXAlignment = Enum.TextXAlignment.Left
	GodmodeLabel.Text = "Status: ACTIVE"
	GodmodeLabel.Parent = ScrollingFrame

	local StatusIndicator = Instance.new("Frame")
	StatusIndicator.Name = "StatusIndicator"
	StatusIndicator.Size = UDim2.new(0, 15, 0, 15)
	StatusIndicator.Position = UDim2.new(1, -35, 0, 12.5)
	StatusIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
	StatusIndicator.BorderSizePixel = 0
	StatusIndicator.Parent = ScrollingFrame

	local StatusCorner = Instance.new("UICorner")
	StatusCorner.CornerRadius = UDim.new(0, 3)
	StatusCorner.Parent = StatusIndicator

	-- Speed Slider
	local SpeedLabel = Instance.new("TextLabel")
	SpeedLabel.Name = "SpeedLabel"
	SpeedLabel.Size = UDim2.new(1, -30, 0, 20)
	SpeedLabel.Position = UDim2.new(0, 15, 0, 50)
	SpeedLabel.BackgroundTransparency = 1
	SpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
	SpeedLabel.TextSize = 12
	SpeedLabel.Font = Enum.Font.Gotham
	SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
	SpeedLabel.Text = "Speed: 50"
	SpeedLabel.Parent = ScrollingFrame

	local SpeedSlider = Instance.new("Frame")
	SpeedSlider.Name = "SpeedSlider"
	SpeedSlider.Size = UDim2.new(1, -30, 0, 8)
	SpeedSlider.Position = UDim2.new(0, 15, 0, 75)
	SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
	SpeedSlider.BorderSizePixel = 0
	SpeedSlider.Parent = ScrollingFrame

	local SpeedSliderCorner = Instance.new("UICorner")
	SpeedSliderCorner.CornerRadius = UDim.new(0, 4)
	SpeedSliderCorner.Parent = SpeedSlider

	local SpeedSliderFill = Instance.new("Frame")
	SpeedSliderFill.Name = "Fill"
	SpeedSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
	SpeedSliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
	SpeedSliderFill.BorderSizePixel = 0
	SpeedSliderFill.Parent = SpeedSlider

	local SpeedSliderFillCorner = Instance.new("UICorner")
	SpeedSliderFillCorner.CornerRadius = UDim.new(0, 4)
	SpeedSliderFillCorner.Parent = SpeedSliderFill

	-- Jump Power Slider
	local JumpLabel = Instance.new("TextLabel")
	JumpLabel.Name = "JumpLabel"
	JumpLabel.Size = UDim2.new(1, -30, 0, 20)
	JumpLabel.Position = UDim2.new(0, 15, 0, 100)
	JumpLabel.BackgroundTransparency = 1
	JumpLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
	JumpLabel.TextSize = 12
	JumpLabel.Font = Enum.Font.Gotham
	JumpLabel.TextXAlignment = Enum.TextXAlignment.Left
	JumpLabel.Text = "Jump Power: 50"
	JumpLabel.Parent = ScrollingFrame

	local JumpSlider = Instance.new("Frame")
	JumpSlider.Name = "JumpSlider"
	JumpSlider.Size = UDim2.new(1, -30, 0, 8)
	JumpSlider.Position = UDim2.new(0, 15, 0, 125)
	JumpSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
	JumpSlider.BorderSizePixel = 0
	JumpSlider.Parent = ScrollingFrame

	local JumpSliderCorner = Instance.new("UICorner")
	JumpSliderCorner.CornerRadius = UDim.new(0, 4)
	JumpSliderCorner.Parent = JumpSlider

	local JumpSliderFill = Instance.new("Frame")
	JumpSliderFill.Name = "Fill"
	JumpSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
	JumpSliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
	JumpSliderFill.BorderSizePixel = 0
	JumpSliderFill.Parent = JumpSlider

	local JumpSliderFillCorner = Instance.new("UICorner")
	JumpSliderFillCorner.CornerRadius = UDim.new(0, 4)
	JumpSliderFillCorner.Parent = JumpSliderFill

	-- Invisible Toggle
	local InvisibleLabel = Instance.new("TextLabel")
	InvisibleLabel.Name = "InvisibleLabel"
	InvisibleLabel.Size = UDim2.new(0.7, 0, 0, 20)
	InvisibleLabel.Position = UDim2.new(0, 15, 0, 160)
	InvisibleLabel.BackgroundTransparency = 1
	InvisibleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
	InvisibleLabel.TextSize = 12
	InvisibleLabel.Font = Enum.Font.Gotham
	InvisibleLabel.TextXAlignment = Enum.TextXAlignment.Left
	InvisibleLabel.Text = "Invisible Mode"
	InvisibleLabel.Parent = ScrollingFrame

	local InvisibleToggle = Instance.new("TextButton")
	InvisibleToggle.Name = "InvisibleToggle"
	InvisibleToggle.Size = UDim2.new(0, 40, 0, 20)
	InvisibleToggle.Position = UDim2.new(1, -55, 0, 160)
	InvisibleToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	InvisibleToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	InvisibleToggle.TextSize = 10
	InvisibleToggle.Font = Enum.Font.Gotham
	InvisibleToggle.Text = "OFF"
	InvisibleToggle.Parent = ScrollingFrame

	local InvisibleToggleCorner = Instance.new("UICorner")
	InvisibleToggleCorner.CornerRadius = UDim.new(0, 6)
	InvisibleToggleCorner.Parent = InvisibleToggle

	-- Info Text
	local InfoText = Instance.new("TextLabel")
	InfoText.Name = "InfoText"
	InfoText.Size = UDim2.new(1, -30, 0, 50)
	InfoText.Position = UDim2.new(0, 15, 0, 200)
	InfoText.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
	InfoText.TextColor3 = Color3.fromRGB(150, 255, 150)
	InfoText.TextSize = 11
	InfoText.Font = Enum.Font.Gotham
	InfoText.TextWrapped = true
	InfoText.Text = "Godmode aktif! Kamu tidak bisa mati.\n\nDrag untuk menggerakkan window.\nClick hide untuk menyembunyikan UI."
	InfoText.Parent = ScrollingFrame

	local InfoCorner = Instance.new("UICorner")
	InfoCorner.CornerRadius = UDim.new(0, 8)
	InfoCorner.Parent = InfoText

	-- Drag Functionality
	local dragging = false
	local dragStart
	local startPos

	TitleBar.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
		end
	end)

	UserInputService.InputChanged:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
			local delta = input.Position - dragStart
			MainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
		end
	end)

	UserInputService.InputEnded:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	-- Hide Button Functionality
	local hidden = false
	HideButton.MouseButton1Click:Connect(function()
		hidden = not hidden
		if hidden then
			ScrollingFrame.Visible = false
			MainFrame.Size = UDim2.new(0, 350, 0, 50)
			HideButton.Text = "+"
		else
			ScrollingFrame.Visible = true
			MainFrame.Size = UDim2.new(0, 350, 0, 500)
			HideButton.Text = "−"
		end
	end)

	-- Exit Button Functionality
	ExitButton.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
		GodmodeScript.Enabled = false
	end)

	-- Speed Slider Functionality
	SpeedSlider.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local relativeX = (input.Position.X - SpeedSlider.AbsolutePosition.X) / SpeedSlider.AbsoluteSize.X
			relativeX = math.clamp(relativeX, 0, 1)
			GodmodeScript.Speed = math.floor(relativeX * 200)
			SpeedSliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
			SpeedLabel.Text = "Speed: " .. GodmodeScript.Speed
		end
	end)

	SpeedSlider.InputChanged:Connect(function(input, gameProcessed)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			local mouse = game:GetService("Mouse")
			if mouse.X >= SpeedSlider.AbsolutePosition.X and 
			   mouse.X <= SpeedSlider.AbsolutePosition.X + SpeedSlider.AbsoluteSize.X and
			   mouse.Y >= SpeedSlider.AbsolutePosition.Y and 
			   mouse.Y <= SpeedSlider.AbsolutePosition.Y + SpeedSlider.AbsoluteSize.Y then
				SpeedSlider.BackgroundColor3 = Color3.fromRGB(70, 70, 100)
			else
				SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
			end
		end
	end)

	-- Jump Power Slider Functionality
	JumpSlider.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local relativeX = (input.Position.X - JumpSlider.AbsolutePosition.X) / JumpSlider.AbsoluteSize.X
			relativeX = math.clamp(relativeX, 0, 1)
			GodmodeScript.JumpPower = math.floor(relativeX * 200)
			JumpSliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
			JumpLabel.Text = "Jump Power: " .. GodmodeScript.JumpPower
		end
	end)

	-- Invisible Toggle Functionality
	InvisibleToggle.MouseButton1Click:Connect(function()
		GodmodeScript.Invisible = not GodmodeScript.Invisible
		if GodmodeScript.Invisible then
			InvisibleToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
			InvisibleToggle.Text = "ON"
		else
			InvisibleToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			InvisibleToggle.Text = "OFF"
		end
	end)

	-- Rainbow Color Animation for Title
	local rainbowIndex = 1
	RunService.Heartbeat:Connect(function()
		if TitleText.Parent then
			rainbowIndex = (rainbowIndex % #RainbowColors) + 1
			TitleText.TextColor3 = RainbowColors[rainbowIndex]
		end
	end)

	return MainFrame, ScreenGui
end

-- Godmode Functions
local function ApplyGodmode()
	if not Character then return end
	
	local Humanoid = Character:FindFirstChild("Humanoid")
	if Humanoid then
		Humanoid.MaxHealth = math.huge
		Humanoid.Health = math.huge
	end

	local RootPart = Character:FindFirstChild("HumanoidRootPart")
	if RootPart then
		-- Infinite Jump
		local hasJumped = false
		Humanoid.StateChanged:Connect(function(oldState, newState)
			if newState == Enum.HumanoidStateType.Landed then
				hasJumped = false
			end
		end)

		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.KeyCode == Enum.KeyCode.Space and not hasJumped then
				Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				hasJumped = true
			end
		end)
	end
end

-- Invisibility Function
local function ApplyInvisibility(invisible)
	if not Character then return end
	
	for _, part in pairs(Character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Transparency = invisible and 1 or 0
		end
	end
end

-- Speed Boost Function
local function ApplySpeed()
	if not Character then return end
	
	local Humanoid = Character:FindFirstChild("Humanoid")
	if Humanoid then
		Humanoid.WalkSpeed = GodmodeScript.Speed
	end
end

-- Jump Power Function
local function ApplyJumpPower()
	if not Character then return end
	
	local Humanoid = Character:FindFirstChild("Humanoid")
	if Humanoid then
		Humanoid.JumpPower = GodmodeScript.JumpPower
	end
end

-- Main Loop
RunService.Heartbeat:Connect(function()
	if not GodmodeScript.Enabled then return end
	if not Character or not Character:FindFirstChild("Humanoid") then
		Character = Player.Character or Player.CharacterAdded:Wait()
		ApplyGodmode()
	end

	ApplySpeed()
	ApplyJumpPower()
	ApplyInvisibility(GodmodeScript.Invisible)

	local Humanoid = Character:FindFirstChild("Humanoid")
	if Humanoid and Humanoid.Health < math.huge then
		Humanoid.MaxHealth = math.huge
		Humanoid.Health = math.huge
	end
end)

-- Initialize
ApplyGodmode()
ApplySpeed()
ApplyJumpPower()
CreateUI()

print("✨ Godmode Script Activated by 170F Team! ✨")
print("Press Space untuk infinite jump")
print("Adjust settings di UI untuk customize")
