--// Global flags for styling

type table = {
    [any]: any
}
type FlagFunc = {
	Data: {
		Class: {},
		WindowClass: table?
	},
	Object: GuiObject
}

local Wrappers = require("@classes/Wrappers.lua")
local ReGui = nil

Wrappers:AddOnInit(function(self)
	ReGui = self
end)

return {
	{
		Properties = {"Center"},
		Callback = function<FlagFunc>(Data, Object, Value)
			local Position = Object.Position
			Wrappers:SetProperties(Object, {
				Position = UDim2.new(
					Value:find("X") and 0.5 or Position.X.Scale,
					Position.X.Offset,
					Value:find("Y") and 0.5 or Position.Y.Scale,
					Position.Y.Offset
				),
				AnchorPoint = Vector2.new(
					Value:find("X") and 0.5 or 0,
					Value:find("Y") and 0.5 or 0
				)
			})
		end,
	},
	{
		Properties = {"ElementStyle"},
		Callback = function<StyleFunc>(Data, Object, Value)
			ReGui:ApplyStyle(Object, Value)
		end,
	},
	{
		Properties = {"ColorTag"},
		Callback = function<StyleFunc>(Data, Object, Value)
			local Class = Data.Class
			local WindowClass = Data.WindowClass
			local NoAutoTheme = Class.NoAutoTheme

			--// Check if theming is enabled
			if not WindowClass then return end
			if NoAutoTheme then return end

			ReGui:UpdateColors({
				Object = Object,
				Tag = Value,
				NoAnimation = true,
				Theme = WindowClass.Theme,
			})
		end,
	},
	{
		Properties = {"Animation"},
		Callback = function<StyleFunc>(Data, Object, Value)
			--// Check if animations are disabled
			local NoAnimation = Data.Class.NoAnimation
			if NoAnimation then return end

			ReGui:SetAnimation(Object, Value)
		end,
	},
	{
		Properties = {"Image"},
		Callback = function<StyleFunc>(Data, Object, Value)
			local WindowClass = Data.WindowClass
			Object.Image = Wrappers:CheckAssetUrl(Value)
			ReGui:DynamicImageTag(Object, Value, WindowClass)
		end,
	},
	{
		Properties = {"Icon", "IconSize", "IconRotation", "IconPadding"},
		Callback = function<StyleFunc>(Data, Object, Value)
			--// Locate icon element
			local Icon = Object:FindFirstChild("Icon", true)
			if not Icon then 
                ReGui:Warn("No icon for", Object) 
				return
			end 

			--// Check class data for missing values
			local Class = Data.Class
			Wrappers:CheckConfig(Class, {
				Icon = "",
				IconSize = UDim2.fromScale(1,1),
				IconRotation = 0,
				IconPadding = UDim2.new(0, 2)
			})

			--// Apply icon padding
			local Padding = Icon.Parent:FindFirstChild("UIPadding")
			Wrappers:SetPadding(Padding, Class.IconPadding)

			--// Check image asset url
			local Image = Class.Icon
			Image = Wrappers:CheckAssetUrl(Image)

			--// Dynamic image
			local WindowClass = Data.WindowClass
			ReGui:DynamicImageTag(Icon, Image, WindowClass)
			Wrappers:SetProperties(Icon, {
				Visible = Icon ~= "",
				Image = Wrappers:CheckAssetUrl(Image),
				Size = Class.IconSize,
				Rotation = Class.IconRotation
			})
		end,
	},
	{
		Properties = {"BorderThickness", "Border", "BorderColor"},
		Callback = function<StyleFunc>(Data, Object, Value)
			local Class = Data.Class
			local Enabled = Class.Border == true

			Wrappers:CheckConfig(Class, {
				BorderTransparency = Data:GetThemeKey("BorderTransparencyActive"),
				BorderColor = Data:GetThemeKey("Border"),
				BorderThickness = 1,
				BorderStrokeMode = Enum.ApplyStrokeMode.Border,
			})

			--// Apply properties to UIStroke
			local Stroke = Wrappers:GetChildOfClass(Object, "UIStroke")
			Wrappers:SetProperties(Stroke, {
				Transparency = Class.BorderTransparency,
				Thickness = Class.BorderThickness,
				Color = Class.BorderColor,
				ApplyStrokeMode = Class.BorderStrokeMode,
				Enabled = Enabled
			})
		end,
	},
	{
		Properties = {"Ratio"},
		Callback = function<StyleFunc>(Data, Object, Value)
			local Class = Data.Class

			Wrappers:CheckConfig(Class, {
				Ratio = 4/3,
				RatioAxis = Enum.DominantAxis.Height,
				RatioAspectType = Enum.AspectType.ScaleWithParentSize
			})

			--// Unpack data
			local AspectRatio = Class.Ratio
			local Axis = Class.RatioAxis
			local AspectType = Class.RatioAspectType

			local Ratio = Wrappers:GetChildOfClass(Object, "UIAspectRatioConstraint")
			Wrappers:SetProperties(Ratio, {
				DominantAxis = Axis,
				AspectType = AspectType,
				AspectRatio = AspectRatio
			})
		end,
	},
	{
		Properties = {"FlexMode"},
		Callback = function<StyleFunc>(Data, Object, Value)
			local FlexItem = Wrappers:GetChildOfClass(Object, "UIFlexItem")
			FlexItem.FlexMode = Value
		end,
	},
	{
		--Recursive = true,
		Properties = {"CornerRadius"},
		Callback = function<StyleFunc>(Data, Object, Value)
			local UICorner = Wrappers:GetChildOfClass(Object, "UICorner")
			UICorner.CornerRadius = Value
		end,
	},
	{
		Properties = {"Fill"},
		Callback = function<StyleFunc>(Data, Object, Value)
			if Value ~= true then return end

			local Class = Data.Class
			Wrappers:CheckConfig(Class, {
				Size = UDim2.fromScale(1, 1),
				UIFlexMode = Enum.UIFlexMode.Fill,
				AutomaticSize = Enum.AutomaticSize.None
			})

			--// Create FlexLayout property
			local Flex = Wrappers:GetChildOfClass(Object, "UIFlexItem")
			Flex.FlexMode = Class.UIFlexMode

			Object.Size = Class.Size
			Object.AutomaticSize = Class.AutomaticSize
		end,
	},
	{
		Properties = {"Label"},
		Callback = function<StyleFunc>(Data, Object, Value)
            local Class = Data.Class

			local Label = Object:FindFirstChild("Label")
			if not Label then return end
			
            Label.Text = tostring(Value)

			function Class:SetLabel(Text)
				Label.Text = Text
				return self
			end
		end,
	},
	{
		Properties = {"NoGradient"},
		WindowProperties = {"NoGradients"},
		Callback = function<StyleFunc>(Data, Object, Value)
			local UIGradient = Object:FindFirstChildOfClass("UIGradient")
			if not UIGradient then return end

			UIGradient.Enabled = Value
		end,
	},
	{
		Properties = {
			"UiPadding", 
			"PaddingBottom", 
			"PaddingTop",
			"PaddingRight", 
			"PaddingTop"
		},
		Callback = function<StyleFunc>(Data, Object, Value)
			Value = Value or 0

			--// Convert number value into a UDim
			if typeof(Value) == "number" then
				Value = UDim.new(0, Value)
			end

			local Class = Data.Class

			local IsUiPadding = Class.UiPadding
			if IsUiPadding then
				Wrappers:CheckConfig(Class, {
					PaddingBottom = Value,
					PaddingLeft = Value,
					PaddingRight = Value,
					PaddingTop = Value,
				})
			end

			local UIPadding = Wrappers:GetChildOfClass(Object, "UIPadding")
			Wrappers:SetProperties(UIPadding, {
				PaddingBottom = Class.PaddingBottom,
				PaddingLeft = Class.PaddingLeft,
				PaddingRight = Class.PaddingRight,
				PaddingTop = Class.PaddingTop,
			})
		end,
	},
	{
		Properties = {"Callback"},
		Callback = function<StyleFunc>(Data, Object)
			local Class = Data.Class

			function Class:SetCallback(NewCallback)
				self.Callback = NewCallback
				return self
			end
			function Class:FireCallback(NewCallback)
				self.Callback(Object)
				return self
			end
		end,
	},
	{
		Properties = {"Value"},
		Callback = function<StyleFunc>(Data, Object)
			local Class = Data.Class
			Wrappers:CheckConfig(Class, {
				GetValue = function(self)
					return Class.Value
				end,
			})
		end
	}
}
