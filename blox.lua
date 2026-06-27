-- Blox Fruits Aura Kill Script
-- Author: 170F Team
-- Type: Aura Kill/Damage Boost System

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

local AuraKillScript = {}
AuraKillScript.Enabled = true
AuraKillScript.AuraLevel = 6
AuraKillScript.DamageMultiplier = 5
AuraKillScript.AuraColor = Color3.fromRGB(0, 0, 0)
AuraKillScript.AutoAura = true
AuraKillScript.ConstantDamage = false
AuraKillScript.DamageAmount = 100
AuraKillScript.AuraRange = 50
AuraKillScript.CombatMode = false

-- Create Main GUI
local function CreateUI()
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "AuraKillUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = Player:WaitForChild("PlayerGui")

	-- Main Frame
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 380, 0, 600)
	MainFrame.Position = UDim2.new(0.5, -190, 0.5, -300)
	MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = ScreenGui

	-- Add corner radius effect
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 15)
	UICorner.Parent = MainFrame

	-- Add gradient-like stroke for modern look
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.fromRGB(100, 50, 200)
	UIStroke.Thickness = 2.5
	UIStroke.Parent = MainFrame

	-- Add shadow effect
	local UIShadow = Instance.new("UISizeConstraint")
	UIShadow.Parent = MainFrame

	-- Title Bar
	local TitleBar = Instance.new("Frame")
	TitleBar.Name = "TitleBar"
	TitleBar.Size = UDim2.new(1, 0, 0, 60)
	TitleBar.BackgroundColor3 = Color3.fromRGB(25, 10, 55)
	TitleBar.BorderSizePixel = 0
	TitleBar.Parent = MainFrame

	local TitleCorner = Instance.new("UICorner")
	TitleCorner.CornerRadius = UDim.new(0, 15)
	TitleCorner.Parent = TitleBar

	local TitleStroke = Instance.new("UIStroke")
	TitleStroke.Color = Color3.fromRGB(150, 80, 255)
	TitleStroke.Thickness = 1
	TitleStroke.Parent = TitleBar

	-- Title Text with Rainbow
	local TitleText = Instance.new("TextLabel")
	TitleText.Name = "TitleText"
	TitleText.Size = UDim2.new(0.7, 0, 1, 0)
	TitleText.Position = UDim2.new(0, 15, 0, 0)
	TitleText.BackgroundTransparency = 1
	TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleText.TextSize = 18
	TitleText.Font = Enum.Font.GothamBold
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.Text = "⚡ AURA KILL ⚡"
	TitleText.Parent = TitleBar

	-- Author Text
	local AuthorText = Instance.new("TextLabel")
	AuthorText.Name = "AuthorText"
	AuthorText.Size = UDim2.new(1, -30, 0, 20)
	AuthorText.Position = UDim2.new(0, 15, 0.08, 0)
	AuthorText.BackgroundTransparency = 1
	AuthorText.TextColor3 = Color3.fromRGB(200, 150, 255)
	AuthorText.TextSize = 12
	AuthorText.Font = Enum.Font.Gotham
	AuthorText.TextXAlignment = Enum.TextXAlignment.Left
	AuthorText.Text = "Author: 170F Team | Blox Fruits"
	AuthorText.Parent = MainFrame

	-- Hide Button
	local HideButton = Instance.new("TextButton")
	HideButton.Name = "HideButton"
	HideButton.Size = UDim2.new(0, 35, 0, 35)
	HideButton.Position = UDim2.new(1, -80, 0.5, -17.5)
	HideButton.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
	HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	HideButton.TextSize = 16
	HideButton.Font = Enum.Font.GothamBold
	HideButton.Text = "−"
	HideButton.Parent = TitleBar

	local HideCorner = Instance.new("UICorner")
	HideCorner.CornerRadius = UDim.new(0, 8)
	HideCorner.Parent = HideButton

	local HideStroke = Instance.new("UIStroke")
	HideStroke.Color = Color3.fromRGB(150, 100, 255)
	HideStroke.Thickness = 1
	HideStroke.Parent = HideButton

	-- Exit Button
	local ExitButton = Instance.new("TextButton")
	ExitButton.Name = "ExitButton"
	ExitButton.Size = UDim2.new(0, 35, 0, 35)
	ExitButton.Position = UDim2.new(1, -40, 0.5, -17.5)
	ExitButton.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
	ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	ExitButton.TextSize = 16
	ExitButton.Font = Enum.Font.GothamBold
	ExitButton.Text = "✕"
	ExitButton.Parent = TitleBar

	local ExitCorner = Instance.new("UICorner")
	ExitCorner.CornerRadius = UDim.new(0, 8)
	ExitCorner.Parent = ExitButton

	local ExitStroke = Instance.new("UIStroke")
	ExitStroke.Color = Color3.fromRGB(255, 100, 120)
	ExitStroke.Thickness = 1
	ExitStroke.Parent = ExitButton

	-- Content Frame
	local ContentFrame = Instance.new("Frame")
	ContentFrame.Name = "ContentFrame"
	ContentFrame.Size = UDim2.new(1, 0, 1, -60)
	ContentFrame.Position = UDim2.new(0, 0, 0, 60)
	ContentFrame.BackgroundTransparency = 1
	ContentFrame.Parent = MainFrame

	-- ScrollingFrame
	local ScrollingFrame = Instance.new("ScrollingFrame")
	ScrollingFrame.Name = "ScrollingFrame"
	ScrollingFrame.Size = UDim2.new(1, -10, 1, -10)
	ScrollingFrame.Position = UDim2.new(0, 5, 0, 5)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.ScrollBarThickness = 6
	ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 50, 200)
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 650)
	ScrollingFrame.Parent = ContentFrame

	-- Status Indicator
	local StatusLabel = Instance.new("TextLabel")
	StatusLabel.Name = "StatusLabel"
	StatusLabel.Size = UDim2.new(0.6, 0, 0, 22)
	StatusLabel.Position = UDim2.new(0, 15, 0, 10)
	StatusLabel.BackgroundTransparency = 1
	StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	StatusLabel.TextSize = 13
	StatusLabel.Font = Enum.Font.Gotham
	StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
	StatusLabel.Text = "Status: ACTIVE"
	StatusLabel.Parent = ScrollingFrame

	local StatusIndicator = Instance.new("Frame")
	StatusIndicator.Name = "StatusIndicator"
	StatusIndicator.Size = UDim2.new(0, 18, 0, 18)
	StatusIndicator.Position = UDim2.new(1, -40, 0, 12)
	StatusIndicator.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
	StatusIndicator.BorderSizePixel = 0
	StatusIndicator.Parent = ScrollingFrame

	local StatusCorner = Instance.new("UICorner")
	StatusCorner.CornerRadius = UDim.new(0, 4)
	StatusCorner.Parent = StatusIndicator

	-- Aura Level Slider
	local AuraLevelLabel = Instance.new("TextLabel")
	AuraLevelLabel.Name = "AuraLevelLabel"
	AuraLevelLabel.Size = UDim2.new(1, -30, 0, 20)
	AuraLevelLabel.Position = UDim2.new(0, 15, 0, 50)
	AuraLevelLabel.BackgroundTransparency = 1
	AuraLevelLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	AuraLevelLabel.TextSize = 12
	AuraLevelLabel.Font = Enum.Font.GothamBold
	AuraLevelLabel.TextXAlignment = Enum.TextXAlignment.Left
	AuraLevelLabel.Text = "Aura Level: 6"
	AuraLevelLabel.Parent = ScrollingFrame

	local AuraLevelSlider = Instance.new("Frame")
	AuraLevelSlider.Name = "AuraLevelSlider"
	AuraLevelSlider.Size = UDim2.new(1, -30, 0, 10)
	AuraLevelSlider.Position = UDim2.new(0, 15, 0, 75)
	AuraLevelSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
	AuraLevelSlider.BorderSizePixel = 0
	AuraLevelSlider.Parent = ScrollingFrame

	local AuraLevelSliderCorner = Instance.new("UICorner")
	AuraLevelSliderCorner.CornerRadius = UDim.new(0, 5)
	AuraLevelSliderCorner.Parent = AuraLevelSlider

	local AuraLevelSliderFill = Instance.new("Frame")
	AuraLevelSliderFill.Name = "Fill"
	AuraLevelSliderFill.Size = UDim2.new(1, 0, 1, 0)
	AuraLevelSliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
	AuraLevelSliderFill.BorderSizePixel = 0
	AuraLevelSliderFill.Parent = AuraLevelSlider

	local AuraLevelSliderFillCorner = Instance.new("UICorner")
	AuraLevelSliderFillCorner.CornerRadius = UDim.new(0, 5)
	AuraLevelSliderFillCorner.Parent = AuraLevelSliderFill

	-- Damage Multiplier Slider
	local DamageMultiplierLabel = Instance.new("TextLabel")
	DamageMultiplierLabel.Name = "DamageMultiplierLabel"
	DamageMultiplierLabel.Size = UDim2.new(1, -30, 0, 20)
	DamageMultiplierLabel.Position = UDim2.new(0, 15, 0, 105)
	DamageMultiplierLabel.BackgroundTransparency = 1
	DamageMultiplierLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	DamageMultiplierLabel.TextSize = 12
	DamageMultiplierLabel.Font = Enum.Font.GothamBold
	DamageMultiplierLabel.TextXAlignment = Enum.TextXAlignment.Left
	DamageMultiplierLabel.Text = "Damage Multiplier: 5x"
	DamageMultiplierLabel.Parent = ScrollingFrame

	local DamageMultiplierSlider = Instance.new("Frame")
	DamageMultiplierSlider.Name = "DamageMultiplierSlider"
	DamageMultiplierSlider.Size = UDim2.new(1, -30, 0, 10)
	DamageMultiplierSlider.Position = UDim2.new(0, 15, 0, 130)
	DamageMultiplierSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
	DamageMultiplierSlider.BorderSizePixel = 0
	DamageMultiplierSlider.Parent = ScrollingFrame

	local DamageMultiplierSliderCorner = Instance.new("UICorner")
	DamageMultiplierSliderCorner.CornerRadius = UDim.new(0, 5)
	DamageMultiplierSliderCorner.Parent = DamageMultiplierSlider

	local DamageMultiplierSliderFill = Instance.new("Frame")
	DamageMultiplierSliderFill.Name = "Fill"
	DamageMultiplierSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
	DamageMultiplierSliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
	DamageMultiplierSliderFill.BorderSizePixel = 0
	DamageMultiplierSliderFill.Parent = DamageMultiplierSlider

	local DamageMultiplierSliderFillCorner = Instance.new("UICorner")
	DamageMultiplierSliderFillCorner.CornerRadius = UDim.new(0, 5)
	DamageMultiplierSliderFillCorner.Parent = DamageMultiplierSliderFill

	-- Aura Range Slider
	local AuraRangeLabel = Instance.new("TextLabel")
	AuraRangeLabel.Name = "AuraRangeLabel"
	AuraRangeLabel.Size = UDim2.new(1, -30, 0, 20)
	AuraRangeLabel.Position = UDim2.new(0, 15, 0, 160)
	AuraRangeLabel.BackgroundTransparency = 1
	AuraRangeLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	AuraRangeLabel.TextSize = 12
	AuraRangeLabel.Font = Enum.Font.GothamBold
	AuraRangeLabel.TextXAlignment = Enum.TextXAlignment.Left
	AuraRangeLabel.Text = "Aura Range: 50"
	AuraRangeLabel.Parent = ScrollingFrame

	local AuraRangeSlider = Instance.new("Frame")
	AuraRangeSlider.Name = "AuraRangeSlider"
	AuraRangeSlider.Size = UDim2.new(1, -30, 0, 10)
	AuraRangeSlider.Position = UDim2.new(0, 15, 0, 185)
	AuraRangeSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
	AuraRangeSlider.BorderSizePixel = 0
	AuraRangeSlider.Parent = ScrollingFrame

	local AuraRangeSliderCorner = Instance.new("UICorner")
	AuraRangeSliderCorner.CornerRadius = UDim.new(0, 5)
	AuraRangeSliderCorner.Parent = AuraRangeSlider

	local AuraRangeSliderFill = Instance.new("Frame")
	AuraRangeSliderFill.Name = "Fill"
	AuraRangeSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
	AuraRangeSliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
	AuraRangeSliderFill.BorderSizePixel = 0
	AuraRangeSliderFill.Parent = AuraRangeSlider

	local AuraRangeSliderFillCorner = Instance.new("UICorner")
	AuraRangeSliderFillCorner.CornerRadius = UDim.new(0, 5)
	AuraRangeSliderFillCorner.Parent = AuraRangeSliderFill

	-- Constant Damage Input
	local ConstantDamageLabel = Instance.new("TextLabel")
	ConstantDamageLabel.Name = "ConstantDamageLabel"
	ConstantDamageLabel.Size = UDim2.new(0.6, 0, 0, 20)
	ConstantDamageLabel.Position = UDim2.new(0, 15, 0, 220)
	ConstantDamageLabel.BackgroundTransparency = 1
	ConstantDamageLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	ConstantDamageLabel.TextSize = 12
	ConstantDamageLabel.Font = Enum.Font.GothamBold
	ConstantDamageLabel.TextXAlignment = Enum.TextXAlignment.Left
	ConstantDamageLabel.Text = "Fixed Damage"
	ConstantDamageLabel.Parent = ScrollingFrame

	local ConstantDamageToggle = Instance.new("TextButton")
	ConstantDamageToggle.Name = "ConstantDamageToggle"
	ConstantDamageToggle.Size = UDim2.new(0, 45, 0, 22)
	ConstantDamageToggle.Position = UDim2.new(1, -65, 0, 220)
	ConstantDamageToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	ConstantDamageToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	ConstantDamageToggle.TextSize = 11
	ConstantDamageToggle.Font = Enum.Font.Gotham
	ConstantDamageToggle.Text = "OFF"
	ConstantDamageToggle.Parent = ScrollingFrame

	local ConstantDamageToggleCorner = Instance.new("UICorner")
	ConstantDamageToggleCorner.CornerRadius = UDim.new(0, 6)
	ConstantDamageToggleCorner.Parent = ConstantDamageToggle

	-- Damage Amount TextBox
	local DamageAmountLabel = Instance.new("TextLabel")
	DamageAmountLabel.Name = "DamageAmountLabel"
	DamageAmountLabel.Size = UDim2.new(1, -30, 0, 18)
	DamageAmountLabel.Position = UDim2.new(0, 15, 0, 250)
	DamageAmountLabel.BackgroundTransparency = 1
	DamageAmountLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	DamageAmountLabel.TextSize = 11
	DamageAmountLabel.Font = Enum.Font.Gotham
	DamageAmountLabel.TextXAlignment = Enum.TextXAlignment.Left
	DamageAmountLabel.Text = "Damage Amount: 100"
	DamageAmountLabel.Parent = ScrollingFrame

	local DamageAmountInput = Instance.new("TextBox")
	DamageAmountInput.Name = "DamageAmountInput"
	DamageAmountInput.Size = UDim2.new(1, -30, 0, 30)
	DamageAmountInput.Position = UDim2.new(0, 15, 0, 270)
	DamageAmountInput.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
	DamageAmountInput.TextColor3 = Color3.fromRGB(200, 200, 255)
	DamageAmountInput.TextSize = 12
	DamageAmountInput.Font = Enum.Font.Gotham
	DamageAmountInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 150)
	DamageAmountInput.PlaceholderText = "Masukan nilai damage..."
	DamageAmountInput.Text = "100"
	DamageAmountInput.Parent = ScrollingFrame

	local DamageAmountInputCorner = Instance.new("UICorner")
	DamageAmountInputCorner.CornerRadius = UDim.new(0, 8)
	DamageAmountInputCorner.Parent = DamageAmountInput

	local DamageAmountInputStroke = Instance.new("UIStroke")
	DamageAmountInputStroke.Color = Color3.fromRGB(100, 50, 200)
	DamageAmountInputStroke.Thickness = 1
	DamageAmountInputStroke.Parent = DamageAmountInput

	-- Auto Aura Toggle
	local AutoAuraLabel = Instance.new("TextLabel")
	AutoAuraLabel.Name = "AutoAuraLabel"
	AutoAuraLabel.Size = UDim2.new(0.6, 0, 0, 20)
	AutoAuraLabel.Position = UDim2.new(0, 15, 0, 315)
	AutoAuraLabel.BackgroundTransparency = 1
	AutoAuraLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	AutoAuraLabel.TextSize = 12
	AutoAuraLabel.Font = Enum.Font.GothamBold
	AutoAuraLabel.TextXAlignment = Enum.TextXAlignment.Left
	AutoAuraLabel.Text = "Auto Aura"
	AutoAuraLabel.Parent = ScrollingFrame

	local AutoAuraToggle = Instance.new("TextButton")
	AutoAuraToggle.Name = "AutoAuraToggle"
	AutoAuraToggle.Size = UDim2.new(0, 45, 0, 22)
	AutoAuraToggle.Position = UDim2.new(1, -65, 0, 315)
	AutoAuraToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
	AutoAuraToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	AutoAuraToggle.TextSize = 11
	AutoAuraToggle.Font = Enum.Font.Gotham
	AutoAuraToggle.Text = "ON"
	AutoAuraToggle.Parent = ScrollingFrame

	local AutoAuraToggleCorner = Instance.new("UICorner")
	AutoAuraToggleCorner.CornerRadius = UDim.new(0, 6)
	AutoAuraToggleCorner.Parent = AutoAuraToggle

	-- Combat Mode Toggle
	local CombatModeLabel = Instance.new("TextLabel")
	CombatModeLabel.Name = "CombatModeLabel"
	CombatModeLabel.Size = UDim2.new(0.6, 0, 0, 20)
	CombatModeLabel.Position = UDim2.new(0, 15, 0, 350)
	CombatModeLabel.BackgroundTransparency = 1
	CombatModeLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	CombatModeLabel.TextSize = 12
	CombatModeLabel.Font = Enum.Font.GothamBold
	CombatModeLabel.TextXAlignment = Enum.TextXAlignment.Left
	CombatModeLabel.Text = "Combat Mode"
	CombatModeLabel.Parent = ScrollingFrame

	local CombatModeToggle = Instance.new("TextButton")
	CombatModeToggle.Name = "CombatModeToggle"
	CombatModeToggle.Size = UDim2.new(0, 45, 0, 22)
	CombatModeToggle.Position = UDim2.new(1, -65, 0, 350)
	CombatModeToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	CombatModeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	CombatModeToggle.TextSize = 11
	CombatModeToggle.Font = Enum.Font.Gotham
	CombatModeToggle.Text = "OFF"
	CombatModeToggle.Parent = ScrollingFrame

	local CombatModeToggleCorner = Instance.new("UICorner")
	CombatModeToggleCorner.CornerRadius = UDim.new(0, 6)
	CombatModeToggleCorner.Parent = CombatModeToggle

	-- Info Panel
	local InfoPanel = Instance.new("Frame")
	InfoPanel.Name = "InfoPanel"
	InfoPanel.Size = UDim2.new(1, -30, 0, 80)
	InfoPanel.Position = UDim2.new(0, 15, 0, 390)
	InfoPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
	InfoPanel.BorderSizePixel = 0
	InfoPanel.Parent = ScrollingFrame

	local InfoPanelCorner = Instance.new("UICorner")
	InfoPanelCorner.CornerRadius = UDim.new(0, 10)
	InfoPanelCorner.Parent = InfoPanel

	local InfoPanelStroke = Instance.new("UIStroke")
	InfoPanelStroke.Color = Color3.fromRGB(100, 150, 255)
	InfoPanelStroke.Thickness = 1.5
	InfoPanelStroke.Parent = InfoPanel

	local InfoText = Instance.new("TextLabel")
	InfoText.Name = "InfoText"
	InfoText.Size = UDim2.new(1, -20, 1, -20)
	InfoText.Position = UDim2.new(0, 10, 0, 10)
	InfoText.BackgroundTransparency = 1
	InfoText.TextColor3 = Color3.fromRGB(150, 200, 255)
	InfoText.TextSize = 11
	InfoText.Font = Enum.Font.Gotham
	InfoText.TextWrapped = true
	InfoText.TextXAlignment = Enum.TextXAlignment.Left
	InfoText.TextYAlignment = Enum.TextYAlignment.Top
	InfoText.Text = "💡 Aura Kill System aktif!\n\n⚡ Damage boost otomatis\n🛡️ Proteksi dari serangan\n🎯 Range attack membesar"
	InfoText.Parent = InfoPanel

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
			MainFrame.Size = UDim2.new(0, 380, 0, 60)
			HideButton.Text = "+"
		else
			ScrollingFrame.Visible = true
			MainFrame.Size = UDim2.new(0, 380, 0, 600)
			HideButton.Text = "−"
		end
	end)

	-- Exit Button Functionality
	ExitButton.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
		AuraKillScript.Enabled = false
	end)

	-- Aura Level Slider Functionality
	AuraLevelSlider.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local relativeX = (input.Position.X - AuraLevelSlider.AbsolutePosition.X) / AuraLevelSlider.AbsoluteSize.X
			relativeX = math.clamp(relativeX, 0, 1)
			AuraKillScript.AuraLevel = math.floor(relativeX * 6)
			AuraLevelSliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
			AuraLevelLabel.Text = "Aura Level: " .. AuraKillScript.AuraLevel
		end
	end)

	-- Damage Multiplier Slider Functionality
	DamageMultiplierSlider.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local relativeX = (input.Position.X - DamageMultiplierSlider.AbsolutePosition.X) / DamageMultiplierSlider.AbsoluteSize.X
			relativeX = math.clamp(relativeX, 0, 1)
			AuraKillScript.DamageMultiplier = math.floor(relativeX * 20) + 1
			DamageMultiplierSliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
			DamageMultiplierLabel.Text = "Damage Multiplier: " .. AuraKillScript.DamageMultiplier .. "x"
		end
	end)

	-- Aura Range Slider Functionality
	AuraRangeSlider.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local relativeX = (input.Position.X - AuraRangeSlider.AbsolutePosition.X) / AuraRangeSlider.AbsoluteSize.X
			relativeX = math.clamp(relativeX, 0, 1)
			AuraKillScript.AuraRange = math.floor(relativeX * 200) + 10
			AuraRangeSliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
			AuraRangeLabel.Text = "Aura Range: " .. AuraKillScript.AuraRange
		end
	end)

	-- Constant Damage Toggle
	ConstantDamageToggle.MouseButton1Click:Connect(function()
		AuraKillScript.ConstantDamage = not AuraKillScript.ConstantDamage
		if AuraKillScript.ConstantDamage then
			ConstantDamageToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
			ConstantDamageToggle.Text = "ON"
		else
			ConstantDamageToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			ConstantDamageToggle.Text = "OFF"
		end
	end)

	-- Damage Amount Input
	DamageAmountInput.FocusLost:Connect(function(enterPressed)
		local value = tonumber(DamageAmountInput.Text)
		if value then
			AuraKillScript.DamageAmount = math.floor(value)
			DamageAmountLabel.Text = "Damage Amount: " .. AuraKillScript.DamageAmount
		else
			DamageAmountInput.Text = tostring(AuraKillScript.DamageAmount)
		end
	end)

	-- Auto Aura Toggle
	AutoAuraToggle.MouseButton1Click:Connect(function()
		AuraKillScript.AutoAura = not AuraKillScript.AutoAura
		if AuraKillScript.AutoAura then
			AutoAuraToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
			AutoAuraToggle.Text = "ON"
		else
			AutoAuraToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			AutoAuraToggle.Text = "OFF"
		end
	end)

	-- Combat Mode Toggle
	CombatModeToggle.MouseButton1Click:Connect(function()
		AuraKillScript.CombatMode = not AuraKillScript.CombatMode
		if AuraKillScript.CombatMode then
			CombatModeToggle.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
			CombatModeToggle.Text = "ON"
		else
			CombatModeToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			CombatModeToggle.Text = "OFF"
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

-- Aura Damage Function
local function ApplyAuraDamage(target)
	if not target or not AuraKillScript.Enabled then return end
	
	local targetHumanoid = target:FindFirstChild("Humanoid")
	if not targetHumanoid then return end

	local Player = game:GetService("Players").LocalPlayer
	local Character = Player.Character
	if not Character then return end

	local distance = (Character:FindFirstChild("HumanoidRootPart").Position - target:FindFirstChild("HumanoidRootPart").Position).Magnitude
	
	if distance <= AuraKillScript.AuraRange then
		if AuraKillScript.ConstantDamage then
			targetHumanoid:TakeDamage(AuraKillScript.DamageAmount)
		else
			targetHumanoid:TakeDamage(50 * AuraKillScript.DamageMultiplier)
		end
	end
end

-- Find and damage nearby enemies
local function ProcessAuraKill()
	if not AuraKillScript.Enabled or not AuraKillScript.CombatMode then return end

	local Player = game:GetService("Players").LocalPlayer
	local Character = Player.Character
	if not Character then return end

	local RootPart = Character:FindFirstChild("HumanoidRootPart")
	if not RootPart then return end

	for _, otherPlayer in pairs(game:GetService("Players"):GetPlayers()) do
		if otherPlayer ~= Player and otherPlayer.Character then
			ApplyAuraDamage(otherPlayer.Character)
		end
	end
end

-- Aura Visualization Function
local function CreateAuraEffect(character)
	if not character then return end

	local RootPart = character:FindFirstChild("HumanoidRootPart")
	if not RootPart then return end

	-- Remove old aura
	if RootPart:FindFirstChild("AuraEffect") then
		RootPart:FindFirstChild("AuraEffect"):Destroy()
	end

	if not AuraKillScript.Enabled then return end

	local Aura = Instance.new("ParticleEmitter")
	Aura.Name = "AuraEffect"
	Aura.Parent = RootPart
	Aura.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	Aura.Rate = 50
	Aura.Lifetime = NumberRange.new(0.5, 1.5)
	Aura.Speed = NumberRange.new(10)
	Aura.Rotation = NumberRange.new(0, 360)
	Aura.Color = ColorSequence.new(AuraKillScript.AuraColor)
	Aura.VelocityInheritance = 0
	Aura.Transparency = NumberSequence.new(0.3)
	Aura.Size = NumberSequence.new(1, 0)

	return Aura
end

-- Auto Aura Activation
local function AutoActivateAura()
	if not AuraKillScript.AutoAura or not AuraKillScript.Enabled then return end

	local Player = game:GetService("Players").LocalPlayer
	local Character = Player.Character
	if not Character then return end

	-- Trigger aura activation
	local Event = ReplicatedStorage:FindFirstChild("Aura") or ReplicatedStorage:FindFirstChild("AuraActivate")
	if Event and Event:IsA("RemoteEvent") then
		Event:FireServer()
	end
end

-- Main Loop
RunService.Heartbeat:Connect(function()
	if not AuraKillScript.Enabled then return end

	local Player = game:GetService("Players").LocalPlayer
	local Character = Player.Character or Player.CharacterAdded:Wait()

	if Character ~= Character then
		CreateAuraEffect(Character)
	end

	ProcessAuraKill()
	
	if AuraKillScript.AutoAura then
		AutoActivateAura()
	end
end)

-- Initialize
local Character = Player.Character or Player.CharacterAdded:Wait()
CreateAuraEffect(Character)
CreateUI()

-- Handle new character
Player.CharacterAdded:Connect(function(newCharacter)
	Character = newCharacter
	wait(0.1)
	CreateAuraEffect(Character)
end)

print("⚡ Aura Kill Script Activated by 170F Team! ⚡")
print("Combat Mode untuk mulai serangan otomatis")
print("Adjust settings di UI untuk customize damage")
