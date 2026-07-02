local MainRaw = "https://raw.githubusercontent.com/GlitchBruxo/DyX/refs/heads/main/UI/MainUI.%20lua"

local PrivateUI = loadstring(game:HttpGet(MainRaw))()

local UI = PrivateUI.new({
	Title = "DyX UI Test",
	Theme = "AmoledGreen",
	ToggleKey = Enum.KeyCode.RightShift
})

local Home = UI:CreateTab("Home")
local Player = UI:CreateTab("Player")
local Config = UI:CreateTab("Config")

Home:CreateSection("Teste Geral")

Home:CreateButton("Testar botão", function()
	print("Botão OK")
	UI:Notify("Botão funcionando!")
end)

Player:CreateSection("Player Test")

Player:CreateToggle("Toggle Teste", false, function(value)
	print("Toggle:", value)
	UI:Notify("Toggle: " .. tostring(value))
end)

Player:CreateSlider("Slider Teste", 1, 10, 5, function(value)
	print("Slider:", value)
end)

Player:CreateTextBox("Texto Teste", "Digite algo...", function(text)
	print("Texto:", text)
	UI:Notify("Texto: " .. text)
end)

Config:CreateSection("Temas")

for themeName in pairs(PrivateUI.Themes) do
	Config:CreateButton(themeName, function()
		UI:SetTheme(themeName)
		UI:Notify("Tema: " .. themeName)
	end)
end

Home:CreateButton("Destruir UI", function()
	UI:Destroy()
end)

UI:Notify("DyX UI carregada!")
