local MainUrl = "https://raw.githubusercontent.com/GlitchBruxo/DyX/refs/heads/main/UI/MainUI.lua"

local DyX = loadstring(game:HttpGet(MainUrl))()

local UI = DyX.new({
	Title = "DyX Test Hub",
	Theme = "AmoledGreen",
	KeyTier = "Free",
	KeyExpire = "Nunca",
	ToggleKey = Enum.KeyCode.RightShift,
	ScriptUrl = "https://raw.githubusercontent.com/GlitchBruxo/DyX/refs/heads/main/TestUI/Test.lua"
})

local PlayerTab = UI:CreateTab("Player", "👤")
local WorldTab = UI:CreateTab("World", "🌎")
local DebugTab = UI:CreateTab("Debug", "🧪")

PlayerTab:Section("Componentes")
PlayerTab:Button("Testar Notify", function()
	UI:Notify("Notificação funcionando com timer e botão X.")
end)

PlayerTab:Toggle("Toggle Teste", false, function(value)
	print("Toggle:", value)
	UI:Notify("Toggle: " .. tostring(value), 3)
end)

PlayerTab:Slider("Slider Teste", 1, 100, 50, function(value)
	print("Slider:", value)
end)

PlayerTab:Textbox("Texto Teste", "Digite algo...", function(text)
	print("Texto:", text)
	UI:Notify("Texto: " .. text, 4)
end)

WorldTab:Section("Dropdown")
WorldTab:Dropdown("Modo", {"Normal", "Teste", "Debug"}, "Normal", function(value)
	print("Modo:", value)
	UI:Notify("Modo: " .. tostring(value), 3)
end)

DebugTab:Section("Debug")
DebugTab:Label("RightShift abre/fecha no PC.")
DebugTab:Label("No mobile aparece uma bolinha DyX.")
DebugTab:Button("Abrir Perfil", function()
	UI:OpenProfileInfo()
end)

UI:Notify("DyX UI carregada com sucesso.")
