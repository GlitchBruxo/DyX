--[[
	DyX MainUI.lua v3.1
	Framework visual puro para Roblox/Luau.

	Recursos:
	- Home obrigatória com catálogo de versões
	- Config obrigatória
	- 12 temas: 5 Light, 5 Dark, 2 AMOLED
	- Sidebar: IconText / Icon / Text
	- Perfil fixo embaixo da sidebar
	- Clique no perfil abre aba Perfil
	- Botão mobile flutuante "DyX"
	- ToggleKey para abrir/fechar
	- Drag na janela e no botão mobile
	- Notify com timer, barra e botão X
	- Opacidade de fundo configurável
	- AutoSave / AutoExecute preparados
	- Reload ao trocar tema
	- Componentes: Section, Label, Button, Toggle, Slider, Dropdown, Textbox

	Uso:
	local DyX = loadstring(game:HttpGet(MainUrl))()

	local UI = DyX.new({
		Title = "DyX Hub",
		Theme = "AmoledGreen",
		KeyTier = "Free",
		ToggleKey = Enum.KeyCode.RightShift,
		ScriptUrl = "URL_DO_TESTE_OU_LOADER"
	})

	local Tab = UI:CreateTab("Player", "👤")
	Tab:Section("Teste")
	Tab:Button("Notify", function()
		UI:Notify("Funcionando")
	end)
]]

local DyX = {}
DyX.__index = DyX
DyX.Version = "v3.1.0"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

DyX.Themes = {
	-- AMOLED
	AmoledGreen = {
		Bg = Color3.fromRGB(0, 0, 0),
		Panel = Color3.fromRGB(8, 8, 10),
		Panel2 = Color3.fromRGB(12, 12, 16),
		Element = Color3.fromRGB(18, 18, 24),
		Element2 = Color3.fromRGB(26, 26, 34),
		Accent = Color3.fromRGB(0, 255, 170),
		Text = Color3.fromRGB(255, 255, 255),
		Muted = Color3.fromRGB(150, 150, 160),
		Stroke = Color3.fromRGB(36, 36, 46),
		Shadow = Color3.fromRGB(0, 0, 0)
	},

	AmoledPurple = {
		Bg = Color3.fromRGB(0, 0, 0),
		Panel = Color3.fromRGB(9, 7, 13),
		Panel2 = Color3.fromRGB(15, 11, 20),
		Element = Color3.fromRGB(22, 16, 30),
		Element2 = Color3.fromRGB(32, 22, 44),
		Accent = Color3.fromRGB(185, 85, 255),
		Text = Color3.fromRGB(255, 255, 255),
		Muted = Color3.fromRGB(160, 145, 170),
		Stroke = Color3.fromRGB(44, 34, 58),
		Shadow = Color3.fromRGB(0, 0, 0)
	},

	-- DARK
	DarkBlue = {
		Bg = Color3.fromRGB(10, 12, 20),
		Panel = Color3.fromRGB(18, 22, 34),
		Panel2 = Color3.fromRGB(22, 27, 42),
		Element = Color3.fromRGB(28, 34, 52),
		Element2 = Color3.fromRGB(35, 42, 62),
		Accent = Color3.fromRGB(70, 140, 255),
		Text = Color3.fromRGB(245, 248, 255),
		Muted = Color3.fromRGB(145, 155, 175),
		Stroke = Color3.fromRGB(45, 55, 78),
		Shadow = Color3.fromRGB(0, 0, 0)
	},

	DarkPurple = {
		Bg = Color3.fromRGB(14, 10, 22),
		Panel = Color3.fromRGB(24, 18, 36),
		Panel2 = Color3.fromRGB(30, 22, 45),
		Element = Color3.fromRGB(38, 28, 58),
		Element2 = Color3.fromRGB(48, 36, 72),
		Accent = Color3.fromRGB(170, 95, 255),
		Text = Color3.fromRGB(250, 245, 255),
		Muted = Color3.fromRGB(165, 145, 185),
		Stroke = Color3.fromRGB(60, 45, 82),
		Shadow = Color3.fromRGB(0, 0, 0)
	},

	DarkGreen = {
		Bg = Color3.fromRGB(8, 18, 14),
		Panel = Color3.fromRGB(14, 28, 22),
		Panel2 = Color3.fromRGB(18, 36, 28),
		Element = Color3.fromRGB(22, 44, 34),
		Element2 = Color3.fromRGB(28, 56, 44),
		Accent = Color3.fromRGB(0, 255, 170),
		Text = Color3.fromRGB(240, 255, 248),
		Muted = Color3.fromRGB(135, 175, 155),
		Stroke = Color3.fromRGB(35, 70, 55),
		Shadow = Color3.fromRGB(0, 0, 0)
	},

	DarkRed = {
		Bg = Color3.fromRGB(22, 9, 11),
		Panel = Color3.fromRGB(34, 15, 18),
		Panel2 = Color3.fromRGB(42, 18, 22),
		Element = Color3.fromRGB(54, 25, 28),
		Element2 = Color3.fromRGB(68, 32, 36),
		Accent = Color3.fromRGB(255, 80, 95),
		Text = Color3.fromRGB(255, 245, 245),
		Muted = Color3.fromRGB(180, 135, 140),
		Stroke = Color3.fromRGB(80, 40, 45),
		Shadow = Color3.fromRGB(0, 0, 0)
	},

	DarkYellow = {
		Bg = Color3.fromRGB(20, 17, 8),
		Panel = Color3.fromRGB(32, 27, 14),
		Panel2 = Color3.fromRGB(40, 34, 18),
		Element = Color3.fromRGB(50, 42, 20),
		Element2 = Color3.fromRGB(64, 54, 28),
		Accent = Color3.fromRGB(255, 190, 40),
		Text = Color3.fromRGB(255, 250, 235),
		Muted = Color3.fromRGB(180, 165, 120),
		Stroke = Color3.fromRGB(75, 65, 35),
		Shadow = Color3.fromRGB(0, 0, 0)
	},

	-- LIGHT
	LightBlue = {
		Bg = Color3.fromRGB(245, 248, 255),
		Panel = Color3.fromRGB(255, 255, 255),
		Panel2 = Color3.fromRGB(248, 251, 255),
		Element = Color3.fromRGB(235, 242, 255),
		Element2 = Color3.fromRGB(225, 235, 255),
		Accent = Color3.fromRGB(60, 130, 255),
		Text = Color3.fromRGB(25, 25, 35),
		Muted = Color3.fromRGB(100, 105, 120),
		Stroke = Color3.fromRGB(210, 220, 240),
		Shadow = Color3.fromRGB(190, 200, 220)
	},

	LightPurple = {
		Bg = Color3.fromRGB(250, 245, 255),
		Panel = Color3.fromRGB(255, 255, 255),
		Panel2 = Color3.fromRGB(252, 248, 255),
		Element = Color3.fromRGB(242, 232, 255),
		Element2 = Color3.fromRGB(234, 220, 255),
		Accent = Color3.fromRGB(150, 90, 255),
		Text = Color3.fromRGB(30, 25, 40),
		Muted = Color3.fromRGB(110, 100, 125),
		Stroke = Color3.fromRGB(225, 210, 245),
		Shadow = Color3.fromRGB(205, 195, 225)
	},

	LightGreen = {
		Bg = Color3.fromRGB(245, 255, 248),
		Panel = Color3.fromRGB(255, 255, 255),
		Panel2 = Color3.fromRGB(248, 255, 251),
		Element = Color3.fromRGB(230, 250, 238),
		Element2 = Color3.fromRGB(218, 244, 230),
		Accent = Color3.fromRGB(0, 180, 110),
		Text = Color3.fromRGB(20, 35, 28),
		Muted = Color3.fromRGB(90, 120, 105),
		Stroke = Color3.fromRGB(205, 235, 220),
		Shadow = Color3.fromRGB(190, 215, 200)
	},

	LightRed = {
		Bg = Color3.fromRGB(255, 246, 246),
		Panel = Color3.fromRGB(255, 255, 255),
		Panel2 = Color3.fromRGB(255, 250, 250),
		Element = Color3.fromRGB(255, 232, 232),
		Element2 = Color3.fromRGB(250, 220, 220),
		Accent = Color3.fromRGB(230, 70, 80),
		Text = Color3.fromRGB(40, 25, 25),
		Muted = Color3.fromRGB(125, 100, 100),
		Stroke = Color3.fromRGB(240, 210, 210),
		Shadow = Color3.fromRGB(220, 195, 195)
	},

	LightYellow = {
		Bg = Color3.fromRGB(255, 253, 240),
		Panel = Color3.fromRGB(255, 255, 255),
		Panel2 = Color3.fromRGB(255, 252, 244),
		Element = Color3.fromRGB(255, 246, 210),
		Element2 = Color3.fromRGB(250, 238, 190),
		Accent = Color3.fromRGB(230, 170, 0),
		Text = Color3.fromRGB(40, 35, 20),
		Muted = Color3.fromRGB(125, 115, 80),
		Stroke = Color3.fromRGB(240, 225, 180),
		Shadow = Color3.fromRGB(220, 210, 175)
	}
}

local function safeCall(fn, ...)
	local ok, result = pcall(fn, ...)
	if ok then
		return result
	end
	return nil
end

local function canFiles()
	return typeof(writefile) == "function"
		and typeof(readfile) == "function"
		and typeof(isfile) == "function"
end

local function makeCorner(obj, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 10)
	corner.Parent = obj
	return corner
end

local function makeStroke(obj, color, transparency, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Transparency = transparency or 0.35
	stroke.Thickness = thickness or 1
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = obj
	return stroke
end

local function makePadding(obj, top, left, right, bottom)
	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, top or 0)
	padding.PaddingLeft = UDim.new(0, left or 0)
	padding.PaddingRight = UDim.new(0, right or 0)
	padding.PaddingBottom = UDim.new(0, bottom or 0)
	padding.Parent = obj
	return padding
end

local function tween(obj, props, duration)
	local tw = TweenService:Create(
		obj,
		TweenInfo.new(duration or 0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		props
	)
	tw:Play()
	return tw
end

local function setTextAuto(button, text)
	button.Text = text
end

local function makeDraggable(frame, handle)
	local dragging = false
	local dragStart
	local startPos

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end

		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

local function getSortedThemeNames()
	local names = {}
	for themeName in pairs(DyX.Themes) do
		table.insert(names, themeName)
	end
	table.sort(names)
	return names
end

function DyX.new(config)
	config = config or {}

	local self = setmetatable({}, DyX)

	self.Title = config.Title or "DyX Hub"
	self.KeyTier = config.KeyTier or "Free"
	self.KeyExpire = config.KeyExpire or "N/A"
	self.KeyOwner = config.KeyOwner or (LocalPlayer and LocalPlayer.Name or "Player")
	self.ToggleKey = config.ToggleKey or Enum.KeyCode.RightShift
	self.ConfigFile = config.ConfigFile or "DyX_Config.json"
	self.ScriptUrl = config.ScriptUrl
	self.ReloadCallback = config.ReloadCallback
	self.ReloadOnThemeChange = config.ReloadOnThemeChange
	if self.ReloadOnThemeChange == nil then
		self.ReloadOnThemeChange = true
	end

	self.Settings = {
		Theme = config.Theme or "AmoledGreen",
		SidebarMode = config.SidebarMode or "IconText",
		BackgroundOpacity = config.BackgroundOpacity or 0.02,
		NotifyTime = config.NotifyTime or 5,
		AutoSave = config.AutoSave ~= false,
		AutoExecute = config.AutoExecute or false,
		MenuScale = config.MenuScale or 1
	}

	self.Tabs = {}
	self.CurrentTab = nil
	self.Notifications = {}
	self.Visible = true
	self.IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

	self:LoadConfig()

	self.Theme = DyX.Themes[self.Settings.Theme] or DyX.Themes.AmoledGreen

	self:BuildUI()
	self:CreateHomeTab()
	self:CreateConfigTab()
	self:ApplySidebarMode()

	return self
end

function DyX:LoadConfig()
	if not canFiles() then return end
	if not isfile(self.ConfigFile) then return end

	local raw = safeCall(readfile, self.ConfigFile)
	if not raw then return end

	local ok, decoded = pcall(function()
		return HttpService:JSONDecode(raw)
	end)

	if not ok or type(decoded) ~= "table" then return end

	for key, value in pairs(decoded) do
		self.Settings[key] = value
	end
end

function DyX:SaveConfig()
	if not self.Settings.AutoSave then return end
	if not canFiles() then return end

	local ok, encoded = pcall(function()
		return HttpService:JSONEncode(self.Settings)
	end)

	if ok and encoded then
		safeCall(writefile, self.ConfigFile, encoded)
	end
end

function DyX:BuildUI()
	if not LocalPlayer then
		warn("[DyX] LocalPlayer não encontrado. Rode isso como LocalScript/client.")
		return
	end

	local parent = LocalPlayer:WaitForChild("PlayerGui")

	local old = parent:FindFirstChild("DyX_UI")
	if old then
		old:Destroy()
	end

	self.Gui = Instance.new("ScreenGui")
	self.Gui.Name = "DyX_UI"
	self.Gui.IgnoreGuiInset = true
	self.Gui.ResetOnSpawn = false
	self.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	self.Gui.Parent = parent

	self.Root = Instance.new("Frame")
	self.Root.Name = "Root"
	self.Root.Size = UDim2.new(0, 660 * self.Settings.MenuScale, 0, 430 * self.Settings.MenuScale)
	self.Root.Position = UDim2.new(0.5, -330 * self.Settings.MenuScale, 0.5, -215 * self.Settings.MenuScale)
	self.Root.BackgroundColor3 = self.Theme.Bg
	self.Root.BackgroundTransparency = self.Settings.BackgroundOpacity
	self.Root.BorderSizePixel = 0
	self.Root.Parent = self.Gui
	makeCorner(self.Root, 18)
	makeStroke(self.Root, self.Theme.Stroke, 0.22, 1)

	self.Topbar = Instance.new("Frame")
	self.Topbar.Name = "Topbar"
	self.Topbar.Size = UDim2.new(1, 0, 0, 50)
	self.Topbar.BackgroundColor3 = self.Theme.Panel
	self.Topbar.BorderSizePixel = 0
	self.Topbar.Parent = self.Root
	makeCorner(self.Topbar, 18)

	self.Brand = Instance.new("TextLabel")
	self.Brand.Name = "Brand"
	self.Brand.Size = UDim2.new(0, 74, 1, 0)
	self.Brand.Position = UDim2.new(0, 16, 0, 0)
	self.Brand.BackgroundTransparency = 1
	self.Brand.Text = "DyX"
	self.Brand.TextColor3 = self.Theme.Accent
	self.Brand.TextSize = 22
	self.Brand.Font = Enum.Font.GothamBlack
	self.Brand.TextXAlignment = Enum.TextXAlignment.Left
	self.Brand.Parent = self.Topbar

	self.TitleLabel = Instance.new("TextLabel")
	self.TitleLabel.Name = "TitleLabel"
	self.TitleLabel.Size = UDim2.new(1, -160, 1, 0)
	self.TitleLabel.Position = UDim2.new(0, 86, 0, 0)
	self.TitleLabel.BackgroundTransparency = 1
	self.TitleLabel.Text = self.Title
	self.TitleLabel.TextColor3 = self.Theme.Text
	self.TitleLabel.TextSize = 16
	self.TitleLabel.Font = Enum.Font.GothamBold
	self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	self.TitleLabel.Parent = self.Topbar

	self.Minimize = Instance.new("TextButton")
	self.Minimize.Name = "Minimize"
	self.Minimize.Size = UDim2.new(0, 34, 0, 30)
	self.Minimize.Position = UDim2.new(1, -84, 0.5, -15)
	self.Minimize.BackgroundColor3 = self.Theme.Element
	self.Minimize.Text = "—"
	self.Minimize.TextColor3 = self.Theme.Text
	self.Minimize.TextSize = 16
	self.Minimize.Font = Enum.Font.GothamBold
	self.Minimize.BorderSizePixel = 0
	self.Minimize.Parent = self.Topbar
	makeCorner(self.Minimize, 9)

	self.Close = Instance.new("TextButton")
	self.Close.Name = "Close"
	self.Close.Size = UDim2.new(0, 34, 0, 30)
	self.Close.Position = UDim2.new(1, -44, 0.5, -15)
	self.Close.BackgroundColor3 = self.Theme.Element
	self.Close.Text = "×"
	self.Close.TextColor3 = self.Theme.Text
	self.Close.TextSize = 20
	self.Close.Font = Enum.Font.GothamBold
	self.Close.BorderSizePixel = 0
	self.Close.Parent = self.Topbar
	makeCorner(self.Close, 9)

	self.Sidebar = Instance.new("Frame")
	self.Sidebar.Name = "Sidebar"
	self.Sidebar.Size = UDim2.new(0, 168, 1, -66)
	self.Sidebar.Position = UDim2.new(0, 10, 0, 56)
	self.Sidebar.BackgroundColor3 = self.Theme.Panel
	self.Sidebar.BorderSizePixel = 0
	self.Sidebar.ClipsDescendants = true
	self.Sidebar.Parent = self.Root
	makeCorner(self.Sidebar, 15)
	makeStroke(self.Sidebar, self.Theme.Stroke, 0.55, 1)

	self.SidebarButtons = Instance.new("Frame")
	self.SidebarButtons.Name = "SidebarButtons"
	self.SidebarButtons.Size = UDim2.new(1, -16, 1, -104)
	self.SidebarButtons.Position = UDim2.new(0, 8, 0, 10)
	self.SidebarButtons.BackgroundTransparency = 1
	self.SidebarButtons.Parent = self.Sidebar

	self.SidebarList = Instance.new("UIListLayout")
	self.SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
	self.SidebarList.Padding = UDim.new(0, 8)
	self.SidebarList.VerticalAlignment = Enum.VerticalAlignment.Top
	self.SidebarList.Parent = self.SidebarButtons

	self.ProfileButton = Instance.new("TextButton")
	self.ProfileButton.Name = "ProfileButton"
	self.ProfileButton.Size = UDim2.new(1, -16, 0, 84)
	self.ProfileButton.Position = UDim2.new(0, 8, 1, -92)
	self.ProfileButton.BackgroundColor3 = self.Theme.Element
	self.ProfileButton.Text = ""
	self.ProfileButton.AutoButtonColor = false
	self.ProfileButton.BorderSizePixel = 0
	self.ProfileButton.Parent = self.Sidebar
	makeCorner(self.ProfileButton, 13)
	makeStroke(self.ProfileButton, self.Theme.Stroke, 0.58, 1)

	self.Avatar = Instance.new("ImageLabel")
	self.Avatar.Name = "Avatar"
	self.Avatar.Size = UDim2.new(0, 40, 0, 40)
	self.Avatar.Position = UDim2.new(0, 10, 0, 10)
	self.Avatar.BackgroundColor3 = self.Theme.Panel2
	self.Avatar.BorderSizePixel = 0
	self.Avatar.Parent = self.ProfileButton
	makeCorner(self.Avatar, 999)

	local thumb = safeCall(function()
		return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
	end)
	self.Avatar.Image = thumb or ""

	self.ProfileName = Instance.new("TextLabel")
	self.ProfileName.Name = "ProfileName"
	self.ProfileName.Size = UDim2.new(1, -60, 0, 20)
	self.ProfileName.Position = UDim2.new(0, 58, 0, 10)
	self.ProfileName.BackgroundTransparency = 1
	self.ProfileName.Text = LocalPlayer.DisplayName
	self.ProfileName.TextColor3 = self.Theme.Text
	self.ProfileName.TextSize = 12
	self.ProfileName.Font = Enum.Font.GothamBold
	self.ProfileName.TextXAlignment = Enum.TextXAlignment.Left
	self.ProfileName.TextTruncate = Enum.TextTruncate.AtEnd
	self.ProfileName.Parent = self.ProfileButton

	self.ProfileUser = Instance.new("TextLabel")
	self.ProfileUser.Name = "ProfileUser"
	self.ProfileUser.Size = UDim2.new(1, -60, 0, 18)
	self.ProfileUser.Position = UDim2.new(0, 58, 0, 31)
	self.ProfileUser.BackgroundTransparency = 1
	self.ProfileUser.Text = "@" .. LocalPlayer.Name
	self.ProfileUser.TextColor3 = self.Theme.Muted
	self.ProfileUser.TextSize = 11
	self.ProfileUser.Font = Enum.Font.Gotham
	self.ProfileUser.TextXAlignment = Enum.TextXAlignment.Left
	self.ProfileUser.TextTruncate = Enum.TextTruncate.AtEnd
	self.ProfileUser.Parent = self.ProfileButton

	self.KeyLabel = Instance.new("TextLabel")
	self.KeyLabel.Name = "KeyLabel"
	self.KeyLabel.Size = UDim2.new(1, -20, 0, 20)
	self.KeyLabel.Position = UDim2.new(0, 10, 1, -26)
	self.KeyLabel.BackgroundTransparency = 1
	self.KeyLabel.Text = tostring(self.KeyTier) .. " • " .. DyX.Version
	self.KeyLabel.TextColor3 = self.Theme.Accent
	self.KeyLabel.TextSize = 11
	self.KeyLabel.Font = Enum.Font.GothamBold
	self.KeyLabel.TextXAlignment = Enum.TextXAlignment.Left
	self.KeyLabel.TextTruncate = Enum.TextTruncate.AtEnd
	self.KeyLabel.Parent = self.ProfileButton

	self.Content = Instance.new("Frame")
	self.Content.Name = "Content"
	self.Content.Size = UDim2.new(1, -194, 1, -66)
	self.Content.Position = UDim2.new(0, 186, 0, 56)
	self.Content.BackgroundColor3 = self.Theme.Panel
	self.Content.BorderSizePixel = 0
	self.Content.ClipsDescendants = true
	self.Content.Parent = self.Root
	makeCorner(self.Content, 15)
	makeStroke(self.Content, self.Theme.Stroke, 0.55, 1)

	self.NotifyHolder = Instance.new("Frame")
	self.NotifyHolder.Name = "NotifyHolder"
	self.NotifyHolder.Size = UDim2.new(0, 340, 1, 0)
	self.NotifyHolder.Position = UDim2.new(1, -360, 0, 20)
	self.NotifyHolder.BackgroundTransparency = 1
	self.NotifyHolder.Parent = self.Gui

	self.NotifyList = Instance.new("UIListLayout")
	self.NotifyList.SortOrder = Enum.SortOrder.LayoutOrder
	self.NotifyList.Padding = UDim.new(0, 10)
	self.NotifyList.VerticalAlignment = Enum.VerticalAlignment.Bottom
	self.NotifyList.Parent = self.NotifyHolder

	makeDraggable(self.Root, self.Topbar)

	self.Close.MouseButton1Click:Connect(function()
		self:Toggle()
	end)

	self.Minimize.MouseButton1Click:Connect(function()
		self:Toggle()
	end)

	self.ProfileButton.MouseButton1Click:Connect(function()
		self:OpenProfileInfo()
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == self.ToggleKey then
			self:Toggle()
		end
	end)

	if self.IsMobile then
		self:CreateMobileButton()
	end
end

function DyX:CreateMobileButton()
	self.MobileButton = Instance.new("TextButton")
	self.MobileButton.Name = "DyXMobileButton"
	self.MobileButton.Size = UDim2.new(0, 64, 0, 64)
	self.MobileButton.Position = UDim2.new(1, -82, 0.5, -32)
	self.MobileButton.BackgroundColor3 = self.Theme.Accent
	self.MobileButton.Text = "DyX"
	self.MobileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	self.MobileButton.TextSize = 16
	self.MobileButton.Font = Enum.Font.GothamBlack
	self.MobileButton.BorderSizePixel = 0
	self.MobileButton.Parent = self.Gui
	makeCorner(self.MobileButton, 999)
	makeStroke(self.MobileButton, self.Theme.Stroke, 0.25, 1)

	makeDraggable(self.MobileButton, self.MobileButton)

	self.MobileButton.MouseButton1Click:Connect(function()
		self:Toggle()
	end)
end

function DyX:Toggle()
	self.Visible = not self.Visible
	self.Root.Visible = self.Visible
end

function DyX:SetVisible(value)
	self.Visible = value and true or false
	self.Root.Visible = self.Visible
end

function DyX:Reload()
	self:SaveConfig()

	task.spawn(function()
		task.wait(0.15)

		if self.ReloadCallback then
			self:Destroy()
			self.ReloadCallback()
			return
		end

		if self.ScriptUrl and typeof(loadstring) == "function" then
			local url = self.ScriptUrl
			self:Destroy()
			loadstring(game:HttpGet(url))()
			return
		end

		self:Notify("ReloadCallback/ScriptUrl não definido.", 4)
	end)
end

function DyX:SetTheme(themeName)
	if not DyX.Themes[themeName] then
		self:Notify("Tema inválido: " .. tostring(themeName), 4)
		return
	end

	self.Settings.Theme = themeName
	self:SaveConfig()

	if self.ReloadOnThemeChange then
		self:Notify("Tema salvo. Recarregando...", 1.2)
		self:Reload()
	else
		self.Theme = DyX.Themes[themeName]
		self:Notify("Tema alterado para " .. themeName, 3)
	end
end

function DyX:SetOpacity(value)
	value = tonumber(value) or 0
	value = math.clamp(value, 0, 0.9)

	self.Settings.BackgroundOpacity = value
	if self.Root then
		self.Root.BackgroundTransparency = value
	end

	self:SaveConfig()
end

function DyX:ApplySidebarMode()
	local mode = self.Settings.SidebarMode or "IconText"

	for _, tab in ipairs(self.Tabs) do
		if mode == "Icon" then
			tab.Button.Text = tab.Icon
			tab.Button.TextSize = 18
		elseif mode == "Text" then
			tab.Button.Text = tab.Name
			tab.Button.TextSize = 13
		else
			tab.Button.Text = tab.Icon .. "  " .. tab.Name
			tab.Button.TextSize = 13
		end
	end

	if mode == "Icon" then
		self.Sidebar.Size = UDim2.new(0, 78, 1, -66)
		self.ProfileButton.Visible = false
		self.Content.Position = UDim2.new(0, 96, 0, 56)
		self.Content.Size = UDim2.new(1, -104, 1, -66)
	elseif mode == "Text" then
		self.Sidebar.Size = UDim2.new(0, 150, 1, -66)
		self.ProfileButton.Visible = true
		self.Content.Position = UDim2.new(0, 168, 0, 56)
		self.Content.Size = UDim2.new(1, -176, 1, -66)
	else
		self.Sidebar.Size = UDim2.new(0, 168, 1, -66)
		self.ProfileButton.Visible = true
		self.Content.Position = UDim2.new(0, 186, 0, 56)
		self.Content.Size = UDim2.new(1, -194, 1, -66)
	end
end

function DyX:CreateTab(name, icon)
	name = name or "Tab"
	icon = icon or "•"

	local tab = {}
	tab.UI = self
	tab.Name = name
	tab.Icon = icon

	local button = Instance.new("TextButton")
	button.Name = "Tab_" .. name
	button.Size = UDim2.new(1, 0, 0, 40)
	button.BackgroundColor3 = self.Theme.Element
	button.TextColor3 = self.Theme.Text
	button.TextSize = 13
	button.Font = Enum.Font.GothamBold
	button.Text = icon .. "  " .. name
	button.AutoButtonColor = false
	button.BorderSizePixel = 0
	button.Parent = self.SidebarButtons
	makeCorner(button, 11)

	local page = Instance.new("ScrollingFrame")
	page.Name = "Page_" .. name
	page.Size = UDim2.new(1, 0, 1, 0)
	page.Position = UDim2.new(0, 0, 0, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 4
	page.ScrollBarImageColor3 = self.Theme.Accent
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.Visible = false
	page.Parent = self.Content

	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 10)
	layout.Parent = page

	makePadding(page, 14, 14, 14, 14)

	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 32)
	end)

	function tab:Show()
		for _, other in ipairs(self.UI.Tabs) do
			other.Page.Visible = false
			other.Button.BackgroundColor3 = self.UI.Theme.Element
			other.Button.TextColor3 = self.UI.Theme.Text
		end

		page.Visible = true
		button.BackgroundColor3 = self.UI.Theme.Accent
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		self.UI.CurrentTab = tab
	end

	function tab:Section(text)
		local label = Instance.new("TextLabel")
		label.Name = "Section"
		label.Size = UDim2.new(1, 0, 0, 28)
		label.BackgroundTransparency = 1
		label.Text = tostring(text or "Section")
		label.TextColor3 = self.UI.Theme.Muted
		label.TextSize = 13
		label.Font = Enum.Font.GothamBold
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = page
		return label
	end

	function tab:Label(text)
		local label = Instance.new("TextLabel")
		label.Name = "Label"
		label.Size = UDim2.new(1, 0, 0, 34)
		label.BackgroundColor3 = self.UI.Theme.Element
		label.Text = tostring(text or "Label")
		label.TextColor3 = self.UI.Theme.Text
		label.TextSize = 13
		label.Font = Enum.Font.Gotham
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.BorderSizePixel = 0
		label.Parent = page
		makeCorner(label, 10)
		makePadding(label, 0, 12, 12, 0)
		makeStroke(label, self.UI.Theme.Stroke, 0.65, 1)
		return label
	end

	function tab:Button(text, callback)
		local btn = Instance.new("TextButton")
		btn.Name = "Button"
		btn.Size = UDim2.new(1, 0, 0, 44)
		btn.BackgroundColor3 = self.UI.Theme.Element
		btn.Text = tostring(text or "Button")
		btn.TextColor3 = self.UI.Theme.Text
		btn.TextSize = 14
		btn.Font = Enum.Font.GothamBold
		btn.AutoButtonColor = false
		btn.BorderSizePixel = 0
		btn.Parent = page
		makeCorner(btn, 12)
		makeStroke(btn, self.UI.Theme.Stroke, 0.58, 1)

		btn.MouseEnter:Connect(function()
			tween(btn, {BackgroundColor3 = self.UI.Theme.Element2}, 0.12)
		end)

		btn.MouseLeave:Connect(function()
			tween(btn, {BackgroundColor3 = self.UI.Theme.Element}, 0.12)
		end)

		btn.MouseButton1Down:Connect(function()
			tween(btn, {Size = UDim2.new(1, -4, 0, 42)}, 0.08)
		end)

		btn.MouseButton1Up:Connect(function()
			tween(btn, {Size = UDim2.new(1, 0, 0, 44)}, 0.08)
		end)

		btn.MouseButton1Click:Connect(function()
			if callback then
				callback()
			end
		end)

		return btn
	end

	function tab:Toggle(text, default, callback)
		local state = default and true or false

		local holder = Instance.new("TextButton")
		holder.Name = "Toggle"
		holder.Size = UDim2.new(1, 0, 0, 48)
		holder.BackgroundColor3 = self.UI.Theme.Element
		holder.Text = ""
		holder.AutoButtonColor = false
		holder.BorderSizePixel = 0
		holder.Parent = page
		makeCorner(holder, 12)
		makeStroke(holder, self.UI.Theme.Stroke, 0.58, 1)

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, -78, 1, 0)
		label.Position = UDim2.new(0, 12, 0, 0)
		label.BackgroundTransparency = 1
		label.Text = tostring(text or "Toggle")
		label.TextColor3 = self.UI.Theme.Text
		label.TextSize = 14
		label.Font = Enum.Font.GothamBold
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = holder

		local pill = Instance.new("Frame")
		pill.Size = UDim2.new(0, 46, 0, 24)
		pill.Position = UDim2.new(1, -58, 0.5, -12)
		pill.BackgroundColor3 = state and self.UI.Theme.Accent or self.UI.Theme.Panel2
		pill.BorderSizePixel = 0
		pill.Parent = holder
		makeCorner(pill, 999)

		local knob = Instance.new("Frame")
		knob.Size = UDim2.new(0, 18, 0, 18)
		knob.Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
		knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		knob.BorderSizePixel = 0
		knob.Parent = pill
		makeCorner(knob, 999)

		local function render()
			tween(pill, {BackgroundColor3 = state and self.UI.Theme.Accent or self.UI.Theme.Panel2}, 0.16)
			tween(knob, {Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)}, 0.16)
		end

		holder.MouseButton1Click:Connect(function()
			state = not state
			render()
			if callback then
				callback(state)
			end
		end)

		return {
			Instance = holder,
			Get = function()
				return state
			end,
			Set = function(_, value)
				state = value and true or false
				render()
				if callback then callback(state) end
			end
		}
	end

	function tab:Slider(text, min, max, default, callback)
		min = tonumber(min) or 0
		max = tonumber(max) or 100
		local value = math.clamp(tonumber(default) or min, min, max)

		local holder = Instance.new("Frame")
		holder.Name = "Slider"
		holder.Size = UDim2.new(1, 0, 0, 62)
		holder.BackgroundColor3 = self.UI.Theme.Element
		holder.BorderSizePixel = 0
		holder.Parent = page
		makeCorner(holder, 12)
		makeStroke(holder, self.UI.Theme.Stroke, 0.58, 1)

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, -24, 0, 28)
		label.Position = UDim2.new(0, 12, 0, 4)
		label.BackgroundTransparency = 1
		label.TextColor3 = self.UI.Theme.Text
		label.TextSize = 14
		label.Font = Enum.Font.GothamBold
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = holder

		local track = Instance.new("Frame")
		track.Size = UDim2.new(1, -24, 0, 8)
		track.Position = UDim2.new(0, 12, 1, -20)
		track.BackgroundColor3 = self.UI.Theme.Panel2
		track.BorderSizePixel = 0
		track.Parent = holder
		makeCorner(track, 999)

		local fill = Instance.new("Frame")
		fill.Size = UDim2.new(0, 0, 1, 0)
		fill.BackgroundColor3 = self.UI.Theme.Accent
		fill.BorderSizePixel = 0
		fill.Parent = track
		makeCorner(fill, 999)

		local function render()
			local alpha = 0
			if max ~= min then
				alpha = (value - min) / (max - min)
			end
			alpha = math.clamp(alpha, 0, 1)
			label.Text = tostring(text or "Slider") .. ": " .. tostring(value)
			tween(fill, {Size = UDim2.new(alpha, 0, 1, 0)}, 0.1)
		end

		local dragging = false

		local function updateFromX(x)
			local pos = track.AbsolutePosition.X
			local size = track.AbsoluteSize.X
			local alpha = math.clamp((x - pos) / size, 0, 1)
			value = math.floor((min + (max - min) * alpha) + 0.5)
			render()
			if callback then callback(value) end
		end

		track.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				updateFromX(input.Position.X)
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				updateFromX(input.Position.X)
			end
		end)

		render()

		return {
			Instance = holder,
			Get = function() return value end,
			Set = function(_, newValue)
				value = math.clamp(tonumber(newValue) or value, min, max)
				render()
				if callback then callback(value) end
			end
		}
	end

	function tab:Dropdown(text, options, default, callback)
		options = options or {}
		local selected = default or options[1] or "None"
		local opened = false

		local holder = Instance.new("Frame")
		holder.Name = "Dropdown"
		holder.Size = UDim2.new(1, 0, 0, 46)
		holder.BackgroundColor3 = self.UI.Theme.Element
		holder.BorderSizePixel = 0
		holder.ClipsDescendants = true
		holder.Parent = page
		makeCorner(holder, 12)
		makeStroke(holder, self.UI.Theme.Stroke, 0.58, 1)

		local main = Instance.new("TextButton")
		main.Size = UDim2.new(1, 0, 0, 46)
		main.BackgroundTransparency = 1
		main.TextColor3 = self.UI.Theme.Text
		main.TextSize = 14
		main.Font = Enum.Font.GothamBold
		main.TextXAlignment = Enum.TextXAlignment.Left
		main.Text = "  " .. tostring(text or "Dropdown") .. ": " .. tostring(selected) .. "   ▼"
		main.Parent = holder

		local list = Instance.new("Frame")
		list.Size = UDim2.new(1, -12, 0, 0)
		list.Position = UDim2.new(0, 6, 0, 50)
		list.BackgroundTransparency = 1
		list.Parent = holder

		local listLayout = Instance.new("UIListLayout")
		listLayout.Padding = UDim.new(0, 6)
		listLayout.SortOrder = Enum.SortOrder.LayoutOrder
		listLayout.Parent = list

		local optionButtons = {}

		local function close()
			opened = false
			tween(holder, {Size = UDim2.new(1, 0, 0, 46)}, 0.16)
			main.Text = "  " .. tostring(text or "Dropdown") .. ": " .. tostring(selected) .. "   ▼"
		end

		local function open()
			opened = true
			local targetHeight = 52 + (#options * 36) + math.max(0, (#options - 1) * 6)
			tween(holder, {Size = UDim2.new(1, 0, 0, targetHeight)}, 0.16)
			main.Text = "  " .. tostring(text or "Dropdown") .. ": " .. tostring(selected) .. "   ▲"
		end

		for _, option in ipairs(options) do
			local opt = Instance.new("TextButton")
			opt.Size = UDim2.new(1, 0, 0, 36)
			opt.BackgroundColor3 = self.UI.Theme.Panel2
			opt.Text = tostring(option)
			opt.TextColor3 = self.UI.Theme.Text
			opt.TextSize = 13
			opt.Font = Enum.Font.GothamBold
			opt.AutoButtonColor = false
			opt.BorderSizePixel = 0
			opt.Parent = list
			makeCorner(opt, 9)

			opt.MouseButton1Click:Connect(function()
				selected = option
				close()
				if callback then callback(selected) end
			end)

			table.insert(optionButtons, opt)
		end

		main.MouseButton1Click:Connect(function()
			if opened then close() else open() end
		end)

		return {
			Instance = holder,
			Get = function() return selected end,
			Set = function(_, value)
				selected = value
				main.Text = "  " .. tostring(text or "Dropdown") .. ": " .. tostring(selected) .. "   ▼"
				if callback then callback(selected) end
			end
		}
	end

	function tab:Textbox(text, placeholder, callback)
		local holder = Instance.new("Frame")
		holder.Name = "TextboxHolder"
		holder.Size = UDim2.new(1, 0, 0, 52)
		holder.BackgroundColor3 = self.UI.Theme.Element
		holder.BorderSizePixel = 0
		holder.Parent = page
		makeCorner(holder, 12)
		makeStroke(holder, self.UI.Theme.Stroke, 0.58, 1)

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0.35, -12, 1, 0)
		label.Position = UDim2.new(0, 12, 0, 0)
		label.BackgroundTransparency = 1
		label.Text = tostring(text or "Text")
		label.TextColor3 = self.UI.Theme.Text
		label.TextSize = 13
		label.Font = Enum.Font.GothamBold
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.Parent = holder

		local box = Instance.new("TextBox")
		box.Size = UDim2.new(0.65, -18, 0, 34)
		box.Position = UDim2.new(0.35, 6, 0.5, -17)
		box.BackgroundColor3 = self.UI.Theme.Panel2
		box.PlaceholderText = placeholder or "Digite..."
		box.PlaceholderColor3 = self.UI.Theme.Muted
		box.Text = ""
		box.TextColor3 = self.UI.Theme.Text
		box.TextSize = 13
		box.Font = Enum.Font.Gotham
		box.ClearTextOnFocus = false
		box.BorderSizePixel = 0
		box.Parent = holder
		makeCorner(box, 9)

		box.FocusLost:Connect(function()
			if callback then callback(box.Text) end
		end)

		return box
	end

	button.MouseButton1Click:Connect(function()
		tab:Show()
	end)

	button.MouseEnter:Connect(function()
		if self.CurrentTab ~= tab then
			tween(button, {BackgroundColor3 = self.Theme.Element2}, 0.12)
		end
	end)

	button.MouseLeave:Connect(function()
		if self.CurrentTab ~= tab then
			tween(button, {BackgroundColor3 = self.Theme.Element}, 0.12)
		end
	end)

	tab.Button = button
	tab.Page = page

	table.insert(self.Tabs, tab)

	if not self.CurrentTab then
		tab:Show()
	end

	self:ApplySidebarMode()

	return tab
end

function DyX:CreateHomeTab()
	local Home = self:CreateTab("Home", "⌂")

	Home:Section("Catálogo de versões")
	Home:Label("DyX Framework " .. DyX.Version)
	Home:Label("Interface global carregada com Home + Config obrigatórias.")

	Home:Button("Free", function()
		self:Notify("Free: acesso básico à interface e funções públicas.", 5)
	end)

	Home:Button("Premium", function()
		self:Notify("Premium: recursos extras por jogo e melhorias futuras.", 5)
	end)

	Home:Button("Ultimate", function()
		self:Notify("Ultimate: acesso completo e prioridade nas features.", 5)
	end)

	Home:Section("Status")
	Home:Label("Plano atual: " .. tostring(self.KeyTier))
	Home:Label("Player: " .. LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")")

	Home:Button("Abrir informações do perfil/key", function()
		self:OpenProfileInfo()
	end)
end

function DyX:CreateConfigTab()
	local Config = self:CreateTab("Config", "⚙")

	Config:Section("Aparência")

	Config:Dropdown("Tema", getSortedThemeNames(), self.Settings.Theme, function(value)
		self:SetTheme(value)
	end)

	Config:Dropdown("Sidebar", {"IconText", "Icon", "Text"}, self.Settings.SidebarMode, function(value)
		self.Settings.SidebarMode = value
		self:ApplySidebarMode()
		self:SaveConfig()
		self:Notify("Sidebar alterada para: " .. value, 4)
	end)

	Config:Slider("Opacidade Fundo", 0, 90, math.floor((self.Settings.BackgroundOpacity or 0) * 100), function(value)
		self:SetOpacity(value / 100)
	end)

	Config:Slider("Timer Notify", 1, 15, self.Settings.NotifyTime or 5, function(value)
		self.Settings.NotifyTime = value
		self:SaveConfig()
	end)

	Config:Section("Sistema")

	Config:Toggle("AutoSave", self.Settings.AutoSave, function(value)
		self.Settings.AutoSave = value
		self:SaveConfig()
		self:Notify("AutoSave: " .. tostring(value), 4)
	end)

	Config:Toggle("AutoExecute", self.Settings.AutoExecute, function(value)
		self.Settings.AutoExecute = value
		self:SaveConfig()
		self:Notify("AutoExecute: " .. tostring(value), 4)
	end)

	Config:Button("Recarregar Interface", function()
		self:Notify("Recarregando...", 1.2)
		self:Reload()
	end)

	Config:Button("Ocultar Menu", function()
		self:Toggle()
	end)

	Config:Button("Destruir Interface", function()
		self:Destroy()
	end)
end

function DyX:OpenProfileInfo()
	if self.ProfileModal then
		self.ProfileModal:Destroy()
		self.ProfileModal = nil
		return
	end

	local overlay = Instance.new("Frame")
	overlay.Name = "ProfileModal"
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.Position = UDim2.new(0, 0, 0, 0)
	overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	overlay.BackgroundTransparency = 0.45
	overlay.BorderSizePixel = 0
	overlay.Parent = self.Gui
	self.ProfileModal = overlay

	local card = Instance.new("Frame")
	card.Name = "ProfileCard"
	card.Size = UDim2.new(0, 360, 0, 330)
	card.Position = UDim2.new(0.5, -180, 0.5, -165)
	card.BackgroundColor3 = self.Theme.Panel
	card.BorderSizePixel = 0
	card.Parent = overlay
	makeCorner(card, 16)
	makeStroke(card, self.Theme.Stroke, 0.32, 1)

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -56, 0, 48)
	title.Position = UDim2.new(0, 16, 0, 0)
	title.BackgroundTransparency = 1
	title.Text = "Perfil / Key"
	title.TextColor3 = self.Theme.Text
	title.TextSize = 17
	title.Font = Enum.Font.GothamBlack
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = card

	local close = Instance.new("TextButton")
	close.Size = UDim2.new(0, 34, 0, 30)
	close.Position = UDim2.new(1, -44, 0, 9)
	close.BackgroundColor3 = self.Theme.Element
	close.Text = "×"
	close.TextColor3 = self.Theme.Text
	close.TextSize = 20
	close.Font = Enum.Font.GothamBold
	close.BorderSizePixel = 0
	close.Parent = card
	makeCorner(close, 9)

	local avatar = Instance.new("ImageLabel")
	avatar.Size = UDim2.new(0, 70, 0, 70)
	avatar.Position = UDim2.new(0, 18, 0, 60)
	avatar.BackgroundColor3 = self.Theme.Element
	avatar.BorderSizePixel = 0
	avatar.Image = self.Avatar and self.Avatar.Image or ""
	avatar.Parent = card
	makeCorner(avatar, 999)

	local name = Instance.new("TextLabel")
	name.Size = UDim2.new(1, -110, 0, 24)
	name.Position = UDim2.new(0, 104, 0, 66)
	name.BackgroundTransparency = 1
	name.Text = tostring(LocalPlayer.DisplayName)
	name.TextColor3 = self.Theme.Text
	name.TextSize = 16
	name.Font = Enum.Font.GothamBold
	name.TextXAlignment = Enum.TextXAlignment.Left
	name.Parent = card

	local user = Instance.new("TextLabel")
	user.Size = UDim2.new(1, -110, 0, 22)
	user.Position = UDim2.new(0, 104, 0, 92)
	user.BackgroundTransparency = 1
	user.Text = "@" .. tostring(LocalPlayer.Name)
	user.TextColor3 = self.Theme.Muted
	user.TextSize = 13
	user.Font = Enum.Font.Gotham
	user.TextXAlignment = Enum.TextXAlignment.Left
	user.Parent = card

	local tier = Instance.new("TextLabel")
	tier.Size = UDim2.new(1, -110, 0, 22)
	tier.Position = UDim2.new(0, 104, 0, 114)
	tier.BackgroundTransparency = 1
	tier.Text = tostring(self.KeyTier) .. " • " .. tostring(DyX.Version)
	tier.TextColor3 = self.Theme.Accent
	tier.TextSize = 13
	tier.Font = Enum.Font.GothamBold
	tier.TextXAlignment = Enum.TextXAlignment.Left
	tier.Parent = card

	local info = Instance.new("Frame")
	info.Size = UDim2.new(1, -32, 0, 160)
	info.Position = UDim2.new(0, 16, 0, 150)
	info.BackgroundColor3 = self.Theme.Element
	info.BorderSizePixel = 0
	info.Parent = card
	makeCorner(info, 12)

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 6)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = info

	makePadding(info, 12, 12, 12, 12)

	local function row(labelText)
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 0, 22)
		label.BackgroundTransparency = 1
		label.Text = labelText
		label.TextColor3 = self.Theme.Text
		label.TextSize = 13
		label.Font = Enum.Font.Gotham
		label.TextXAlignment = Enum.TextXAlignment.Left
		label.TextTruncate = Enum.TextTruncate.AtEnd
		label.Parent = info
	end

	row("UserId: " .. tostring(LocalPlayer.UserId))
	row("Plano: " .. tostring(self.KeyTier))
	row("Owner: " .. tostring(self.KeyOwner))
	row("Expira: " .. tostring(self.KeyExpire))
	row("Tema: " .. tostring(self.Settings.Theme))
	row("Sidebar: " .. tostring(self.Settings.SidebarMode))

	close.MouseButton1Click:Connect(function()
		if overlay then overlay:Destroy() end
		self.ProfileModal = nil
	end)

	overlay.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if input.Target == overlay then
				overlay:Destroy()
				self.ProfileModal = nil
			end
		end
	end)
end


function DyX:Notify(text, duration)
	duration = tonumber(duration) or self.Settings.NotifyTime or 5

	local frame = Instance.new("Frame")
	frame.Name = "Notify"
	frame.Size = UDim2.new(1, 0, 0, 62)
	frame.BackgroundColor3 = self.Theme.Panel
	frame.BackgroundTransparency = 0
	frame.BorderSizePixel = 0
	frame.Parent = self.NotifyHolder
	makeCorner(frame, 13)
	makeStroke(frame, self.Theme.Stroke, 0.38, 1)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -56, 1, -12)
	label.Position = UDim2.new(0, 12, 0, 6)
	label.BackgroundTransparency = 1
	label.Text = tostring(text or "Notify")
	label.TextColor3 = self.Theme.Text
	label.TextSize = 13
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextWrapped = true
	label.Parent = frame

	local close = Instance.new("TextButton")
	close.Size = UDim2.new(0, 30, 0, 30)
	close.Position = UDim2.new(1, -40, 0, 8)
	close.BackgroundColor3 = self.Theme.Element
	close.Text = "×"
	close.TextColor3 = self.Theme.Text
	close.TextSize = 18
	close.Font = Enum.Font.GothamBold
	close.BorderSizePixel = 0
	close.Parent = frame
	makeCorner(close, 9)

	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(1, 0, 0, 3)
	bar.Position = UDim2.new(0, 0, 1, -3)
	bar.BackgroundColor3 = self.Theme.Accent
	bar.BorderSizePixel = 0
	bar.Parent = frame

	local closed = false

	local function destroy()
		if closed then return end
		closed = true

		tween(frame, {BackgroundTransparency = 1}, 0.18)
		tween(label, {TextTransparency = 1}, 0.18)
		tween(close, {TextTransparency = 1, BackgroundTransparency = 1}, 0.18)
		tween(bar, {BackgroundTransparency = 1}, 0.18)

		task.delay(0.22, function()
			if frame then frame:Destroy() end
		end)
	end

	close.MouseButton1Click:Connect(destroy)

	tween(bar, {Size = UDim2.new(0, 0, 0, 3)}, duration)

	task.delay(duration, destroy)

	return frame
end

function DyX:Destroy()
	if self.Gui then
		self.Gui:Destroy()
	end
end

return DyX
