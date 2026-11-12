-- discord.gg/syncrypt

local t1 = {
	listfunction = {},
	listtab = {}
}
local TouchGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TouchGui")
local u3
local t2 = {}

t1.UIColor = {
	["Border Color"] = Color3.fromRGB(168, 128, 255),
	["Click Effect Color"] = Color3.fromRGB(230, 230, 230),
	["Setting Icon Color"] = Color3.fromRGB(230, 230, 230),
	["Logo Image"] = "rbxassetid://139680899478857",
	["Search Icon Color"] = Color3.fromRGB(255, 255, 255),
	["Search Icon Highlight Color"] = Color3.fromRGB(229, 204, 255),
	["GUI Text Color"] = Color3.fromRGB(230, 230, 230),
	["Text Color"] = Color3.fromRGB(230, 230, 230),
	["Placeholder Text Color"] = Color3.fromRGB(178, 178, 178),
	["Title Text Color"] = Color3.fromRGB(170, 85, 255),
	["Background Main Color"] = Color3.fromRGB(15, 15, 15),
	["Background 1 Color"] = Color3.fromRGB(28, 28, 34),
	["Background 1 Transparency"] = 0.25,
	["Background 2 Color"] = Color3.fromRGB(90, 90, 90),
	["Background 3 Color"] = Color3.fromRGB(20, 20, 20),
	["Background Image"] = "",
	["Page Selected Color"] = Color3.fromRGB(200, 0, 255),
	["Section Text Color"] = Color3.fromRGB(200, 0, 255),
	["Section Underline Color"] = Color3.fromRGB(200, 0, 255),
	["Toggle Border Color"] = Color3.fromRGB(200, 0, 255),
	["Toggle Checked Color"] = Color3.fromRGB(230, 230, 230),
	["Toggle Desc Color"] = Color3.fromRGB(185, 185, 185),
	["Button Color"] = Color3.fromRGB(35, 35, 35),
	["Label Color"] = Color3.fromRGB(35, 35, 35),
	["Dropdown Icon Color"] = Color3.fromRGB(230, 230, 230),
	["Dropdown Selected Color"] = Color3.fromRGB(170, 170, 255),
	["Dropdown Selected Check Color"] = Color3.fromRGB(160, 143, 255),
	["Textbox Highlight Color"] = Color3.fromRGB(170, 85, 255),
	["Box Highlight Color"] = Color3.fromRGB(170, 85, 255),
	["Slider Line Color"] = Color3.fromRGB(45, 22, 67),
	["Slider Highlight Color"] = Color3.fromRGB(179, 116, 255),
	["Tween Animation 1 Speed"] = TouchGui and 0 or 0.25,
	["Tween Animation 2 Speed"] = TouchGui and 0 or 0.5,
	["Tween Animation 3 Speed"] = TouchGui and 0 or 0.1,
	["Text Stroke Transparency"] = 0.5
}
t1.UIToggled = true

local t3 = {
	Options = {}
}

getgenv().Options = t3.Options

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function v10(p1, p2)
	local u11
	local u12
	local Position
	local Position2

	p1.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			u11 = true
			Position = input.Position
			Position2 = p2.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					u11 = false
				end
			end)

			return
		elseif input.UserInputType == Enum.UserInputType.Touch then
			u11 = true
			Position = input.Position
			Position2 = p2.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					u11 = false
				end
			end)
		end
	end)
	p1.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			u12 = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == u12 and u11 then
			local v15 = input.Position - Position

			if not djtmemay and cac then
				TweenService:Create(p2, TweenInfo.new(TouchGui and 0 or 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Position = UDim2.new(Position2.X.Scale, Position2.X.Offset + v15.X, Position2.Y.Scale, Position2.Y.Offset + v15.Y)
				}):Play()
			elseif not djtmemay and not cac then
				p2.Position = UDim2.new(Position2.X.Scale, Position2.X.Offset + v15.X, Position2.Y.Scale, Position2.Y.Offset + v15.Y)
			end
		end
	end)
end

local t4 = {
	Gui = Instance.new("ScreenGui")
}

t4.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
t4.Gui.Name = "Nousigi Hub GUI"
t4.Gui.DisplayOrder = 9999
t4.Gui.ResetOnSpawn = false
t4.Gui.Enabled = false
t1.ReadyForGuiLoaded = false

local function v16()
	repeat
		task.wait()
	until t1.ReadyForGuiLoaded

	if t1.UIToggled then
		t4.Gui.Enabled = true
	end
end

spawn(v16)
t4.NotiGui = Instance.new("ScreenGui")
t4.NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
t4.NotiGui.Name = "Nousigi Hub Notification"
t4.NotiGui.DisplayOrder = 2147483647
t4.NotiGui.ResetOnSpawn = false
t4.NotiGui.IgnoreGuiInset = true
t4.HideGui = Instance.new("ScreenGui")
t4.HideGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
t4.HideGui.Name = "Nousigi Hub Btn"
t4.HideGui.DisplayOrder = 99999
t4.HideGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

Frame.Name = "NotiContainer"
Frame.Parent = t4.NotiGui
Frame.AnchorPoint = Vector2.new(1, 1)
Frame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
Frame.BackgroundTransparency = 1
Frame.Position = UDim2.new(1, -5, 1, -5)
Frame.Size = UDim2.new(0, 350, 1, -10)
Frame.ZIndex = 999999
UIListLayout.Name = "NotiList"
UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.Padding = UDim.new(0, 5)

local hui

pcall(function()
	if gethui then
		hui = gethui()
	elseif game:GetService("CoreGui") then
		hui = game:GetService("CoreGui")
	end
end)
hui = hui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
t4.Gui.Parent = hui
t4.NotiGui.Parent = hui
t4.HideGui.Parent = hui

local ImageButton = Instance.new("ImageButton", t4.HideGui)

ImageButton.BorderSizePixel = 0
ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageButton.AnchorPoint = Vector2.new(0, 1)
ImageButton.Image = "rbxassetid://136103435617044"
ImageButton.Size = UDim2.new(0, 50, 0, 50)
ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageButton.Position = UDim2.new(0.01, 0, 0.99, 0)
v10(ImageButton, ImageButton)
t3.ToggleKey = Enum.KeyCode.LeftControl
t3.ToggleUI = function()
	t4.Gui.Enabled = not t4.Gui.Enabled
	t1.UIToggled = t4.Gui.Enabled

	return t4.Gui.Enabled
end
ImageButton.MouseButton1Down:Connect(function()
	t3.ToggleUI()
end)
UserInputService.InputBegan:Connect(function(input)
	if (input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl or t3.ToggleKey and input.KeyCode == t3.ToggleKey) and not UserInputService:GetFocusedTextBox() then
		t3.ToggleUI()
	end
end)
Instance.new("UICorner", ImageButton).CornerRadius = UDim.new(1, 8)

local UIStroke = Instance.new("UIStroke", ImageButton)

UIStroke.Thickness = 0.6
UIStroke.Color = Color3.fromRGB(171, 0, 255)
t4.Getcolor = function(p3)
	return {
		math.floor(p3.r * 255),
		math.floor(p3.g * 255),
		math.floor(p3.b * 255)
	}
end

local function v22(p4)
	local v23 = p4 or {}

	t1.TitleNameNoti = v23.Title or v23.Name or ""

	local Desc = v23.Desc or v23.Description or v23.Content or v23.Text or ""
	local ShowTime = v23.ShowTime or v23.Duration or v23.Time or v23.Delay or 10
	local Frame2 = Instance.new("Frame")
	local Frame3 = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Frame4 = Instance.new("Frame")
	local ImageLabel = Instance.new("ImageLabel")
	local UICorner2 = Instance.new("UICorner")
	local TextLabel = Instance.new("TextLabel")
	local Frame5 = Instance.new("Frame")
	local ImageLabel2 = Instance.new("ImageLabel")
	local TextButton = Instance.new("TextButton")
	local TextLabel2 = Instance.new("TextLabel")

	Frame2.Name = "NotiFrame"
	Frame2.Parent = Frame
	Frame2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Frame2.BackgroundTransparency = 1
	Frame2.ClipsDescendants = true
	Frame2.Position = UDim2.new(0, 0, 0, 0)
	Frame2.Size = UDim2.new(1, 0, 0, 0)
	Frame2.AutomaticSize = Enum.AutomaticSize.Y
	Frame2.ZIndex = 999999
	Frame3.Name = "Noticontainer"
	Frame3.Parent = Frame2
	Frame3.Position = UDim2.new(1, 0, 0, 0)
	Frame3.Size = UDim2.new(1, 0, 1, 6)
	Frame3.AutomaticSize = Enum.AutomaticSize.Y
	Frame3.BackgroundColor3 = Color3.fromRGB(48, 47, 55)
	Frame3.ZIndex = 999999
	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Frame3

	local UIStroke2 = Instance.new("UIStroke", Frame3)

	UIStroke2.Thickness = 1
	UIStroke2.Color = Color3.fromRGB(90, 90, 70)
	Frame4.Name = "Topnoti"
	Frame4.Parent = Frame3
	Frame4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Frame4.BackgroundTransparency = 1
	Frame4.Position = UDim2.new(0, 0, 0, 5)
	Frame4.Size = UDim2.new(1, 0, 0, 25)
	Frame4.ZIndex = 999999
	ImageLabel.Name = "Ruafimg"
	ImageLabel.Parent = Frame4
	ImageLabel.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ImageLabel.BackgroundTransparency = 1

	local UDim2_

	if t1.T1 then
		ImageLabel.Position = UDim2.new(0, 5, 0, 5)
		UDim2_ = UDim2
	else
		ImageLabel.Position = UDim2.new(0, 5, 0, 0)
		UDim2_ = UDim2
	end

	local new = UDim2_.new
	local v40

	if not t1.T1 then
		if t1.T1 then
			v40 = new(0, 25, 0, 15)
		else
			v40 = new(0, 25, 0, 25)
		end
	elseif t1.T1 then
		v40 = new(0, 30, 0, 15)
	else
		v40 = new(0, 30, 0, 25)
	end

	ImageLabel.Size = v40
	ImageLabel.Image = t1.UIColor["Logo Image"]
	ImageLabel.ZIndex = 999999
	UICorner2.CornerRadius = UDim.new(1, 0)
	UICorner2.Name = "RuafimgCorner"
	UICorner2.Parent = ImageLabel
	TextLabel.Text = "<font color=\"rgb(" .. (tostring(t4.Getcolor(t1.UIColor["Title Text Color"])[1]) .. "," .. tostring(t4.Getcolor(t1.UIColor["Title Text Color"])[2]) .. "," .. tostring(t4.Getcolor(t1.UIColor["Title Text Color"])[3])) .. ")\">Teddy Hub</font> " .. t1.TitleNameNoti
	TextLabel.Name = "TextLabelNoti"
	TextLabel.Parent = Frame4
	TextLabel.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextLabel.BackgroundTransparency = 1

	local uDim2New

	if t1.T1 then
		TextLabel.Position = UDim2.new(0, 40, 0, 0)
		uDim2New = UDim2.new
	else
		TextLabel.Position = UDim2.new(0, 35, 0, 0)
		uDim2New = UDim2.new
	end

	if t1.T1 then
		TextLabel.Size = uDim2New(1, -40, 1, 0)
		TextLabel.Font = Enum.Font.GothamBold
	else
		TextLabel.Size = uDim2New(1, -35, 1, 0)
		TextLabel.Font = Enum.Font.GothamBold
	end

	TextLabel.TextSize = 14
	TextLabel.TextWrapped = true
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.RichText = true
	TextLabel.TextColor3 = t1.UIColor["GUI Text Color"]
	TextLabel.ZIndex = 999999
	Frame5.Name = "CloseContainer"
	Frame5.Parent = Frame4
	Frame5.AnchorPoint = Vector2.new(1, 0.5)
	Frame5.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Frame5.BackgroundTransparency = 1
	Frame5.Position = UDim2.new(1, -4, 0.5, 0)
	Frame5.Size = UDim2.new(0, 22, 0, 22)
	Frame5.ZIndex = 999999
	ImageLabel2.Name = "CloseImage"
	ImageLabel2.Parent = Frame5
	ImageLabel2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ImageLabel2.BackgroundTransparency = 1
	ImageLabel2.Size = UDim2.new(1, 0, 1, 0)
	ImageLabel2.Image = "rbxassetid://129781592728096"
	ImageLabel2.ImageRectOffset = Vector2.new(284, 4)
	ImageLabel2.ImageRectSize = Vector2.new(24, 24)
	ImageLabel2.ImageColor3 = t1.UIColor["Search Icon Color"]
	ImageLabel2.ZIndex = 999999
	TextButton.Parent = Frame5
	TextButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextButton.BackgroundTransparency = 1
	TextButton.Size = UDim2.new(1, 0, 1, 0)
	TextButton.Font = Enum.Font.FredokaOne
	TextButton.Text = "X"
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 14
	TextButton.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TextButton.TextColor3 = Color3.new(1, 1, 1)
	TextButton.ZIndex = 1000000

	if Desc ~= "" then
		TextLabel2.Name = "TextColor"
		TextLabel2.Parent = Frame3
		TextLabel2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TextLabel2.BackgroundTransparency = 1
		TextLabel2.Position = UDim2.new(0, 10, 0, 35)
		TextLabel2.Size = UDim2.new(1, -15, 0, 0)
		TextLabel2.Font = Enum.Font.GothamBold
		TextLabel2.Text = Desc
		TextLabel2.TextSize = 14
		TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel2.RichText = true
		TextLabel2.TextColor3 = t1.UIColor["Text Color"]
		TextLabel2.AutomaticSize = Enum.AutomaticSize.Y
		TextLabel2.TextWrapped = true
		TextLabel2.ZIndex = 999999
	end

	local function v42()
		TweenService:Create(Frame3, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
			Position = UDim2.new(1, 0, 0, 0)
		}):Play()
		wait(0.25)
		Frame2:Destroy()
	end

	TweenService:Create(Frame3, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
		Position = UDim2.new(0, 0, 0, 0)
	}):Play()
	TextButton.MouseEnter:Connect(function()
		TweenService:Create(ImageLabel2, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = t1.UIColor["Search Icon Highlight Color"]
		}):Play()
	end)
	TextButton.MouseLeave:Connect(function()
		TweenService:Create(ImageLabel2, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = t1.UIColor["Search Icon Color"]
		}):Play()
	end)
	TextButton.MouseButton1Click:Connect(function()
		wait(0.25)
		v42()
	end)
	spawn(function()
		wait(ShowTime)
		v42()
	end)
end

t3.Notify = function(...)
	local t5 = { ... }
	local v44, v45

	if t5[1] == t3 or type(t5[1]) == "table" and (t5[1].Notify or t5[1].CreateMain or t5[1].CreateSection or t5[1].Options) then
		v44 = t5[2] or {}
		v45 = t5[3]
	else
		v44 = t5[1] or {}
		v45 = t5[2]
	end

	if not t1.Config or v45 then
		local _, result = pcall(function()
			v22(v44)
		end)

		if result then
			warn("[Notify Error]:", result)
		end
	end
end
t3.CreateNoti = t3.Notify
t3.CreateMain = function(p5)
	t1.MainDesc = p5.Desc or ""
	cac = false

	local Frame2 = Instance.new("Frame")
	local ImageLabel = Instance.new("ImageLabel")
	local UICorner = Instance.new("UICorner")
	local Frame3 = Instance.new("Frame")
	local ImageLabel2 = Instance.new("ImageLabel")
	local TextLabel = Instance.new("TextLabel")
	local Frame4 = Instance.new("Frame")
	local UICorner2 = Instance.new("UICorner")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout2 = Instance.new("UIListLayout")
	local TextLabel2 = Instance.new("TextLabel")
	local Frame5 = Instance.new("Frame")
	local UIPageLayout = Instance.new("UIPageLayout")
	local Frame6 = Instance.new("Frame")
	local Frame7 = Instance.new("Frame")

	Frame2.Name = "Main"
	Frame2.Parent = t4.Gui
	Frame2.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
	Frame2.BackgroundTransparency = 1
	Frame2.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame2.Size = UDim2.new(0, 629, 0, 359)
	v10(Frame2, Frame2)
	ImageLabel.Name = "maingui"
	ImageLabel.Parent = Frame2
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Selectable = true
	ImageLabel.Size = UDim2.new(1, 30, 1, 30)
	ImageLabel.Image = "rbxassetid://129781592728096"
	ImageLabel.ScaleType = Enum.ScaleType.Slice
	ImageLabel.SliceCenter = Rect.new(15, 15, 175, 175)
	ImageLabel.SliceScale = 1.3
	ImageLabel.ImageColor3 = t1.UIColor["Border Color"]
	ImageLabel.ImageTransparency = 1
	ImageLabel.ImageColor3 = t1.UIColor["Title Text Color"]
	TextLabel.Text = "<font color=\"rgb(" .. (tostring(t4.Getcolor(t1.UIColor["Title Text Color"])[1]) .. "," .. tostring(t4.Getcolor(t1.UIColor["Title Text Color"])[2]) .. "," .. tostring(t4.Getcolor(t1.UIColor["Title Text Color"])[3])) .. ")\">" .. (p5.Title or "Teddy Hub") .. " </font> " .. (p5.Desc or ": Blox Fruits")

	local ImageLabel3 = Instance.new("ImageLabel")

	ImageLabel3.Name = "MainContainer"
	ImageLabel3.Parent = Frame2
	ImageLabel3.BackgroundColor3 = t1.UIColor["Background Main Color"]
	ImageLabel3.Size = UDim2.new(1, 0, 1, 0)

	local UIStroke2 = Instance.new("UIStroke", ImageLabel3)

	UIStroke2.Thickness = 1
	UIStroke2.Color = Color3.fromRGB(90, 90, 70)

	local UIGradient = Instance.new("UIGradient", ImageLabel3)

	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
	})
	UIGradient.Rotation = 90
	UIGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.92),
		NumberSequenceKeypoint.new(1, 0.92)
	})
	t1.ReadyForGuiLoaded = true
	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Name = "MainCorner"
	UICorner.Parent = ImageLabel3
	Frame6.Name = "Concacontainer"
	Frame6.Parent = ImageLabel3
	Frame6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame6.BackgroundTransparency = 1
	Frame6.ClipsDescendants = true
	Frame6.Position = UDim2.new(0, 0, 0, 30)
	Frame6.Size = UDim2.new(1, 0, 1, -30)
	Frame7.Name = "Concacmain"
	Frame7.Parent = Frame6
	Frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame7.BackgroundTransparency = 1
	Frame7.Selectable = true
	Frame7.Size = UDim2.new(1, 0, 1, 0)
	Frame3.Name = "TopMain"
	Frame3.Parent = ImageLabel3
	Frame3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame3.BackgroundTransparency = 1
	Frame3.Size = UDim2.new(1, 0, 0, 25)

	local Frame8 = Instance.new("Frame", Frame3)

	Frame8.Name = "TopStroke"
	Frame8.BackgroundColor3 = Color3.fromRGB(90, 90, 70)
	Frame8.BackgroundTransparency = 0.6
	Frame8.BorderSizePixel = 0
	Frame8.Position = UDim2.new(0, 0, 1, -1)
	Frame8.Size = UDim2.new(1, 0, 0, 1)
	ImageLabel2.Name = "Ruafimg"
	ImageLabel2.Parent = Frame3
	ImageLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel2.BackgroundTransparency = 1

	local n1 = 0
	local n2 = 5
	local n3 = 0

	ImageLabel2.Position = UDim2.new(n1, n2, n3, t1.T1 and 5 or 0)
	ImageLabel2.Size = UDim2.new(n1, t1.T1 and 30 or 25, n3, t1.T1 and 15 or 25)
	ImageLabel2.Image = "rbxassetid://139680899478857"
	TextLabel.Name = "TextLabelMain"
	TextLabel.Parent = Frame3
	TextLabel.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Position = UDim2.new(n1, t1.T1 and 40 or 35, 0, 0)
	TextLabel.Size = UDim2.new(1, t1.T1 and -40 or -35, 1, 0)
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.RichText = true
	TextLabel.TextSize = 16
	TextLabel.TextWrapped = true
	TextLabel.TextXAlignment = Enum.TextXAlignment.Center
	TextLabel.TextColor3 = t1.UIColor["GUI Text Color"]
	TextLabel.Text = "<font color=\"rgb(" .. (tostring(t4.Getcolor(t1.UIColor["Title Text Color"])[1]) .. "," .. tostring(t4.Getcolor(t1.UIColor["Title Text Color"])[2]) .. "," .. tostring(t4.Getcolor(t1.UIColor["Title Text Color"])[3])) .. ")\">Teddy Hub </font> : Blox Fruits"
	Frame4.Name = "Background1"
	Frame4.Parent = Frame7
	Frame4.Position = UDim2.new(0, 5, 0, 0)
	Frame4.Size = UDim2.new(0, 160, 0, 325)
	Frame4.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
	Frame4.BackgroundColor3 = t1.UIColor["Background 1 Color"]

	local UIGradient2 = Instance.new("UIGradient", Frame4)

	UIGradient2.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.1),
		NumberSequenceKeypoint.new(1, 0.1)
	})
	UIGradient2.Name = "thua"
	UIGradient2.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 22, 22)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 44, 44))
	})

	local UIStroke3 = Instance.new("UIStroke", Frame4)

	UIStroke3.Color = Color3.fromRGB(90, 90, 70)
	UIStroke3.Thickness = 1
	UICorner2.CornerRadius = UDim.new(0, 4)
	UICorner2.Parent = Frame4
	ScrollingFrame.Name = "ControlList"
	ScrollingFrame.Parent = Frame4
	ScrollingFrame.Active = true
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0, 0, 0, 30)
	ScrollingFrame.Size = UDim2.new(1, -5, 1, -30)
	ScrollingFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.ScrollBarThickness = 5
	ScrollingFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	UIListLayout2.Parent = ScrollingFrame
	UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout2.Padding = UDim.new(0, 5)
	TextLabel2.Name = "GUITextColor"
	TextLabel2.Parent = Frame4
	TextLabel2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextLabel2.BackgroundTransparency = 1
	TextLabel2.Position = UDim2.new(0, 5, 0, 0)
	TextLabel2.Size = UDim2.new(1, 0, 0, 25)
	TextLabel2.Font = Enum.Font.GothamBold
	TextLabel2.Text = "by vhai"
	TextLabel2.TextSize = 14
	TextLabel2.TextXAlignment = Enum.TextXAlignment.Center
	TextLabel2.TextColor3 = t1.UIColor["GUI Text Color"]
	Frame5.Name = "MainPage"
	Frame5.Parent = Frame7
	Frame5.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Frame5.BackgroundTransparency = 1
	Frame5.ClipsDescendants = true
	Frame5.Position = UDim2.new(0, 170, 0, 0)
	Frame5.Size = UDim2.new(0, 453, 0, 325)
	UIPageLayout.Name = "UIPage"
	UIPageLayout.Parent = Frame5
	UIPageLayout.FillDirection = Enum.FillDirection.Vertical
	UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
	UIPageLayout.EasingStyle = Enum.EasingStyle.Quart
	UIPageLayout.Padding = UDim.new(0, 10)
	UIPageLayout.TweenTime = t1.UIColor["Tween Animation 1 Speed"]
	UIListLayout2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout2.AbsoluteContentSize.Y + 5)
	end)

	local ImageLabel4 = Instance.new("ImageLabel", Frame2)

	ImageLabel4.Name = "Shadow"
	ImageLabel4.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel4.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	ImageLabel4.BackgroundTransparency = 1
	ImageLabel4.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel4.Size = UDim2.new(1, 40, 1, 40)
	ImageLabel4.ZIndex = 0
	ImageLabel4.Image = "rbxassetid://5028857084"
	ImageLabel4.ImageTransparency = 0.35
	ImageLabel4.ScaleType = Enum.ScaleType.Slice
	ImageLabel4.SliceCenter = Rect.new(24, 24, 276, 276)

	local Frame9 = Instance.new("Frame")
	local UICorner3 = Instance.new("UICorner")
	local Frame10 = Instance.new("Frame")
	local ImageLabel5 = Instance.new("ImageLabel")
	local TextButton = Instance.new("TextButton")
	local TextBox = Instance.new("TextBox")

	Frame9.Name = "Page Search"
	Frame9.Parent = Frame4
	Frame9.AnchorPoint = Vector2.new(1, 0)
	Frame9.BackgroundColor3 = Color3.fromRGB(37, 36, 44)
	Frame9.Position = UDim2.new(1, -5, 0, 5)
	Frame9.Size = UDim2.new(0, 20, 0, 20)
	Frame9.ClipsDescendants = true
	UICorner3.CornerRadius = UDim.new(0, 2)
	UICorner3.Name = "PageSearchCorner"
	UICorner3.Parent = Frame9
	Frame10.Name = "SearchFrame"
	Frame10.Parent = Frame9
	Frame10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame10.BackgroundTransparency = 1
	Frame10.Size = UDim2.new(0, 20, 0, 20)
	ImageLabel5.Name = "SearchIcon"
	ImageLabel5.Parent = Frame10
	ImageLabel5.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel5.BackgroundTransparency = 1
	ImageLabel5.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel5.Size = UDim2.new(0, 16, 0, 16)
	ImageLabel5.Image = "rbxassetid://8154282545"
	ImageLabel5.ImageColor3 = t1.UIColor["Search Icon Color"]
	TextButton.Name = "Search Button"
	TextButton.Parent = Frame10
	TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.BackgroundTransparency = 1
	TextButton.Size = UDim2.new(1, 0, 1, 0)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = ""
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 14
	TextBox.Name = "Search Box"
	TextBox.Parent = Frame9
	TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.BackgroundTransparency = 1
	TextBox.Position = UDim2.new(0, 30, 0, 0)
	TextBox.Size = UDim2.new(1, -30, 1, 0)
	TextBox.Font = Enum.Font.GothamBold
	TextBox.Text = ""
	TextBox.TextSize = 14
	TextBox.TextXAlignment = Enum.TextXAlignment.Left
	TextBox.PlaceholderText = "Search section or function"
	TextBox.PlaceholderColor3 = t1.UIColor["Placeholder Text Color"]
	TextBox.TextColor3 = t1.UIColor["Text Color"]

	local u79 = true

	TextButton.MouseEnter:Connect(function()
		TweenService:Create(ImageLabel5, TweenInfo.new(t1.UIColor["Tween Animation 3 Speed"]), {
			ImageColor3 = t1.UIColor["Search Icon Highlight Color"]
		}):Play()
	end)
	TextButton.MouseLeave:Connect(function()
		TweenService:Create(ImageLabel5, TweenInfo.new(t1.UIColor["Tween Animation 3 Speed"]), {
			ImageColor3 = t1.UIColor["Search Icon Color"]
		}):Play()
	end)
	TextButton.MouseButton1Click:Connect(function()
		u79 = not u79

		local uDim2 = u79 and UDim2.new(0, 150, 0, 20) or UDim2.new(0, 20, 0, 20)

		game.TweenService:Create(Frame9, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
			Size = uDim2
		}):Play()
	end)

	local uDim2 = u79 and UDim2.new(0, 150, 0, 20) or UDim2.new(0, 20, 0, 20)

	game.TweenService:Create(Frame9, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
		Size = uDim2
	}):Play()

	local layoutOrder = -1
	local layoutOrder2 = -1
	local n4 = 1

	u3 = function()
		for _, child in pairs(ScrollingFrame:GetChildren()) do
			if not child:IsA("UIListLayout") then
				child.Visible = true
			end
		end

		for _, child in pairs(Frame5:GetChildren()) do
			if not child:IsA("UIPageLayout") and not child:IsA("UICorner") then
				child.Visible = true
			end
		end

		for k, v in pairs(t2) do
			k.Visible = true

			for _, v2 in pairs(v) do
				v2.Visible = true
			end
		end
	end
	TextBox:GetPropertyChangedSignal("Text"):Connect(function()
		local Text = TextBox.Text

		if Text == "" then
			u3()
		else
			for k, v in pairs(t2) do
				k.Visible = false

				for _, v2 in pairs(v) do
					v2.Visible = false
				end
			end

			for _, child in pairs(ScrollingFrame:GetChildren()) do
				if not child:IsA("UIListLayout") then
					child.Visible = false
				end
			end

			for _, child in pairs(Frame5:GetChildren()) do
				if not child:IsA("UIPageLayout") and not child:IsA("UICorner") then
					child.Visible = false
				end
			end

			for k, v in pairs(t1.listfunction) do
				for _, v2 in pairs(v) do
					if string.find(v2.Name:lower(), Text:lower()) then
						if v2.Call then
							v2.Call()
						end

						local v106 = t1.listtab[k]

						if v106 then
							v106[1].Visible = true
							v106[2].Visible = true
							v106[3].Visible = true

							local tweenAnimation1Speed = t1.UIColor["Tween Animation 1 Speed"]

							UIPageLayout.TweenTime = 0
							UIPageLayout:JumpTo(v106[2])
							task.wait()
							UIPageLayout.TweenTime = tweenAnimation1Speed
						end
					end
				end
			end
		end
	end)

	return {
		CreatePage = function(p6)
			local text = tostring(p6.Page_Name)
			local text2 = tostring(p6.Page_Title)

			layoutOrder2 += 1
			layoutOrder += 1

			local Frame11 = Instance.new("Frame")
			local Frame12 = Instance.new("Frame")
			local UICorner4 = Instance.new("UICorner")
			local Frame13 = Instance.new("Frame")
			local Frame14 = Instance.new("Frame")
			local UICorner5 = Instance.new("UICorner")
			local Frame15 = Instance.new("Frame")
			local TextLabel3 = Instance.new("TextLabel")
			local TextButton2 = Instance.new("TextButton")

			Frame11.Name = text .. "_Control"
			Frame11.Parent = ScrollingFrame
			Frame11.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Frame11.BackgroundTransparency = 1
			Frame11.Size = UDim2.new(1, -10, 0, 25)
			Frame11.LayoutOrder = layoutOrder
			Frame12.Parent = Frame11
			Frame12.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Frame12.BackgroundTransparency = 1
			Frame12.Position = UDim2.new(0, 5, 0, 0)
			Frame12.Size = UDim2.new(1, -5, 1, 0)
			UICorner4.CornerRadius = UDim.new(0, 4)
			UICorner4.Name = "TabNameCorner"
			UICorner4.Parent = Frame12
			Frame13.Name = "Line"
			Frame13.Parent = Frame12
			Frame13.AnchorPoint = Vector2.new(0, 0.5)
			Frame13.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Frame13.BackgroundTransparency = 1
			Frame13.Position = UDim2.new(0, 0, 0.5, 0)
			Frame13.Size = UDim2.new(0, 14, 1, 0)
			Frame14.Name = "PageInLine"
			Frame14.Parent = Frame13
			Frame14.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame14.BorderSizePixel = 0
			Frame14.Position = UDim2.new(0.5, 0, 0.5, 0)
			Frame14.Size = UDim2.new(1, -10, 1, -10)
			Frame14.BackgroundColor3 = t1.UIColor["Page Selected Color"]
			Frame14.BackgroundTransparency = 1
			UICorner5.Name = "LineCorner"
			UICorner5.Parent = Frame14
			Frame15.Name = "TabTitleContainer"
			Frame15.Parent = Frame12
			Frame15.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Frame15.BackgroundTransparency = 1
			Frame15.Position = UDim2.new(0, 15, 0, 0)
			Frame15.Size = UDim2.new(1, -15, 1, 0)
			TextLabel3.Name = "GUITextColor"
			TextLabel3.Parent = Frame15
			TextLabel3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			TextLabel3.BackgroundTransparency = 1
			TextLabel3.Size = UDim2.new(1, 0, 1, 0)
			TextLabel3.Font = Enum.Font.GothamBold
			TextLabel3.Text = text
			TextLabel3.TextColor3 = Color3.fromRGB(230, 230, 230)
			TextLabel3.TextSize = 14
			TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel3.TextColor3 = t1.UIColor["GUI Text Color"]
			TextButton2.Name = "PageButton"
			TextButton2.Parent = Frame11
			TextButton2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			TextButton2.BackgroundTransparency = 1
			TextButton2.Size = UDim2.new(1, 0, 1, 0)
			TextButton2.Font = Enum.Font.SourceSans
			TextButton2.Text = ""
			TextButton2.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextButton2.TextSize = 14

			local Frame16 = Instance.new("Frame")
			local UICorner6 = Instance.new("UICorner")
			local TextLabel4 = Instance.new("TextLabel")
			local ScrollingFrame2 = Instance.new("ScrollingFrame")
			local UIListLayout3 = Instance.new("UIListLayout")
			local v124 = n4

			n4 += 1
			Frame16.Name = "Page" .. v124
			Frame16.Parent = Frame5
			Frame16.BackgroundColor3 = t1.UIColor["Background 1 Color"]
			Frame16.Position = UDim2.new(0, 190, 0, 30)
			Frame16.Size = UDim2.new(0, 453, 0, 325)
			Frame16.LayoutOrder = layoutOrder2
			Frame16.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
			UICorner6.CornerRadius = UDim.new(0, 4)
			UICorner6.Parent = Frame16
			TextLabel4.Name = "GUITextColor"
			TextLabel4.Parent = Frame16
			TextLabel4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			TextLabel4.BackgroundTransparency = 1
			TextLabel4.Position = UDim2.new(0, 5, 0, 0)
			TextLabel4.Size = UDim2.new(1, 0, 0, 25)
			TextLabel4.Font = Enum.Font.GothamBold
			TextLabel4.Text = text2
			TextLabel4.TextSize = 16
			TextLabel4.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel4.TextColor3 = t1.UIColor["GUI Text Color"]
			ScrollingFrame2.Name = "PageList"
			ScrollingFrame2.Parent = Frame16
			ScrollingFrame2.Active = true
			ScrollingFrame2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			ScrollingFrame2.BackgroundTransparency = 1
			ScrollingFrame2.BorderColor3 = Color3.fromRGB(27, 42, 53)
			ScrollingFrame2.BorderSizePixel = 0
			ScrollingFrame2.Position = UDim2.new(0, 5, 0, 30)
			ScrollingFrame2.Size = UDim2.new(1, -10, 1, -30)
			ScrollingFrame2.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
			ScrollingFrame2.ScrollBarThickness = 5
			ScrollingFrame2.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
			ScrollingFrame2.ScrollingEnabled = true
			ScrollingFrame2.VerticalScrollBarInset = Enum.ScrollBarInset.Always
			UIListLayout3.Name = "Pagelistlayout"
			UIListLayout3.Parent = ScrollingFrame2
			UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout3.Padding = UDim.new(0, 5)
			UIListLayout3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				ScrollingFrame2.CanvasSize = UDim2.new(0, 0, 0, UIListLayout3.AbsoluteContentSize.Y)
			end)

			local Frame17 = Instance.new("Frame")
			local UICorner7 = Instance.new("UICorner")
			local Frame18 = Instance.new("Frame")
			local ImageLabel6 = Instance.new("ImageLabel")
			local TextButton3 = Instance.new("TextButton")
			local TextBox2 = Instance.new("TextBox")

			Frame17.Name = "Page Search"
			Frame17.Parent = Frame16
			Frame17.AnchorPoint = Vector2.new(1, 0)
			Frame17.BackgroundColor3 = Color3.fromRGB(37, 36, 44)
			Frame17.Position = UDim2.new(1, -5, 0, 5)
			Frame17.Size = UDim2.new(0, 20, 0, 20)
			Frame17.ClipsDescendants = true
			UICorner7.CornerRadius = UDim.new(0, 2)
			UICorner7.Name = "PageSearchCorner"
			UICorner7.Parent = Frame17
			Frame18.Name = "SearchFrame"
			Frame18.Parent = Frame17
			Frame18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Frame18.BackgroundTransparency = 1
			Frame18.Size = UDim2.new(0, 20, 0, 20)
			ImageLabel6.Name = "SearchIcon"
			ImageLabel6.Parent = Frame18
			ImageLabel6.AnchorPoint = Vector2.new(0.5, 0.5)
			ImageLabel6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ImageLabel6.BackgroundTransparency = 1
			ImageLabel6.Position = UDim2.new(0.5, 0, 0.5, 0)
			ImageLabel6.Size = UDim2.new(0, 16, 0, 16)
			ImageLabel6.Image = "rbxassetid://8154282545"
			ImageLabel6.ImageColor3 = t1.UIColor["Search Icon Color"]
			TextButton3.Name = "Search Button"
			TextButton3.Parent = Frame18
			TextButton3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextButton3.BackgroundTransparency = 1
			TextButton3.Size = UDim2.new(1, 0, 1, 0)
			TextButton3.Font = Enum.Font.SourceSans
			TextButton3.Text = ""
			TextButton3.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextButton3.TextSize = 14
			TextBox2.Name = "Search Box"
			TextBox2.Parent = Frame17
			TextBox2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBox2.BackgroundTransparency = 1
			TextBox2.Position = UDim2.new(0, 30, 0, 0)
			TextBox2.Size = UDim2.new(1, -30, 1, 0)
			TextBox2.Font = Enum.Font.GothamBold
			TextBox2.Text = ""
			TextBox2.TextSize = 14
			TextBox2.TextXAlignment = Enum.TextXAlignment.Left
			TextBox2.PlaceholderText = "Search section or function"
			TextBox2.PlaceholderColor3 = t1.UIColor["Placeholder Text Color"]
			TextBox2.TextColor3 = t1.UIColor["Text Color"]

			local u131 = false

			TextButton3.MouseEnter:Connect(function()
				TweenService:Create(ImageLabel6, TweenInfo.new(t1.UIColor["Tween Animation 3 Speed"]), {
					ImageColor3 = t1.UIColor["Search Icon Highlight Color"]
				}):Play()
			end)
			TextButton3.MouseLeave:Connect(function()
				TweenService:Create(ImageLabel6, TweenInfo.new(t1.UIColor["Tween Animation 3 Speed"]), {
					ImageColor3 = t1.UIColor["Search Icon Color"]
				}):Play()
			end)
			TextButton3.MouseButton1Click:Connect(function()
				u131 = not u131

				local uDim22 = u131 and UDim2.new(0, 150, 0, 20) or UDim2.new(0, 20, 0, 20)

				game.TweenService:Create(Frame17, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
					Size = uDim22
				}):Play()
			end)
			TextBox2:GetPropertyChangedSignal("Text"):Connect(function()
				local Text = TextBox2.Text

				if Text == "" then
					for _, child in pairs(ScrollingFrame:GetChildren()) do
						if not child:IsA("UIListLayout") then
							child.Visible = true
						end
					end

					for _, child in pairs(Frame5:GetChildren()) do
						if not child:IsA("UIPageLayout") and not child:IsA("UICorner") then
							child.Visible = true
						end
					end

					for k, v in pairs(t2) do
						k.Visible = true

						for _, v2 in pairs(v) do
							v2.Visible = true
						end
					end
				else
					for k, v in pairs(t2) do
						k.Visible = false

						for _, v2 in pairs(v) do
							v2.Visible = false
						end
					end

					for _, child in pairs(ScrollingFrame:GetChildren()) do
						if not child:IsA("UIListLayout") then
							child.Visible = false
						end
					end

					for _, child in pairs(Frame5:GetChildren()) do
						if not child:IsA("UIPageLayout") and not child:IsA("UICorner") then
							child.Visible = false
						end
					end

					for k, v in pairs(t1.listfunction) do
						for _, v2 in pairs(v) do
							if string.find(v2.Name:lower(), Text:lower()) then
								if v2.Call then
									v2.Call()
								end

								local v154 = t1.listtab[k]

								if v154 then
									v154[1].Visible = true
									v154[2].Visible = true
									v154[3].Visible = true

									local tweenAnimation1Speed = t1.UIColor["Tween Animation 1 Speed"]

									UIPageLayout.TweenTime = 0
									UIPageLayout:JumpTo(v154[2])
									task.wait()
									UIPageLayout.TweenTime = tweenAnimation1Speed
								end
							end
						end
					end
				end
			end)
			visiblealloff = function()
				for _, child in pairs(ScrollingFrame:GetChildren()) do
					if not child:IsA("UIListLayout") then
						child.Visible = false
					end
				end

				for _, child in pairs(Frame5:GetChildren()) do
					if not child:IsA("UIPageLayout") and not child:IsA("UICorner") then
						child.Visible = false
					end
				end
			end
			UIGradient2 = visiblealloff

			for k, child in pairs(ScrollingFrame:GetChildren()) do
				if not child:IsA("UIListLayout") and k == 2 then
					child.Frame.Line.PageInLine.BackgroundTransparency = 0
				end
			end

			TextButton2.MouseButton1Click:Connect(function()
				if tostring(UIPageLayout.CurrentPage) == Frame16.Name then
					return
				end

				for _, child in pairs(Frame5:GetChildren()) do
					if not child:IsA("UIPageLayout") and not child:IsA("UICorner") then
						child.Visible = false
					end
				end

				Frame16.Visible = true
				UIPageLayout:JumpTo(Frame16)

				local children, v165 = ScrollingFrame:GetChildren()

				for _, v in next, children, v165 do
					if not v:IsA("UIListLayout") then
						if v.Name == text .. "_Control" then
							TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
								BackgroundTransparency = 0
							}):Play()
						else
							TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
								BackgroundTransparency = 1
							}):Play()
						end
					end
				end
			end)

			local t6

			t6 = {
				CreateSection = function(...)
					local t7 = { ... }
					local Section_Name = t7[1]
					local v171 = t7[2]
					local v172 = t7[3]
					local v173 = t7[4]

					if t7[1] == t6 or type(t7[1]) == "table" and (t7[1].CreateSection or t7[1].AddSection) then
						Section_Name = t7[2]
						v171 = t7[3]
						v172 = t7[4]
						v173 = t7[5]
					end

					if type(Section_Name) == "table" then
						Section_Name = Section_Name.Section_Name or Section_Name.Name or Section_Name.Title or tostring(Section_Name)
					end

					local text3 = tostring(Section_Name or "Section")
					local v175 = text3:lower():find("status") ~= nil
					local v176 = v171 or false
					local Frame19 = Instance.new("Frame")
					local UICorner8 = Instance.new("UICorner")
					local Frame20 = Instance.new("Frame")
					local TextLabel5 = Instance.new("TextLabel")
					local Frame21 = Instance.new("Frame")
					local UIGradient3 = Instance.new("UIGradient")
					local UIListLayout4 = Instance.new("UIListLayout")

					t1.listtab[Frame19] = {
						Frame11,
						Frame16,
						Frame19
					}
					t1.listfunction[Frame19] = {}
					Frame19.Name = text3 .. "_Dot"
					Frame19.Parent = ScrollingFrame2
					Frame19.Size = UDim2.new(1, -5, 0, 30)
					Frame19.BackgroundColor3 = t1.UIColor["Background 3 Color"]
					Frame19.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
					Frame19.ClipsDescendants = true
					t2[Frame19] = {}

					local UIStroke4 = Instance.new("UIStroke", Frame19)

					UIStroke4.Color = Color3.fromRGB(90, 90, 70)
					UIStroke4.Thickness = 1
					UICorner8.CornerRadius = UDim.new(0, 4)
					UICorner8.Parent = Frame19

					local UIGradient4 = Instance.new("UIGradient", Frame19)

					UIGradient4.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 46)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(48, 48, 56))
					})
					UIGradient4.Rotation = 90
					UIGradient4.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0.05),
						NumberSequenceKeypoint.new(1, 0.15)
					})
					Frame20.Name = "Topsec"
					Frame20.Parent = Frame19
					Frame20.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
					Frame20.BackgroundTransparency = 1
					Frame20.Size = UDim2.new(0, 415, 0, 30)
					TextLabel5.Name = "Sectiontitle"
					TextLabel5.Parent = Frame20
					TextLabel5.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
					TextLabel5.BackgroundTransparency = 1
					TextLabel5.Size = UDim2.new(1, 0, 1, 0)
					TextLabel5.Font = Enum.Font.GothamBold
					TextLabel5.Text = text3
					TextLabel5.TextSize = 14
					TextLabel5.TextColor3 = v173 and v173 or t1.UIColor["Section Text Color"]
					Frame21.Name = "Linesec"
					Frame21.Parent = Frame20
					Frame21.AnchorPoint = Vector2.new(0.5, 1)
					Frame21.BorderSizePixel = 0
					Frame21.Position = UDim2.new(0.5, 0, 1, -2)
					Frame21.Size = UDim2.new(1, -10, 0, 2)
					Frame21.BackgroundColor3 = v173 and v173 or t1.UIColor["Section Underline Color"]

					local ImageLabel7 = Instance.new("ImageLabel", Frame21)

					ImageLabel7.Name = "LineShadow"
					ImageLabel7.AnchorPoint = Vector2.new(0.5, 0.5)
					ImageLabel7.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
					ImageLabel7.BackgroundTransparency = 1
					ImageLabel7.Position = UDim2.new(0.5, 0, 0.5, 0)
					ImageLabel7.Size = UDim2.new(1, 8, 1, 8)
					ImageLabel7.ZIndex = 0
					ImageLabel7.Image = "rbxassetid://5028857084"
					ImageLabel7.ImageTransparency = 0.6
					ImageLabel7.ScaleType = Enum.ScaleType.Slice
					ImageLabel7.SliceCenter = Rect.new(24, 24, 276, 276)
					UIGradient3.Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(0.5, 0),
						NumberSequenceKeypoint.new(0.51, 0.02),
						NumberSequenceKeypoint.new(1, 1)
					})
					UIGradient3.Parent = Frame21

					local u187
					local u188 = false
					local UDim_

					if v176 then
						local Frame22 = Instance.new("Frame")
						local UICorner9 = Instance.new("UICorner")
						local ImageButton2 = Instance.new("ImageButton")
						local ImageButton3 = Instance.new("ImageButton")
						local TextButton4 = Instance.new("TextButton")

						TextButton4.Name = "VisibilityButton"
						TextButton4.Parent = Frame20
						TextButton4.AnchorPoint = Vector2.new(1, 0.5)
						TextButton4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						TextButton4.BackgroundTransparency = 1
						TextButton4.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextButton4.BorderSizePixel = 0
						TextButton4.Font = Enum.Font.SourceSans
						TextButton4.Text = ""
						TextButton4.TextColor3 = Color3.fromRGB(0, 0, 0)
						TextButton4.TextSize = 14
						TextButton4.ZIndex = 2
						TextButton4.Position = UDim2.new(1, -5, 0.5, 0)
						TextButton4.Size = UDim2.new(0, 20, 0, 20)
						Frame22.Name = "VisibilitySectionFrame"
						Frame22.Parent = Frame20
						Frame22.AnchorPoint = Vector2.new(1, 0.5)
						Frame22.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
						Frame22.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Frame22.BorderSizePixel = 0
						Frame22.Position = UDim2.new(1, -5, 0.5, 0)
						Frame22.Size = UDim2.new(0, 20, 0, 20)
						UICorner9.CornerRadius = UDim.new(0, 4)
						UICorner9.Name = "VisibilitySectionFrameCorner"
						UICorner9.Parent = Frame22
						ImageButton2.Name = "visibility"
						ImageButton2.Parent = Frame22
						ImageButton2.AnchorPoint = Vector2.new(0.5, 0.5)
						ImageButton2.BackgroundTransparency = 1
						ImageButton2.LayoutOrder = 4
						ImageButton2.Position = UDim2.new(0.5, 0, 0.5, 0)
						ImageButton2.Size = UDim2.new(1, -4, 1, -4)
						ImageButton2.ZIndex = 2
						ImageButton2.Image = "rbxassetid://3926307971"
						ImageButton2.ImageRectOffset = Vector2.new(84, 44)
						ImageButton2.ImageRectSize = Vector2.new(36, 36)
						ImageButton2.ImageTransparency = 1
						ImageButton3.Name = "visibility_off"
						ImageButton3.Parent = Frame22
						ImageButton3.AnchorPoint = Vector2.new(0.5, 0.5)
						ImageButton3.BackgroundTransparency = 1
						ImageButton3.LayoutOrder = 4
						ImageButton3.Position = UDim2.new(0.5, 0, 0.5, 0)
						ImageButton3.Size = UDim2.new(1, -4, 1, -4)
						ImageButton3.ZIndex = 2
						ImageButton3.Image = "rbxassetid://3926307971"
						ImageButton3.ImageRectOffset = Vector2.new(564, 44)
						ImageButton3.ImageRectSize = Vector2.new(36, 36)
						ImageButton3.ImageTransparency = 0
						TextButton4.MouseButton1Down:Connect(function()
							u188 = not u188
							TweenService:Create(ImageButton2, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"] / 2), {
								ImageTransparency = u188 and 0 or 1
							}):Play()
							wait(t1.UIColor["Tween Animation 1 Speed"] / 4)
							TweenService:Create(ImageButton3, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"] / 2), {
								ImageTransparency = u188 and 1 or 0
							}):Play()
							TweenService:Create(Frame19, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
								Size = UDim2.new(1, -5, 0, u188 and u187 or 30)
							}):Play()
						end)

						if v172 then
							local Frame23 = Instance.new("Frame")

							Frame23.Name = "SectionGap"
							Frame23.Parent = ScrollingFrame2
							Frame23.Size = UDim2.new(1, -5, 0, 30)
							Frame23.ClipsDescendants = true
							Frame23.Transparency = 1
						end

						UIGradient3.Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 1),
							NumberSequenceKeypoint.new(0.5, 0),
							NumberSequenceKeypoint.new(0.51, 0.02),
							NumberSequenceKeypoint.new(1, 1)
						})
						UIGradient3.Parent = Frame21
						UIListLayout4.Name = "SectionList"
						UIListLayout4.Parent = Frame19
						UIListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
						UDim_ = UDim
					else
						if v172 then
							local Frame22 = Instance.new("Frame")

							Frame22.Name = "SectionGap"
							Frame22.Parent = ScrollingFrame2
							Frame22.Size = UDim2.new(1, -5, 0, 30)
							Frame22.ClipsDescendants = true
							Frame22.Transparency = 1
						end

						UIGradient3.Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 1),
							NumberSequenceKeypoint.new(0.5, 0),
							NumberSequenceKeypoint.new(0.51, 0.02),
							NumberSequenceKeypoint.new(1, 1)
						})
						UIGradient3.Parent = Frame21
						UIListLayout4.Name = "SectionList"
						UIListLayout4.Parent = Frame19
						UIListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
						UDim_ = UDim
					end

					UIListLayout4.Padding = UDim_.new(0, 5)

					local n5 = -1

					UIListLayout4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
						local v198 = UIListLayout4.AbsoluteContentSize.Y + 5

						if v198 == n5 then
							return
						end

						n5 = v198

						if not v176 then
							Frame19.Size = UDim2.new(1, -5, 0, v198)
						end

						u187 = v198

						if u188 then
							TweenService:Create(Frame19, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
								Size = UDim2.new(1, -5, 0, u187)
							}):Play()
						end
					end)

					local t8

					t8 = {
						IsStatusSection = v175,
						CreateToggle = function(p7, p8)
							local text4 = tostring(p7.Title or "")
							local Desc = p7.Desc
							local Default = p7.Default

							if Default == nil then
								Default = false
							end

							local v203 = p8 or function()
							end
							local Frame22 = Instance.new("Frame")
							local Frame23 = Instance.new("Frame")
							local ImageLabel8 = Instance.new("ImageLabel")
							local ImageLabel9 = Instance.new("ImageLabel")
							local TextLabel6 = Instance.new("TextLabel")
							local TextLabel7 = Instance.new("TextLabel")
							local Frame24 = Instance.new("Frame")
							local UICorner9 = Instance.new("UICorner")
							local TextButton4 = Instance.new("TextButton")
							local UIListLayout5 = Instance.new("UIListLayout")

							Frame22.Name = "ToggleFrame"
							Frame22.Parent = Frame19
							Frame22.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Frame22.BackgroundTransparency = 1
							Frame22.Position = UDim2.new(0, 0, 0.300000012, 0)
							Frame22.Size = UDim2.new(1, 0, 0, 0)
							Frame22.AutomaticSize = Enum.AutomaticSize.Y
							Frame23.Name = "TogFrame1"
							Frame23.Parent = Frame22
							Frame23.AnchorPoint = Vector2.new(0.5, 0.5)
							Frame23.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Frame23.BackgroundTransparency = 1
							Frame23.Position = UDim2.new(0.5, 0, 0.5, 0)
							Frame23.Size = UDim2.new(1, -10, 0, 0)
							Frame23.AutomaticSize = Enum.AutomaticSize.Y
							ImageLabel8.Name = "checkbox"
							ImageLabel8.Parent = Frame23
							ImageLabel8.AnchorPoint = Vector2.new(1, 0.5)
							ImageLabel8.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							ImageLabel8.BackgroundTransparency = 1
							ImageLabel8.Position = UDim2.new(1, -5, 0.5, 3)
							ImageLabel8.Size = UDim2.new(0, 25, 0, 25)
							ImageLabel8.Image = "rbxassetid://4552505888"
							ImageLabel8.ImageColor3 = t1.UIColor["Toggle Border Color"]
							ImageLabel9.Name = "check"
							ImageLabel9.Parent = ImageLabel8
							ImageLabel9.AnchorPoint = Vector2.new(0.5, 0.5)
							ImageLabel9.BackgroundColor3 = Color3.fromRGB(200, 0, 255)
							ImageLabel9.BackgroundTransparency = 0
							ImageLabel9.Position = UDim2.new(0.5, 0, 0.5, 0)
							ImageLabel9.Size = UDim2.new(0, 0, 0, 0)
							ImageLabel9.Image = ""
							ImageLabel9.ImageColor3 = t1.UIColor["Toggle Checked Color"]

							local n6 = 5

							if Desc then
								n6 = 0
								TextLabel6.Name = "ToggleDesc"
								TextLabel6.Parent = Frame23
								TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
								TextLabel6.BackgroundTransparency = 1
								TextLabel6.Position = UDim2.new(0, 15, 0, 20)
								TextLabel6.Size = UDim2.new(1, -50, 0, 0)
								TextLabel6.Font = Enum.Font.GothamBlack
								TextLabel6.Text = Desc
								TextLabel6.TextSize = 13
								TextLabel6.TextWrapped = true
								TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
								TextLabel6.RichText = true
								TextLabel6.AutomaticSize = Enum.AutomaticSize.Y
								TextLabel6.TextColor3 = t1.UIColor["Toggle Desc Color"]
							else
								TextLabel6.Text = ""
							end

							TextLabel7.Name = "TextColor"
							TextLabel7.Parent = Frame23
							TextLabel7.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							TextLabel7.BackgroundTransparency = 1
							TextLabel7.Position = UDim2.new(0, 10, 0, n6)
							TextLabel7.Size = UDim2.new(1, -10, 0, 20)
							TextLabel7.Font = v175 and Enum.Font.GothamMedium or Enum.Font.GothamBlack
							TextLabel7.Text = text4
							TextLabel7.TextSize = v175 and 13 or 14
							TextLabel7.TextXAlignment = Enum.TextXAlignment.Left
							TextLabel7.TextYAlignment = Enum.TextYAlignment.Center
							TextLabel7.RichText = true
							TextLabel7.AutomaticSize = Enum.AutomaticSize.Y
							TextLabel7.TextColor3 = t1.UIColor["Text Color"]
							Frame24.Name = "Background1"
							Frame24.Parent = Frame23
							Frame24.Size = UDim2.new(1, 0, 1, 6)
							Frame24.ZIndex = 0
							Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
							Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
							UICorner9.CornerRadius = UDim.new(0, 4)
							UICorner9.Name = "ToggleCorner"
							UICorner9.Parent = Frame24
							TextButton4.Name = "ToggleButton"
							TextButton4.Parent = Frame23
							TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							TextButton4.BackgroundTransparency = 1
							TextButton4.AnchorPoint = Vector2.new(1, 0.5)
							TextButton4.Size = UDim2.new(0, 25, 0, 25)
							TextButton4.Position = UDim2.new(1, -5, 0.5, 3)
							TextButton4.Font = Enum.Font.SourceSans
							TextButton4.Text = ""
							TextButton4.TextColor3 = Color3.fromRGB(0, 0, 0)
							TextButton4.TextSize = 14
							UIListLayout5.Name = "ToggleList"
							UIListLayout5.Parent = Frame22
							UIListLayout5.HorizontalAlignment = Enum.HorizontalAlignment.Center
							UIListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
							UIListLayout5.VerticalAlignment = Enum.VerticalAlignment.Center
							UIListLayout5.Padding = UDim.new(0, 5)
							Instance.new("UICorner", ImageLabel9).CornerRadius = UDim.new(0, 2)

							local function v215(p9)
								local uDim22 = p9 and UDim2.new(1, -12, 1, -12) or UDim2.new(0, 0, 0, 0)
								local uDim23 = UDim2.new(0.5, 0, 0.5, 0)
								local vector2 = Vector2.new(0.5, 0.5)

								game.TweenService:Create(ImageLabel9, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
									Size = uDim22,
									Position = uDim23,
									AnchorPoint = vector2
								}):Play()
								v203(p9)
							end

							v215(Default)

							local t9 = {
								SetStage = function(p10)
									if p10 ~= Default then
										ButtonClick()
									end
								end
							}

							t9.SetValue = t9.SetStage
							t9.GetValue = function()
								return Default
							end

							local t10 = {
								name = text4,
								type = "toggle",
								value = Default,
								Page_Name = text,
								Section_Name = text3,
								FunctionCreate = t9
							}

							t3.Options[text4] = t10

							if type(getgenv().Options) == "table" then
								getgenv().Options[text4] = t10
							end

							local function v221()
								Default = not Default

								if t10 then
									t10.value = Default
								end

								v215(Default)
							end

							TextButton4.MouseButton1Down:Connect(function()
								v221()
							end)
							visibleon = function()
								Frame22.Visible = true
							end
							table.insert(t1.listfunction[Frame19], {
								Type = "Toggle",
								Name = text4,
								Call = visibleon
							})
							table.insert(t2[Frame19], Frame22)

							return t9
						end,
						CreateButton = function(p11, p12)
							local Title = p11.Title
							local v223 = p12 or function()
							end
							local Frame22 = Instance.new("Frame", Frame19)

							Frame22.LayoutOrder = 0
							Frame22.BorderMode = Enum.BorderMode.Outline
							Frame22.Selectable = false
							Frame22.AnchorPoint = Vector2.new(0, 0)
							Frame22.AutomaticSize = Enum.AutomaticSize.None
							Frame22.Size = UDim2.new(1, 0, 0, 40)
							Frame22.Draggable = false
							Frame22.BorderColor3 = Color3.new(0.10588235408067703, 0.16470588743686676, 0.20784313976764679)
							Frame22.Style = Enum.FrameStyle.Custom
							Frame22.Transparency = 1
							Frame22.BackgroundTransparency = 1
							Frame22.SelectionOrder = 0
							Frame22.SizeConstraint = Enum.SizeConstraint.RelativeXY
							Frame22.BackgroundColor3 = Color3.new(0.63921570777893066, 0.63529413938522339, 0.64705884456634521)

							local Frame23 = Instance.new("Frame", Frame22)

							Frame23.LayoutOrder = 0
							Frame23.BorderMode = Enum.BorderMode.Outline
							Frame23.Selectable = false
							Frame23.AnchorPoint = Vector2.new(0.5, 0.5)
							Frame23.AutomaticSize = Enum.AutomaticSize.None
							Frame23.Size = UDim2.new(1, -10, 1, 0)
							Frame23.Draggable = false
							Frame23.BorderColor3 = Color3.new(0.10588235408067703, 0.16470588743686676, 0.20784313976764679)
							Frame23.Style = Enum.FrameStyle.Custom
							Frame23.SizeConstraint = Enum.SizeConstraint.RelativeXY
							Frame23.Transparency = t1.UIColor["Background 1 Transparency"]
							Frame23.BackgroundTransparency = 0.25
							Frame23.Position = UDim2.new(0.5, 0, 0.5, 0)
							Frame23.SelectionOrder = 0
							Frame23.BackgroundColor3 = t1.UIColor["Background 1 Color"]
							Instance.new("UICorner", Frame23).CornerRadius = UDim.new(0, 10)

							local Frame24 = Instance.new("Frame", Frame23)

							Frame24.LayoutOrder = 0
							Frame24.BorderMode = Enum.BorderMode.Outline
							Frame24.Selectable = false
							Frame24.AnchorPoint = Vector2.new(0, 0)
							Frame24.ZIndex = 2
							Frame24.AutomaticSize = Enum.AutomaticSize.None
							Frame24.Draggable = false
							Frame24.BorderColor3 = Color3.new(0.10588235408067703, 0.16470588743686676, 0.20784313976764679)
							Frame24.Style = Enum.FrameStyle.Custom
							Frame24.Transparency = 1
							Frame24.BackgroundTransparency = 1
							Frame24.SelectionOrder = 0
							Frame24.SizeConstraint = Enum.SizeConstraint.RelativeXY
							Frame24.BackgroundColor3 = Color3.new(0.18823529779911041, 0.18823529779911041, 0.21960784494876862)
							Instance.new("UICorner", Frame24).CornerRadius = UDim.new(0, 10)

							local TextLabel6 = Instance.new("TextLabel", Frame23)

							TextLabel6.LineHeight = 1
							TextLabel6.Active = false
							TextLabel6.TextStrokeTransparency = 0.85000002384185791
							TextLabel6.TextTruncate = Enum.TextTruncate.None
							TextLabel6.SizeConstraint = Enum.SizeConstraint.RelativeXY
							TextLabel6.ZIndex = 1
							TextLabel6.BorderSizePixel = 1
							TextLabel6.Draggable = false
							TextLabel6.RichText = false
							TextLabel6.SelectionOrder = 0
							TextLabel6.BackgroundColor3 = Color3.new(0.63921570777893066, 0.63529413938522339, 0.64705884456634521)
							TextLabel6.BorderMode = Enum.BorderMode.Outline
							TextLabel6.TextStrokeColor3 = Color3.new(0, 0, 0)
							TextLabel6.AnchorPoint = Vector2.new(0, 0)
							TextLabel6.AutomaticSize = Enum.AutomaticSize.None
							TextLabel6.Size = UDim2.new(1, -110, 1, 0)
							TextLabel6.TextColor3 = Color3.new(0.92156863212585449, 0.92156863212585449, 0.90196079015731812)
							TextLabel6.ClipsDescendants = false
							TextLabel6.BorderColor3 = Color3.new(0.10588235408067703, 0.16470588743686676, 0.20784313976764679)
							TextLabel6.Text = Title
							TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
							TextLabel6.LayoutOrder = 0
							TextLabel6.Rotation = 0
							TextLabel6.Font = v175 and Enum.Font.GothamMedium or Enum.Font.GothamBold
							TextLabel6.BackgroundTransparency = 1
							TextLabel6.Position = UDim2.new(0, 12, 0, 0)
							TextLabel6.Selectable = false
							TextLabel6.MaxVisibleGraphemes = -1
							TextLabel6.Visible = true

							if v175 then
								TextLabel6.TextSize = 13
							else
								TextLabel6.TextSize = 14
							end

							local Frame25 = Instance.new("Frame", Frame23)

							Frame25.LayoutOrder = 0
							Frame25.BorderMode = Enum.BorderMode.Outline
							Frame25.Selectable = false
							Frame25.AnchorPoint = Vector2.new(1, 0.5)
							Frame25.AutomaticSize = Enum.AutomaticSize.None
							Frame25.Size = UDim2.new(0, 94, 0, 30)
							Frame25.Draggable = false
							Frame25.BorderColor3 = Color3.new(0.10588235408067703, 0.16470588743686676, 0.20784313976764679)
							Frame25.SizeConstraint = Enum.SizeConstraint.RelativeXY
							Frame25.Transparency = 0
							Frame25.Style = Enum.FrameStyle.Custom
							Frame25.Position = UDim2.new(1, -8, 0.5, 0)
							Frame25.SelectionOrder = 0
							Frame25.BackgroundColor3 = Color3.fromRGB(195, 195, 195)
							Frame25.ClipsDescendants = true

							local UICorner9 = Instance.new("UICorner", Frame25)

							UICorner9.CornerRadius = UDim.new(0, 12)

							local UIGradient5 = Instance.new("UIGradient", Frame25)

							UIGradient5.Enabled = true
							UIGradient5.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(225, 60, 255)),
								ColorSequenceKeypoint.new(0.4, Color3.fromRGB(201, 0, 255)),
								ColorSequenceKeypoint.new(0.6, Color3.fromRGB(175, 0, 235)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(145, 0, 210))
							})
							UIGradient5.Offset = Vector2.new(0, 0)
							UIGradient5.Rotation = 90

							local UIScale = Instance.new("UIScale", Frame25)

							UIScale.Scale = 1

							local tween = TweenService:Create(UIScale, TweenInfo.new(0.12, Enum.EasingStyle.Sine), {
								Scale = 1.05
							})
							local tween2 = TweenService:Create(UIScale, TweenInfo.new(0.12, Enum.EasingStyle.Sine), {
								Scale = 1
							})
							local TextButton4 = Instance.new("TextButton", Frame25)

							TextButton4.Visible = true
							TextButton4.TextWrapped = false
							TextButton4.LineHeight = 1
							TextButton4.Active = true
							TextButton4.TextStrokeTransparency = 0.85
							TextButton4.TextTruncate = Enum.TextTruncate.None
							TextButton4.SizeConstraint = Enum.SizeConstraint.RelativeXY
							TextButton4.ZIndex = 1
							TextButton4.BorderSizePixel = 0
							TextButton4.Draggable = false
							TextButton4.RichText = false
							TextButton4.AutoButtonColor = false
							TextButton4.Transparency = 1
							TextButton4.SelectionOrder = 0
							TextButton4.TextYAlignment = Enum.TextYAlignment.Center
							TextButton4.TextScaled = false
							TextButton4.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
							TextButton4.BackgroundTransparency = 1
							TextButton4.Selectable = true
							TextButton4.AnchorPoint = Vector2.new(0, 0)
							TextButton4.Style = Enum.ButtonStyle.Custom
							TextButton4.Modal = false
							TextButton4.Selected = false
							TextButton4.AutomaticSize = Enum.AutomaticSize.None
							TextButton4.Size = UDim2.new(1, 0, 1, 0)
							TextButton4.TextXAlignment = Enum.TextXAlignment.Center
							TextButton4.TextTransparency = 0
							TextButton4.ClipsDescendants = false
							TextButton4.BorderColor3 = Color3.new(0, 0, 0)
							TextButton4.Text = "Click"
							TextButton4.LayoutOrder = 0
							TextButton4.TextStrokeColor3 = Color3.new(0, 0, 0)
							TextButton4.Rotation = 0
							TextButton4.Font = Enum.Font.GothamBold
							TextButton4.Position = UDim2.new(0, 0, 0, 0)
							TextButton4.TextSize = 13
							TextButton4.MaxVisibleGraphemes = -1
							TextButton4.TextColor3 = Color3.fromRGB(240, 240, 240)

							local Frame26 = Instance.new("Frame", Frame25)

							Frame26.LayoutOrder = 0
							Frame26.BorderMode = Enum.BorderMode.Outline
							Frame26.Selectable = false
							Frame26.AnchorPoint = Vector2.new(0.5, 0)
							Frame26.ZIndex = 2
							Frame26.AutomaticSize = Enum.AutomaticSize.None
							Frame26.Size = UDim2.new(1, -6, 0, 10)
							Frame26.Draggable = false
							Frame26.BorderColor3 = Color3.new(0.10588235408067703, 0.16470588743686676, 0.20784313976764679)
							Frame26.Style = Enum.FrameStyle.Custom
							Frame26.SizeConstraint = Enum.SizeConstraint.RelativeXY
							Frame26.Transparency = 0.8
							Frame26.BackgroundTransparency = 0.8
							Frame26.Position = UDim2.new(0.5, 0, 0, 2)
							Frame26.SelectionOrder = 0
							Frame26.BackgroundColor3 = Color3.new(1, 1, 1)
							Instance.new("UICorner", Frame26).CornerRadius = UDim.new(0, 10)

							local ImageLabel8 = Instance.new("ImageLabel", Frame25)

							ImageLabel8.LayoutOrder = 0
							ImageLabel8.BorderMode = Enum.BorderMode.Outline
							ImageLabel8.SliceCenter = Rect.new(24, 24, 276, 276)
							ImageLabel8.Active = false
							ImageLabel8.Selectable = false
							ImageLabel8.Visible = true
							ImageLabel8.ImageTransparency = 0.65
							ImageLabel8.ImageColor3 = Color3.fromRGB(180, 0, 255)
							ImageLabel8.AnchorPoint = Vector2.new(0.5, 0.5)
							ImageLabel8.Image = "rbxassetid://5028857084"
							ImageLabel8.ImageRectOffset = Vector2.new(0, 0)
							ImageLabel8.ImageRectSize = Vector2.new(0, 0)
							ImageLabel8.ZIndex = 0
							ImageLabel8.AutomaticSize = Enum.AutomaticSize.None
							ImageLabel8.Size = UDim2.new(1, 14, 1, 14)
							ImageLabel8.Draggable = false
							ImageLabel8.ScaleType = Enum.ScaleType.Slice
							ImageLabel8.BorderColor3 = Color3.new(0.10588235408067703, 0.16470588743686676, 0.20784313976764679)
							ImageLabel8.SizeConstraint = Enum.SizeConstraint.RelativeXY
							ImageLabel8.SelectionOrder = 0
							ImageLabel8.ClipsDescendants = false
							ImageLabel8.Rotation = 0
							ImageLabel8.Transparency = 1
							ImageLabel8.BackgroundTransparency = 1
							ImageLabel8.Position = UDim2.new(0.5, 0, 0.5, 0)
							ImageLabel8.SliceScale = 1
							ImageLabel8.BorderSizePixel = 0
							ImageLabel8.BackgroundColor3 = Color3.new(0.63921570777893066, 0.63529413938522339, 0.64705884456634521)
							TextButton4.MouseEnter:Connect(function()
								tween:Play()
							end)
							TextButton4.MouseLeave:Connect(function()
								tween2:Play()
							end)
							TextButton4.MouseButton1Down:Connect(function()
								local Frame27 = Instance.new("Frame")

								Frame27.AnchorPoint = Vector2.new(0.5, 0.5)
								Frame27.Position = UDim2.new(0.5, 0, 0.5, 0)
								Frame27.Size = UDim2.new(0, 0, 0, 0)
								Frame27.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								Frame27.BackgroundTransparency = 0.6
								Frame27.ZIndex = 20
								Frame27.Parent = Frame25

								local UICorner10 = Instance.new("UICorner")

								UICorner10.CornerRadius = UICorner9.CornerRadius
								UICorner10.Parent = Frame27

								local tween3 = TweenService:Create(Frame27, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									Size = UDim2.new(1, 0, 1, 0),
									BackgroundTransparency = 1,
									Position = UDim2.new(0.5, 0, 0.5, 0)
								})

								tween3:Play()
								tween3.Completed:Connect(function()
									Frame27:Destroy()
								end)
								v223()
							end)

							local t11 = {
								name = Title,
								type = "button",
								value = Title,
								text = Title,
								Page_Name = text,
								Section_Name = text3,
								FunctionCreate = Frame22
							}

							t3.Options[Title] = t11

							if type(getgenv().Options) == "table" then
								getgenv().Options[Title] = t11
							end

							visibleon = function()
								Frame22.Visible = true
							end
							table.insert(t1.listfunction[Frame19], {
								Type = "Toggle",
								Name = Title,
								Call = visibleon
							})
							table.insert(t2[Frame19], Frame22)

							return Frame22
						end,
						CreateLabel = function(p13, p14)
							local v241 = p13

							if type(p13) == "table" and (p13 == t8 or p13.CreateLabel or p13.CreateToggle) and p14 ~= nil then
								v241 = p14
							end

							local Title = type(v241) == "table" and (v241.Title or v241.Text or v241.Name or "")

							if not Title then
								Title = tostring(v241 or "")
							end

							local IsStatus = v175 or type(v241) == "table" and (v241.IsStatus or v241.SmallFont)
							local Font_ = type(v241) == "table" and v241.Font
							local TextSize = type(v241) == "table" and v241.TextSize
							local Frame22 = Instance.new("Frame")
							local Frame23 = Instance.new("Frame")
							local UICorner9 = Instance.new("UICorner")
							local TextLabel6 = Instance.new("TextLabel")

							Frame22.Name = "LabelFrame"
							Frame22.Parent = Frame19
							Frame22.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Frame22.BackgroundTransparency = 1
							Frame22.Position = UDim2.new(0, 0, 0, 0)
							Frame22.Size = UDim2.new(1, 0, 0, 0)
							Frame22.AutomaticSize = Enum.AutomaticSize.Y
							Frame23.Name = "LabelBG"
							Frame23.Parent = Frame22
							Frame23.AnchorPoint = Vector2.new(0.5, 0)
							Frame23.Position = UDim2.new(0.5, 0, 0, 0)
							Frame23.Size = UDim2.new(1, -10, 0, -10)
							Frame23.BackgroundColor3 = t1.UIColor["Background 1 Color"]
							Frame23.AutomaticSize = Enum.AutomaticSize.Y
							Frame23.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
							UICorner9.CornerRadius = UDim.new(0, 4)
							UICorner9.Name = "LabelCorner"
							UICorner9.Parent = Frame23
							TextLabel6.Name = "TextColor"
							TextLabel6.Parent = Frame23
							TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							TextLabel6.BackgroundTransparency = 1
							TextLabel6.Position = UDim2.new(0, 10, 0, IsStatus and 4 or 3)
							TextLabel6.Size = UDim2.new(1, -20, 1, IsStatus and 4 or 10)
							TextLabel6.Font = Font_ or IsStatus and Enum.Font.GothamMedium or Enum.Font.GothamBlack
							TextLabel6.Text = Title
							TextLabel6.TextSize = TextSize or IsStatus and 13 or 14
							TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
							TextLabel6.AutomaticSize = Enum.AutomaticSize.Y
							TextLabel6.TextWrapped = true
							TextLabel6.TextColor3 = t1.UIColor["Text Color"]
							TextLabel6.TextStrokeTransparency = IsStatus and 0.85000002384185791 or t1.UIColor["Text Stroke Transparency"]
							TextLabel6.RichText = true

							local t12 = {
								SetText = function(p15, p16)
									TextLabel6.Text = tostring(p16 ~= nil and p16 or p15 or "")
								end
							}

							t12.Set = t12.SetText
							t12.SetValue = t12.SetText
							t12.GetText = function()
								return TextLabel6.Text
							end
							t12.SetColor = function(p17, p18)
								local textColor3 = typeof(p18) == "Color3" and p18 or p17

								if typeof(textColor3) == "Color3" then
									TextLabel6.TextColor3 = textColor3
								end
							end

							local t13 = {
								name = Title,
								type = "textlabel",
								text = Title,
								value = Title,
								Page_Name = text,
								Section_Name = text3,
								FunctionCreate = t12
							}

							t3.Options[Title] = t13

							if type(getgenv().Options) == "table" then
								getgenv().Options[Title] = t13
							end

							visibleon = function()
								Frame22.Visible = true
							end
							table.insert(t1.listfunction[Frame19], {
								Type = "Label",
								Name = Title,
								Call = visibleon
							})
							table.insert(t2[Frame19], Frame22)

							return t12
						end
					}
					t8.AddLabel = t8.CreateLabel
					t8.CreateDropdown = function(p19, p20)
						local v253 = tostring(p19.Title)
						local List = p19.List
						local Search = p19.Search or false
						local Selected = p19.Selected or false
						local Slider = p19.Slider or false
						local SliderRelease = p19.SliderRelease or false
						local Default = p19.Default
						local v260 = p20 or function()
						end
						local SortPairs = p19.SortPairs or pairs
						local Frame22 = Instance.new("Frame")
						local Frame23 = Instance.new("Frame")
						local UICorner9 = Instance.new("UICorner")
						local Frame24 = Instance.new("Frame")
						local UICorner10 = Instance.new("UICorner")
						local ImageLabel8 = Instance.new("ImageLabel")
						local TextButton4 = Instance.new("TextButton")
						local Frame25 = Instance.new("Frame")
						local ScrollingFrame3 = Instance.new("ScrollingFrame")
						local Frame26 = Instance.new("Frame")
						local UIListLayout5 = Instance.new("UIListLayout")
						local TextBox3

						if Search then
							TextBox3 = Instance.new("TextBox")
						else
							TextBox3 = Instance.new("TextLabel")
						end

						Frame22.Name = v253 .. "DropdownFrame"
						Frame22.Parent = Frame19
						Frame22.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						Frame22.BackgroundTransparency = 1
						Frame22.Position = UDim2.new(0, 0, 0.473684222, 0)
						Frame22.Size = UDim2.new(1, 0, 0, 25)
						Frame23.Name = "Background1"
						Frame23.Parent = Frame22
						Frame23.AnchorPoint = Vector2.new(0.5, 0.5)
						Frame23.Position = UDim2.new(0.5, 0, 0.5, 0)
						Frame23.Size = UDim2.new(1, -10, 1, 0)
						Frame23.ClipsDescendants = true
						Frame23.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
						Frame23.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
						Frame23.BackgroundTransparency = 0.25
						UICorner9.CornerRadius = UDim.new(0, 4)
						UICorner9.Name = "Dropdowncorner"
						UICorner9.Parent = Frame23
						Frame24.Name = "Background2"
						Frame24.Parent = Frame23
						Frame24.Size = UDim2.new(1, 0, 0, 25)
						Frame24.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
						Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
						Frame24.BackgroundTransparency = 0.25
						UICorner10.CornerRadius = UDim.new(0, 4)
						UICorner10.Parent = Frame24
						TextBox3.Name = "TextColorPlaceholder"
						TextBox3.Parent = Frame24
						TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						TextBox3.BackgroundTransparency = 1
						TextBox3.Position = UDim2.new(0, 10, 0, 0)
						TextBox3.Size = UDim2.new(1, -40, 1, 0)
						TextBox3.Font = v175 and Enum.Font.GothamMedium or Enum.Font.GothamBlack
						TextBox3.Text = ""
						TextBox3.TextSize = v175 and 13 or 14
						TextBox3.TextXAlignment = Enum.TextXAlignment.Left
						TextBox3.ClipsDescendants = true

						local StringValue = Instance.new("StringValue", TextBox3)

						StringValue.Value = ""

						if Default and table.find(List, Default) then
							StringValue.Value = Default
						end

						if not Selected then
							if Search then
								TextBox3.PlaceholderColor3 = t1.UIColor["Placeholder Text Color"]
								TextBox3.PlaceholderText = v253 .. ": " .. tostring(Default or "")
							else
								TextBox3.Text = v253 .. ": " .. tostring(Default or "")
							end
						elseif Search then
							TextBox3.PlaceholderColor3 = t1.UIColor["Placeholder Text Color"]
							TextBox3.PlaceholderText = v253 .. ": " .. tostring(Default or "")
						else
							TextBox3.Text = v253 .. ": " .. tostring(Default or "")
						end

						TextBox3.TextColor3 = t1.UIColor["Text Color"]
						ImageLabel8.Name = "ImgDrop"
						ImageLabel8.Parent = Frame24
						ImageLabel8.AnchorPoint = Vector2.new(1, 0.5)
						ImageLabel8.BackgroundTransparency = 1
						ImageLabel8.BorderColor3 = Color3.fromRGB(27, 42, 53)
						ImageLabel8.Position = UDim2.new(1, -6, 0.5, 0)
						ImageLabel8.Size = UDim2.new(0, 15, 0, 15)
						ImageLabel8.Image = "rbxassetid://6954383209"
						ImageLabel8.ImageColor3 = t1.UIColor["Dropdown Icon Color"]
						TextButton4.Name = "DropdownButton"
						TextButton4.Parent = Frame24
						TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						TextButton4.BackgroundTransparency = 1
						TextButton4.Size = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1, 0)
						TextButton4.Position = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0, 0, 0, 0)
						TextButton4.Font = Enum.Font.GothamBold
						TextButton4.Text = ""
						TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
						TextButton4.TextSize = 14
						Frame25.Name = "Dropdownlisttt"
						Frame25.Parent = Frame23
						Frame25.BackgroundTransparency = 1
						Frame25.BorderSizePixel = 0
						Frame25.Position = UDim2.new(0, 0, 0, 25)
						Frame25.Size = UDim2.new(1, 0, 0, 25)
						Frame25.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						ScrollingFrame3.Name = "DropdownScroll"
						ScrollingFrame3.Parent = Frame25
						ScrollingFrame3.Active = true
						ScrollingFrame3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						ScrollingFrame3.BackgroundTransparency = 1
						ScrollingFrame3.BorderSizePixel = 0
						ScrollingFrame3.Size = UDim2.new(1, 0, 1, 0)
						ScrollingFrame3.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
						ScrollingFrame3.CanvasSize = UDim2.new(0, 0, 0, 0)
						ScrollingFrame3.ScrollBarThickness = 5
						ScrollingFrame3.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
						ScrollingFrame3.ScrollingEnabled = true
						ScrollingFrame3.VerticalScrollBarInset = Enum.ScrollBarInset.Always
						Frame26.Name = "ScrollContainer"
						Frame26.Parent = ScrollingFrame3
						Frame26.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						Frame26.BackgroundTransparency = 1
						Frame26.Position = UDim2.new(0, 5, 0, 5)
						Frame26.Size = UDim2.new(1, -15, 1, -5)
						UIListLayout5.Name = "ScrollContainerList"
						UIListLayout5.Parent = Frame26
						UIListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
						UIListLayout5.Padding = UDim.new(0, 5)
						UIListLayout5:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
							ScrollingFrame3.CanvasSize = UDim2.new(0, 0, 0, 10 + UIListLayout5.AbsoluteContentSize.Y + 5)
						end)

						local u275 = false
						local t14 = {}
						local t15 = {}

						local function v278()
							for k in SortPairs(t14) do
								t14[k] = nil
							end

							for _, child in SortPairs(Frame26:GetChildren()) do
								if not child:IsA("UIListLayout") and not child:IsA("UIPadding") and not child:IsA("UIGridLayout") then
									child.Visible = false
								end
							end

							TextBox3.Text = string.lower(TextBox3.Text)
						end
						local function v282()
							for _, v in SortPairs(t15) do
								if string.find(v, TextBox3.Text) then
									table.insert(t14, v)
								end
							end

							for _, child in SortPairs(Frame26:GetChildren()) do
								for _, v in SortPairs(t14) do
									if v == child.Name then
										child.Visible = true
									end
								end
							end
						end
						local function v289()
							local children, v291 = Frame26:GetChildren()

							for _, v in next, children, v291 do
								if v:IsA("Frame") then
									v:Destroy()
								end
							end
						end

						local u294 = List

						local function v295(p21)
							SortPairs = p21 or SortPairs
							v289()
							t15 = {}

							for k, v in SortPairs(u294) do
								if Selected then
									table.insert(t15, string.lower(k))
								elseif Slider then
									table.insert(t15, string.lower(v.Title))
								else
									table.insert(t15, string.lower(v))
								end
							end

							if Selected then
								for k, v in SortPairs(u294) do
									local Frame27 = Instance.new("Frame")
									local UICorner11 = Instance.new("UICorner")
									local Frame28 = Instance.new("Frame")
									local UICorner12 = Instance.new("UICorner")
									local TextLabel6 = Instance.new("TextLabel")
									local ImageButton2 = Instance.new("ImageButton")
									local TextButton5 = Instance.new("TextButton")

									Frame27.Name = string.lower(k)
									Frame27.Parent = Frame26
									Frame27.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
									Frame27.BackgroundTransparency = 1
									Frame27.BorderColor3 = Color3.fromRGB(27, 42, 53)
									Frame27.LayoutOrder = 1
									Frame27.Position = UDim2.new(0, 0, 0.208333328, 0)
									Frame27.Size = UDim2.new(1, 0, 0, 25)
									UICorner11.CornerRadius = UDim.new(0, 4)
									UICorner11.Name = "SampleItemCorner"
									UICorner11.Parent = Frame27
									Frame28.Name = "SampleItemBG"
									Frame28.Parent = Frame27
									Frame28.AnchorPoint = Vector2.new(0.5, 0.5)
									Frame28.BackgroundColor3 = v and t1.UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
									Frame28.BackgroundTransparency = v and 0.5 or 1
									Frame28.BorderColor3 = Color3.fromRGB(27, 42, 53)
									Frame28.Position = UDim2.new(0.5, 0, 0.5, 0)
									Frame28.Size = UDim2.new(1, 0, 1, 0)
									UICorner12.CornerRadius = UDim.new(0, 4)
									UICorner12.Name = "SampleItemBGCorner"
									UICorner12.Parent = Frame28
									TextLabel6.Name = "SampleItemTitle"
									TextLabel6.Parent = Frame28
									TextLabel6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									TextLabel6.BackgroundTransparency = 1
									TextLabel6.BorderColor3 = Color3.fromRGB(27, 42, 53)
									TextLabel6.Position = UDim2.new(0, 10, 0, 0)
									TextLabel6.Size = UDim2.new(1, -40, 0, 25)
									TextLabel6.Font = Enum.Font.GothamBlack
									TextLabel6.Text = k
									TextLabel6.TextColor3 = Color3.fromRGB(255, 255, 255)
									TextLabel6.TextSize = 14
									TextLabel6.TextStrokeTransparency = 0.5
									TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
									ImageButton2.Name = "SampleItemCheck"
									ImageButton2.Parent = Frame28
									ImageButton2.AnchorPoint = Vector2.new(1, 0.5)
									ImageButton2.BackgroundTransparency = 1
									ImageButton2.Position = UDim2.new(1, 0, 0.5, 0)
									ImageButton2.Size = UDim2.new(0, 25, 0, 25)
									ImageButton2.ZIndex = 2
									ImageButton2.Image = "rbxassetid://3926305904"
									ImageButton2.ImageColor3 = t1.UIColor["Dropdown Selected Check Color"]
									ImageButton2.ImageRectOffset = Vector2.new(312, 4)
									ImageButton2.ImageRectSize = Vector2.new(24, 24)
									ImageButton2.ImageTransparency = v and 0 or 1
									TextButton5.Name = "SampleItemButton"
									TextButton5.Parent = Frame27
									TextButton5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									TextButton5.BackgroundTransparency = 1
									TextButton5.BorderColor3 = Color3.fromRGB(0, 0, 0)
									TextButton5.BorderSizePixel = 0
									TextButton5.Size = UDim2.new(1, 0, 1, 0)
									TextButton5.Font = Enum.Font.SourceSans
									TextButton5.TextColor3 = t1.UIColor["Text Color"]
									TextButton5.TextSize = 14
									TextButton5.TextTransparency = 1
									TextButton5.MouseEnter:Connect(function()
										if v then
											return
										end

										TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
											BackgroundColor3 = Color3.fromRGB(255, 255, 255)
										}):Play()
										TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
											BackgroundTransparency = 0.7
										}):Play()
									end)
									TextButton5.MouseLeave:Connect(function()
										if v then
											return
										end

										TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
											BackgroundColor3 = Color3.fromRGB(255, 255, 255)
										}):Play()
										TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
											BackgroundTransparency = 1
										}):Play()
									end)
									TextButton5.MouseButton1Click:Connect(function()
										v = not v
										TweenService:Create(ImageButton2, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
											ImageTransparency = v and 0 or 1
										}):Play()
										TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
											BackgroundColor3 = v and t1.UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
										}):Play()
										TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
											BackgroundTransparency = v and 0.5 or 1
										}):Play()

										if v260 then
											v260(k, v)
											u294[k] = v
										end

										if Search then
											TextBox3.PlaceholderText = v253 .. ": "
										else
											TextBox3.Text = v253 .. ": "
										end
									end)
								end
							elseif Slider then
								for k, v in SortPairs(u294) do
									local text4 = tostring(v.Title) or ""
									local v310 = tonumber(v.Min) or 0
									local v311 = tonumber(v.Max)

									v311 = v311 or 100

									local Precise = v.Precise or false
									local v313 = tonumber(v.Default) or v310
									local Frame27 = Instance.new("Frame")
									local UICorner11 = Instance.new("UICorner")
									local Frame28 = Instance.new("Frame")
									local UICorner12 = Instance.new("UICorner")
									local TextLabel6 = Instance.new("TextLabel")
									local Frame29 = Instance.new("Frame")
									local TextButton5 = Instance.new("TextButton")
									local UICorner13 = Instance.new("UICorner")
									local Frame30 = Instance.new("Frame")
									local UICorner14 = Instance.new("UICorner")
									local Frame31 = Instance.new("Frame")
									local UICorner15 = Instance.new("UICorner")
									local TextBox4 = Instance.new("TextBox")

									Frame27.Name = string.lower(v.Title)
									Frame27.Parent = Frame26
									Frame27.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
									Frame27.BackgroundTransparency = 1
									Frame27.Position = UDim2.new(0, 0, 0.208333328, 0)
									Frame27.Size = UDim2.new(1, 0, 0, 50)
									UICorner11.CornerRadius = UDim.new(0, 4)
									UICorner11.Name = "SliderCorner"
									UICorner11.Parent = Frame27
									Frame28.Name = "Background1"
									Frame28.Parent = Frame27
									Frame28.AnchorPoint = Vector2.new(0.5, 0.5)
									Frame28.Position = UDim2.new(0.5, 0, 0.5, 0)
									Frame28.Size = UDim2.new(1, -10, 1, 0)
									Frame28.BackgroundColor3 = t1.UIColor["Background 1 Color"]
									Frame28.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
									UICorner12.CornerRadius = UDim.new(0, 4)
									UICorner12.Name = "SliderBGCorner"
									UICorner12.Parent = Frame28
									TextLabel6.Name = "TextColor"
									TextLabel6.Parent = Frame28
									TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextLabel6.BackgroundTransparency = 1
									TextLabel6.Position = UDim2.new(0, 10, 0, 0)
									TextLabel6.Size = UDim2.new(1, -10, 0, 25)
									TextLabel6.Font = v175 and Enum.Font.GothamMedium or Enum.Font.GothamBlack
									TextLabel6.Text = text4
									TextLabel6.TextSize = v175 and 13 or 14
									TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
									TextLabel6.TextColor3 = t1.UIColor["Text Color"]
									Frame29.Name = "SliderBar"
									Frame29.Parent = Frame27
									Frame29.AnchorPoint = Vector2.new(0.5, 0.5)
									Frame29.Position = UDim2.new(0.5, 0, 0.5, 14)
									Frame29.Size = UDim2.new(1, -20, 0, 6)
									Frame29.BackgroundColor3 = t1.UIColor["Background 2 Color"]
									TextButton5.Name = "SliderButton "
									TextButton5.Parent = Frame29
									TextButton5.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextButton5.BackgroundTransparency = 1
									TextButton5.Size = UDim2.new(1, 0, 1, 0)
									TextButton5.Font = Enum.Font.GothamBold
									TextButton5.Text = ""
									TextButton5.TextColor3 = Color3.fromRGB(230, 230, 230)
									TextButton5.TextSize = 14
									UICorner13.CornerRadius = UDim.new(1, 0)
									UICorner13.Name = "SliderBarCorner"
									UICorner13.Parent = Frame29
									Frame30.Name = "Bar"
									Frame30.BorderSizePixel = 0
									Frame30.Parent = Frame29
									Frame30.Size = UDim2.new(0, 0, 1, 0)
									Frame30.BackgroundColor3 = t1.UIColor["Slider Line Color"]
									UICorner14.CornerRadius = UDim.new(1, 0)
									UICorner14.Name = "BarCorner"
									UICorner14.Parent = Frame30
									Frame31.Name = "Background2"
									Frame31.Parent = Frame27
									Frame31.AnchorPoint = Vector2.new(1, 0)
									Frame31.Position = UDim2.new(1, -10, 0, 5)
									Frame31.Size = UDim2.new(0, 150, 0, 25)
									Frame31.BackgroundColor3 = t1.UIColor["Background 2 Color"]
									UICorner15.CornerRadius = UDim.new(0, 4)
									UICorner15.Name = "Sliderbox"
									UICorner15.Parent = Frame31
									TextBox4.Name = "TextColor"
									TextBox4.Parent = Frame31
									TextBox4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextBox4.BackgroundTransparency = 1
									TextBox4.Size = UDim2.new(1, 0, 1, 0)
									TextBox4.Font = Enum.Font.GothamBold
									TextBox4.Text = ""
									TextBox4.TextSize = 14
									TextBox4.TextColor3 = t1.UIColor["Text Color"]
									TextButton5.MouseEnter:Connect(function()
										TweenService:Create(Frame30, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
											BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
										}):Play()
									end)
									TextButton5.MouseLeave:Connect(function()
										TweenService:Create(Frame30, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
											BackgroundColor3 = t1.UIColor["Slider Line Color"]
										}):Play()
									end)

									local function v327(p22)
										TextBox4.Text = p22
										u294[k].Default = p22
										v260(k, v)
									end

									if v313 <= v310 then
										v313 = v310
									elseif v311 <= v313 then
										v313 = v311
									end

									Frame30.Size = UDim2.new(1 - (v311 - v313) / (v311 - v310), 0, 0, 6)
									v327(v313)

									if SliderRelease then
										local u328 = false
										local u329
										local n7 = 0

										local function v331(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												n7 = tick()
												input.Changed:Connect(function()
													if input.UserInputState == Enum.UserInputState.End then
														u328 = false
														n7 = 0
													end
												end)
											end
										end
										local function v332(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												u328 = false
												n7 = 0
											end
										end
										local function v333(input)
											if input.UserInputType == Enum.UserInputType.MouseMovement then
												u329 = input

												return
											elseif input.UserInputType == Enum.UserInputType.Touch then
												u329 = input
											end
										end

										TextButton5.InputBegan:Connect(v331)
										TextButton5.InputEnded:Connect(v332)
										TextButton5.InputChanged:Connect(v333)
										RunService.RenderStepped:Connect(function()
											if n7 > 0 then
												if tick() - n7 >= 0 and not u328 then
													u328 = true
												end
											end

											if u328 and u329 then
												local v334 = Precise and tonumber(string.format("%.1f", (tonumber(v311) - tonumber(v310)) / 365 * Frame30.AbsoluteSize.X + tonumber(v310))) or math.floor((tonumber(v311) - tonumber(v310)) / 365 * Frame30.AbsoluteSize.X + tonumber(v310))

												pcall(function()
													v327(v334)
												end)
												Frame30.Size = UDim2.new(0, math.clamp(u329.Position.X - Frame30.AbsolutePosition.X, 0, 365), 0, 6)
											end
										end)
									else
										local u335 = false
										local u336
										local n8 = 0

										local function v338(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												n8 = tick()
												input.Changed:Connect(function()
													if input.UserInputState == Enum.UserInputState.End then
														u335 = false
														n8 = 0
													end
												end)
											end
										end
										local function v339(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												u335 = false
												n8 = 0
											end
										end
										local function v340(input)
											if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
												u336 = input
											end
										end

										TextButton5.InputBegan:Connect(v338)
										TextButton5.InputEnded:Connect(v339)
										TextButton5.InputChanged:Connect(v340)
										RunService.RenderStepped:Connect(function()
											if n8 > 0 then
												if tick() - n8 >= 0 and not u335 then
													u335 = true
												end
											end

											if u335 and u336 then
												local v341 = Precise and tonumber(string.format("%.1f", (tonumber(v311) - tonumber(v310)) / 365 * Frame30.AbsoluteSize.X + tonumber(v310)))

												v341 = v341 or math.floor((tonumber(v311) - tonumber(v310)) / 365 * Frame30.AbsoluteSize.X + tonumber(v310))
												pcall(function()
													v327(v341)
												end)
												Frame30.Size = UDim2.new(0, math.clamp(u336.Position.X - Frame30.AbsolutePosition.X, 0, 365), 0, 6)
											end
										end)
									end

									local function v342(p23)
										if tonumber(p23) <= v310 then
											Frame30.Size = UDim2.new(0, 0, 0, 6)
											v327(v310)
										elseif v311 <= tonumber(p23) then
											Frame30.Size = UDim2.new(0, v311 / v311 * 365, 0, 6)
											v327(v311)
										else
											Frame30.Size = UDim2.new(1 - (v311 - p23) / (v311 - v310), 0, 0, 6)
											v327(p23)
										end
									end

									TextBox4.FocusLost:Connect(function()
										v342(TextBox4.Text)
									end)
								end
							else
								for _, v in SortPairs(u294) do
									if typeof(v) == "string" then
										local Frame27 = Instance.new("Frame")
										local UICorner11 = Instance.new("UICorner")
										local Frame28 = Instance.new("Frame")
										local UICorner12 = Instance.new("UICorner")
										local TextLabel6 = Instance.new("TextLabel")
										local ImageButton2 = Instance.new("ImageButton")
										local TextButton5 = Instance.new("TextButton")

										Frame27.Name = string.lower(v)
										Frame27.Parent = Frame26
										Frame27.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
										Frame27.BackgroundTransparency = 1
										Frame27.BorderColor3 = Color3.fromRGB(27, 42, 53)
										Frame27.LayoutOrder = 1
										Frame27.Position = UDim2.new(0, 0, 0.208333328, 0)
										Frame27.Size = UDim2.new(1, 0, 0, 25)
										UICorner11.CornerRadius = UDim.new(0, 4)
										UICorner11.Name = "SampleItemCorner"
										UICorner11.Parent = Frame27
										Frame28.Name = "SampleItemBG"
										Frame28.Parent = Frame27
										Frame28.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame28.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
										Frame28.BackgroundTransparency = 1
										Frame28.BorderColor3 = Color3.fromRGB(27, 42, 53)
										Frame28.Position = UDim2.new(0.5, 0, 0.5, 0)
										Frame28.Size = UDim2.new(1, 0, 1, 0)
										UICorner12.CornerRadius = UDim.new(0, 4)
										UICorner12.Name = "SampleItemBGCorner"
										UICorner12.Parent = Frame28
										TextLabel6.Name = "SampleItemTitle"
										TextLabel6.Parent = Frame28
										TextLabel6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
										TextLabel6.BackgroundTransparency = 1
										TextLabel6.BorderColor3 = Color3.fromRGB(27, 42, 53)
										TextLabel6.Position = UDim2.new(0, 10, 0, 0)
										TextLabel6.Size = UDim2.new(1, -40, 0, 25)
										TextLabel6.Font = Enum.Font.GothamBlack
										TextLabel6.Text = v
										TextLabel6.TextColor3 = Color3.fromRGB(255, 255, 255)
										TextLabel6.TextSize = 14
										TextLabel6.TextStrokeTransparency = 0.5
										TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
										ImageButton2.Name = "SampleItemCheck"
										ImageButton2.Parent = Frame28
										ImageButton2.AnchorPoint = Vector2.new(1, 0.5)
										ImageButton2.BackgroundTransparency = 1
										ImageButton2.Position = UDim2.new(1, 0, 0.5, 0)
										ImageButton2.Size = UDim2.new(0, 25, 0, 25)
										ImageButton2.ZIndex = 2
										ImageButton2.Image = "rbxassetid://3926305904"
										ImageButton2.ImageColor3 = t1.UIColor["Dropdown Selected Check Color"]
										ImageButton2.ImageRectOffset = Vector2.new(312, 4)
										ImageButton2.ImageRectSize = Vector2.new(24, 24)
										ImageButton2.ImageTransparency = 1
										TextButton5.Name = "SampleItemButton"
										TextButton5.Parent = Frame27
										TextButton5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
										TextButton5.BackgroundTransparency = 1
										TextButton5.BorderColor3 = Color3.fromRGB(0, 0, 0)
										TextButton5.BorderSizePixel = 0
										TextButton5.Size = UDim2.new(1, 0, 1, 0)
										TextButton5.Font = Enum.Font.SourceSans
										TextButton5.TextColor3 = t1.UIColor["Text Color"]
										TextButton5.TextSize = 14
										TextButton5.TextTransparency = 1
										TextButton5.MouseEnter:Connect(function()
											if StringValue.Value == v then
												return
											end

											TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
												BackgroundColor3 = Color3.fromRGB(255, 255, 255)
											}):Play()
											TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
												BackgroundTransparency = 0.7
											}):Play()
										end)
										TextButton5.MouseLeave:Connect(function()
											if StringValue.Value == v then
												return
											end

											TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
												BackgroundColor3 = Color3.fromRGB(255, 255, 255)
											}):Play()
											TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
												BackgroundTransparency = 1
											}):Play()
										end)
										TextButton5.MouseButton1Click:Connect(function()
											if Search then
												TextBox3.PlaceholderText = v253 .. ": " .. v or ""
												StringValue.Value = v
											else
												TextBox3.Text = v253 .. ": " .. v or ""
												StringValue.Value = v
											end

											TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
												BackgroundColor3 = t1.UIColor["Dropdown Selected Check Color"]
											}):Play()
											TweenService:Create(Frame28, TweenInfo.new(t1.UIColor["Tween Animation 1 Speed"]), {
												BackgroundTransparency = 0.5
											}):Play()

											if v260 then
												v260(v)
											end

											if Search then
												TextBox3.Text = ""
											end

											v295()
										end)

										if StringValue.Value == v then
											Frame28.BackgroundTransparency = 0.5
											Frame28.BackgroundColor3 = t1.UIColor["Dropdown Selected Check Color"]
											Frame27.LayoutOrder = 0
										end
									end
								end
							end
						end

						if Search then
							TextBox3.Changed:Connect(function()
								v278()
								v282()
							end)
						end

						if typeof(Default) ~= "table" then
							v260(Default)

							if Search then
								TextBox3.PlaceholderText = v253 .. ": " .. tostring(Default or "")
							else
								TextBox3.Text = v253 .. ": " .. tostring(Default or "")
							end
						elseif Slider then
							TextBox3.Text = ""
							TextBox3.PlaceholderText = v253 .. ": "
						elseif Selected then
							if Search then
								TextBox3.PlaceholderText = v253 .. ": "
							else
								TextBox3.Text = v253 .. ": "
							end
						end

						TextButton4.MouseButton1Click:Connect(function()
							v295()
							u275 = not u275

							local uDim22 = u275 and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
							local uDim23 = u275 and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
							local v354 = u275 and 90 or 0

							TweenService:Create(Frame25, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
								Size = uDim22
							}):Play()
							TweenService:Create(Frame22, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
								Size = uDim23
							}):Play()
							TweenService:Create(ImageLabel8, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
								Rotation = v354
							}):Play()
						end)

						local t16 = {
							rf = v295,
							ClearText = function(p24, p25)
								if Selected then
									TextBox3.Text = v253 .. ": " .. (p25 or "")
								elseif Search then
									TextBox3.PlaceholderText = v253 .. ": " .. (p25 or "")
								else
									TextBox3.Text = v253 .. ": " .. (p25 or "")
								end
							end,
							GetNewList = function(p26, p27)
								StringValue.Value = ""
								u275 = false

								local uDim22 = UDim2.new(1, 0, 0, 0)
								local uDim23 = u275 and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
								local v358 = u275 and 90

								v358 = v358 or 0
								TweenService:Create(Frame25, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
									Size = uDim22
								}):Play()
								TweenService:Create(Frame22, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
									Size = uDim23
								}):Play()
								TweenService:Create(ImageLabel8, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
									Rotation = v358
								}):Play()
								u294 = {}
								u294 = p27
								v295()

								if Search then
									TextBox3.PlaceholderText = v253 .. ": "
								else
									TextBox3.Text = v253 .. ": "
								end
							end,
							GetValue = function()
								if not Selected then
									return StringValue.Value
								end

								local t17 = {}

								if type(u294) == "table" then
									for k, v in SortPairs(u294) do
										if v == true then
											table.insert(t17, k)
										end
									end
								end

								return t17
							end
						}

						t16.GetValue = t16.GetValue
						t16.SetValue = function(p28)
							if not Selected then
								StringValue.Value = tostring(p28)

								if Search then
									TextBox3.PlaceholderText = v253 .. ": " .. tostring(p28)
								else
									TextBox3.Text = v253 .. ": " .. tostring(p28)
								end

								v260(p28)
							end
						end

						local t18 = {
							name = v253,
							type = Selected and "priority_dropdown" or "dropdown",
							value = Default or List and List[1] or "",
							list = List,
							Page_Name = text,
							Section_Name = text3,
							FunctionCreate = t16
						}

						t3.Options[v253] = t18

						if type(getgenv().Options) == "table" then
							getgenv().Options[v253] = t18
						end

						table.insert(t1.listfunction[Frame19], {
							Type = "Dropdown",
							Name = v253,
							Call = function()
								Frame22.Visible = true
							end
						})
						table.insert(t2[Frame19], Frame22)

						return t16
					end
					t8.CreateBind = function(p29, p30)
						local text4 = tostring(p29.Title) or ""

						table.insert(t1.listfunction[Frame19], {
							Type = "Bind",
							Name = text4
						})

						local Key = p29.Key
						local Default = p29.Default or p29.Key
						local u366 = tostring(Default):match("UserInputType") and "UserInputType" or "KeyCode"
						local v367 = p30 or function()
						end
						local v368 = tostring(Key):gsub("Enum.UserInputType.", "")

						tostring(v368):gsub("Enum.KeyCode.", "")

						local Frame22 = Instance.new("Frame")
						local UICorner9 = Instance.new("UICorner")
						local Frame23 = Instance.new("Frame")
						local UICorner10 = Instance.new("UICorner")
						local TextLabel6 = Instance.new("TextLabel")

						Instance.new("TextButton")

						local Frame24 = Instance.new("Frame")
						local UICorner11 = Instance.new("UICorner")
						local TextButton4 = Instance.new("TextButton")

						Frame22.Name = text4 .. "bguvl"
						Frame22.Parent = Frame19
						Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
						Frame22.BackgroundTransparency = 1
						Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
						Frame22.Size = UDim2.new(1, 0, 0, 35)
						UICorner9.CornerRadius = UDim.new(0, 4)
						UICorner9.Name = "BindCorner"
						UICorner9.Parent = Frame22
						Frame23.Name = "Background1"
						Frame23.Parent = Frame22
						Frame23.AnchorPoint = Vector2.new(0.5, 0.5)
						Frame23.Position = UDim2.new(0.5, 0, 0.5, 0)
						Frame23.Size = UDim2.new(1, -10, 1, 0)
						Frame23.BackgroundColor3 = t1.UIColor["Background 1 Color"]
						Frame23.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
						UICorner10.CornerRadius = UDim.new(0, 4)
						UICorner10.Name = "ButtonCorner"
						UICorner10.Parent = Frame23
						TextLabel6.Name = "TextColor"
						TextLabel6.Parent = Frame23
						TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						TextLabel6.BackgroundTransparency = 1
						TextLabel6.Position = UDim2.new(0, 10, 0, 0)
						TextLabel6.Size = UDim2.new(1, -10, 1, 0)
						TextLabel6.Font = v175 and Enum.Font.GothamMedium or Enum.Font.GothamBlack
						TextLabel6.Text = text4
						TextLabel6.TextSize = v175 and 13 or 14
						TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
						TextLabel6.TextColor3 = t1.UIColor["Text Color"]
						Frame24.Name = "Background2"
						Frame24.Parent = Frame23
						Frame24.AnchorPoint = Vector2.new(1, 0.5)
						Frame24.Position = UDim2.new(1, -5, 0.5, 0)
						Frame24.Size = UDim2.new(0, 150, 0, 25)
						Frame24.BackgroundColor3 = t1.UIColor["Background 2 Color"]
						UICorner11.CornerRadius = UDim.new(0, 4)
						UICorner11.Name = "ButtonCorner"
						UICorner11.Parent = Frame24
						TextButton4.Name = "Bindkey"
						TextButton4.Parent = Frame24
						TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						TextButton4.BackgroundTransparency = 1
						TextButton4.Size = UDim2.new(1, 0, 1, 0)
						TextButton4.Font = Enum.Font.GothamBold
						TextButton4.Text = tostring(Default):gsub("Enum.KeyCode.", "")
						TextButton4.TextSize = 14
						TextButton4.TextColor3 = t1.UIColor["Text Color"]

						local t19 = {
							[Enum.UserInputType.MouseButton1] = "Mouse1",
							[Enum.UserInputType.MouseButton2] = "Mouse2",
							[Enum.UserInputType.MouseButton3] = "Mouse3"
						}

						TextButton4.MouseButton1Click:Connect(function()
							local connection

							TextButton4.Text = "..."
							connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
								if t19[input.UserInputType] then
									TextButton4.Text = t19[input.UserInputType]
									spawn(function()
										wait(0.1)
										Default = input.UserInputType
										u366 = "UserInputType"
									end)
								elseif input.KeyCode ~= Enum.KeyCode.Unknown then
									TextButton4.Text = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
									spawn(function()
										wait(0.1)
										Default = input.KeyCode
										u366 = "KeyCode"
									end)
								end

								connection:Disconnect()
							end)
						end)
						game:GetService("UserInputService").InputBegan:Connect(function(input)
							if Default == input.UserInputType or Default == input.KeyCode then
								v367(Default)
							end
						end)

						local t20 = {
							name = text4,
							type = "keybind",
							value = Default,
							Page_Name = text,
							Section_Name = text3,
							FunctionCreate = Frame22
						}

						t3.Options[text4] = t20

						if type(getgenv().Options) == "table" then
							getgenv().Options[text4] = t20
						end
					end
					t8.CreateBox = function(p31, p32)
						local text4 = tostring(p31.Title) or ""
						local placeholderText = tostring(p31.Placeholder) or ""
						local Default = p31.Default or false
						local Number = p31.Number or false
						local v384 = p32 or function()
						end
						local Frame22 = Instance.new("Frame")
						local UICorner9 = Instance.new("UICorner")
						local Frame23 = Instance.new("Frame")
						local UICorner10 = Instance.new("UICorner")
						local TextLabel6 = Instance.new("TextLabel")
						local Frame24 = Instance.new("Frame")
						local UICorner11 = Instance.new("UICorner")
						local TextBox3 = Instance.new("TextBox")
						local Frame25 = Instance.new("Frame")
						local UICorner12 = Instance.new("UICorner")

						Frame22.Name = "BoxFrame"
						Frame22.Parent = Frame19
						Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
						Frame22.BackgroundTransparency = 1
						Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
						Frame22.Size = UDim2.new(1, 0, 0, 60)
						UICorner9.CornerRadius = UDim.new(0, 4)
						UICorner9.Name = "BoxCorner"
						UICorner9.Parent = Frame22
						Frame23.Name = "Background1"
						Frame23.Parent = Frame22
						Frame23.AnchorPoint = Vector2.new(0.5, 0.5)
						Frame23.Position = UDim2.new(0.5, 0, 0.5, 0)
						Frame23.Size = UDim2.new(1, -10, 1, 0)
						Frame23.BackgroundColor3 = t1.UIColor["Background 1 Color"]
						Frame23.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
						UICorner10.CornerRadius = UDim.new(0, 4)
						UICorner10.Name = "ButtonCorner"
						UICorner10.Parent = Frame23
						TextLabel6.Name = "TextColor"
						TextLabel6.Parent = Frame23
						TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						TextLabel6.BackgroundTransparency = 1
						TextLabel6.Position = UDim2.new(0, 10, 0, 0)
						TextLabel6.Size = UDim2.new(1, -10, 0.5, 0)
						TextLabel6.Font = v175 and Enum.Font.GothamMedium or Enum.Font.GothamBlack
						TextLabel6.Text = text4
						TextLabel6.TextSize = v175 and 13 or 14
						TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
						TextLabel6.TextColor3 = t1.UIColor["Text Color"]
						Frame24.Name = "Background2"
						Frame24.Parent = Frame23
						Frame24.AnchorPoint = Vector2.new(1, 0.5)
						Frame24.ClipsDescendants = true
						Frame24.Position = UDim2.new(1, -5, 0, 40)
						Frame24.Size = UDim2.new(1, -10, 0, 25)
						Frame24.BackgroundColor3 = t1.UIColor["Background 2 Color"]
						UICorner11.CornerRadius = UDim.new(0, 4)
						UICorner11.Name = "ButtonCorner"
						UICorner11.Parent = Frame24
						TextBox3.Name = "TextColorPlaceholder"
						TextBox3.Parent = Frame24
						TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						TextBox3.BackgroundTransparency = 1
						TextBox3.Position = UDim2.new(0, 5, 0, 0)
						TextBox3.Size = UDim2.new(1, -5, 1, 0)
						TextBox3.Font = Enum.Font.GothamBold
						TextBox3.PlaceholderText = placeholderText
						TextBox3.Text = ""
						TextBox3.TextSize = 14
						TextBox3.TextXAlignment = Enum.TextXAlignment.Left
						TextBox3.PlaceholderColor3 = t1.UIColor["Placeholder Text Color"]
						TextBox3.TextColor3 = t1.UIColor["Text Color"]
						Frame25.Name = "TextNSBoxLineeeee"
						Frame25.Parent = Frame24
						Frame25.BackgroundTransparency = 1
						Frame25.Position = UDim2.new(0, 0, 1, -2)
						Frame25.Size = UDim2.new(1, 0, 0, 6)
						Frame25.BackgroundColor3 = t1.UIColor["Box Highlight Color"]
						UICorner12.CornerRadius = UDim.new(1, 0)
						UICorner12.Parent = Frame25
						TextBox3.Focused:Connect(function()
							TweenService:Create(Frame25, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
								BackgroundTransparency = 0
							}):Play()
						end)

						if Number then
							TextBox3:GetPropertyChangedSignal("Text"):Connect(function()
								if not tonumber(TextBox3.Text) then
									TextBox3.PlaceholderText = placeholderText
									TextBox3.Text = ""
								end
							end)
						end

						TextBox3.FocusLost:Connect(function()
							TweenService:Create(Frame25, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
								BackgroundTransparency = 1
							}):Play()

							if TextBox3.Text ~= "" then
								v384(TextBox3.Text)
							end
						end)

						if Default then
							TextBox3.Text = Default
							v384(Default)
						end

						local t21 = {
							SetValue = function(p33)
								TextBox3.Text = p33
								v384(p33)
							end,
							GetValue = function()
								return TextBox3.Text
							end
						}
						local t22 = {
							name = text4,
							type = "box",
							value = Default or "",
							Page_Name = text,
							Section_Name = text3,
							FunctionCreate = t21
						}

						t3.Options[text4] = t22

						if type(getgenv().Options) == "table" then
							getgenv().Options[text4] = t22
						end

						table.insert(t1.listfunction[Frame19], {
							Type = "Box",
							Name = text4,
							Call = function()
								Frame22.Visible = true
							end
						})
						table.insert(t2[Frame19], Frame22)

						return t21
					end
					t8.CreateSlider = function(p34, p35)
						local text4 = tostring(p34.Title)
						local Frame22, functionCreate, insert, v401, t23

						if text4 then
							local v403 = tonumber(p34.Min)
							local v404, value, t24

							if v403 then
								v404 = tonumber(p34.Max)

								if v404 then
									local Precise = p34.Precise
									local Frame23, TextBox3, v410, v411, Connect, v413

									if Precise then
										value = tonumber(p34.Default) or 0

										local v414 = p35 or function()
										end

										Frame22 = Instance.new("Frame")

										local UICorner9 = Instance.new("UICorner")
										local Frame24 = Instance.new("Frame")
										local UICorner10 = Instance.new("UICorner")
										local TextLabel6 = Instance.new("TextLabel")
										local Frame25 = Instance.new("Frame")
										local TextButton4 = Instance.new("TextButton")
										local UICorner11 = Instance.new("UICorner")

										Frame23 = Instance.new("Frame")

										local UICorner12 = Instance.new("UICorner")
										local Frame26 = Instance.new("Frame")
										local UICorner13 = Instance.new("UICorner")

										TextBox3 = Instance.new("TextBox")
										Frame22.Name = text4 .. "buda"
										Frame22.Parent = Frame19
										Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
										Frame22.BackgroundTransparency = 1
										Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
										Frame22.Size = UDim2.new(1, 0, 0, 50)
										UICorner9.CornerRadius = UDim.new(0, 4)
										UICorner9.Name = "SliderCorner"
										UICorner9.Parent = Frame22
										Frame24.Name = "Background1"
										Frame24.Parent = Frame22
										Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
										Frame24.Size = UDim2.new(1, -10, 1, 0)
										Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
										Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
										UICorner10.CornerRadius = UDim.new(0, 4)
										UICorner10.Name = "SliderBGCorner"
										UICorner10.Parent = Frame24
										TextLabel6.Name = "TextColor"
										TextLabel6.Parent = Frame24
										TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextLabel6.BackgroundTransparency = 1
										TextLabel6.Position = UDim2.new(0, 10, 0, 0)
										TextLabel6.Size = UDim2.new(1, -10, 0, 25)
										TextLabel6.Font = Enum.Font.GothamBlack
										TextLabel6.Text = text4
										TextLabel6.TextSize = 14
										TextLabel6.RichText = true
										TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
										TextLabel6.TextColor3 = t1.UIColor["Text Color"]
										Frame25.Name = "SliderBar"
										Frame25.Parent = Frame22
										Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
										Frame25.Size = UDim2.new(0, 400, 0, 6)
										Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										TextButton4.Name = "SliderButton "
										TextButton4.Parent = Frame25
										TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.BackgroundTransparency = 1
										TextButton4.Size = UDim2.new(1, 0, 1, 0)
										TextButton4.Font = Enum.Font.GothamBold
										TextButton4.Text = ""
										TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.TextSize = 14
										UICorner11.CornerRadius = UDim.new(1, 0)
										UICorner11.Name = "SliderBarCorner"
										UICorner11.Parent = Frame25
										Frame23.Name = "Bar"
										Frame23.BorderSizePixel = 0
										Frame23.Parent = Frame25
										Frame23.Size = UDim2.new(0, 0, 1, 0)
										Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
										UICorner12.CornerRadius = UDim.new(1, 0)
										UICorner12.Name = "BarCorner"
										UICorner12.Parent = Frame23
										Frame26.Name = "Background2"
										Frame26.Parent = Frame22
										Frame26.AnchorPoint = Vector2.new(1, 0)
										Frame26.Position = UDim2.new(1, -10, 0, 5)
										Frame26.Size = UDim2.new(0, 150, 0, 25)
										Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										UICorner13.CornerRadius = UDim.new(0, 4)
										UICorner13.Name = "Sliderbox"
										UICorner13.Parent = Frame26
										TextBox3.Name = "TextColor"
										TextBox3.Parent = Frame26
										TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextBox3.BackgroundTransparency = 1
										TextBox3.Size = UDim2.new(1, 0, 1, 0)
										TextBox3.Font = Enum.Font.GothamBold
										TextBox3.Text = ""
										TextBox3.TextSize = 14
										TextBox3.TextColor3 = t1.UIColor["Text Color"]
										TextButton4.MouseEnter:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
											}):Play()
										end)
										TextButton4.MouseLeave:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Line Color"]
											}):Play()
										end)
										v410 = function(p36)
											TextBox3.Text = p36
											v414(tonumber(p36))
										end

										if value then
											if value <= v403 then
												value = v403
											elseif v404 <= value then
												value = v404
											end

											Frame23.Size = UDim2.new(1 - (v404 - value) / (v404 - v403), 0, 0, 6)
											v410(value)
										end

										local u425 = false
										local u426
										local n9 = 0

										local function v428(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												n9 = tick()
												input.Changed:Connect(function()
													if input.UserInputState == Enum.UserInputState.End then
														u425 = false
														n9 = 0
													end
												end)
											end
										end
										local function v429(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												u425 = false
												n9 = 0
											end
										end
										local function v430(input)
											if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
												u426 = input
											end
										end

										TextButton4.InputBegan:Connect(v428)
										TextButton4.InputEnded:Connect(v429)
										TextButton4.InputChanged:Connect(v430)

										local RenderStepped = RunService.RenderStepped

										v411 = RenderStepped
										Connect = RenderStepped.Connect
										v413 = function()
											if n9 > 0 and tick() - n9 >= 0 and not u425 then
												u425 = true
											end

											if u425 and u426 then
												local v432 = Precise and tonumber(string.format("%.1f", (tonumber(v404) - tonumber(v403)) / 400 * Frame23.AbsoluteSize.X + tonumber(v403))) or math.floor((tonumber(v404) - tonumber(v403)) / 400 * Frame23.AbsoluteSize.X + tonumber(v403))

												pcall(function()
													v410(v432)
												end)
												Frame23.Size = UDim2.new(0, math.clamp(u426.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
											end
										end
									else
										value = tonumber(p34.Default) or 0

										local v433 = p35 or function()
										end

										Frame22 = Instance.new("Frame")

										local UICorner9 = Instance.new("UICorner")
										local Frame24 = Instance.new("Frame")
										local UICorner10 = Instance.new("UICorner")
										local TextLabel6 = Instance.new("TextLabel")
										local Frame25 = Instance.new("Frame")
										local TextButton4 = Instance.new("TextButton")
										local UICorner11 = Instance.new("UICorner")

										Frame23 = Instance.new("Frame")

										local UICorner12 = Instance.new("UICorner")
										local Frame26 = Instance.new("Frame")
										local UICorner13 = Instance.new("UICorner")

										TextBox3 = Instance.new("TextBox")
										Frame22.Name = text4 .. "buda"
										Frame22.Parent = Frame19
										Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
										Frame22.BackgroundTransparency = 1
										Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
										Frame22.Size = UDim2.new(1, 0, 0, 50)
										UICorner9.CornerRadius = UDim.new(0, 4)
										UICorner9.Name = "SliderCorner"
										UICorner9.Parent = Frame22
										Frame24.Name = "Background1"
										Frame24.Parent = Frame22
										Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
										Frame24.Size = UDim2.new(1, -10, 1, 0)
										Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
										Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
										UICorner10.CornerRadius = UDim.new(0, 4)
										UICorner10.Name = "SliderBGCorner"
										UICorner10.Parent = Frame24
										TextLabel6.Name = "TextColor"
										TextLabel6.Parent = Frame24
										TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextLabel6.BackgroundTransparency = 1
										TextLabel6.Position = UDim2.new(0, 10, 0, 0)
										TextLabel6.Size = UDim2.new(1, -10, 0, 25)
										TextLabel6.Font = Enum.Font.GothamBlack
										TextLabel6.Text = text4
										TextLabel6.TextSize = 14
										TextLabel6.RichText = true
										TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
										TextLabel6.TextColor3 = t1.UIColor["Text Color"]
										Frame25.Name = "SliderBar"
										Frame25.Parent = Frame22
										Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
										Frame25.Size = UDim2.new(0, 400, 0, 6)
										Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										TextButton4.Name = "SliderButton "
										TextButton4.Parent = Frame25
										TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.BackgroundTransparency = 1
										TextButton4.Size = UDim2.new(1, 0, 1, 0)
										TextButton4.Font = Enum.Font.GothamBold
										TextButton4.Text = ""
										TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.TextSize = 14
										UICorner11.CornerRadius = UDim.new(1, 0)
										UICorner11.Name = "SliderBarCorner"
										UICorner11.Parent = Frame25
										Frame23.Name = "Bar"
										Frame23.BorderSizePixel = 0
										Frame23.Parent = Frame25
										Frame23.Size = UDim2.new(0, 0, 1, 0)
										Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
										UICorner12.CornerRadius = UDim.new(1, 0)
										UICorner12.Name = "BarCorner"
										UICorner12.Parent = Frame23
										Frame26.Name = "Background2"
										Frame26.Parent = Frame22
										Frame26.AnchorPoint = Vector2.new(1, 0)
										Frame26.Position = UDim2.new(1, -10, 0, 5)
										Frame26.Size = UDim2.new(0, 150, 0, 25)
										Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										UICorner13.CornerRadius = UDim.new(0, 4)
										UICorner13.Name = "Sliderbox"
										UICorner13.Parent = Frame26
										TextBox3.Name = "TextColor"
										TextBox3.Parent = Frame26
										TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextBox3.BackgroundTransparency = 1
										TextBox3.Size = UDim2.new(1, 0, 1, 0)
										TextBox3.Font = Enum.Font.GothamBold
										TextBox3.Text = ""
										TextBox3.TextSize = 14
										TextBox3.TextColor3 = t1.UIColor["Text Color"]
										TextButton4.MouseEnter:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
											}):Play()
										end)
										TextButton4.MouseLeave:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Line Color"]
											}):Play()
										end)
										v410 = function(p37)
											TextBox3.Text = p37
											v433(tonumber(p37))
										end

										if value then
											if value <= v403 then
												value = v403
											elseif v404 <= value then
												value = v404
											end

											Frame23.Size = UDim2.new(1 - (v404 - value) / (v404 - v403), 0, 0, 6)
											v410(value)
										end

										local u444 = false
										local u445
										local n10 = 0

										local function v447(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												n10 = tick()
												input.Changed:Connect(function()
													if input.UserInputState == Enum.UserInputState.End then
														u444 = false
														n10 = 0
													end
												end)
											end
										end
										local function v448(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												u444 = false
												n10 = 0
											end
										end
										local function v449(input)
											if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
												u445 = input
											end
										end

										TextButton4.InputBegan:Connect(v447)
										TextButton4.InputEnded:Connect(v448)
										TextButton4.InputChanged:Connect(v449)

										local RenderStepped = RunService.RenderStepped

										v411 = RenderStepped
										Connect = RenderStepped.Connect
										v413 = function()
											if n10 > 0 and tick() - n10 >= 0 and not u444 then
												u444 = true
											end

											if u444 and u445 then
												local v451 = nil and tonumber(string.format("%.1f", (tonumber(v404) - tonumber(v403)) / 400 * Frame23.AbsoluteSize.X + tonumber(v403))) or math.floor((tonumber(v404) - tonumber(v403)) / 400 * Frame23.AbsoluteSize.X + tonumber(v403))

												pcall(function()
													v410(v451)
												end)
												Frame23.Size = UDim2.new(0, math.clamp(u445.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
											end
										end
									end

									Connect(v411, v413)

									local function v452(p38)
										if tonumber(p38) <= v403 then
											Frame23.Size = UDim2.new(0, 0, 0, 6)
											v410(v403)
										elseif v404 <= tonumber(p38) then
											Frame23.Size = UDim2.new(0, v404 / v404 * 400, 0, 6)
											v410(v404)
										else
											Frame23.Size = UDim2.new(1 - (v404 - p38) / (v404 - v403), 0, 0, 6)
											v410(p38)
										end
									end

									TextBox3.FocusLost:Connect(function()
										v452(TextBox3.Text)
									end)
									functionCreate = {
										SetValue = function(p39)
											v452(p39)
										end,
										GetValue = function()
											return tonumber(TextBox3.Text) or value
										end
									}
									t24 = {
										name = text4,
										type = "slider",
										min = v403,
										max = v404
									}
								else
									local Precise = p34.Precise
									local Frame23, TextBox3, v456, v457, Connect, v459

									if Precise then
										value = tonumber(p34.Default) or 0

										local v460 = p35 or function()
										end

										Frame22 = Instance.new("Frame")

										local UICorner9 = Instance.new("UICorner")
										local Frame24 = Instance.new("Frame")
										local UICorner10 = Instance.new("UICorner")
										local TextLabel6 = Instance.new("TextLabel")
										local Frame25 = Instance.new("Frame")
										local TextButton4 = Instance.new("TextButton")
										local UICorner11 = Instance.new("UICorner")

										Frame23 = Instance.new("Frame")

										local UICorner12 = Instance.new("UICorner")
										local Frame26 = Instance.new("Frame")
										local UICorner13 = Instance.new("UICorner")

										TextBox3 = Instance.new("TextBox")
										Frame22.Name = text4 .. "buda"
										Frame22.Parent = Frame19
										Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
										Frame22.BackgroundTransparency = 1
										Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
										Frame22.Size = UDim2.new(1, 0, 0, 50)
										UICorner9.CornerRadius = UDim.new(0, 4)
										UICorner9.Name = "SliderCorner"
										UICorner9.Parent = Frame22
										Frame24.Name = "Background1"
										Frame24.Parent = Frame22
										Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
										Frame24.Size = UDim2.new(1, -10, 1, 0)
										Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
										Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
										UICorner10.CornerRadius = UDim.new(0, 4)
										UICorner10.Name = "SliderBGCorner"
										UICorner10.Parent = Frame24
										TextLabel6.Name = "TextColor"
										TextLabel6.Parent = Frame24
										TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextLabel6.BackgroundTransparency = 1
										TextLabel6.Position = UDim2.new(0, 10, 0, 0)
										TextLabel6.Size = UDim2.new(1, -10, 0, 25)
										TextLabel6.Font = Enum.Font.GothamBlack
										TextLabel6.Text = text4
										TextLabel6.TextSize = 14
										TextLabel6.RichText = true
										TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
										TextLabel6.TextColor3 = t1.UIColor["Text Color"]
										Frame25.Name = "SliderBar"
										Frame25.Parent = Frame22
										Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
										Frame25.Size = UDim2.new(0, 400, 0, 6)
										Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										TextButton4.Name = "SliderButton "
										TextButton4.Parent = Frame25
										TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.BackgroundTransparency = 1
										TextButton4.Size = UDim2.new(1, 0, 1, 0)
										TextButton4.Font = Enum.Font.GothamBold
										TextButton4.Text = ""
										TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.TextSize = 14
										UICorner11.CornerRadius = UDim.new(1, 0)
										UICorner11.Name = "SliderBarCorner"
										UICorner11.Parent = Frame25
										Frame23.Name = "Bar"
										Frame23.BorderSizePixel = 0
										Frame23.Parent = Frame25
										Frame23.Size = UDim2.new(0, 0, 1, 0)
										Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
										UICorner12.CornerRadius = UDim.new(1, 0)
										UICorner12.Name = "BarCorner"
										UICorner12.Parent = Frame23
										Frame26.Name = "Background2"
										Frame26.Parent = Frame22
										Frame26.AnchorPoint = Vector2.new(1, 0)
										Frame26.Position = UDim2.new(1, -10, 0, 5)
										Frame26.Size = UDim2.new(0, 150, 0, 25)
										Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										UICorner13.CornerRadius = UDim.new(0, 4)
										UICorner13.Name = "Sliderbox"
										UICorner13.Parent = Frame26
										TextBox3.Name = "TextColor"
										TextBox3.Parent = Frame26
										TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextBox3.BackgroundTransparency = 1
										TextBox3.Size = UDim2.new(1, 0, 1, 0)
										TextBox3.Font = Enum.Font.GothamBold
										TextBox3.Text = ""
										TextBox3.TextSize = 14
										TextBox3.TextColor3 = t1.UIColor["Text Color"]
										TextButton4.MouseEnter:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
											}):Play()
										end)
										TextButton4.MouseLeave:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Line Color"]
											}):Play()
										end)
										v456 = function(p40)
											TextBox3.Text = p40
											v460(tonumber(p40))
										end

										if value then
											if value <= v403 then
												value = v403
											elseif value >= 100 then
												value = 100
											end

											Frame23.Size = UDim2.new(1 - (100 - value) / (100 - v403), 0, 0, 6)
											v456(value)
										end

										local u471 = false
										local u472
										local n11 = 0

										local function v474(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												n11 = tick()
												input.Changed:Connect(function()
													if input.UserInputState == Enum.UserInputState.End then
														u471 = false
														n11 = 0
													end
												end)
											end
										end
										local function v475(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												u471 = false
												n11 = 0
											end
										end
										local function v476(input)
											if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
												u472 = input
											end
										end

										TextButton4.InputBegan:Connect(v474)
										TextButton4.InputEnded:Connect(v475)
										TextButton4.InputChanged:Connect(v476)

										local RenderStepped = RunService.RenderStepped

										v457 = RenderStepped
										Connect = RenderStepped.Connect
										v459 = function()
											if n11 > 0 and tick() - n11 >= 0 and not u471 then
												u471 = true
											end

											if u471 and u472 then
												local v478 = Precise and tonumber(string.format("%.1f", (tonumber(nil) - tonumber(v403)) / 400 * Frame23.AbsoluteSize.X + tonumber(v403))) or math.floor((tonumber(nil) - tonumber(v403)) / 400 * Frame23.AbsoluteSize.X + tonumber(v403))

												pcall(function()
													v456(v478)
												end)
												Frame23.Size = UDim2.new(0, math.clamp(u472.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
											end
										end
									else
										value = tonumber(p34.Default) or 0

										local v479 = p35 or function()
										end

										Frame22 = Instance.new("Frame")

										local UICorner9 = Instance.new("UICorner")
										local Frame24 = Instance.new("Frame")
										local UICorner10 = Instance.new("UICorner")
										local TextLabel6 = Instance.new("TextLabel")
										local Frame25 = Instance.new("Frame")
										local TextButton4 = Instance.new("TextButton")
										local UICorner11 = Instance.new("UICorner")

										Frame23 = Instance.new("Frame")

										local UICorner12 = Instance.new("UICorner")
										local Frame26 = Instance.new("Frame")
										local UICorner13 = Instance.new("UICorner")

										TextBox3 = Instance.new("TextBox")
										Frame22.Name = text4 .. "buda"
										Frame22.Parent = Frame19
										Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
										Frame22.BackgroundTransparency = 1
										Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
										Frame22.Size = UDim2.new(1, 0, 0, 50)
										UICorner9.CornerRadius = UDim.new(0, 4)
										UICorner9.Name = "SliderCorner"
										UICorner9.Parent = Frame22
										Frame24.Name = "Background1"
										Frame24.Parent = Frame22
										Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
										Frame24.Size = UDim2.new(1, -10, 1, 0)
										Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
										Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
										UICorner10.CornerRadius = UDim.new(0, 4)
										UICorner10.Name = "SliderBGCorner"
										UICorner10.Parent = Frame24
										TextLabel6.Name = "TextColor"
										TextLabel6.Parent = Frame24
										TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextLabel6.BackgroundTransparency = 1
										TextLabel6.Position = UDim2.new(0, 10, 0, 0)
										TextLabel6.Size = UDim2.new(1, -10, 0, 25)
										TextLabel6.Font = Enum.Font.GothamBlack
										TextLabel6.Text = text4
										TextLabel6.TextSize = 14
										TextLabel6.RichText = true
										TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
										TextLabel6.TextColor3 = t1.UIColor["Text Color"]
										Frame25.Name = "SliderBar"
										Frame25.Parent = Frame22
										Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
										Frame25.Size = UDim2.new(0, 400, 0, 6)
										Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										TextButton4.Name = "SliderButton "
										TextButton4.Parent = Frame25
										TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.BackgroundTransparency = 1
										TextButton4.Size = UDim2.new(1, 0, 1, 0)
										TextButton4.Font = Enum.Font.GothamBold
										TextButton4.Text = ""
										TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.TextSize = 14
										UICorner11.CornerRadius = UDim.new(1, 0)
										UICorner11.Name = "SliderBarCorner"
										UICorner11.Parent = Frame25
										Frame23.Name = "Bar"
										Frame23.BorderSizePixel = 0
										Frame23.Parent = Frame25
										Frame23.Size = UDim2.new(0, 0, 1, 0)
										Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
										UICorner12.CornerRadius = UDim.new(1, 0)
										UICorner12.Name = "BarCorner"
										UICorner12.Parent = Frame23
										Frame26.Name = "Background2"
										Frame26.Parent = Frame22
										Frame26.AnchorPoint = Vector2.new(1, 0)
										Frame26.Position = UDim2.new(1, -10, 0, 5)
										Frame26.Size = UDim2.new(0, 150, 0, 25)
										Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										UICorner13.CornerRadius = UDim.new(0, 4)
										UICorner13.Name = "Sliderbox"
										UICorner13.Parent = Frame26
										TextBox3.Name = "TextColor"
										TextBox3.Parent = Frame26
										TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextBox3.BackgroundTransparency = 1
										TextBox3.Size = UDim2.new(1, 0, 1, 0)
										TextBox3.Font = Enum.Font.GothamBold
										TextBox3.Text = ""
										TextBox3.TextSize = 14
										TextBox3.TextColor3 = t1.UIColor["Text Color"]
										TextButton4.MouseEnter:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
											}):Play()
										end)
										TextButton4.MouseLeave:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Line Color"]
											}):Play()
										end)
										v456 = function(p41)
											TextBox3.Text = p41
											v479(tonumber(p41))
										end

										if value then
											if value <= v403 then
												value = v403
											elseif value >= 100 then
												value = 100
											end

											Frame23.Size = UDim2.new(1 - (100 - value) / (100 - v403), 0, 0, 6)
											v456(value)
										end

										local u490 = false
										local u491
										local n12 = 0

										local function v493(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												n12 = tick()
												input.Changed:Connect(function()
													if input.UserInputState == Enum.UserInputState.End then
														u490 = false
														n12 = 0
													end
												end)
											end
										end
										local function v494(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												u490 = false
												n12 = 0
											end
										end
										local function v495(input)
											if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
												u491 = input
											end
										end

										TextButton4.InputBegan:Connect(v493)
										TextButton4.InputEnded:Connect(v494)
										TextButton4.InputChanged:Connect(v495)

										local RenderStepped = RunService.RenderStepped

										v457 = RenderStepped
										Connect = RenderStepped.Connect
										v459 = function()
											if n12 > 0 and tick() - n12 >= 0 and not u490 then
												u490 = true
											end

											if u490 and u491 then
												local v497 = nil and tonumber(string.format("%.1f", (tonumber(nil) - tonumber(v403)) / 400 * Frame23.AbsoluteSize.X + tonumber(v403))) or math.floor((tonumber(nil) - tonumber(v403)) / 400 * Frame23.AbsoluteSize.X + tonumber(v403))

												pcall(function()
													v456(v497)
												end)
												Frame23.Size = UDim2.new(0, math.clamp(u491.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
											end
										end
									end

									Connect(v457, v459)

									local function v498(p42)
										if tonumber(p42) <= v403 then
											Frame23.Size = UDim2.new(0, 0, 0, 6)
											v456(v403)
										elseif nil <= tonumber(p42) then
											Frame23.Size = UDim2.new(0, nil / nil * 400, 0, 6)
											v456(nil)
										else
											Frame23.Size = UDim2.new(1 - (nil - p42) / (nil - v403), 0, 0, 6)
											v456(p42)
										end
									end

									TextBox3.FocusLost:Connect(function()
										v498(TextBox3.Text)
									end)
									functionCreate = {
										SetValue = function(p43)
											v498(p43)
										end,
										GetValue = function()
											return tonumber(TextBox3.Text) or value
										end
									}
									t24 = {
										name = text4,
										type = "slider",
										min = v403,
										max = 100
									}
								end
							else
								v404 = tonumber(p34.Max)

								if v404 then
									local Precise = p34.Precise
									local Frame23, TextBox3, v502, v503, Connect, v505

									if Precise then
										value = tonumber(p34.Default) or 0

										local v506 = p35 or function()
										end

										Frame22 = Instance.new("Frame")

										local UICorner9 = Instance.new("UICorner")
										local Frame24 = Instance.new("Frame")
										local UICorner10 = Instance.new("UICorner")
										local TextLabel6 = Instance.new("TextLabel")
										local Frame25 = Instance.new("Frame")
										local TextButton4 = Instance.new("TextButton")
										local UICorner11 = Instance.new("UICorner")

										Frame23 = Instance.new("Frame")

										local UICorner12 = Instance.new("UICorner")
										local Frame26 = Instance.new("Frame")
										local UICorner13 = Instance.new("UICorner")

										TextBox3 = Instance.new("TextBox")
										Frame22.Name = text4 .. "buda"
										Frame22.Parent = Frame19
										Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
										Frame22.BackgroundTransparency = 1
										Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
										Frame22.Size = UDim2.new(1, 0, 0, 50)
										UICorner9.CornerRadius = UDim.new(0, 4)
										UICorner9.Name = "SliderCorner"
										UICorner9.Parent = Frame22
										Frame24.Name = "Background1"
										Frame24.Parent = Frame22
										Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
										Frame24.Size = UDim2.new(1, -10, 1, 0)
										Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
										Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
										UICorner10.CornerRadius = UDim.new(0, 4)
										UICorner10.Name = "SliderBGCorner"
										UICorner10.Parent = Frame24
										TextLabel6.Name = "TextColor"
										TextLabel6.Parent = Frame24
										TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextLabel6.BackgroundTransparency = 1
										TextLabel6.Position = UDim2.new(0, 10, 0, 0)
										TextLabel6.Size = UDim2.new(1, -10, 0, 25)
										TextLabel6.Font = Enum.Font.GothamBlack
										TextLabel6.Text = text4
										TextLabel6.TextSize = 14
										TextLabel6.RichText = true
										TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
										TextLabel6.TextColor3 = t1.UIColor["Text Color"]
										Frame25.Name = "SliderBar"
										Frame25.Parent = Frame22
										Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
										Frame25.Size = UDim2.new(0, 400, 0, 6)
										Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										TextButton4.Name = "SliderButton "
										TextButton4.Parent = Frame25
										TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.BackgroundTransparency = 1
										TextButton4.Size = UDim2.new(1, 0, 1, 0)
										TextButton4.Font = Enum.Font.GothamBold
										TextButton4.Text = ""
										TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.TextSize = 14
										UICorner11.CornerRadius = UDim.new(1, 0)
										UICorner11.Name = "SliderBarCorner"
										UICorner11.Parent = Frame25
										Frame23.Name = "Bar"
										Frame23.BorderSizePixel = 0
										Frame23.Parent = Frame25
										Frame23.Size = UDim2.new(0, 0, 1, 0)
										Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
										UICorner12.CornerRadius = UDim.new(1, 0)
										UICorner12.Name = "BarCorner"
										UICorner12.Parent = Frame23
										Frame26.Name = "Background2"
										Frame26.Parent = Frame22
										Frame26.AnchorPoint = Vector2.new(1, 0)
										Frame26.Position = UDim2.new(1, -10, 0, 5)
										Frame26.Size = UDim2.new(0, 150, 0, 25)
										Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										UICorner13.CornerRadius = UDim.new(0, 4)
										UICorner13.Name = "Sliderbox"
										UICorner13.Parent = Frame26
										TextBox3.Name = "TextColor"
										TextBox3.Parent = Frame26
										TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextBox3.BackgroundTransparency = 1
										TextBox3.Size = UDim2.new(1, 0, 1, 0)
										TextBox3.Font = Enum.Font.GothamBold
										TextBox3.Text = ""
										TextBox3.TextSize = 14
										TextBox3.TextColor3 = t1.UIColor["Text Color"]
										TextButton4.MouseEnter:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
											}):Play()
										end)
										TextButton4.MouseLeave:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Line Color"]
											}):Play()
										end)
										v502 = function(p44)
											TextBox3.Text = p44
											v506(tonumber(p44))
										end

										if value then
											if value <= 0 then
												value = 0
											elseif v404 <= value then
												value = v404
											end

											Frame23.Size = UDim2.new(1 - (v404 - value) / (v404 - 0), 0, 0, 6)
											v502(value)
										end

										local u517 = false
										local u518
										local n13 = 0

										local function v520(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												n13 = tick()
												input.Changed:Connect(function()
													if input.UserInputState == Enum.UserInputState.End then
														u517 = false
														n13 = 0
													end
												end)
											end
										end
										local function v521(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												u517 = false
												n13 = 0
											end
										end
										local function v522(input)
											if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
												u518 = input
											end
										end

										TextButton4.InputBegan:Connect(v520)
										TextButton4.InputEnded:Connect(v521)
										TextButton4.InputChanged:Connect(v522)

										local RenderStepped = RunService.RenderStepped

										v503 = RenderStepped
										Connect = RenderStepped.Connect
										v505 = function()
											if n13 > 0 and tick() - n13 >= 0 and not u517 then
												u517 = true
											end

											if u517 and u518 then
												local v524 = Precise and tonumber(string.format("%.1f", (tonumber(v404) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))) or math.floor((tonumber(v404) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))

												pcall(function()
													v502(v524)
												end)
												Frame23.Size = UDim2.new(0, math.clamp(u518.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
											end
										end
									else
										value = tonumber(p34.Default) or 0

										local v525 = p35 or function()
										end

										Frame22 = Instance.new("Frame")

										local UICorner9 = Instance.new("UICorner")
										local Frame24 = Instance.new("Frame")
										local UICorner10 = Instance.new("UICorner")
										local TextLabel6 = Instance.new("TextLabel")
										local Frame25 = Instance.new("Frame")
										local TextButton4 = Instance.new("TextButton")
										local UICorner11 = Instance.new("UICorner")

										Frame23 = Instance.new("Frame")

										local UICorner12 = Instance.new("UICorner")
										local Frame26 = Instance.new("Frame")
										local UICorner13 = Instance.new("UICorner")

										TextBox3 = Instance.new("TextBox")
										Frame22.Name = text4 .. "buda"
										Frame22.Parent = Frame19
										Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
										Frame22.BackgroundTransparency = 1
										Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
										Frame22.Size = UDim2.new(1, 0, 0, 50)
										UICorner9.CornerRadius = UDim.new(0, 4)
										UICorner9.Name = "SliderCorner"
										UICorner9.Parent = Frame22
										Frame24.Name = "Background1"
										Frame24.Parent = Frame22
										Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
										Frame24.Size = UDim2.new(1, -10, 1, 0)
										Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
										Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
										UICorner10.CornerRadius = UDim.new(0, 4)
										UICorner10.Name = "SliderBGCorner"
										UICorner10.Parent = Frame24
										TextLabel6.Name = "TextColor"
										TextLabel6.Parent = Frame24
										TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextLabel6.BackgroundTransparency = 1
										TextLabel6.Position = UDim2.new(0, 10, 0, 0)
										TextLabel6.Size = UDim2.new(1, -10, 0, 25)
										TextLabel6.Font = Enum.Font.GothamBlack
										TextLabel6.Text = text4
										TextLabel6.TextSize = 14
										TextLabel6.RichText = true
										TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
										TextLabel6.TextColor3 = t1.UIColor["Text Color"]
										Frame25.Name = "SliderBar"
										Frame25.Parent = Frame22
										Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
										Frame25.Size = UDim2.new(0, 400, 0, 6)
										Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										TextButton4.Name = "SliderButton "
										TextButton4.Parent = Frame25
										TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.BackgroundTransparency = 1
										TextButton4.Size = UDim2.new(1, 0, 1, 0)
										TextButton4.Font = Enum.Font.GothamBold
										TextButton4.Text = ""
										TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.TextSize = 14
										UICorner11.CornerRadius = UDim.new(1, 0)
										UICorner11.Name = "SliderBarCorner"
										UICorner11.Parent = Frame25
										Frame23.Name = "Bar"
										Frame23.BorderSizePixel = 0
										Frame23.Parent = Frame25
										Frame23.Size = UDim2.new(0, 0, 1, 0)
										Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
										UICorner12.CornerRadius = UDim.new(1, 0)
										UICorner12.Name = "BarCorner"
										UICorner12.Parent = Frame23
										Frame26.Name = "Background2"
										Frame26.Parent = Frame22
										Frame26.AnchorPoint = Vector2.new(1, 0)
										Frame26.Position = UDim2.new(1, -10, 0, 5)
										Frame26.Size = UDim2.new(0, 150, 0, 25)
										Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										UICorner13.CornerRadius = UDim.new(0, 4)
										UICorner13.Name = "Sliderbox"
										UICorner13.Parent = Frame26
										TextBox3.Name = "TextColor"
										TextBox3.Parent = Frame26
										TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextBox3.BackgroundTransparency = 1
										TextBox3.Size = UDim2.new(1, 0, 1, 0)
										TextBox3.Font = Enum.Font.GothamBold
										TextBox3.Text = ""
										TextBox3.TextSize = 14
										TextBox3.TextColor3 = t1.UIColor["Text Color"]
										TextButton4.MouseEnter:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
											}):Play()
										end)
										TextButton4.MouseLeave:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Line Color"]
											}):Play()
										end)
										v502 = function(p45)
											TextBox3.Text = p45
											v525(tonumber(p45))
										end

										if value then
											if value <= 0 then
												value = 0
											elseif v404 <= value then
												value = v404
											end

											Frame23.Size = UDim2.new(1 - (v404 - value) / (v404 - 0), 0, 0, 6)
											v502(value)
										end

										local u536 = false
										local u537
										local n14 = 0

										local function v539(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												n14 = tick()
												input.Changed:Connect(function()
													if input.UserInputState == Enum.UserInputState.End then
														u536 = false
														n14 = 0
													end
												end)
											end
										end
										local function v540(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												u536 = false
												n14 = 0
											end
										end
										local function v541(input)
											if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
												u537 = input
											end
										end

										TextButton4.InputBegan:Connect(v539)
										TextButton4.InputEnded:Connect(v540)
										TextButton4.InputChanged:Connect(v541)

										local RenderStepped = RunService.RenderStepped

										v503 = RenderStepped
										Connect = RenderStepped.Connect
										v505 = function()
											if n14 > 0 and tick() - n14 >= 0 and not u536 then
												u536 = true
											end

											if u536 and u537 then
												local v543 = nil and tonumber(string.format("%.1f", (tonumber(v404) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))) or math.floor((tonumber(v404) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))

												pcall(function()
													v502(v543)
												end)
												Frame23.Size = UDim2.new(0, math.clamp(u537.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
											end
										end
									end

									Connect(v503, v505)

									local function v544(p46)
										if tonumber(p46) <= nil then
											Frame23.Size = UDim2.new(0, 0, 0, 6)
											v502(nil)
										elseif v404 <= tonumber(p46) then
											Frame23.Size = UDim2.new(0, v404 / v404 * 400, 0, 6)
											v502(v404)
										else
											Frame23.Size = UDim2.new(1 - (v404 - p46) / (v404 - nil), 0, 0, 6)
											v502(p46)
										end
									end

									TextBox3.FocusLost:Connect(function()
										v544(TextBox3.Text)
									end)
									functionCreate = {
										SetValue = function(p47)
											v544(p47)
										end,
										GetValue = function()
											return tonumber(TextBox3.Text) or value
										end
									}
									t24 = {
										name = text4,
										type = "slider",
										min = 0,
										max = v404
									}
								else
									local Precise = p34.Precise
									local Frame23, TextBox3, v548, v549, Connect, v551

									if Precise then
										value = tonumber(p34.Default) or 0

										local v552 = p35 or function()
										end

										Frame22 = Instance.new("Frame")

										local UICorner9 = Instance.new("UICorner")
										local Frame24 = Instance.new("Frame")
										local UICorner10 = Instance.new("UICorner")
										local TextLabel6 = Instance.new("TextLabel")
										local Frame25 = Instance.new("Frame")
										local TextButton4 = Instance.new("TextButton")
										local UICorner11 = Instance.new("UICorner")

										Frame23 = Instance.new("Frame")

										local UICorner12 = Instance.new("UICorner")
										local Frame26 = Instance.new("Frame")
										local UICorner13 = Instance.new("UICorner")

										TextBox3 = Instance.new("TextBox")
										Frame22.Name = text4 .. "buda"
										Frame22.Parent = Frame19
										Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
										Frame22.BackgroundTransparency = 1
										Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
										Frame22.Size = UDim2.new(1, 0, 0, 50)
										UICorner9.CornerRadius = UDim.new(0, 4)
										UICorner9.Name = "SliderCorner"
										UICorner9.Parent = Frame22
										Frame24.Name = "Background1"
										Frame24.Parent = Frame22
										Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
										Frame24.Size = UDim2.new(1, -10, 1, 0)
										Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
										Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
										UICorner10.CornerRadius = UDim.new(0, 4)
										UICorner10.Name = "SliderBGCorner"
										UICorner10.Parent = Frame24
										TextLabel6.Name = "TextColor"
										TextLabel6.Parent = Frame24
										TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextLabel6.BackgroundTransparency = 1
										TextLabel6.Position = UDim2.new(0, 10, 0, 0)
										TextLabel6.Size = UDim2.new(1, -10, 0, 25)
										TextLabel6.Font = Enum.Font.GothamBlack
										TextLabel6.Text = text4
										TextLabel6.TextSize = 14
										TextLabel6.RichText = true
										TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
										TextLabel6.TextColor3 = t1.UIColor["Text Color"]
										Frame25.Name = "SliderBar"
										Frame25.Parent = Frame22
										Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
										Frame25.Size = UDim2.new(0, 400, 0, 6)
										Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										TextButton4.Name = "SliderButton "
										TextButton4.Parent = Frame25
										TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.BackgroundTransparency = 1
										TextButton4.Size = UDim2.new(1, 0, 1, 0)
										TextButton4.Font = Enum.Font.GothamBold
										TextButton4.Text = ""
										TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.TextSize = 14
										UICorner11.CornerRadius = UDim.new(1, 0)
										UICorner11.Name = "SliderBarCorner"
										UICorner11.Parent = Frame25
										Frame23.Name = "Bar"
										Frame23.BorderSizePixel = 0
										Frame23.Parent = Frame25
										Frame23.Size = UDim2.new(0, 0, 1, 0)
										Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
										UICorner12.CornerRadius = UDim.new(1, 0)
										UICorner12.Name = "BarCorner"
										UICorner12.Parent = Frame23
										Frame26.Name = "Background2"
										Frame26.Parent = Frame22
										Frame26.AnchorPoint = Vector2.new(1, 0)
										Frame26.Position = UDim2.new(1, -10, 0, 5)
										Frame26.Size = UDim2.new(0, 150, 0, 25)
										Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										UICorner13.CornerRadius = UDim.new(0, 4)
										UICorner13.Name = "Sliderbox"
										UICorner13.Parent = Frame26
										TextBox3.Name = "TextColor"
										TextBox3.Parent = Frame26
										TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextBox3.BackgroundTransparency = 1
										TextBox3.Size = UDim2.new(1, 0, 1, 0)
										TextBox3.Font = Enum.Font.GothamBold
										TextBox3.Text = ""
										TextBox3.TextSize = 14
										TextBox3.TextColor3 = t1.UIColor["Text Color"]
										TextButton4.MouseEnter:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
											}):Play()
										end)
										TextButton4.MouseLeave:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Line Color"]
											}):Play()
										end)
										v548 = function(p48)
											TextBox3.Text = p48
											v552(tonumber(p48))
										end

										if value then
											if value <= 0 then
												value = 0
											elseif value >= 100 then
												value = 100
											end

											Frame23.Size = UDim2.new(1 - (100 - value) / 100, 0, 0, 6)
											v548(value)
										end

										local u563 = false
										local u564
										local n15 = 0

										local function v566(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												n15 = tick()
												input.Changed:Connect(function()
													if input.UserInputState == Enum.UserInputState.End then
														u563 = false
														n15 = 0
													end
												end)
											end
										end
										local function v567(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												u563 = false
												n15 = 0
											end
										end
										local function v568(input)
											if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
												u564 = input
											end
										end

										TextButton4.InputBegan:Connect(v566)
										TextButton4.InputEnded:Connect(v567)
										TextButton4.InputChanged:Connect(v568)

										local RenderStepped = RunService.RenderStepped

										v549 = RenderStepped
										Connect = RenderStepped.Connect
										v551 = function()
											if n15 > 0 and tick() - n15 >= 0 and not u563 then
												u563 = true
											end

											if u563 and u564 then
												local v570 = Precise and tonumber(string.format("%.1f", (tonumber(nil) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))) or math.floor((tonumber(nil) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))

												pcall(function()
													v548(v570)
												end)
												Frame23.Size = UDim2.new(0, math.clamp(u564.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
											end
										end
									else
										value = tonumber(p34.Default) or 0

										local v571 = p35 or function()
										end

										Frame22 = Instance.new("Frame")

										local UICorner9 = Instance.new("UICorner")
										local Frame24 = Instance.new("Frame")
										local UICorner10 = Instance.new("UICorner")
										local TextLabel6 = Instance.new("TextLabel")
										local Frame25 = Instance.new("Frame")
										local TextButton4 = Instance.new("TextButton")
										local UICorner11 = Instance.new("UICorner")

										Frame23 = Instance.new("Frame")

										local UICorner12 = Instance.new("UICorner")
										local Frame26 = Instance.new("Frame")
										local UICorner13 = Instance.new("UICorner")

										TextBox3 = Instance.new("TextBox")
										Frame22.Name = text4 .. "buda"
										Frame22.Parent = Frame19
										Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
										Frame22.BackgroundTransparency = 1
										Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
										Frame22.Size = UDim2.new(1, 0, 0, 50)
										UICorner9.CornerRadius = UDim.new(0, 4)
										UICorner9.Name = "SliderCorner"
										UICorner9.Parent = Frame22
										Frame24.Name = "Background1"
										Frame24.Parent = Frame22
										Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
										Frame24.Size = UDim2.new(1, -10, 1, 0)
										Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
										Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
										UICorner10.CornerRadius = UDim.new(0, 4)
										UICorner10.Name = "SliderBGCorner"
										UICorner10.Parent = Frame24
										TextLabel6.Name = "TextColor"
										TextLabel6.Parent = Frame24
										TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextLabel6.BackgroundTransparency = 1
										TextLabel6.Position = UDim2.new(0, 10, 0, 0)
										TextLabel6.Size = UDim2.new(1, -10, 0, 25)
										TextLabel6.Font = Enum.Font.GothamBlack
										TextLabel6.Text = text4
										TextLabel6.TextSize = 14
										TextLabel6.RichText = true
										TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
										TextLabel6.TextColor3 = t1.UIColor["Text Color"]
										Frame25.Name = "SliderBar"
										Frame25.Parent = Frame22
										Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
										Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
										Frame25.Size = UDim2.new(0, 400, 0, 6)
										Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										TextButton4.Name = "SliderButton "
										TextButton4.Parent = Frame25
										TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.BackgroundTransparency = 1
										TextButton4.Size = UDim2.new(1, 0, 1, 0)
										TextButton4.Font = Enum.Font.GothamBold
										TextButton4.Text = ""
										TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
										TextButton4.TextSize = 14
										UICorner11.CornerRadius = UDim.new(1, 0)
										UICorner11.Name = "SliderBarCorner"
										UICorner11.Parent = Frame25
										Frame23.Name = "Bar"
										Frame23.BorderSizePixel = 0
										Frame23.Parent = Frame25
										Frame23.Size = UDim2.new(0, 0, 1, 0)
										Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
										UICorner12.CornerRadius = UDim.new(1, 0)
										UICorner12.Name = "BarCorner"
										UICorner12.Parent = Frame23
										Frame26.Name = "Background2"
										Frame26.Parent = Frame22
										Frame26.AnchorPoint = Vector2.new(1, 0)
										Frame26.Position = UDim2.new(1, -10, 0, 5)
										Frame26.Size = UDim2.new(0, 150, 0, 25)
										Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
										UICorner13.CornerRadius = UDim.new(0, 4)
										UICorner13.Name = "Sliderbox"
										UICorner13.Parent = Frame26
										TextBox3.Name = "TextColor"
										TextBox3.Parent = Frame26
										TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
										TextBox3.BackgroundTransparency = 1
										TextBox3.Size = UDim2.new(1, 0, 1, 0)
										TextBox3.Font = Enum.Font.GothamBold
										TextBox3.Text = ""
										TextBox3.TextSize = 14
										TextBox3.TextColor3 = t1.UIColor["Text Color"]
										TextButton4.MouseEnter:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
											}):Play()
										end)
										TextButton4.MouseLeave:Connect(function()
											TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
												BackgroundColor3 = t1.UIColor["Slider Line Color"]
											}):Play()
										end)
										v548 = function(p49)
											TextBox3.Text = p49
											v571(tonumber(p49))
										end

										if value then
											if value <= 0 then
												value = 0
											elseif value >= 100 then
												value = 100
											end

											Frame23.Size = UDim2.new(1 - (100 - value) / 100, 0, 0, 6)
											v548(value)
										end

										local u582 = false
										local u583
										local n16 = 0

										local function v585(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												n16 = tick()
												input.Changed:Connect(function()
													if input.UserInputState == Enum.UserInputState.End then
														u582 = false
														n16 = 0
													end
												end)
											end
										end
										local function v586(input)
											if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
												u582 = false
												n16 = 0
											end
										end
										local function v587(input)
											if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
												u583 = input
											end
										end

										TextButton4.InputBegan:Connect(v585)
										TextButton4.InputEnded:Connect(v586)
										TextButton4.InputChanged:Connect(v587)

										local RenderStepped = RunService.RenderStepped

										v549 = RenderStepped
										Connect = RenderStepped.Connect
										v551 = function()
											if n16 > 0 and tick() - n16 >= 0 and not u582 then
												u582 = true
											end

											if u582 and u583 then
												local v589 = nil and tonumber(string.format("%.1f", (tonumber(nil) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))) or math.floor((tonumber(nil) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))

												pcall(function()
													v548(v589)
												end)
												Frame23.Size = UDim2.new(0, math.clamp(u583.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
											end
										end
									end

									Connect(v549, v551)

									local function v590(p50)
										if tonumber(p50) <= nil then
											Frame23.Size = UDim2.new(0, 0, 0, 6)
											v548(nil)
										elseif nil <= tonumber(p50) then
											Frame23.Size = UDim2.new(0, nil / nil * 400, 0, 6)
											v548(nil)
										else
											Frame23.Size = UDim2.new(1 - (nil - p50) / (nil - nil), 0, 0, 6)
											v548(p50)
										end
									end

									TextBox3.FocusLost:Connect(function()
										v590(TextBox3.Text)
									end)
									functionCreate = {
										SetValue = function(p51)
											v590(p51)
										end,
										GetValue = function()
											return tonumber(TextBox3.Text) or value
										end
									}
									t24 = {
										name = text4,
										type = "slider",
										min = 0,
										max = 100
									}
								end
							end

							t24.step = p34.Step or 1
							t24.value = value
							t24.Page_Name = text
							t24.Section_Name = text3
							t24.FunctionCreate = functionCreate
							t3.Options[text4] = t24

							if type(getgenv().Options) == "table" then
								getgenv().Options[text4] = t24
							end

							insert = table.insert
							v401 = t1.listfunction[Frame19]
							t23 = {
								Type = "Slider",
								Name = text4,
								Call = function()
									Frame22.Visible = true
								end
							}
							insert(v401, t23)
							table.insert(t2[Frame19], Frame22)

							return functionCreate
						end

						local v591 = tonumber(p34.Min)
						local v592, value, t25, Step

						if v591 then
							v592 = tonumber(p34.Max)

							if v592 then
								local Precise = p34.Precise
								local Frame23, TextBox3, v599, v600, Connect, v602

								if Precise then
									value = tonumber(p34.Default) or 0

									local v603 = p35 or function()
									end

									Frame22 = Instance.new("Frame")

									local UICorner9 = Instance.new("UICorner")
									local Frame24 = Instance.new("Frame")
									local UICorner10 = Instance.new("UICorner")
									local TextLabel6 = Instance.new("TextLabel")
									local Frame25 = Instance.new("Frame")
									local TextButton4 = Instance.new("TextButton")
									local UICorner11 = Instance.new("UICorner")

									Frame23 = Instance.new("Frame")

									local UICorner12 = Instance.new("UICorner")
									local Frame26 = Instance.new("Frame")
									local UICorner13 = Instance.new("UICorner")

									TextBox3 = Instance.new("TextBox")
									Frame22.Name = "buda"
									Frame22.Parent = Frame19
									Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
									Frame22.BackgroundTransparency = 1
									Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
									Frame22.Size = UDim2.new(1, 0, 0, 50)
									UICorner9.CornerRadius = UDim.new(0, 4)
									UICorner9.Name = "SliderCorner"
									UICorner9.Parent = Frame22
									Frame24.Name = "Background1"
									Frame24.Parent = Frame22
									Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
									Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
									Frame24.Size = UDim2.new(1, -10, 1, 0)
									Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
									Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
									UICorner10.CornerRadius = UDim.new(0, 4)
									UICorner10.Name = "SliderBGCorner"
									UICorner10.Parent = Frame24
									TextLabel6.Name = "TextColor"
									TextLabel6.Parent = Frame24
									TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextLabel6.BackgroundTransparency = 1
									TextLabel6.Position = UDim2.new(0, 10, 0, 0)
									TextLabel6.Size = UDim2.new(1, -10, 0, 25)
									TextLabel6.Font = Enum.Font.GothamBlack
									TextLabel6.Text = ""
									TextLabel6.TextSize = 14
									TextLabel6.RichText = true
									TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
									TextLabel6.TextColor3 = t1.UIColor["Text Color"]
									Frame25.Name = "SliderBar"
									Frame25.Parent = Frame22
									Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
									Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
									Frame25.Size = UDim2.new(0, 400, 0, 6)
									Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
									TextButton4.Name = "SliderButton "
									TextButton4.Parent = Frame25
									TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextButton4.BackgroundTransparency = 1
									TextButton4.Size = UDim2.new(1, 0, 1, 0)
									TextButton4.Font = Enum.Font.GothamBold
									TextButton4.Text = ""
									TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
									TextButton4.TextSize = 14
									UICorner11.CornerRadius = UDim.new(1, 0)
									UICorner11.Name = "SliderBarCorner"
									UICorner11.Parent = Frame25
									Frame23.Name = "Bar"
									Frame23.BorderSizePixel = 0
									Frame23.Parent = Frame25
									Frame23.Size = UDim2.new(0, 0, 1, 0)
									Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
									UICorner12.CornerRadius = UDim.new(1, 0)
									UICorner12.Name = "BarCorner"
									UICorner12.Parent = Frame23
									Frame26.Name = "Background2"
									Frame26.Parent = Frame22
									Frame26.AnchorPoint = Vector2.new(1, 0)
									Frame26.Position = UDim2.new(1, -10, 0, 5)
									Frame26.Size = UDim2.new(0, 150, 0, 25)
									Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
									UICorner13.CornerRadius = UDim.new(0, 4)
									UICorner13.Name = "Sliderbox"
									UICorner13.Parent = Frame26
									TextBox3.Name = "TextColor"
									TextBox3.Parent = Frame26
									TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextBox3.BackgroundTransparency = 1
									TextBox3.Size = UDim2.new(1, 0, 1, 0)
									TextBox3.Font = Enum.Font.GothamBold
									TextBox3.Text = ""
									TextBox3.TextSize = 14
									TextBox3.TextColor3 = t1.UIColor["Text Color"]
									TextButton4.MouseEnter:Connect(function()
										TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
											BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
										}):Play()
									end)
									TextButton4.MouseLeave:Connect(function()
										TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
											BackgroundColor3 = t1.UIColor["Slider Line Color"]
										}):Play()
									end)
									v599 = function(p52)
										TextBox3.Text = p52
										v603(tonumber(p52))
									end

									if value then
										if value <= v591 then
											value = v591
										elseif v592 <= value then
											value = v592
										end

										Frame23.Size = UDim2.new(1 - (v592 - value) / (v592 - v591), 0, 0, 6)
										v599(value)
									end

									local u614 = false
									local u615
									local n17 = 0

									local function v617(input)
										if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
											n17 = tick()
											input.Changed:Connect(function()
												if input.UserInputState == Enum.UserInputState.End then
													u614 = false
													n17 = 0
												end
											end)
										end
									end
									local function v618(input)
										if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
											u614 = false
											n17 = 0
										end
									end
									local function v619(input)
										if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
											u615 = input
										end
									end

									TextButton4.InputBegan:Connect(v617)
									TextButton4.InputEnded:Connect(v618)
									TextButton4.InputChanged:Connect(v619)

									local RenderStepped = RunService.RenderStepped

									v600 = RenderStepped
									Connect = RenderStepped.Connect
									v602 = function()
										if n17 > 0 and tick() - n17 >= 0 and not u614 then
											u614 = true
										end

										if u614 and u615 then
											local v621 = Precise and tonumber(string.format("%.1f", (tonumber(v592) - tonumber(v591)) / 400 * Frame23.AbsoluteSize.X + tonumber(v591))) or math.floor((tonumber(v592) - tonumber(v591)) / 400 * Frame23.AbsoluteSize.X + tonumber(v591))

											pcall(function()
												v599(v621)
											end)
											Frame23.Size = UDim2.new(0, math.clamp(u615.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
										end
									end
								else
									value = tonumber(p34.Default) or 0

									local v622 = p35 or function()
									end

									Frame22 = Instance.new("Frame")

									local UICorner9 = Instance.new("UICorner")
									local Frame24 = Instance.new("Frame")
									local UICorner10 = Instance.new("UICorner")
									local TextLabel6 = Instance.new("TextLabel")
									local Frame25 = Instance.new("Frame")
									local TextButton4 = Instance.new("TextButton")
									local UICorner11 = Instance.new("UICorner")

									Frame23 = Instance.new("Frame")

									local UICorner12 = Instance.new("UICorner")
									local Frame26 = Instance.new("Frame")
									local UICorner13 = Instance.new("UICorner")

									TextBox3 = Instance.new("TextBox")
									Frame22.Name = "buda"
									Frame22.Parent = Frame19
									Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
									Frame22.BackgroundTransparency = 1
									Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
									Frame22.Size = UDim2.new(1, 0, 0, 50)
									UICorner9.CornerRadius = UDim.new(0, 4)
									UICorner9.Name = "SliderCorner"
									UICorner9.Parent = Frame22
									Frame24.Name = "Background1"
									Frame24.Parent = Frame22
									Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
									Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
									Frame24.Size = UDim2.new(1, -10, 1, 0)
									Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
									Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
									UICorner10.CornerRadius = UDim.new(0, 4)
									UICorner10.Name = "SliderBGCorner"
									UICorner10.Parent = Frame24
									TextLabel6.Name = "TextColor"
									TextLabel6.Parent = Frame24
									TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextLabel6.BackgroundTransparency = 1
									TextLabel6.Position = UDim2.new(0, 10, 0, 0)
									TextLabel6.Size = UDim2.new(1, -10, 0, 25)
									TextLabel6.Font = Enum.Font.GothamBlack
									TextLabel6.Text = ""
									TextLabel6.TextSize = 14
									TextLabel6.RichText = true
									TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
									TextLabel6.TextColor3 = t1.UIColor["Text Color"]
									Frame25.Name = "SliderBar"
									Frame25.Parent = Frame22
									Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
									Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
									Frame25.Size = UDim2.new(0, 400, 0, 6)
									Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
									TextButton4.Name = "SliderButton "
									TextButton4.Parent = Frame25
									TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextButton4.BackgroundTransparency = 1
									TextButton4.Size = UDim2.new(1, 0, 1, 0)
									TextButton4.Font = Enum.Font.GothamBold
									TextButton4.Text = ""
									TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
									TextButton4.TextSize = 14
									UICorner11.CornerRadius = UDim.new(1, 0)
									UICorner11.Name = "SliderBarCorner"
									UICorner11.Parent = Frame25
									Frame23.Name = "Bar"
									Frame23.BorderSizePixel = 0
									Frame23.Parent = Frame25
									Frame23.Size = UDim2.new(0, 0, 1, 0)
									Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
									UICorner12.CornerRadius = UDim.new(1, 0)
									UICorner12.Name = "BarCorner"
									UICorner12.Parent = Frame23
									Frame26.Name = "Background2"
									Frame26.Parent = Frame22
									Frame26.AnchorPoint = Vector2.new(1, 0)
									Frame26.Position = UDim2.new(1, -10, 0, 5)
									Frame26.Size = UDim2.new(0, 150, 0, 25)
									Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
									UICorner13.CornerRadius = UDim.new(0, 4)
									UICorner13.Name = "Sliderbox"
									UICorner13.Parent = Frame26
									TextBox3.Name = "TextColor"
									TextBox3.Parent = Frame26
									TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextBox3.BackgroundTransparency = 1
									TextBox3.Size = UDim2.new(1, 0, 1, 0)
									TextBox3.Font = Enum.Font.GothamBold
									TextBox3.Text = ""
									TextBox3.TextSize = 14
									TextBox3.TextColor3 = t1.UIColor["Text Color"]
									TextButton4.MouseEnter:Connect(function()
										TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
											BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
										}):Play()
									end)
									TextButton4.MouseLeave:Connect(function()
										TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
											BackgroundColor3 = t1.UIColor["Slider Line Color"]
										}):Play()
									end)
									v599 = function(p53)
										TextBox3.Text = p53
										v622(tonumber(p53))
									end

									if value then
										if value <= v591 then
											value = v591
										elseif v592 <= value then
											value = v592
										end

										Frame23.Size = UDim2.new(1 - (v592 - value) / (v592 - v591), 0, 0, 6)
										v599(value)
									end

									local u633 = false
									local u634
									local n18 = 0

									local function v636(input)
										if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
											n18 = tick()
											input.Changed:Connect(function()
												if input.UserInputState == Enum.UserInputState.End then
													u633 = false
													n18 = 0
												end
											end)
										end
									end
									local function v637(input)
										if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
											u633 = false
											n18 = 0
										end
									end
									local function v638(input)
										if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
											u634 = input
										end
									end

									TextButton4.InputBegan:Connect(v636)
									TextButton4.InputEnded:Connect(v637)
									TextButton4.InputChanged:Connect(v638)

									local RenderStepped = RunService.RenderStepped

									v600 = RenderStepped
									Connect = RenderStepped.Connect
									v602 = function()
										if n18 > 0 and tick() - n18 >= 0 and not u633 then
											u633 = true
										end

										if u633 and u634 then
											local v640 = nil and tonumber(string.format("%.1f", (tonumber(v592) - tonumber(v591)) / 400 * Frame23.AbsoluteSize.X + tonumber(v591))) or math.floor((tonumber(v592) - tonumber(v591)) / 400 * Frame23.AbsoluteSize.X + tonumber(v591))

											pcall(function()
												v599(v640)
											end)
											Frame23.Size = UDim2.new(0, math.clamp(u634.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
										end
									end
								end

								Connect(v600, v602)

								local function v641(p54)
									if tonumber(p54) <= v591 then
										Frame23.Size = UDim2.new(0, 0, 0, 6)
										v599(v591)
									elseif v592 <= tonumber(p54) then
										Frame23.Size = UDim2.new(0, v592 / v592 * 400, 0, 6)
										v599(v592)
									else
										Frame23.Size = UDim2.new(1 - (v592 - p54) / (v592 - v591), 0, 0, 6)
										v599(p54)
									end
								end

								TextBox3.FocusLost:Connect(function()
									v641(TextBox3.Text)
								end)
								functionCreate = {
									SetValue = function(p55)
										v641(p55)
									end,
									GetValue = function()
										return tonumber(TextBox3.Text) or value
									end
								}
								t25 = {
									name = "",
									type = "slider",
									min = v591,
									max = v592
								}
								Step = p34.Step or 1
								t25.step = Step
								t25.value = value
								t25.Page_Name = text
								t25.Section_Name = text3
								t25.FunctionCreate = functionCreate
								t3.Options[""] = t25

								if type(getgenv().Options) == "table" then
									getgenv().Options[""] = t25
								end

								insert = table.insert
								v401 = t1.listfunction[Frame19]
								t23 = {
									Type = "Slider",
									Name = ""
								}
							else
								local Precise = p34.Precise
								local Frame23, TextBox3, v645, v646, Connect, v648

								if Precise then
									value = tonumber(p34.Default) or 0

									local v649 = p35 or function()
									end

									Frame22 = Instance.new("Frame")

									local UICorner9 = Instance.new("UICorner")
									local Frame24 = Instance.new("Frame")
									local UICorner10 = Instance.new("UICorner")
									local TextLabel6 = Instance.new("TextLabel")
									local Frame25 = Instance.new("Frame")
									local TextButton4 = Instance.new("TextButton")
									local UICorner11 = Instance.new("UICorner")

									Frame23 = Instance.new("Frame")

									local UICorner12 = Instance.new("UICorner")
									local Frame26 = Instance.new("Frame")
									local UICorner13 = Instance.new("UICorner")

									TextBox3 = Instance.new("TextBox")
									Frame22.Name = "buda"
									Frame22.Parent = Frame19
									Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
									Frame22.BackgroundTransparency = 1
									Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
									Frame22.Size = UDim2.new(1, 0, 0, 50)
									UICorner9.CornerRadius = UDim.new(0, 4)
									UICorner9.Name = "SliderCorner"
									UICorner9.Parent = Frame22
									Frame24.Name = "Background1"
									Frame24.Parent = Frame22
									Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
									Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
									Frame24.Size = UDim2.new(1, -10, 1, 0)
									Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
									Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
									UICorner10.CornerRadius = UDim.new(0, 4)
									UICorner10.Name = "SliderBGCorner"
									UICorner10.Parent = Frame24
									TextLabel6.Name = "TextColor"
									TextLabel6.Parent = Frame24
									TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextLabel6.BackgroundTransparency = 1
									TextLabel6.Position = UDim2.new(0, 10, 0, 0)
									TextLabel6.Size = UDim2.new(1, -10, 0, 25)
									TextLabel6.Font = Enum.Font.GothamBlack
									TextLabel6.Text = ""
									TextLabel6.TextSize = 14
									TextLabel6.RichText = true
									TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
									TextLabel6.TextColor3 = t1.UIColor["Text Color"]
									Frame25.Name = "SliderBar"
									Frame25.Parent = Frame22
									Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
									Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
									Frame25.Size = UDim2.new(0, 400, 0, 6)
									Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
									TextButton4.Name = "SliderButton "
									TextButton4.Parent = Frame25
									TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextButton4.BackgroundTransparency = 1
									TextButton4.Size = UDim2.new(1, 0, 1, 0)
									TextButton4.Font = Enum.Font.GothamBold
									TextButton4.Text = ""
									TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
									TextButton4.TextSize = 14
									UICorner11.CornerRadius = UDim.new(1, 0)
									UICorner11.Name = "SliderBarCorner"
									UICorner11.Parent = Frame25
									Frame23.Name = "Bar"
									Frame23.BorderSizePixel = 0
									Frame23.Parent = Frame25
									Frame23.Size = UDim2.new(0, 0, 1, 0)
									Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
									UICorner12.CornerRadius = UDim.new(1, 0)
									UICorner12.Name = "BarCorner"
									UICorner12.Parent = Frame23
									Frame26.Name = "Background2"
									Frame26.Parent = Frame22
									Frame26.AnchorPoint = Vector2.new(1, 0)
									Frame26.Position = UDim2.new(1, -10, 0, 5)
									Frame26.Size = UDim2.new(0, 150, 0, 25)
									Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
									UICorner13.CornerRadius = UDim.new(0, 4)
									UICorner13.Name = "Sliderbox"
									UICorner13.Parent = Frame26
									TextBox3.Name = "TextColor"
									TextBox3.Parent = Frame26
									TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextBox3.BackgroundTransparency = 1
									TextBox3.Size = UDim2.new(1, 0, 1, 0)
									TextBox3.Font = Enum.Font.GothamBold
									TextBox3.Text = ""
									TextBox3.TextSize = 14
									TextBox3.TextColor3 = t1.UIColor["Text Color"]
									TextButton4.MouseEnter:Connect(function()
										TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
											BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
										}):Play()
									end)
									TextButton4.MouseLeave:Connect(function()
										TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
											BackgroundColor3 = t1.UIColor["Slider Line Color"]
										}):Play()
									end)
									v645 = function(p56)
										TextBox3.Text = p56
										v649(tonumber(p56))
									end

									if value then
										if value <= v591 then
											value = v591
										elseif value >= 100 then
											value = 100
										end

										Frame23.Size = UDim2.new(1 - (100 - value) / (100 - v591), 0, 0, 6)
										v645(value)
									end

									local u660 = false
									local u661
									local n19 = 0

									local function v663(input)
										if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
											n19 = tick()
											input.Changed:Connect(function()
												if input.UserInputState == Enum.UserInputState.End then
													u660 = false
													n19 = 0
												end
											end)
										end
									end
									local function v664(input)
										if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
											u660 = false
											n19 = 0
										end
									end
									local function v665(input)
										if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
											u661 = input
										end
									end

									TextButton4.InputBegan:Connect(v663)
									TextButton4.InputEnded:Connect(v664)
									TextButton4.InputChanged:Connect(v665)

									local RenderStepped = RunService.RenderStepped

									v646 = RenderStepped
									Connect = RenderStepped.Connect
									v648 = function()
										if n19 > 0 and tick() - n19 >= 0 and not u660 then
											u660 = true
										end

										if u660 and u661 then
											local v667 = Precise and tonumber(string.format("%.1f", (tonumber(nil) - tonumber(v591)) / 400 * Frame23.AbsoluteSize.X + tonumber(v591))) or math.floor((tonumber(nil) - tonumber(v591)) / 400 * Frame23.AbsoluteSize.X + tonumber(v591))

											pcall(function()
												v645(v667)
											end)
											Frame23.Size = UDim2.new(0, math.clamp(u661.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
										end
									end
								else
									value = tonumber(p34.Default) or 0

									local v668 = p35 or function()
									end

									Frame22 = Instance.new("Frame")

									local UICorner9 = Instance.new("UICorner")
									local Frame24 = Instance.new("Frame")
									local UICorner10 = Instance.new("UICorner")
									local TextLabel6 = Instance.new("TextLabel")
									local Frame25 = Instance.new("Frame")
									local TextButton4 = Instance.new("TextButton")
									local UICorner11 = Instance.new("UICorner")

									Frame23 = Instance.new("Frame")

									local UICorner12 = Instance.new("UICorner")
									local Frame26 = Instance.new("Frame")
									local UICorner13 = Instance.new("UICorner")

									TextBox3 = Instance.new("TextBox")
									Frame22.Name = "buda"
									Frame22.Parent = Frame19
									Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
									Frame22.BackgroundTransparency = 1
									Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
									Frame22.Size = UDim2.new(1, 0, 0, 50)
									UICorner9.CornerRadius = UDim.new(0, 4)
									UICorner9.Name = "SliderCorner"
									UICorner9.Parent = Frame22
									Frame24.Name = "Background1"
									Frame24.Parent = Frame22
									Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
									Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
									Frame24.Size = UDim2.new(1, -10, 1, 0)
									Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
									Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
									UICorner10.CornerRadius = UDim.new(0, 4)
									UICorner10.Name = "SliderBGCorner"
									UICorner10.Parent = Frame24
									TextLabel6.Name = "TextColor"
									TextLabel6.Parent = Frame24
									TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextLabel6.BackgroundTransparency = 1
									TextLabel6.Position = UDim2.new(0, 10, 0, 0)
									TextLabel6.Size = UDim2.new(1, -10, 0, 25)
									TextLabel6.Font = Enum.Font.GothamBlack
									TextLabel6.Text = ""
									TextLabel6.TextSize = 14
									TextLabel6.RichText = true
									TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
									TextLabel6.TextColor3 = t1.UIColor["Text Color"]
									Frame25.Name = "SliderBar"
									Frame25.Parent = Frame22
									Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
									Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
									Frame25.Size = UDim2.new(0, 400, 0, 6)
									Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
									TextButton4.Name = "SliderButton "
									TextButton4.Parent = Frame25
									TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextButton4.BackgroundTransparency = 1
									TextButton4.Size = UDim2.new(1, 0, 1, 0)
									TextButton4.Font = Enum.Font.GothamBold
									TextButton4.Text = ""
									TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
									TextButton4.TextSize = 14
									UICorner11.CornerRadius = UDim.new(1, 0)
									UICorner11.Name = "SliderBarCorner"
									UICorner11.Parent = Frame25
									Frame23.Name = "Bar"
									Frame23.BorderSizePixel = 0
									Frame23.Parent = Frame25
									Frame23.Size = UDim2.new(0, 0, 1, 0)
									Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
									UICorner12.CornerRadius = UDim.new(1, 0)
									UICorner12.Name = "BarCorner"
									UICorner12.Parent = Frame23
									Frame26.Name = "Background2"
									Frame26.Parent = Frame22
									Frame26.AnchorPoint = Vector2.new(1, 0)
									Frame26.Position = UDim2.new(1, -10, 0, 5)
									Frame26.Size = UDim2.new(0, 150, 0, 25)
									Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
									UICorner13.CornerRadius = UDim.new(0, 4)
									UICorner13.Name = "Sliderbox"
									UICorner13.Parent = Frame26
									TextBox3.Name = "TextColor"
									TextBox3.Parent = Frame26
									TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
									TextBox3.BackgroundTransparency = 1
									TextBox3.Size = UDim2.new(1, 0, 1, 0)
									TextBox3.Font = Enum.Font.GothamBold
									TextBox3.Text = ""
									TextBox3.TextSize = 14
									TextBox3.TextColor3 = t1.UIColor["Text Color"]
									TextButton4.MouseEnter:Connect(function()
										TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
											BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
										}):Play()
									end)
									TextButton4.MouseLeave:Connect(function()
										TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
											BackgroundColor3 = t1.UIColor["Slider Line Color"]
										}):Play()
									end)
									v645 = function(p57)
										TextBox3.Text = p57
										v668(tonumber(p57))
									end

									if value then
										if value <= v591 then
											value = v591
										elseif value >= 100 then
											value = 100
										end

										Frame23.Size = UDim2.new(1 - (100 - value) / (100 - v591), 0, 0, 6)
										v645(value)
									end

									local u679 = false
									local u680
									local n20 = 0

									local function v682(input)
										if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
											n20 = tick()
											input.Changed:Connect(function()
												if input.UserInputState == Enum.UserInputState.End then
													u679 = false
													n20 = 0
												end
											end)
										end
									end
									local function v683(input)
										if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
											u679 = false
											n20 = 0
										end
									end
									local function v684(input)
										if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
											u680 = input
										end
									end

									TextButton4.InputBegan:Connect(v682)
									TextButton4.InputEnded:Connect(v683)
									TextButton4.InputChanged:Connect(v684)

									local RenderStepped = RunService.RenderStepped

									v646 = RenderStepped
									Connect = RenderStepped.Connect
									v648 = function()
										if n20 > 0 and tick() - n20 >= 0 and not u679 then
											u679 = true
										end

										if u679 and u680 then
											local v686 = nil and tonumber(string.format("%.1f", (tonumber(nil) - tonumber(v591)) / 400 * Frame23.AbsoluteSize.X + tonumber(v591))) or math.floor((tonumber(nil) - tonumber(v591)) / 400 * Frame23.AbsoluteSize.X + tonumber(v591))

											pcall(function()
												v645(v686)
											end)
											Frame23.Size = UDim2.new(0, math.clamp(u680.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
										end
									end
								end

								Connect(v646, v648)

								local function v687(p58)
									if tonumber(p58) <= v591 then
										Frame23.Size = UDim2.new(0, 0, 0, 6)
										v645(v591)
									elseif nil <= tonumber(p58) then
										Frame23.Size = UDim2.new(0, nil / nil * 400, 0, 6)
										v645(nil)
									else
										Frame23.Size = UDim2.new(1 - (nil - p58) / (nil - v591), 0, 0, 6)
										v645(p58)
									end
								end

								TextBox3.FocusLost:Connect(function()
									v687(TextBox3.Text)
								end)
								functionCreate = {
									SetValue = function(p59)
										v687(p59)
									end,
									GetValue = function()
										return tonumber(TextBox3.Text) or value
									end
								}
								t25 = {
									name = "",
									type = "slider",
									min = v591,
									max = 100
								}
								Step = p34.Step or 1
								t25.step = Step
								t25.value = value
								t25.Page_Name = text
								t25.Section_Name = text3
								t25.FunctionCreate = functionCreate
								t3.Options[""] = t25

								if type(getgenv().Options) == "table" then
									getgenv().Options[""] = t25
								end

								insert = table.insert
								v401 = t1.listfunction[Frame19]
								t23 = {
									Type = "Slider",
									Name = ""
								}
							end

							t23.Call = function()
								Frame22.Visible = true
							end
							insert(v401, t23)
							table.insert(t2[Frame19], Frame22)

							return functionCreate
						end

						v592 = tonumber(p34.Max)

						if v592 then
							local Precise = p34.Precise
							local Frame23, TextBox3, v691, v692, Connect, v694

							if Precise then
								value = tonumber(p34.Default) or 0

								local v695 = p35 or function()
								end

								Frame22 = Instance.new("Frame")

								local UICorner9 = Instance.new("UICorner")
								local Frame24 = Instance.new("Frame")
								local UICorner10 = Instance.new("UICorner")
								local TextLabel6 = Instance.new("TextLabel")
								local Frame25 = Instance.new("Frame")
								local TextButton4 = Instance.new("TextButton")
								local UICorner11 = Instance.new("UICorner")

								Frame23 = Instance.new("Frame")

								local UICorner12 = Instance.new("UICorner")
								local Frame26 = Instance.new("Frame")
								local UICorner13 = Instance.new("UICorner")

								TextBox3 = Instance.new("TextBox")
								Frame22.Name = "buda"
								Frame22.Parent = Frame19
								Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
								Frame22.BackgroundTransparency = 1
								Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
								Frame22.Size = UDim2.new(1, 0, 0, 50)
								UICorner9.CornerRadius = UDim.new(0, 4)
								UICorner9.Name = "SliderCorner"
								UICorner9.Parent = Frame22
								Frame24.Name = "Background1"
								Frame24.Parent = Frame22
								Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
								Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
								Frame24.Size = UDim2.new(1, -10, 1, 0)
								Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
								Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
								UICorner10.CornerRadius = UDim.new(0, 4)
								UICorner10.Name = "SliderBGCorner"
								UICorner10.Parent = Frame24
								TextLabel6.Name = "TextColor"
								TextLabel6.Parent = Frame24
								TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
								TextLabel6.BackgroundTransparency = 1
								TextLabel6.Position = UDim2.new(0, 10, 0, 0)
								TextLabel6.Size = UDim2.new(1, -10, 0, 25)
								TextLabel6.Font = Enum.Font.GothamBlack
								TextLabel6.Text = ""
								TextLabel6.TextSize = 14
								TextLabel6.RichText = true
								TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
								TextLabel6.TextColor3 = t1.UIColor["Text Color"]
								Frame25.Name = "SliderBar"
								Frame25.Parent = Frame22
								Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
								Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
								Frame25.Size = UDim2.new(0, 400, 0, 6)
								Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
								TextButton4.Name = "SliderButton "
								TextButton4.Parent = Frame25
								TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
								TextButton4.BackgroundTransparency = 1
								TextButton4.Size = UDim2.new(1, 0, 1, 0)
								TextButton4.Font = Enum.Font.GothamBold
								TextButton4.Text = ""
								TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
								TextButton4.TextSize = 14
								UICorner11.CornerRadius = UDim.new(1, 0)
								UICorner11.Name = "SliderBarCorner"
								UICorner11.Parent = Frame25
								Frame23.Name = "Bar"
								Frame23.BorderSizePixel = 0
								Frame23.Parent = Frame25
								Frame23.Size = UDim2.new(0, 0, 1, 0)
								Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
								UICorner12.CornerRadius = UDim.new(1, 0)
								UICorner12.Name = "BarCorner"
								UICorner12.Parent = Frame23
								Frame26.Name = "Background2"
								Frame26.Parent = Frame22
								Frame26.AnchorPoint = Vector2.new(1, 0)
								Frame26.Position = UDim2.new(1, -10, 0, 5)
								Frame26.Size = UDim2.new(0, 150, 0, 25)
								Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
								UICorner13.CornerRadius = UDim.new(0, 4)
								UICorner13.Name = "Sliderbox"
								UICorner13.Parent = Frame26
								TextBox3.Name = "TextColor"
								TextBox3.Parent = Frame26
								TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
								TextBox3.BackgroundTransparency = 1
								TextBox3.Size = UDim2.new(1, 0, 1, 0)
								TextBox3.Font = Enum.Font.GothamBold
								TextBox3.Text = ""
								TextBox3.TextSize = 14
								TextBox3.TextColor3 = t1.UIColor["Text Color"]
								TextButton4.MouseEnter:Connect(function()
									TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
										BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
									}):Play()
								end)
								TextButton4.MouseLeave:Connect(function()
									TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
										BackgroundColor3 = t1.UIColor["Slider Line Color"]
									}):Play()
								end)
								v691 = function(p60)
									TextBox3.Text = p60
									v695(tonumber(p60))
								end

								if value then
									if value <= 0 then
										value = 0
									elseif v592 <= value then
										value = v592
									end

									Frame23.Size = UDim2.new(1 - (v592 - value) / (v592 - 0), 0, 0, 6)
									v691(value)
								end

								local u706 = false
								local u707
								local n21 = 0

								local function v709(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										n21 = tick()
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												u706 = false
												n21 = 0
											end
										end)
									end
								end
								local function v710(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										u706 = false
										n21 = 0
									end
								end
								local function v711(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										u707 = input
									end
								end

								TextButton4.InputBegan:Connect(v709)
								TextButton4.InputEnded:Connect(v710)
								TextButton4.InputChanged:Connect(v711)

								local RenderStepped = RunService.RenderStepped

								v692 = RenderStepped
								Connect = RenderStepped.Connect
								v694 = function()
									if n21 > 0 and tick() - n21 >= 0 and not u706 then
										u706 = true
									end

									if u706 and u707 then
										local v713 = Precise and tonumber(string.format("%.1f", (tonumber(v592) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))) or math.floor((tonumber(v592) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))

										pcall(function()
											v691(v713)
										end)
										Frame23.Size = UDim2.new(0, math.clamp(u707.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
									end
								end
							else
								value = tonumber(p34.Default) or 0

								local v714 = p35 or function()
								end

								Frame22 = Instance.new("Frame")

								local UICorner9 = Instance.new("UICorner")
								local Frame24 = Instance.new("Frame")
								local UICorner10 = Instance.new("UICorner")
								local TextLabel6 = Instance.new("TextLabel")
								local Frame25 = Instance.new("Frame")
								local TextButton4 = Instance.new("TextButton")
								local UICorner11 = Instance.new("UICorner")

								Frame23 = Instance.new("Frame")

								local UICorner12 = Instance.new("UICorner")
								local Frame26 = Instance.new("Frame")
								local UICorner13 = Instance.new("UICorner")

								TextBox3 = Instance.new("TextBox")
								Frame22.Name = "buda"
								Frame22.Parent = Frame19
								Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
								Frame22.BackgroundTransparency = 1
								Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
								Frame22.Size = UDim2.new(1, 0, 0, 50)
								UICorner9.CornerRadius = UDim.new(0, 4)
								UICorner9.Name = "SliderCorner"
								UICorner9.Parent = Frame22
								Frame24.Name = "Background1"
								Frame24.Parent = Frame22
								Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
								Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
								Frame24.Size = UDim2.new(1, -10, 1, 0)
								Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
								Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
								UICorner10.CornerRadius = UDim.new(0, 4)
								UICorner10.Name = "SliderBGCorner"
								UICorner10.Parent = Frame24
								TextLabel6.Name = "TextColor"
								TextLabel6.Parent = Frame24
								TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
								TextLabel6.BackgroundTransparency = 1
								TextLabel6.Position = UDim2.new(0, 10, 0, 0)
								TextLabel6.Size = UDim2.new(1, -10, 0, 25)
								TextLabel6.Font = Enum.Font.GothamBlack
								TextLabel6.Text = ""
								TextLabel6.TextSize = 14
								TextLabel6.RichText = true
								TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
								TextLabel6.TextColor3 = t1.UIColor["Text Color"]
								Frame25.Name = "SliderBar"
								Frame25.Parent = Frame22
								Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
								Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
								Frame25.Size = UDim2.new(0, 400, 0, 6)
								Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
								TextButton4.Name = "SliderButton "
								TextButton4.Parent = Frame25
								TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
								TextButton4.BackgroundTransparency = 1
								TextButton4.Size = UDim2.new(1, 0, 1, 0)
								TextButton4.Font = Enum.Font.GothamBold
								TextButton4.Text = ""
								TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
								TextButton4.TextSize = 14
								UICorner11.CornerRadius = UDim.new(1, 0)
								UICorner11.Name = "SliderBarCorner"
								UICorner11.Parent = Frame25
								Frame23.Name = "Bar"
								Frame23.BorderSizePixel = 0
								Frame23.Parent = Frame25
								Frame23.Size = UDim2.new(0, 0, 1, 0)
								Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
								UICorner12.CornerRadius = UDim.new(1, 0)
								UICorner12.Name = "BarCorner"
								UICorner12.Parent = Frame23
								Frame26.Name = "Background2"
								Frame26.Parent = Frame22
								Frame26.AnchorPoint = Vector2.new(1, 0)
								Frame26.Position = UDim2.new(1, -10, 0, 5)
								Frame26.Size = UDim2.new(0, 150, 0, 25)
								Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
								UICorner13.CornerRadius = UDim.new(0, 4)
								UICorner13.Name = "Sliderbox"
								UICorner13.Parent = Frame26
								TextBox3.Name = "TextColor"
								TextBox3.Parent = Frame26
								TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
								TextBox3.BackgroundTransparency = 1
								TextBox3.Size = UDim2.new(1, 0, 1, 0)
								TextBox3.Font = Enum.Font.GothamBold
								TextBox3.Text = ""
								TextBox3.TextSize = 14
								TextBox3.TextColor3 = t1.UIColor["Text Color"]
								TextButton4.MouseEnter:Connect(function()
									TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
										BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
									}):Play()
								end)
								TextButton4.MouseLeave:Connect(function()
									TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
										BackgroundColor3 = t1.UIColor["Slider Line Color"]
									}):Play()
								end)
								v691 = function(p61)
									TextBox3.Text = p61
									v714(tonumber(p61))
								end

								if value then
									if value <= 0 then
										value = 0
									elseif v592 <= value then
										value = v592
									end

									Frame23.Size = UDim2.new(1 - (v592 - value) / (v592 - 0), 0, 0, 6)
									v691(value)
								end

								local u725 = false
								local u726
								local n22 = 0

								local function v728(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										n22 = tick()
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												u725 = false
												n22 = 0
											end
										end)
									end
								end
								local function v729(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										u725 = false
										n22 = 0
									end
								end
								local function v730(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										u726 = input
									end
								end

								TextButton4.InputBegan:Connect(v728)
								TextButton4.InputEnded:Connect(v729)
								TextButton4.InputChanged:Connect(v730)

								local RenderStepped = RunService.RenderStepped

								v692 = RenderStepped
								Connect = RenderStepped.Connect
								v694 = function()
									if n22 > 0 and tick() - n22 >= 0 and not u725 then
										u725 = true
									end

									if u725 and u726 then
										local v732 = nil and tonumber(string.format("%.1f", (tonumber(v592) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))) or math.floor((tonumber(v592) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))

										pcall(function()
											v691(v732)
										end)
										Frame23.Size = UDim2.new(0, math.clamp(u726.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
									end
								end
							end

							Connect(v692, v694)

							local function v733(p62)
								if tonumber(p62) <= nil then
									Frame23.Size = UDim2.new(0, 0, 0, 6)
									v691(nil)
								elseif v592 <= tonumber(p62) then
									Frame23.Size = UDim2.new(0, v592 / v592 * 400, 0, 6)
									v691(v592)
								else
									Frame23.Size = UDim2.new(1 - (v592 - p62) / (v592 - nil), 0, 0, 6)
									v691(p62)
								end
							end

							TextBox3.FocusLost:Connect(function()
								v733(TextBox3.Text)
							end)
							functionCreate = {
								SetValue = function(p63)
									v733(p63)
								end,
								GetValue = function()
									return tonumber(TextBox3.Text) or value
								end
							}
							t25 = {
								name = "",
								type = "slider",
								min = 0,
								max = v592
							}
							Step = p34.Step or 1
							t25.step = Step
							t25.value = value
							t25.Page_Name = text
							t25.Section_Name = text3
							t25.FunctionCreate = functionCreate
							t3.Options[""] = t25

							if type(getgenv().Options) == "table" then
								getgenv().Options[""] = t25
							end

							insert = table.insert
							v401 = t1.listfunction[Frame19]
							t23 = {
								Type = "Slider",
								Name = "",
								Call = function()
									Frame22.Visible = true
								end
							}
							insert(v401, t23)
							table.insert(t2[Frame19], Frame22)

							return functionCreate
						end

						local Precise = p34.Precise
						local Frame23, TextBox3, v737, v738, Connect, v740, v741

						if Precise then
							value = tonumber(p34.Default) or 0

							local v742 = p35 or function()
							end

							Frame22 = Instance.new("Frame")

							local UICorner9 = Instance.new("UICorner")
							local Frame24 = Instance.new("Frame")
							local UICorner10 = Instance.new("UICorner")
							local TextLabel6 = Instance.new("TextLabel")
							local Frame25 = Instance.new("Frame")
							local TextButton4 = Instance.new("TextButton")
							local UICorner11 = Instance.new("UICorner")

							Frame23 = Instance.new("Frame")

							local UICorner12 = Instance.new("UICorner")
							local Frame26 = Instance.new("Frame")
							local UICorner13 = Instance.new("UICorner")

							TextBox3 = Instance.new("TextBox")
							Frame22.Name = "buda"
							Frame22.Parent = Frame19
							Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							Frame22.BackgroundTransparency = 1
							Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
							Frame22.Size = UDim2.new(1, 0, 0, 50)
							UICorner9.CornerRadius = UDim.new(0, 4)
							UICorner9.Name = "SliderCorner"
							UICorner9.Parent = Frame22
							Frame24.Name = "Background1"
							Frame24.Parent = Frame22
							Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
							Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
							Frame24.Size = UDim2.new(1, -10, 1, 0)
							Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
							Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
							UICorner10.CornerRadius = UDim.new(0, 4)
							UICorner10.Name = "SliderBGCorner"
							UICorner10.Parent = Frame24
							TextLabel6.Name = "TextColor"
							TextLabel6.Parent = Frame24
							TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							TextLabel6.BackgroundTransparency = 1
							TextLabel6.Position = UDim2.new(0, 10, 0, 0)
							TextLabel6.Size = UDim2.new(1, -10, 0, 25)
							TextLabel6.Font = Enum.Font.GothamBlack
							TextLabel6.Text = ""
							TextLabel6.TextSize = 14
							TextLabel6.RichText = true
							TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
							TextLabel6.TextColor3 = t1.UIColor["Text Color"]
							Frame25.Name = "SliderBar"
							Frame25.Parent = Frame22
							Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
							Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
							Frame25.Size = UDim2.new(0, 400, 0, 6)
							Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
							TextButton4.Name = "SliderButton "
							TextButton4.Parent = Frame25
							TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							TextButton4.BackgroundTransparency = 1
							TextButton4.Size = UDim2.new(1, 0, 1, 0)
							TextButton4.Font = Enum.Font.GothamBold
							TextButton4.Text = ""
							TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
							TextButton4.TextSize = 14
							UICorner11.CornerRadius = UDim.new(1, 0)
							UICorner11.Name = "SliderBarCorner"
							UICorner11.Parent = Frame25
							Frame23.Name = "Bar"
							Frame23.BorderSizePixel = 0
							Frame23.Parent = Frame25
							Frame23.Size = UDim2.new(0, 0, 1, 0)
							Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
							UICorner12.CornerRadius = UDim.new(1, 0)
							UICorner12.Name = "BarCorner"
							UICorner12.Parent = Frame23
							Frame26.Name = "Background2"
							Frame26.Parent = Frame22
							Frame26.AnchorPoint = Vector2.new(1, 0)
							Frame26.Position = UDim2.new(1, -10, 0, 5)
							Frame26.Size = UDim2.new(0, 150, 0, 25)
							Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
							UICorner13.CornerRadius = UDim.new(0, 4)
							UICorner13.Name = "Sliderbox"
							UICorner13.Parent = Frame26
							TextBox3.Name = "TextColor"
							TextBox3.Parent = Frame26
							TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							TextBox3.BackgroundTransparency = 1
							TextBox3.Size = UDim2.new(1, 0, 1, 0)
							TextBox3.Font = Enum.Font.GothamBold
							TextBox3.Text = ""
							TextBox3.TextSize = 14
							TextBox3.TextColor3 = t1.UIColor["Text Color"]
							TextButton4.MouseEnter:Connect(function()
								TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
								}):Play()
							end)
							TextButton4.MouseLeave:Connect(function()
								TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = t1.UIColor["Slider Line Color"]
								}):Play()
							end)
							v737 = function(p64)
								TextBox3.Text = p64
								v742(tonumber(p64))
							end

							if value then
								if value <= 0 then
									value = 0
								elseif value >= 100 then
									value = 100
								end

								Frame23.Size = UDim2.new(1 - (100 - value) / 100, 0, 0, 6)
								v737(value)
							end

							local u753 = false
							local u754
							local n23 = 0

							local function v756(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									n23 = tick()
									input.Changed:Connect(function()
										if input.UserInputState == Enum.UserInputState.End then
											u753 = false
											n23 = 0
										end
									end)
								end
							end
							local function v757(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									u753 = false
									n23 = 0
								end
							end
							local function v758(input)
								if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
									u754 = input
								end
							end

							TextButton4.InputBegan:Connect(v756)
							TextButton4.InputEnded:Connect(v757)
							TextButton4.InputChanged:Connect(v758)

							local RenderStepped = RunService.RenderStepped

							v738 = RenderStepped
							Connect = RenderStepped.Connect
							v740 = function()
								if n23 > 0 and tick() - n23 >= 0 and not u753 then
									u753 = true
								end

								if u753 and u754 then
									local v760 = Precise and tonumber(string.format("%.1f", (tonumber(nil) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))) or math.floor((tonumber(nil) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))

									pcall(function()
										v737(v760)
									end)
									Frame23.Size = UDim2.new(0, math.clamp(u754.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
								end
							end
							Connect(v738, v740)
							v741 = function(p65)
								if tonumber(p65) <= nil then
									Frame23.Size = UDim2.new(0, 0, 0, 6)
									v737(nil)
								elseif nil <= tonumber(p65) then
									Frame23.Size = UDim2.new(0, nil / nil * 400, 0, 6)
									v737(nil)
								else
									Frame23.Size = UDim2.new(1 - (nil - p65) / (nil - nil), 0, 0, 6)
									v737(p65)
								end
							end
							TextBox3.FocusLost:Connect(function()
								v741(TextBox3.Text)
							end)
							functionCreate = {
								SetValue = function(p66)
									v741(p66)
								end,
								GetValue = function()
									return tonumber(TextBox3.Text) or value
								end
							}
							t25 = {
								name = "",
								type = "slider",
								min = 0,
								max = 100
							}
							Step = p34.Step or 1
							t25.step = Step
							t25.value = value
							t25.Page_Name = text
							t25.Section_Name = text3
							t25.FunctionCreate = functionCreate
							t3.Options[""] = t25

							if type(getgenv().Options) == "table" then
								getgenv().Options[""] = t25
							end

							insert = table.insert
							v401 = t1.listfunction[Frame19]
							t23 = {
								Type = "Slider",
								Name = "",
								Call = function()
									Frame22.Visible = true
								end
							}
							insert(v401, t23)
							table.insert(t2[Frame19], Frame22)

							return functionCreate
						end

						value = tonumber(p34.Default) or 0

						local v761 = p35 or function()
						end

						Frame22 = Instance.new("Frame")

						local UICorner9 = Instance.new("UICorner")
						local Frame24 = Instance.new("Frame")
						local UICorner10 = Instance.new("UICorner")
						local TextLabel6 = Instance.new("TextLabel")
						local Frame25 = Instance.new("Frame")
						local TextButton4 = Instance.new("TextButton")
						local UICorner11 = Instance.new("UICorner")

						Frame23 = Instance.new("Frame")

						local UICorner12 = Instance.new("UICorner")
						local Frame26 = Instance.new("Frame")
						local UICorner13 = Instance.new("UICorner")

						TextBox3 = Instance.new("TextBox")
						Frame22.Name = "buda"
						Frame22.Parent = Frame19
						Frame22.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
						Frame22.BackgroundTransparency = 1
						Frame22.Position = UDim2.new(0, 0, 0.208333328, 0)
						Frame22.Size = UDim2.new(1, 0, 0, 50)
						UICorner9.CornerRadius = UDim.new(0, 4)
						UICorner9.Name = "SliderCorner"
						UICorner9.Parent = Frame22
						Frame24.Name = "Background1"
						Frame24.Parent = Frame22
						Frame24.AnchorPoint = Vector2.new(0.5, 0.5)
						Frame24.Position = UDim2.new(0.5, 0, 0.5, 0)
						Frame24.Size = UDim2.new(1, -10, 1, 0)
						Frame24.BackgroundColor3 = t1.UIColor["Background 1 Color"]
						Frame24.BackgroundTransparency = t1.UIColor["Background 1 Transparency"]
						UICorner10.CornerRadius = UDim.new(0, 4)
						UICorner10.Name = "SliderBGCorner"
						UICorner10.Parent = Frame24
						TextLabel6.Name = "TextColor"
						TextLabel6.Parent = Frame24
						TextLabel6.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						TextLabel6.BackgroundTransparency = 1
						TextLabel6.Position = UDim2.new(0, 10, 0, 0)
						TextLabel6.Size = UDim2.new(1, -10, 0, 25)
						TextLabel6.Font = Enum.Font.GothamBlack
						TextLabel6.Text = ""
						TextLabel6.TextSize = 14
						TextLabel6.RichText = true
						TextLabel6.TextXAlignment = Enum.TextXAlignment.Left
						TextLabel6.TextColor3 = t1.UIColor["Text Color"]
						Frame25.Name = "SliderBar"
						Frame25.Parent = Frame22
						Frame25.AnchorPoint = Vector2.new(0.5, 0.5)
						Frame25.Position = UDim2.new(0.5, 0, 0.5, 14)
						Frame25.Size = UDim2.new(0, 400, 0, 6)
						Frame25.BackgroundColor3 = t1.UIColor["Background 2 Color"]
						TextButton4.Name = "SliderButton "
						TextButton4.Parent = Frame25
						TextButton4.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						TextButton4.BackgroundTransparency = 1
						TextButton4.Size = UDim2.new(1, 0, 1, 0)
						TextButton4.Font = Enum.Font.GothamBold
						TextButton4.Text = ""
						TextButton4.TextColor3 = Color3.fromRGB(230, 230, 230)
						TextButton4.TextSize = 14
						UICorner11.CornerRadius = UDim.new(1, 0)
						UICorner11.Name = "SliderBarCorner"
						UICorner11.Parent = Frame25
						Frame23.Name = "Bar"
						Frame23.BorderSizePixel = 0
						Frame23.Parent = Frame25
						Frame23.Size = UDim2.new(0, 0, 1, 0)
						Frame23.BackgroundColor3 = t1.UIColor["Slider Line Color"]
						UICorner12.CornerRadius = UDim.new(1, 0)
						UICorner12.Name = "BarCorner"
						UICorner12.Parent = Frame23
						Frame26.Name = "Background2"
						Frame26.Parent = Frame22
						Frame26.AnchorPoint = Vector2.new(1, 0)
						Frame26.Position = UDim2.new(1, -10, 0, 5)
						Frame26.Size = UDim2.new(0, 150, 0, 25)
						Frame26.BackgroundColor3 = t1.UIColor["Background 2 Color"]
						UICorner13.CornerRadius = UDim.new(0, 4)
						UICorner13.Name = "Sliderbox"
						UICorner13.Parent = Frame26
						TextBox3.Name = "TextColor"
						TextBox3.Parent = Frame26
						TextBox3.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
						TextBox3.BackgroundTransparency = 1
						TextBox3.Size = UDim2.new(1, 0, 1, 0)
						TextBox3.Font = Enum.Font.GothamBold
						TextBox3.Text = ""
						TextBox3.TextSize = 14
						TextBox3.TextColor3 = t1.UIColor["Text Color"]
						TextButton4.MouseEnter:Connect(function()
							TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
								BackgroundColor3 = t1.UIColor["Slider Highlight Color"]
							}):Play()
						end)
						TextButton4.MouseLeave:Connect(function()
							TweenService:Create(Frame23, TweenInfo.new(t1.UIColor["Tween Animation 2 Speed"]), {
								BackgroundColor3 = t1.UIColor["Slider Line Color"]
							}):Play()
						end)
						v737 = function(p67)
							TextBox3.Text = p67
							v761(tonumber(p67))
						end

						if value then
							if value <= 0 then
								value = 0
							elseif value >= 100 then
								value = 100
							end

							Frame23.Size = UDim2.new(1 - (100 - value) / 100, 0, 0, 6)
							v737(value)

							local u772 = false
							local u773
							local n24 = 0

							local function v775(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									n24 = tick()
									input.Changed:Connect(function()
										if input.UserInputState == Enum.UserInputState.End then
											u772 = false
											n24 = 0
										end
									end)
								end
							end
							local function v776(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									u772 = false
									n24 = 0
								end
							end
							local function v777(input)
								if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
									u773 = input
								end
							end

							TextButton4.InputBegan:Connect(v775)
							TextButton4.InputEnded:Connect(v776)
							TextButton4.InputChanged:Connect(v777)

							local RenderStepped = RunService.RenderStepped

							v738 = RenderStepped
							Connect = RenderStepped.Connect
							v740 = function()
								if n24 > 0 and tick() - n24 >= 0 and not u772 then
									u772 = true
								end

								if u772 and u773 then
									local v779 = nil and tonumber(string.format("%.1f", (tonumber(nil) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))) or math.floor((tonumber(nil) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))

									pcall(function()
										v737(v779)
									end)
									Frame23.Size = UDim2.new(0, math.clamp(u773.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
								end
							end
							Connect(v738, v740)
							v741 = function(p68)
								if tonumber(p68) <= nil then
									Frame23.Size = UDim2.new(0, 0, 0, 6)
									v737(nil)
								elseif nil <= tonumber(p68) then
									Frame23.Size = UDim2.new(0, nil / nil * 400, 0, 6)
									v737(nil)
								else
									Frame23.Size = UDim2.new(1 - (nil - p68) / (nil - nil), 0, 0, 6)
									v737(p68)
								end
							end
							TextBox3.FocusLost:Connect(function()
								v741(TextBox3.Text)
							end)
							functionCreate = {
								SetValue = function(p69)
									v741(p69)
								end,
								GetValue = function()
									return tonumber(TextBox3.Text) or value
								end
							}
							t25 = {
								name = "",
								type = "slider",
								min = 0,
								max = 100,
								step = p34.Step or 1,
								value = value,
								Page_Name = text,
								Section_Name = text3,
								FunctionCreate = functionCreate
							}
							t3.Options[""] = t25

							if type(getgenv().Options) == "table" then
								getgenv().Options[""] = t25
							end

							insert = table.insert
							v401 = t1.listfunction[Frame19]
							t23 = {
								Type = "Slider",
								Name = "",
								Call = function()
									Frame22.Visible = true
								end
							}
						else
							local u780 = false
							local u781
							local n25 = 0

							local function v783(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									n25 = tick()
									input.Changed:Connect(function()
										if input.UserInputState == Enum.UserInputState.End then
											u780 = false
											n25 = 0
										end
									end)
								end
							end
							local function v784(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
									u780 = false
									n25 = 0
								end
							end
							local function v785(input)
								if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
									u781 = input
								end
							end

							TextButton4.InputBegan:Connect(v783)
							TextButton4.InputEnded:Connect(v784)
							TextButton4.InputChanged:Connect(v785)
							RunService.RenderStepped:Connect(function()
								if n25 > 0 and tick() - n25 >= 0 and not u780 then
									u780 = true
								end

								if u780 and u781 then
									local v786 = nil and tonumber(string.format("%.1f", (tonumber(nil) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))) or math.floor((tonumber(nil) - tonumber(nil)) / 400 * Frame23.AbsoluteSize.X + tonumber(nil))

									pcall(function()
										v737(v786)
									end)
									Frame23.Size = UDim2.new(0, math.clamp(u781.Position.X - Frame23.AbsolutePosition.X, 0, 400), 0, 6)
								end
							end)

							local function v787(p70)
								if tonumber(p70) <= nil then
									Frame23.Size = UDim2.new(0, 0, 0, 6)
									v737(nil)
								elseif nil <= tonumber(p70) then
									Frame23.Size = UDim2.new(0, nil / nil * 400, 0, 6)
									v737(nil)
								else
									Frame23.Size = UDim2.new(1 - (nil - p70) / (nil - nil), 0, 0, 6)
									v737(p70)
								end
							end

							TextBox3.FocusLost:Connect(function()
								v787(TextBox3.Text)
							end)
							functionCreate = {
								SetValue = function(p71)
									v787(p71)
								end,
								GetValue = function()
									return tonumber(TextBox3.Text) or value
								end
							}

							local t26 = {
								name = "",
								type = "slider",
								min = 0,
								max = 100,
								step = p34.Step or 1,
								value = value,
								Page_Name = text,
								Section_Name = text3,
								FunctionCreate = functionCreate
							}

							t3.Options[""] = t26

							if type(getgenv().Options) == "table" then
								getgenv().Options[""] = t26
							end

							insert = table.insert
							v401 = t1.listfunction[Frame19]
							t23 = {
								Type = "Slider",
								Name = "",
								Call = function()
									Frame22.Visible = true
								end
							}
						end

						insert(v401, t23)
						table.insert(t2[Frame19], Frame22)

						return functionCreate
					end

					return t8
				end
			}

			return t6
		end
	}
end
t3.CreateNoti({
	Title = "Notification",
	Desc = "The UI automatically hides once executed.\nPress the button at the bottom-left of the screen to show the GUI.",
	ShowTime = 10
}, true)

return t3
