type ThemeData = {
	[string]: any
}

local Accent = require("@config/Accent.lua")
local ThemeConfigs = {}

ThemeConfigs.DarkTheme = {
	Values = {
		AnimationTweenInfo = TweenInfo.new(0.08),
		TextFont = Font.fromEnum(Enum.Font.RobotoMono),
		TextSize = 14,
		Text = Accent.White,
		TextDisabled = Accent.Gray,
		ErrorText = Accent.Red,

		FrameBg = Accent.Dark,
		FrameBgTransparency = 0.4,
		FrameBgActive = Accent.Light,
		FrameBgTransparencyActive = 0.4,
		FrameRounding = UDim.new(0, 0),

		--// Elements
		SliderGrab = Accent.Light,
		ButtonsBg = Accent.Light,
		CollapsingHeaderBg = Accent.Light,
		CollapsingHeaderText = Accent.White,
		CheckMark = Accent.Light,
		ResizeGrab = Accent.Light,
		HeaderBg = Accent.Gray,
		HeaderBgTransparency = 0.7,
		HistogramBar = Accent.Yellow,
		ProgressBar = Accent.Yellow,
		RegionBg = Accent.Dark,
		RegionBgTransparency = 0.1,
		Separator = Accent.Gray,
		SeparatorTransparency = 0.5,
		ConsoleLineNumbers = Accent.White,
		LabelPaddingTop = UDim.new(0, 0),
		LabelPaddingBottom = UDim.new(0, 0),
		MenuBar = Accent.ExtraDark,
		MenuBarTransparency = 0.1,
		PopupCanvas = Accent.Black,

		--// TabSelector
		TabTextPaddingTop = UDim.new(0, 3),
		TabTextPaddingBottom = UDim.new(0, 8),
		TabText = Accent.Gray,
		TabBg = Accent.Dark,
		TabTextActive = Accent.White,
		TabBgActive = Accent.Light,
		TabsBarBg = Color3.fromRGB(36, 36, 36),
		TabsBarBgTransparency = 1,
		TabPagePadding = UDim.new(0, 8),

		--// Window
		ModalWindowDimBg = Color3.fromRGB(230, 230, 230),
		ModalWindowDimTweenInfo = TweenInfo.new(0.2),

		WindowBg = Accent.Black,
		WindowBgTransparency = 0.05,

		Border = Accent.Gray,
		BorderTransparency = 0.8,
		BorderTransparencyActive = 0.5,

		Title = Accent.White,
		TitleAlign = Enum.TextXAlignment.Left,
		TitleBarBg = Accent.Black,
		TitleBarTransparency = 0,
		TitleActive = Accent.White,
		TitleBarBgActive = Accent.Dark,
		TitleBarTransparencyActive = 0.05,
		TitleBarBgCollapsed = Color3.fromRGB(0, 0, 0),
		TitleBarTransparencyCollapsed = 0.6,
	}
}
ThemeConfigs.LightTheme = {
	BaseTheme = ThemeConfigs.DarkTheme,
	Values = {
		Text = Accent.Black,
		TextFont = Font.fromEnum(Enum.Font.Ubuntu),
		TextSize = 14,

		FrameBg = Accent.Gray,
		FrameBgTransparency = 0.4,
		FrameBgActive = Accent.Light,
		FrameBgTransparencyActive = 0.6,

		SliderGrab = Accent.Light,
		ButtonsBg = Accent.Light,
		CollapsingHeaderText = Accent.Black,
		Separator = Accent.Black,
		ConsoleLineNumbers = Accent.Yellow,
		MenuBar = Color3.fromRGB(219, 219, 219),
		PopupCanvas = Accent.White,

		TabText = Accent.Black,
		TabTextActive = Accent.Black,

		WindowBg = Accent.White,
		Border = Accent.Gray,
		ResizeGrab = Accent.Gray,

		Title = Accent.Black,
		TitleAlign = Enum.TextXAlignment.Center,
		TitleBarBg = Accent.Gray,
		TitleActive = Accent.Black,
		TitleBarBgActive = Color3.fromRGB(186, 186, 186),
		TitleBarBgCollapsed = Accent.Gray
	}
}
ThemeConfigs.ImGui = {
	BaseTheme = ThemeConfigs.DarkTheme,
	Values = {
		AnimationTweenInfo = TweenInfo.new(0),
		Text = Color3.fromRGB(255, 255, 255),

		FrameBg = Accent.ImGui.Dark,
		FrameBgTransparency = 0.4,
		FrameBgActive = Accent.ImGui.Light,
		FrameBgTransparencyActive = 0.5,
		FrameRounding = UDim.new(0, 0),

		ButtonsBg = Accent.ImGui.Light,
		CollapsingHeaderBg = Accent.ImGui.Light,
		CollapsingHeaderText = Accent.White,
		CheckMark = Accent.ImGui.Light,
		ResizeGrab = Accent.ImGui.Light,
		MenuBar = Accent.ImGui.Gray,
		MenuBarTransparency = 0,
		PopupCanvas = Accent.ImGui.Black,

		TabText = Accent.Gray,
		TabBg = Accent.ImGui.Dark,
		TabTextActive = Accent.White,
		TabBgActive = Accent.ImGui.Light,

		WindowBg = Accent.ImGui.Black,
		WindowBgTransparency = 0.05,
		Border = Accent.Gray,
		BorderTransparency = 0.7,
		BorderTransparencyActive = 0.4,

		Title = Accent.White,
		TitleBarBg = Accent.ImGui.Black,
		TitleBarTransparency = 0,
		TitleBarBgActive = Accent.ImGui.Dark,
		TitleBarTransparencyActive = 0,
	}
}

return ThemeConfigs