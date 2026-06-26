--// 170F Team - WalkSpeed Tester

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local ParentGui = (gethui and gethui()) or game:GetService("CoreGui")

local Gui = Instance.new("ScreenGui")
Gui.Name = "170F_WalkSpeed"
Gui.ResetOnSpawn = false
Gui.Parent = ParentGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 320, 0, 190)
Main.Position = UDim2.new(0.5, -160, 0.5, -95)
Main.BackgroundColor3 = Color3.fromRGB(30,30,30)
Main.BorderSizePixel = 0
Main.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0,12)
Corner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundTransparency = 1
Title.Text = "170F Team | WalkSpeed Test"
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.TextColor3 = Color3.new(1,1,1)
Title.Parent = Main

-- Rainbow title
task.spawn(function()
	while task.wait() do
		local t = tick() * 0.3
		Title.TextColor3 = Color3.fromHSV(t % 1,1,1)
	end
end)

local Box = Instance.new("TextBox")
Box.Size = UDim2.new(0.8,0,0,35)
Box.Position = UDim2.new(0.1,0,0.3,0)
Box.PlaceholderText = "Masukkan WalkSpeed (contoh: 50)"
Box.Text = ""
Box.Font = Enum.Font.Gotham
Box.TextScaled = true
Box.Parent = Main

local BoxCorner = Instance.new("UICorner")
BoxCorner.Parent = Box

local SetBtn = Instance.new("TextButton")
SetBtn.Size = UDim2.new(0.35,0,0,35)
SetBtn.Position = UDim2.new(0.08,0,0.58,0)
SetBtn.Text = "SET"
SetBtn.Font = Enum.Font.GothamBold
SetBtn.TextScaled = true
SetBtn.Parent = Main
Instance.new("UICorner", SetBtn)

local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0.25,0,0,35)
HideBtn.Position = UDim2.new(0.47,0,0.58,0)
HideBtn.Text = "HIDE"
HideBtn.Font = Enum.Font.GothamBold
HideBtn.TextScaled = true
HideBtn.Parent = Main
Instance.new("UICorner", HideBtn)

local ExitBtn = Instance.new("TextButton")
ExitBtn.Size = UDim2.new(0.2,0,0,35)
ExitBtn.Position = UDim2.new(0.75,0,0.58,0)
ExitBtn.Text = "EXIT"
ExitBtn.Font = Enum.Font.GothamBold
ExitBtn.TextScaled = true
ExitBtn.Parent = Main
Instance.new("UICorner", ExitBtn)

local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1,0,0,25)
Credit.Position = UDim2.new(0,0,0.85,0)
Credit.BackgroundTransparency = 1
Credit.Text = "Author : 170F Team"
Credit.Font = Enum.Font.Gotham
Credit.TextScaled = true
Credit.Parent = Main

task.spawn(function()
	while task.wait() do
		local t = tick() * 0.2
		Credit.TextColor3 = Color3.fromHSV(t % 1,1,1)
	end
end)

-- Drag UI
local dragging = false
local dragStart
local startPos

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch) then

		local delta = input.Position - dragStart
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Set WalkSpeed
local function applySpeed(value)
	local char = Player.Character or Player.CharacterAdded:Wait()
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = value
	end
end

SetBtn.MouseButton1Click:Connect(function()
	local speed = tonumber(Box.Text)
	if speed then
		applySpeed(speed)
	end
end)

Player.CharacterAdded:Connect(function(char)
	task.wait(1)
	local speed = tonumber(Box.Text)
	if speed then
		applySpeed(speed)
	end
end)

-- Hide / Show
local hidden = false
HideBtn.MouseButton1Click:Connect(function()
	hidden = not hidden

	for _,v in ipairs(Main:GetChildren()) do
		if v ~= Title and v ~= HideBtn then
			v.Visible = not hidden
		end
	end

	if hidden then
		HideBtn.Text = "SHOW"
	else
		HideBtn.Text = "HIDE"
	end
end)

-- Exit
ExitBtn.MouseButton1Click:Connect(function()
	Gui:Destroy()
end)
