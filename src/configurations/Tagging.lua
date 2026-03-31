local Tags = {}

Tags.Coloring = {
	["MenuBar"] = {
		BackgroundColor3 = "MenuBar",
		BackgroundTransparency = "MenuBarTransparency",
	},
	["FrameRounding"] = {
		CornerRadius = "FrameRounding"
	},
	["PopupCanvas"] = {
		BackgroundColor3 = "PopupCanvas"
	},
	["ModalWindowDim"] = {
		BackgroundColor3 = "ModalWindowDimBg"
	},
	["Selectable"] = "Button",
	["MenuButton"] = "Button",
	["Separator"] = {
		BackgroundColor3 = "Separator",
		BackgroundTransparency = "SeparatorTransparency",
	},
	["Region"] = {
		BackgroundColor3 = "RegionBg",
		BackgroundTransparency = "RegionBgTransparency",
	},
	["Label"] = {
		TextColor3 = "Text",
		FontFace = "TextFont",
		TextSize = "TextSize",
	},
	["ImageFollowsText"] = {
		ImageColor3 = "Text",
	},
	["ConsoleLineNumbers"] = {
		TextColor3 = "ConsoleLineNumbers",
		FontFace = "TextFont",
		TextSize = "TextSize",
	},
	["ConsoleText"] = "Label",
	["LabelDisabled"] = {
		TextColor3 = "TextDisabled",
		FontFace = "TextFont",
		TextSize = "TextSize",
	},
	["Plot"] = {
		BackgroundColor3 = "HistogramBar",
	},
	["Header"] = {
		BackgroundColor3 = "HeaderBg",
		BackgroundTransparency = "HeaderBgTransparency",
	},
	["WindowTitle"] = {
		TextXAlignment = "TitleAlign",
		FontFace = "TextFont",
		TextSize = "TextSize",
	},
	["TitleBar"] = {
		BackgroundColor3 = "TitleBarBgActive"
	},
	["Window"] = {
		BackgroundColor3 = "WindowBg",
		BackgroundTransparency = "WindowBgTransparency"
	},
	["TitleBarBgCollapsed"] = {
		BackgroundColor3 = "TitleBarBgCollapsed",
		BackgroundTransparency = "TitleBarTransparencyCollapsed"
	},
	["TitleBarBgActive"] = {
		BackgroundColor3 = "TitleBarBgActive",
		BackgroundTransparency = "TitleBarTransparencyActive"
	},
	["TitleBarBg"] = {
		BackgroundColor3 = "TitleBarBg",
		BackgroundTransparency = "TitleBarTransparency"
	},
	["TabsBar"] = {
		BackgroundColor3 = "TabsBarBg",
		BackgroundTransparency = "TabsBarBgTransparency",
	},
	["Border"] = {
		Color = "Border",
		Transparency = "BorderTransparency"
	},
	["ResizeGrab"] = {
		TextColor3 = "ResizeGrab"
	},
	["BorderActive"] = {
		Transparency = "BorderTransparencyActive"
	},
	["Frame"] = {
		BackgroundColor3 = "FrameBg",
		BackgroundTransparency = "FrameBgTransparency",
		TextColor3 = "Text",
		FontFace = "TextFont",
		TextSize = "TextSize",
	},
	["FrameActive"] = {
		BackgroundColor3 = "FrameBgActive",
		BackgroundTransparency = "FrameBgTransparencyActive"
	},
	["SliderGrab"] = {
		BackgroundColor3 = "SliderGrab"
	},
	["Button"] = {
		BackgroundColor3 = "ButtonsBg",
		TextColor3 = "Text",
		FontFace = "TextFont",
		TextSize = "TextSize",
	},
	["CollapsingHeader"] = {
		FontFace = "TextFont",
		TextSize = "TextSize",
		TextColor3 = "CollapsingHeaderText",
		BackgroundColor3 = "CollapsingHeaderBg",
	},
	["Checkbox"] = {
		BackgroundColor3 = "FrameBg",
	},
	["CheckMark"] = {
		ImageColor3 = "CheckMark",
		BackgroundColor3 = "CheckMark",
	},
	["RadioButton"] = {
		BackgroundColor3 = "ButtonsBg",
		TextColor3 = "Text",
		FontFace = "TextFont",
		TextSize = "TextSize"
	}
}

Tags.Styles = {
	RadioButton = {
		Animation = "RadioButtons",
		CornerRadius = UDim.new(1, 0),
	},
	Button = {
		Animation = "Buttons"
	},
	CollapsingHeader = {
		Animation = "Buttons"
	},
	TreeNode = {
		Animation = "TransparentButtons"
	},
	TransparentButton = {
		Animation = "TransparentButtons"
	}
}

Tags.Animations = {
	["Invisible"] = {
		Connections = {
			MouseEnter = {
				Visible = true,
			},
			MouseLeave = {
				Visible = false,
			}
		},
		Init = "MouseLeave"
	},
	["Buttons"] = {
		Connections = {
			MouseEnter = {
				BackgroundTransparency = 0.3,
			},
			MouseLeave = {
				BackgroundTransparency = 0.7,
			}
		},
		Init = "MouseLeave"
	},
	["TextButtons"] = {
		Connections = {
			MouseEnter = {
				TextTransparency = 0.3,
			},
			MouseLeave = {
				TextTransparency = 0.7,
			}
		},
		Init = "MouseLeave"
	},
	["TransparentButtons"] = {
		Connections = {
			MouseEnter = {
				BackgroundTransparency = 0.3,
			},
			MouseLeave = {
				BackgroundTransparency = 1,
			}
		},
		Init = "MouseLeave"
	},
	["RadioButtons"] = {
		Connections = {
			MouseEnter = {
				BackgroundTransparency = 0.5,
			},
			MouseLeave = {
				BackgroundTransparency = 1,
			}
		},
		Init = "MouseLeave"
	},
	["Inputs"] = {
		Connections = {
			MouseEnter = {
				BackgroundTransparency = 0,
			},
			MouseLeave = {
				BackgroundTransparency = 0.5,
			},
		},
		Init = "MouseLeave"
	},
	["Plots"] = {
		Connections = {
			MouseEnter = {
				BackgroundTransparency = 0.3,
			},
			MouseLeave = {
				BackgroundTransparency = 0,
			},
		},
		Init = "MouseLeave"
	},
	["Border"] = {
		Connections = {
			Selected = {
				Transparency = 0,
				Thickness = 1
			},
			Deselected = {
				Transparency = 0.7,
				Thickness = 1
			}
		},
		Init = "Selected"
	},
}

return Tags