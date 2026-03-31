local Wrappers = {
    Services = {},
    OnInitConnections = {}
}

export type table = {
    [any]: any
}

--// Compatibility 
local GetHiddenUI = get_hidden_gui or gethui
local NewReference = cloneref or function(...): Instance 
	return ... 
end

--// Service handlers
local Services = Wrappers.Services
setmetatable(Services, {
	__index = function(self, Name: string)
		local Service = game:GetService(Name)
		return NewReference(Service)
	end,
})

--// Services
local CoreGui = Services.CoreGui

--// Modules
local ReGui

function Wrappers:AddOnInit(Func: (table)->nil)
    local Connections = self.OnInitConnections
    table.insert(Connections, Func)
end

function Wrappers:NewReference(Object: Instance): Instance
	return NewReference(Object)
end

function Wrappers:CallOnInitConnections(ReGuiModule, ...)
    local Connections = self.OnInitConnections
    ReGui = ReGuiModule

    for _, Func in next, Connections do
        Func(ReGui, ...)
    end
end

function Wrappers:SetProperties(Object: Instance, Properties: table)
	for Key: string, Value in next, Properties do
		pcall(function()
			Object[Key] = Value
		end)
	end
end

function Wrappers:NewClass(Class: table, Merge: table?)
	Merge = Merge or {}
	Class.__index = Class
	return setmetatable(Merge, Class)
end

function Wrappers:CheckConfig(Source: table, Base: table, Call: boolean?, IgnoreKeys: table?)
	if not Source then return end 

	for Key: string?, Value in next, Base do
		if Source[Key] ~= nil then continue end

		--// Check the key should be ignored
		if IgnoreKeys then
			if table.find(IgnoreKeys, Key) then continue end
		end

		--// Call value function
		if Call then
			Value = Value()
		end

		--// Set value
		Source[Key] = Value
	end

	return Source
end

function Wrappers:ResolveUIParent(): GuiObject?
	local PlayerGui = ReGui.PlayerGui
	local Debug = ReGui.Debug

	local Steps = {
		[1] = function()
			local Parent = GetHiddenUI()
			if Parent.Parent == CoreGui then return end

			return Parent
		end,
		[2] = function()
			return CoreGui
		end,
		[3] = function()
			return PlayerGui
		end
	}

	local Test = ReGui:CreateInstance("ScreenGui")

	--// Test each step for a successful parent
	for Step, Func in next, Steps do
		--// Test fetching the parent
		local Success, Parent = pcall(Func)
		if not Success or not Parent then continue end

		--// Test parenting
		local CanParent = pcall(function()
			Test.Parent = Parent
		end)
		if not CanParent then continue end

		if Debug then
			ReGui:Warn(`Step: {Step} was chosen as the parent!: {Parent}`)
		end

		return Parent
	end

	--// Error message
	ReGui:Warn("The ReGui container does not have a parent defined")

	return nil
end

function Wrappers:GetChildOfClass(Object: GuiObject, ClassName: string): GuiObject
	local Child = Object:FindFirstChildOfClass(ClassName)

	--// Create missing child
	if not Child then
		Child = ReGui:CreateInstance(ClassName, Object)
	end

	return Child
end

function Wrappers:CheckAssetUrl(Url: (string|number)): string
	--// Convert Id number to asset URL
	if tonumber(Url) then
		return `rbxassetid://{Url}`
	end
	return Url
end

function Wrappers:SetPadding(UiPadding: UIPadding, Padding: UDim)
	if not UiPadding then return end

	self:SetProperties(UiPadding, {
		PaddingBottom = Padding,
		PaddingLeft = Padding,
		PaddingRight = Padding,
		PaddingTop = Padding
	})
end

return Wrappers