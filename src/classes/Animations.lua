--// Animation class

type table = {
    [any]: any
}

export type ObjectTable = { 
	[GuiObject]: any 
}

local Wrappers = require("@classes/Wrappers.lua")
local Animation = {
    DefaultTweenInfo = TweenInfo.new(0.08),
}

local Services = Wrappers.Services
local TweenService = Services.TweenService

type AnimationTween = {
	Object: Instance,
	NoAnimation: boolean?,
	Tweeninfo: TweenInfo?,
    StartProperties: table?,
	EndProperties: table,
	Completed: (() -> any?)?
}
function Animation:Tween(Data: AnimationTween): Tween?
	local DefaultTweenInfo = self.DefaultTweenInfo

	--// Unpack animation data for the Tween
	local Object = Data.Object
	local NoAnimation = Data.NoAnimation
	local Tweeninfo = Data.Tweeninfo or DefaultTweenInfo
	local EndProperties = Data.EndProperties
	local StartProperties = Data.StartProperties
	local Completed = Data.Completed

	--// Apply Start Properties to the object
	if StartProperties then
		Wrappers:SetProperties(Object, StartProperties)
	end

	--// Set properties without a tween for NoAnimation flag
	if NoAnimation then
		Wrappers:SetProperties(Object, EndProperties)

		--// Invoke Completed event
		if Completed then
			Completed()
		end
		return
	end

	--// Create the tween animation
	local MasterTween = nil
	for Key, Value in next, EndProperties do
		local Properties = {
			[Key] = Value
		}

		--// Create the tween for the property
		local Success, Tween = pcall(function()
			return TweenService:Create(Object, Tweeninfo, Properties)
		end)

		--// Set Properties instead of tweening
		if not Success then
			Wrappers:SetProperties(Object, Properties)
			continue
		end

		--// Set the MasterTween if it does not exist
		if not MasterTween then
			MasterTween = Tween
		end

		Tween:Play()
	end

	--// Connect the TweenCompleted event
	if Completed then
		if MasterTween then
			MasterTween.Completed:Connect(Completed)
		else
			Completed()
		end
	end

	return MasterTween
end

type Animate = {
	NoAnimation: boolean?,
	Objects: ObjectTable,
	Tweeninfo: TweenInfo?,
	Completed: () -> any,
}
function Animation:Animate(Data: Animate): Tween
	local NoAnimation = Data.NoAnimation
	local Objects = Data.Objects
	local Tweeninfo = Data.Tweeninfo
	local Completed = Data.Completed

	local BaseTween = nil

	--// Create tweens
	for Object, EndProperties in next, Objects do
		local Tween = self:Tween({
			NoAnimation = NoAnimation,
			Object = Object,
			Tweeninfo = Tweeninfo, 
			EndProperties = EndProperties
		})

		if not BaseTween then
			BaseTween = Tween
		end
	end

	--// Connect completed event call
	if Completed then
		BaseTween.Completed:Connect(Completed)
	end

	return BaseTween
end

type HeaderCollapseToggle = {
	Rotations: {
		Open: number?,
		Closed: number?
	}?,
	Toggle: GuiObject,
	NoAnimation: boolean?,
	Collapsed: boolean,
	Tweeninfo: TweenInfo?,
}
function Animation:HeaderCollapseToggle(Data: HeaderCollapseToggle)
	--// Check configuration
	Wrappers:CheckConfig(Data, {
		Rotations = {
			Open = 90,
			Closed = 0
		}
	})

	--// Unpack configuration
	local Toggle = Data.Toggle
	local NoAnimation = Data.NoAnimation
	local Rotations = Data.Rotations
	local Collapsed = Data.Collapsed
	local Tweeninfo = Data.Tweeninfo

	local Rotation = Collapsed and Rotations.Closed or Rotations.Open

	--// Animate toggle
	self:Tween({
		Tweeninfo = Tweeninfo,
		NoAnimation = NoAnimation,
		Object = Toggle,
		EndProperties = {
			Rotation = Rotation,
		}
	})
end

type HeaderCollapse = {
	Collapsed: boolean,
	ClosedSize: UDim2,
	OpenSize: UDim2,
	Toggle: Instance,
	Resize: Instance?,
	Hide: Instance?,
	NoAnimation: boolean?,
	NoAutomaticSize: boolean?,
	Tweeninfo: TweenInfo?,
	IconOnly: boolean?,
	Completed: (() -> any)?,
	IconRotations: {
		Open: number?,
		Closed: number?
	}?
}
function Animation:HeaderCollapse(Data: HeaderCollapse): Tween
	--// Unpack config
	local Tweeninfo = Data.Tweeninfo
	local Collapsed = Data.Collapsed
	local ClosedSize = Data.ClosedSize
	local OpenSize: UDim2 = Data.OpenSize
	local Toggle = Data.Toggle
	local Resize = Data.Resize
	local Hide = Data.Hide
	local NoAnimation = Data.NoAnimation
	local NoAutomaticSize = Data.NoAutomaticSize
	local Rotations = Data.IconRotations
	local Completed = Data.Completed

	--// Apply base properties
	if not NoAutomaticSize then
		Resize.AutomaticSize = Enum.AutomaticSize.None
	end
	if not Collapsed then
		Hide.Visible = true
	end

	--// Build and play animation keyframes
	self:HeaderCollapseToggle({
		Tweeninfo = Tweeninfo,
		Collapsed = Collapsed,
		NoAnimation = NoAnimation,
		Toggle = Toggle,
		Rotations = Rotations
	})

	local Tween = self:Tween({
		Tweeninfo = Tweeninfo,
		NoAnimation = NoAnimation,
		Object = Resize,
		StartProperties = {
			Size = Collapsed and OpenSize or ClosedSize
		},
		EndProperties = {
			Size = Collapsed and ClosedSize or OpenSize
		},
		Completed = function()
			Hide.Visible = not Collapsed

			--// Invoke completed callback function
			if Completed then 
				Completed() 
			end

			--// Reset AutomaticSize after animation
			if Collapsed then return end
			if NoAutomaticSize then return end

			--// Reset sizes of the object
			Resize.Size = UDim2.fromScale(1, 0)
			Resize.AutomaticSize = Enum.AutomaticSize.Y
		end,
	})

	return Tween
end

return Animation