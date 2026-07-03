local MainUrl = "https://raw.githubusercontent.com/GlitchBruxo/DyX/refs/heads/main/UI/MainUI.%20lua"

local DyX = loadstring(game:HttpGet(MainUrl))()

local UI = DyX.new({
	Title = "DyX Test Hub",
	Theme = "AmoledGreen",
	KeyTier = "Free",
	ToggleKey = Enum.KeyCode.RightShift,
	ScriptUrl = "https://raw.githubusercontent.com/GlitchBruxo/DyX/refs/heads/main/TestUI/Test.lua"
})

local Home = UI:CreateTab("Home", "⌂")
local Player = UI:CreateTab("Player", "👤")
local World = UI:CreateTab("World", "🌎")

Home:Section("Teste")
Home:Button("Testar Notify", function()
	UI:Notify("Notify funcionando.")
end)

Player:Section("Componentes")
Player:Toggle("Toggle Teste", false, function(v)
	print("Toggle:", v)
end)

Player:Slider("Slider Teste", 1, 10, 5, function(v)
	print("Slider:", v)
end)

Player:Textbox("Texto", "Digite algo...", function(text)
	print("Texto:", text)
end)

World:Dropdown("Modo", {"Normal", "Teste", "Debug"}, "Normal", function(v)
	print("Modo:", v)
end)

UI:Notify("DyX UI carregada.")
