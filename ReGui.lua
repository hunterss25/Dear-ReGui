type table__DARKLUA_TYPE_a = {[any]: any}
type table__DARKLUA_TYPE_b = {[any]: any}
type ObjectTable__DARKLUA_TYPE_c = {[GuiObject]: any}
type AnimationTween__DARKLUA_TYPE_d = {Object: Instance, NoAnimation: boolean?, Tweeninfo: TweenInfo?, StartProperties: table__DARKLUA_TYPE_b?, EndProperties: table__DARKLUA_TYPE_b, Completed: (() -> any?)?}
type Animate__DARKLUA_TYPE_e = {NoAnimation: boolean?, Objects: ObjectTable__DARKLUA_TYPE_c, Tweeninfo: TweenInfo?, Completed: () -> any}
type HeaderCollapseToggle__DARKLUA_TYPE_f = {Rotations: {Open: number?, Closed: number?}?, Toggle: GuiObject, NoAnimation: boolean?, Collapsed: boolean, Tweeninfo: TweenInfo?}
type HeaderCollapse__DARKLUA_TYPE_g = {Collapsed: boolean, ClosedSize: UDim2, OpenSize: UDim2, Toggle: Instance, Resize: Instance?, Hide: Instance?, NoAnimation: boolean?, NoAutomaticSize: boolean?, Tweeninfo: TweenInfo?, IconOnly: boolean?, Completed: (() -> any)?, IconRotations: {Open: number?, Closed: number?}?}
type SignalClass__DARKLUA_TYPE_h = {Connections: {[number]: (...any) -> nil}, Fire: (SignalClass__DARKLUA_TYPE_h, ...any) -> nil, GetConnections: (SignalClass__DARKLUA_TYPE_h) -> table__DARKLUA_TYPE_i, Connect: (SignalClass__DARKLUA_TYPE_h, (...any) -> nil) -> table__DARKLUA_TYPE_i, DisconnectConnections: (SignalClass__DARKLUA_TYPE_h) -> nil}
type table__DARKLUA_TYPE_i = {[any]: any}
type ThemeData__DARKLUA_TYPE_j = {[string]: any}
type table__DARKLUA_TYPE_k = {[any]: any}
type FlagFunc__DARKLUA_TYPE_l = {Data: {Class: {}, WindowClass: table__DARKLUA_TYPE_k?}, Object: GuiObject}

local a = {
    cache = {}::any,
}

do
    do
        local function __modImpl()
            local b = '8.0'
            local c = cloneref or function(c): Instance
                return c
            end
            local d = {
                Theme = {
                    Syntax = {
                        Text = Color3.fromRGB(204, 204, 204),
                        Background = Color3.fromRGB(20, 20, 20),
                        Selection = Color3.fromRGB(255, 255, 255),
                        SelectionBack = Color3.fromRGB(102, 161, 255),
                        Operator = Color3.fromRGB(204, 204, 204),
                        Number = Color3.fromRGB(255, 198, 0),
                        String = Color3.fromRGB(172, 240, 148),
                        Comment = Color3.fromRGB(102, 102, 102),
                        Keyword = Color3.fromRGB(248, 109, 124),
                        BuiltIn = Color3.fromRGB(132, 214, 247),
                        LocalMethod = Color3.fromRGB(253, 251, 172),
                        LocalProperty = Color3.fromRGB(97, 161, 241),
                        Nil = Color3.fromRGB(255, 198, 0),
                        Bool = Color3.fromRGB(255, 198, 0),
                        Function = Color3.fromRGB(248, 109, 124),
                        Local = Color3.fromRGB(248, 109, 124),
                        Self = Color3.fromRGB(248, 109, 124),
                        FunctionName = Color3.fromRGB(253, 251, 172),
                        Bracket = Color3.fromRGB(204, 204, 204),
                    },
                },
            }
            local e = setmetatable({}, {
                __index = function(e, f: string)
                    local g = game:GetService(f)

                    return c(g)
                end,
            })
            local f = {
                StartAndEnd = {
                    Enum.UserInputType.MouseButton1,
                    Enum.UserInputType.Touch,
                },
                Movement = {
                    Enum.UserInputType.MouseMovement,
                    Enum.UserInputType.Touch,
                },
            }
            local g: Players = e.Players
            local h: UserInputService = e.UserInputService
            local i: RunService = e.RunService
            local j: TweenService = e.TweenService
            local k = c(g.LocalPlayer)
            local l = c(k:GetMouse())

            local function Merge(m, n)
                for o, p in next, n do
                    m[o] = p
                end

                return m
            end
            local function InputTypeAllowed(m, n: string)
                local o = m.UserInputType

                return table.find(f[n], o)
            end
            local function NewInstance(...)
                return c(Instance.new(...))
            end
            local function createSimple(m, n)
                local o = NewInstance(m)

                for p, q in next, n do
                    o[p] = q
                end

                return o
            end

            local m = {}
            local n = NewInstance'Frame'

            m.CheckMouseInGui = function(o)
                if o == nil then
                    return false
                end

                local p = o.AbsolutePosition
                local q = o.AbsoluteSize

                return l.X >= p.X and l.X < p.X + q.X and l.Y >= p.Y and l.Y < p.Y + q.Y
            end
            m.Signal = (function()
                local o = {}
                local p = function(p)
                    local q = table.find(p.Signal.Connections, p)

                    if q then
                        table.remove(p.Signal.Connections, q)
                    end
                end

                o.Connect = function(q, r)
                    if type(r) ~= 'function' then
                        error'Attempt to connect a non-function'
                    end

                    local s = {
                        Signal = q,
                        Func = r,
                        Disconnect = p,
                    }

                    q.Connections[#q.Connections + 1] = s

                    return s
                end
                o.Fire = function(q, ...)
                    for r, s in next, q.Connections do
                        xpcall(coroutine.wrap(s.Func), function(t)
                            warn(t .. '\n' .. debug.traceback())
                        end, ...)
                    end
                end

                local q = {
                    __index = o,
                    __tostring = function(q)
                        return 'Signal: ' .. tostring(#q.Connections) .. ' Connections'
                    end,
                }

                local function new()
                    local r = {}

                    r.Connections = {}

                    return setmetatable(r, q)
                end

                return {new = new}
            end)()
            m.CreateArrow = function(o, p, q)
                local r = p
                local s = createSimple('Frame', {
                    BackgroundTransparency = 1,
                    Name = 'Arrow',
                    Size = UDim2.new(0, o, 0, o),
                })

                if q == 'up' then
                    for t = 1, p do
                        createSimple('Frame', {
                            BackgroundColor3 = Color3.new(0.8627450980392157, 0.8627450980392157, 0.8627450980392157),
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, math.floor(o / 2) - (t - 1), 0, math.floor(o / 2) + t - math.floor(r / 2) - 1),
                            Size = UDim2.new(0, t + (t - 1), 0, 1),
                            Parent = s,
                        })
                    end

                    return s
                elseif q == 'down' then
                    for t = 1, p do
                        createSimple('Frame', {
                            BackgroundColor3 = Color3.new(0.8627450980392157, 0.8627450980392157, 0.8627450980392157),
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, math.floor(o / 2) - (t - 1), 0, math.floor(o / 2) - t + math.floor(r / 2) + 1),
                            Size = UDim2.new(0, t + (t - 1), 0, 1),
                            Parent = s,
                        })
                    end

                    return s
                elseif q == 'left' then
                    for t = 1, p do
                        createSimple('Frame', {
                            BackgroundColor3 = Color3.new(0.8627450980392157, 0.8627450980392157, 0.8627450980392157),
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, math.floor(o / 2) + t - math.floor(r / 2) - 1, 0, math.floor(o / 2) - (t - 1)),
                            Size = UDim2.new(0, 1, 0, t + (t - 1)),
                            Parent = s,
                        })
                    end

                    return s
                elseif q == 'right' then
                    for t = 1, p do
                        createSimple('Frame', {
                            BackgroundColor3 = Color3.new(0.8627450980392157, 0.8627450980392157, 0.8627450980392157),
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, math.floor(o / 2) - t + math.floor(r / 2) + 1, 0, math.floor(o / 2) - (t - 1)),
                            Size = UDim2.new(0, 1, 0, t + (t - 1)),
                            Parent = s,
                        })
                    end

                    return s
                end

                error''
            end
            m.FastWait = (function(o)
                task.wait(o)
            end)
            m.ScrollBar = (function()
                local o = {}
                local p = m.CheckMouseInGui
                local q = m.CreateArrow

                local function drawThumb(r)
                    local s = r.TotalSpace
                    local t = r.VisibleSpace
                    local u = r.GuiElems.ScrollThumb
                    local v = r.GuiElems.ScrollThumbFrame

                    if not (r:CanScrollUp() or r:CanScrollDown()) then
                        u.Visible = false
                    else
                        u.Visible = true
                    end
                    if r.Horizontal then
                        u.Size = UDim2.new(t / s, 0, 1, 0)

                        if u.AbsoluteSize.X < 10 then
                            u.Size = UDim2.new(0, 10, 1, 0)
                        end

                        local w = v.AbsoluteSize.X
                        local x = u.AbsoluteSize.X

                        u.Position = UDim2.new(r:GetScrollPercent() * (w - x) / w, 0, 0, 0)
                    else
                        u.Size = UDim2.new(1, 0, t / s, 0)

                        if u.AbsoluteSize.Y < 10 then
                            u.Size = UDim2.new(1, 0, 0, 10)
                        end

                        local w = v.AbsoluteSize.Y
                        local x = u.AbsoluteSize.Y

                        u.Position = UDim2.new(0, 0, r:GetScrollPercent() * (w - x) / w, 0)
                    end
                end
                local function createFrame(r)
                    local s = createSimple('Frame', {
                        Style = 0,
                        Active = true,
                        AnchorPoint = Vector2.new(0, 0),
                        BackgroundColor3 = Color3.new(0.35294118523598, 0.35294118523598, 0.35294118523598),
                        BackgroundTransparency = 0,
                        BorderColor3 = Color3.new(0.10588236153126, 0.16470588743687, 0.20784315466881),
                        BorderSizePixel = 0,
                        ClipsDescendants = false,
                        Draggable = false,
                        Position = UDim2.new(1, -10, 0, 0),
                        Rotation = 0,
                        Selectable = false,
                        Size = UDim2.new(0, 10, 1, 0),
                        SizeConstraint = 0,
                        Visible = true,
                        ZIndex = 1,
                        Name = 'ScrollBar',
                    })
                    local t
                    local u

                    if r.Horizontal then
                        s.Size = UDim2.new(1, 0, 0, 10)
                        t = createSimple('ImageButton', {
                            Parent = s,
                            Name = 'Left',
                            Size = UDim2.new(0, 10, 0, 10),
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            AutoButtonColor = false,
                        })
                        q(10, 4, 'left').Parent = t
                        u = createSimple('ImageButton', {
                            Parent = s,
                            Name = 'Right',
                            Position = UDim2.new(1, -10, 0, 0),
                            Size = UDim2.new(0, 10, 0, 10),
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            AutoButtonColor = false,
                        })
                        q(10, 4, 'right').Parent = u
                    else
                        s.Size = UDim2.new(0, 10, 1, 0)
                        t = createSimple('ImageButton', {
                            Parent = s,
                            Name = 'Up',
                            Size = UDim2.new(0, 10, 0, 10),
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            AutoButtonColor = false,
                        })
                        q(10, 4, 'up').Parent = t
                        u = createSimple('ImageButton', {
                            Parent = s,
                            Name = 'Down',
                            Position = UDim2.new(0, 0, 1, -10),
                            Size = UDim2.new(0, 10, 0, 10),
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            AutoButtonColor = false,
                        })
                        q(10, 4, 'down').Parent = u
                    end

                    local v = createSimple('Frame', {
                        BackgroundTransparency = 1,
                        Parent = s,
                    })

                    if r.Horizontal then
                        v.Position = UDim2.new(0, 10, 0, 0)
                        v.Size = UDim2.new(1, -20, 1, 0)
                    else
                        v.Position = UDim2.new(0, 0, 0, 10)
                        v.Size = UDim2.new(1, 0, 1, -20)
                    end

                    local w = createSimple('Frame', {
                        BackgroundColor3 = Color3.new(0.47058823529411764, 0.47058823529411764, 0.47058823529411764),
                        BorderSizePixel = 0,
                        Parent = v,
                    })
                    local x = createSimple('Frame', {
                        BackgroundTransparency = 1,
                        Name = 'Markers',
                        Size = UDim2.new(1, 0, 1, 0),
                        Parent = v,
                    })
                    local y = false
                    local z = false
                    local A = false

                    t.InputBegan:Connect(function(B)
                        if InputTypeAllowed(B, 'Movement') and not y and r:CanScrollUp() then
                            t.BackgroundTransparency = 0.8
                        end
                        if not InputTypeAllowed(B, 'StartAndEnd') or not r:CanScrollUp() then
                            return
                        end

                        y = true
                        t.BackgroundTransparency = 0.5

                        if r:CanScrollUp() then
                            r:ScrollUp()
                            r.Scrolled:Fire()
                        end

                        local C = tick()
                        local D

                        D = h.InputEnded:Connect(function(E)
                            if not InputTypeAllowed(E, 'StartAndEnd') then
                                return
                            end

                            D:Disconnect()

                            if p(t) and r:CanScrollUp() then
                                t.BackgroundTransparency = 0.8
                            else
                                t.BackgroundTransparency = 1
                            end

                            y = false
                        end)

                        while y do
                            if tick() - C >= 0.3 and r:CanScrollUp() then
                                r:ScrollUp()
                                r.Scrolled:Fire()
                            end

                            wait()
                        end
                    end)
                    t.InputEnded:Connect(function(B)
                        if InputTypeAllowed(B, 'Movement') and not y then
                            t.BackgroundTransparency = 1
                        end
                    end)
                    u.InputBegan:Connect(function(B)
                        if InputTypeAllowed(B, 'Movement') and not y and r:CanScrollDown() then
                            u.BackgroundTransparency = 0.8
                        end
                        if not InputTypeAllowed(B, 'StartAndEnd') or not r:CanScrollDown() then
                            return
                        end

                        y = true
                        u.BackgroundTransparency = 0.5

                        if r:CanScrollDown() then
                            r:ScrollDown()
                            r.Scrolled:Fire()
                        end

                        local C = tick()
                        local D

                        D = h.InputEnded:Connect(function(E)
                            if not InputTypeAllowed(E, 'StartAndEnd') then
                                return
                            end

                            D:Disconnect()

                            if p(u) and r:CanScrollDown() then
                                u.BackgroundTransparency = 0.8
                            else
                                u.BackgroundTransparency = 1
                            end

                            y = false
                        end)

                        while y do
                            if tick() - C >= 0.3 and r:CanScrollDown() then
                                r:ScrollDown()
                                r.Scrolled:Fire()
                            end

                            wait()
                        end
                    end)
                    u.InputEnded:Connect(function(B)
                        if InputTypeAllowed(B, 'Movement') and not y then
                            u.BackgroundTransparency = 1
                        end
                    end)
                    w.InputBegan:Connect(function(B)
                        if InputTypeAllowed(B, 'Movement') and not z then
                            w.BackgroundTransparency = 0.2
                            w.BackgroundColor3 = r.ThumbSelectColor
                        end
                        if not InputTypeAllowed(B, 'StartAndEnd') then
                            return
                        end

                        local C = r.Horizontal and 'X' or 'Y'
                        local D

                        y = false
                        A = false
                        z = true
                        w.BackgroundTransparency = 0

                        local E = l[C] - w.AbsolutePosition[C]
                        local F
                        local G

                        F = h.InputEnded:Connect(function(H)
                            if not InputTypeAllowed(H, 'StartAndEnd') then
                                return
                            end

                            F:Disconnect()

                            if G then
                                G:Disconnect()
                            end
                            if p(w) then
                                w.BackgroundTransparency = 0.2
                            else
                                w.BackgroundTransparency = 0
                                w.BackgroundColor3 = r.ThumbColor
                            end

                            z = false
                        end)

                        r:Update()

                        G = h.InputChanged:Connect(function(H)
                            if InputTypeAllowed(H, 'Movement') and z and F.Connected then
                                local I = v.AbsoluteSize[C] - w.AbsoluteSize[C]
                                local J = l[C] - v.AbsolutePosition[C] - E

                                if J > I then
                                    J = I
                                elseif J < 0 then
                                    J = 0
                                end
                                if D ~= J then
                                    D = J

                                    r:ScrollTo(math.floor(0.5 + J / I * (r.TotalSpace - r.VisibleSpace)))
                                end

                                wait()
                            end
                        end)
                    end)
                    w.InputEnded:Connect(function(B)
                        if InputTypeAllowed(B, 'Movement') and not z then
                            w.BackgroundTransparency = 0
                            w.BackgroundColor3 = r.ThumbColor
                        end
                    end)
                    v.InputBegan:Connect(function(B)
                        if not InputTypeAllowed(B, 'StartAndEnd') or p(w) then
                            return
                        end

                        local C = r.Horizontal and 'X' or 'Y'
                        local D = 0

                        if l[C] >= w.AbsolutePosition[C] + w.AbsoluteSize[C] then
                            D = 1
                        end

                        local function doTick()
                            local E = r.VisibleSpace - 1

                            if D == 0 and l[C] < w.AbsolutePosition[C] then
                                r:ScrollTo(r.Index - E)
                            elseif D == 1 and l[C] >= w.AbsolutePosition[C] + w.AbsoluteSize[C] then
                                r:ScrollTo(r.Index + E)
                            end
                        end

                        z = false
                        A = true

                        doTick()

                        local E = tick()
                        local F

                        F = h.InputEnded:Connect(function(G)
                            if not InputTypeAllowed(G, 'StartAndEnd') then
                                return
                            end

                            F:Disconnect()

                            A = false
                        end)

                        while A do
                            if tick() - E >= 0.3 and p(v) then
                                doTick()
                            end

                            wait()
                        end
                    end)
                    s.MouseWheelForward:Connect(function()
                        r:ScrollTo(r.Index - r.WheelIncrement)
                    end)
                    s.MouseWheelBackward:Connect(function()
                        r:ScrollTo(r.Index + r.WheelIncrement)
                    end)

                    r.GuiElems.ScrollThumb = w
                    r.GuiElems.ScrollThumbFrame = v
                    r.GuiElems.Button1 = t
                    r.GuiElems.Button2 = u
                    r.GuiElems.MarkerFrame = x

                    return s
                end

                o.Update = function(r, s)
                    local t = r.TotalSpace
                    local u = r.VisibleSpace
                    local v = r.GuiElems.Button1
                    local w = r.GuiElems.Button2

                    r.Index = math.clamp(r.Index, 0, math.max(0, t - u))

                    if r.LastTotalSpace ~= r.TotalSpace then
                        r.LastTotalSpace = r.TotalSpace

                        r:UpdateMarkers()
                    end
                    if r:CanScrollUp() then
                        for x, y in pairs(v.Arrow:GetChildren())do
                            y.BackgroundTransparency = 0
                        end
                    else
                        v.BackgroundTransparency = 1

                        for x, y in pairs(v.Arrow:GetChildren())do
                            y.BackgroundTransparency = 0.5
                        end
                    end
                    if r:CanScrollDown() then
                        for x, y in pairs(w.Arrow:GetChildren())do
                            y.BackgroundTransparency = 0
                        end
                    else
                        w.BackgroundTransparency = 1

                        for x, y in pairs(w.Arrow:GetChildren())do
                            y.BackgroundTransparency = 0.5
                        end
                    end

                    drawThumb(r)
                end
                o.UpdateMarkers = function(r)
                    local s = r.GuiElems.MarkerFrame

                    s:ClearAllChildren()

                    for t, u in pairs(r.Markers)do
                        if t < r.TotalSpace then
                            createSimple('Frame', {
                                BackgroundTransparency = 0,
                                BackgroundColor3 = u,
                                BorderSizePixel = 0,
                                Position = r.Horizontal and UDim2.new(t / r.TotalSpace, 0, 1, 
-6) or UDim2.new(1, -6, t / r.TotalSpace, 0),
                                Size = r.Horizontal and UDim2.new(0, 1, 0, 6) or UDim2.new(0, 6, 0, 1),
                                Name = 'Marker' .. tostring(t),
                                Parent = s,
                            })
                        end
                    end
                end
                o.AddMarker = function(r, s, t)
                    r.Markers[s] = t or Color3.new(0, 0, 0)
                end
                o.ScrollTo = function(r, s, t)
                    r.Index = s

                    r:Update()

                    if not t then
                        r.Scrolled:Fire()
                    end
                end
                o.ScrollUp = function(r)
                    r.Index = r.Index - r.Increment

                    r:Update()
                end
                o.ScrollDown = function(r)
                    r.Index = r.Index + r.Increment

                    r:Update()
                end
                o.CanScrollUp = function(r)
                    return r.Index > 0
                end
                o.CanScrollDown = function(r)
                    return r.Index + r.VisibleSpace < r.TotalSpace
                end
                o.GetScrollPercent = function(r)
                    return r.Index / (r.TotalSpace - r.VisibleSpace)
                end
                o.SetScrollPercent = function(r, s)
                    r.Index = math.floor(s * (r.TotalSpace - r.VisibleSpace))

                    r:Update()
                end
                o.Texture = function(r, s)
                    r.ThumbColor = s.ThumbColor or Color3.new(0, 0, 0)
                    r.ThumbSelectColor = s.ThumbSelectColor or Color3.new(0, 0, 0)
                    r.GuiElems.ScrollThumb.BackgroundColor3 = s.ThumbColor or Color3.new(0, 0, 0)
                    r.Gui.BackgroundColor3 = s.FrameColor or Color3.new(0, 0, 0)
                    r.GuiElems.Button1.BackgroundColor3 = s.ButtonColor or Color3.new(0, 0, 0)
                    r.GuiElems.Button2.BackgroundColor3 = s.ButtonColor or Color3.new(0, 0, 0)

                    for t, u in pairs(r.GuiElems.Button1.Arrow:GetChildren())do
                        u.BackgroundColor3 = s.ArrowColor or Color3.new(0, 0, 0)
                    end
                    for t, u in pairs(r.GuiElems.Button2.Arrow:GetChildren())do
                        u.BackgroundColor3 = s.ArrowColor or Color3.new(0, 0, 0)
                    end
                end
                o.SetScrollFrame = function(r, s)
                    if r.ScrollUpEvent then
                        r.ScrollUpEvent:Disconnect()

                        r.ScrollUpEvent = nil
                    end
                    if r.ScrollDownEvent then
                        r.ScrollDownEvent:Disconnect()

                        r.ScrollDownEvent = nil
                    end

                    r.ScrollUpEvent = s.MouseWheelForward:Connect(function()
                        r:ScrollTo(r.Index - r.WheelIncrement)
                    end)
                    r.ScrollDownEvent = s.MouseWheelBackward:Connect(function()
                        r:ScrollTo(r.Index + r.WheelIncrement)
                    end)
                end

                local r = {}

                r.__index = o

                local function new(s)
                    local t = setmetatable({
                        Index = 0,
                        VisibleSpace = 0,
                        TotalSpace = 0,
                        Increment = 1,
                        WheelIncrement = 1,
                        Markers = {},
                        GuiElems = {},
                        Horizontal = s,
                        LastTotalSpace = 0,
                        Scrolled = m.Signal.new(),
                    }, r)

                    t.Gui = createFrame(t)

                    t:Texture{
                        ThumbColor = Color3.fromRGB(60, 60, 60),
                        ThumbSelectColor = Color3.fromRGB(75, 75, 75),
                        ArrowColor = Color3.new(1, 1, 1),
                        FrameColor = Color3.fromRGB(40, 40, 40),
                        ButtonColor = Color3.fromRGB(75, 75, 75),
                    }

                    return t
                end

                return {new = new}
            end)()
            m.CodeFrame = (function()
                local o = {}
                local p = {
                    [1] = 'String',
                    [2] = 'String',
                    [3] = 'String',
                    [4] = 'Comment',
                    [5] = 'Operator',
                    [6] = 'Number',
                    [7] = 'Keyword',
                    [8] = 'BuiltIn',
                    [9] = 'LocalMethod',
                    [10] = 'LocalProperty',
                    [11] = 'Nil',
                    [12] = 'Bool',
                    [13] = 'Function',
                    [14] = 'Local',
                    [15] = 'Self',
                    [16] = 'FunctionName',
                    [17] = 'Bracket',
                }
                local q = {
                    ['nil'] = 11,
                    ['true'] = 12,
                    ['false'] = 12,
                    ['function'] = 13,
                    ['local'] = 14,
                    self = 15,
                }
                local r = {
                    ['and'] = true,
                    ['break'] = true,
                    ['do'] = true,
                    ['else'] = true,
                    ['elseif'] = true,
                    ['end'] = true,
                    ['false'] = true,
                    ['for'] = true,
                    ['function'] = true,
                    ['if'] = true,
                    ['in'] = true,
                    ['local'] = true,
                    ['nil'] = true,
                    ['not'] = true,
                    ['or'] = true,
                    ['repeat'] = true,
                    ['return'] = true,
                    ['then'] = true,
                    ['true'] = true,
                    ['until'] = true,
                    ['while'] = true,
                    plugin = true,
                }
                local s = {
                    delay = true,
                    elapsedTime = true,
                    require = true,
                    spawn = true,
                    tick = true,
                    time = true,
                    typeof = true,
                    UserSettings = true,
                    wait = true,
                    warn = true,
                    game = true,
                    shared = true,
                    script = true,
                    workspace = true,
                    assert = true,
                    collectgarbage = true,
                    error = true,
                    getfenv = true,
                    getmetatable = true,
                    ipairs = true,
                    loadstring = true,
                    newproxy = true,
                    next = true,
                    pairs = true,
                    pcall = true,
                    print = true,
                    rawequal = true,
                    rawget = true,
                    rawset = true,
                    select = true,
                    setfenv = true,
                    setmetatable = true,
                    tonumber = true,
                    tostring = true,
                    type = true,
                    unpack = true,
                    xpcall = true,
                    _G = true,
                    _VERSION = true,
                    coroutine = true,
                    debug = true,
                    math = true,
                    os = true,
                    string = true,
                    table = true,
                    bit32 = true,
                    utf8 = true,
                    Axes = true,
                    BrickColor = true,
                    CFrame = true,
                    Color3 = true,
                    ColorSequence = true,
                    ColorSequenceKeypoint = true,
                    DockWidgetPluginGuiInfo = true,
                    Enum = true,
                    Faces = true,
                    Instance = true,
                    NumberRange = true,
                    NumberSequence = true,
                    NumberSequenceKeypoint = true,
                    PathWaypoint = true,
                    PhysicalProperties = true,
                    Random = true,
                    Ray = true,
                    Rect = true,
                    Region3 = true,
                    Region3int16 = true,
                    TweenInfo = true,
                    UDim = true,
                    UDim2 = true,
                    Vector2 = true,
                    Vector2int16 = true,
                    Vector3 = true,
                    Vector3int16 = true,
                    Drawing = true,
                    syn = true,
                    crypt = true,
                    cache = true,
                    bit = true,
                    readfile = true,
                    writefile = true,
                    isfile = true,
                    appendfile = true,
                    listfiles = true,
                    loadfile = true,
                    isfolder = true,
                    makefolder = true,
                    delfolder = true,
                    delfile = true,
                    setclipboard = true,
                    setfflag = true,
                    getnamecallmethod = true,
                    isluau = true,
                    setnonreplicatedproperty = true,
                    getspecialinfo = true,
                    saveinstance = true,
                    rconsoleprint = true,
                    rconsoleinfo = true,
                    rconsolewarn = true,
                    rconsoleerr = true,
                    rconsoleclear = true,
                    rconsolename = true,
                    rconsoleinput = true,
                    rconsoleinputasync = true,
                    printconsole = true,
                    checkcaller = true,
                    islclosure = true,
                    iscclosure = true,
                    dumpstring = true,
                    decompile = true,
                    hookfunction = true,
                    newcclosure = true,
                    isrbxactive = true,
                    keypress = true,
                    keyrelease = true,
                    mouse1click = true,
                    mouse1press = true,
                    mouse1release = true,
                    mouse2click = true,
                    mouse2press = true,
                    mouse2release = true,
                    mousescroll = true,
                    mousemoveabs = true,
                    mousemoverel = true,
                    getrawmetatable = true,
                    setrawmetatable = true,
                    setreadonly = true,
                    isreadonly = true,
                    getsenv = true,
                    getcallingscript = true,
                    getgenv = true,
                    getrenv = true,
                    getreg = true,
                    getgc = true,
                    getinstances = true,
                    getnilinstances = true,
                    getscripts = true,
                    getloadedmodules = true,
                    getconnections = true,
                    firesignal = true,
                    fireclickdetector = true,
                    firetouchinterest = true,
                    fireproximityprompt = true,
                }
                local t = false
                local u = {
                    ["'"] = '&apos;',
                    ['"'] = '&quot;',
                    ['<'] = '&lt;',
                    ['>'] = '&gt;',
                    ['&'] = '&amp;',
                }
                local v = '\205'
                local w = (' %s%s '):format(v, v)
                local x = {
                    [('[^%s] %s'):format(v, v)] = 0,
                    [(' %s%s'):format(v, v)] = -1,
                    [('%s%s '):format(v, v)] = 2,
                    [('%s [^%s]'):format(v, v)] = 1,
                }
                local y = {}

                local function initBuiltIn()
                    local z = getfenv()
                    local A = type
                    local B = tostring

                    for C, D in next, s do
                        local E = z[C]

                        if A(E) == 'table' then
                            local F = {}

                            for G, H in next, E do
                                F[G] = true
                            end

                            s[C] = F
                        end
                    end

                    local C = {}
                    local D = Enum:GetEnums()

                    for E = 1, #D do
                        C[B(D[E])] = true
                    end

                    s.Enum = C
                    t = true
                end
                local function setupEditBox(z)
                    local A = z.GuiElems.EditBox

                    A.Focused:Connect(function()
                        z:ConnectEditBoxEvent()

                        z.Editing = true
                    end)
                    A.FocusLost:Connect(function()
                        z:DisconnectEditBoxEvent()

                        z.Editing = false
                    end)
                    A:GetPropertyChangedSignal'Text':Connect(function()
                        local B = A.Text

                        if #B == 0 or z.EditBoxCopying then
                            return
                        end

                        B = B:gsub('\t', '    ')
                        A.Text = ''

                        z:AppendText(B)
                    end)
                end
                local function setupMouseSelection(z)
                    local A = z.GuiElems.LinesFrame
                    local B = z.Lines

                    A.InputBegan:Connect(function(C)
                        if InputTypeAllowed(C, 'StartAndEnd') then
                            local D, E = math.ceil(z.FontSize / 2), z.FontSize
                            local F = l.X - A.AbsolutePosition.X
                            local G = l.Y - A.AbsolutePosition.Y
                            local H = math.round(F / D) + z.ViewX
                            local I = math.floor(G / E) + z.ViewY
                            local J, K, L
                            local M, N = 0, 0

                            I = math.min(#B - 1, I)

                            local O = B[I + 1] or ''

                            H = math.min(#O, H + z:TabAdjust(H, I))
                            z.SelectionRange = {
                                {
                                    -1,
                                    -1,
                                },
                                {
                                    -1,
                                    -1,
                                },
                            }

                            z:MoveCursor(H, I)

                            z.FloatCursorX = H

                            local function updateSelection()
                                local P = l.X - A.AbsolutePosition.X
                                local Q = l.Y - A.AbsolutePosition.Y
                                local R = math.max(0, math.round(P / D) + z.ViewX)
                                local S = math.max(0, math.floor(Q / E) + z.ViewY)

                                S = math.min(#B - 1, S)

                                local T = B[S + 1] or ''

                                R = math.min(#T, R + z:TabAdjust(R, S))

                                if S < I or (S == I and R < H) then
                                    z.SelectionRange = {
                                        {R, S},
                                        {H, I},
                                    }
                                else
                                    z.SelectionRange = {
                                        {H, I},
                                        {R, S},
                                    }
                                end

                                z:MoveCursor(R, S)

                                z.FloatCursorX = R

                                z:Refresh()
                            end

                            J = h.InputEnded:Connect(function(P)
                                if InputTypeAllowed(P, 'StartAndEnd') then
                                    J:Disconnect()
                                    K:Disconnect()
                                    L:Disconnect()
                                    z:SetCopyableSelection()
                                end
                            end)
                            K = h.InputChanged:Connect(function(P)
                                if InputTypeAllowed(P, 'Movement') then
                                    local Q = l.Y - A.AbsolutePosition.Y
                                    local R = l.Y - A.AbsolutePosition.Y - A.AbsoluteSize.Y
                                    local S = l.X - A.AbsolutePosition.X
                                    local T = l.X - A.AbsolutePosition.X - A.AbsoluteSize.X

                                    M = 0
                                    N = 0

                                    if R > 0 then
                                        M = math.floor(R * 0.05) + 1
                                    elseif Q < 0 then
                                        M = math.ceil(Q * 0.05) - 1
                                    end
                                    if T > 0 then
                                        N = math.floor(T * 0.05) + 1
                                    elseif S < 0 then
                                        N = math.ceil(S * 0.05) - 1
                                    end

                                    updateSelection()
                                end
                            end)
                            L = i.RenderStepped:Connect(function()
                                if M ~= 0 or N ~= 0 then
                                    z:ScrollDelta(N, M)
                                    updateSelection()
                                end
                            end)

                            z:Refresh()
                        end
                    end)
                end

                function o.MakeEditorFrame(z)
                    local A = NewInstance'TextButton'

                    A.BackgroundTransparency = 1
                    A.TextTransparency = 1
                    A.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    A.BorderSizePixel = 0
                    A.Size = UDim2.fromOffset(100, 100)
                    A.Visible = true

                    local B = {}
                    local C = NewInstance'Frame'

                    C.Name = 'Lines'
                    C.BackgroundTransparency = 1
                    C.Size = UDim2.new(1, 0, 1, 0)
                    C.ClipsDescendants = true
                    C.Parent = A

                    local D = NewInstance'TextLabel'

                    D.Name = 'LineNumbers'
                    D.BackgroundTransparency = 1
                    D.FontFace = z.FontFace
                    D.TextXAlignment = Enum.TextXAlignment.Right
                    D.TextYAlignment = Enum.TextYAlignment.Top
                    D.ClipsDescendants = true
                    D.RichText = true
                    D.Parent = A
                    n.Name = 'Cursor'
                    n.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
                    n.BorderSizePixel = 0
                    n.Parent = A

                    local E = NewInstance'TextBox'

                    E.Name = 'EditBox'
                    E.MultiLine = true
                    E.Visible = false
                    E.Parent = A
                    E.TextSize = z.FontSize
                    E.FontFace = z.FontFace
                    y.Invis = j:Create(n, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
                    y.Vis = j:Create(n, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0})

                    local F = NewInstance'Frame'

                    F.BackgroundColor3 = Color3.new(0.15686275064945, 0.15686275064945, 0.15686275064945)
                    F.BorderSizePixel = 0
                    F.Name = 'ScrollCorner'
                    F.Position = UDim2.new(1, -10, 1, -10)
                    F.Size = UDim2.new(0, 10, 0, 10)
                    F.Visible = false
                    B.ScrollCorner = F
                    B.LinesFrame = C
                    B.LineNumbersLabel = D
                    B.Cursor = n
                    B.EditBox = E
                    B.ScrollCorner.Parent = A

                    C.InputBegan:Connect(function(G)
                        if InputTypeAllowed(G, 'StartAndEnd') then
                            z:SetEditing(true, G)
                        end
                    end)

                    z.Frame = A
                    z.Gui = A
                    z.GuiElems = B

                    setupEditBox(z)
                    setupMouseSelection(z)

                    return A
                end

                o.GetSelectionText = function(z)
                    if not z:IsValidRange() then
                        return ''
                    end

                    local A = z.SelectionRange
                    local B, C = A[1][1], A[1][2]
                    local D, E = A[2][1], A[2][2]
                    local F = E - C
                    local G = z.Lines

                    if not G[C + 1] or not G[E + 1] then
                        return ''
                    end
                    if F == 0 then
                        return z:ConvertText(G[C + 1]:sub(B + 1, D), false)
                    end

                    local H = G[C + 1]:sub(B + 1)
                    local I = G[E + 1]:sub(1, D)
                    local J = H .. '\n'

                    for K = C + 1, E - 1 do
                        J = J .. G[K + 1] .. '\n'
                    end

                    J = J .. I

                    return z:ConvertText(J, false)
                end
                o.SetCopyableSelection = function(z)
                    local A = z:GetSelectionText()
                    local B = z.GuiElems.EditBox

                    z.EditBoxCopying = true
                    B.Text = A
                    B.SelectionStart = 1
                    B.CursorPosition = #B.Text + 1
                    z.EditBoxCopying = false
                end
                o.ConnectEditBoxEvent = function(z)
                    if z.EditBoxEvent then
                        z.EditBoxEvent:Disconnect()
                    end

                    z.EditBoxEvent = h.InputBegan:Connect(function(A)
                        if A.UserInputType ~= Enum.UserInputType.Keyboard then
                            return
                        end

                        local B = Enum.KeyCode
                        local C = A.KeyCode

                        local function setupMove(D, E)
                            local F, G

                            F = h.InputEnded:Connect(function(H)
                                if H.KeyCode ~= D then
                                    return
                                end

                                F:Disconnect()

                                G = true
                            end)

                            E()
                            m.FastWait(0.5)

                            while not G do
                                E()
                                m.FastWait(0.03)
                            end
                        end

                        if C == B.Down then
                            setupMove(B.Down, function()
                                z.CursorX = z.FloatCursorX
                                z.CursorY = z.CursorY + 1

                                z:UpdateCursor()
                                z:JumpToCursor()
                            end)
                        elseif C == B.Up then
                            setupMove(B.Up, function()
                                z.CursorX = z.FloatCursorX
                                z.CursorY = z.CursorY - 1

                                z:UpdateCursor()
                                z:JumpToCursor()
                            end)
                        elseif C == B.Left then
                            setupMove(B.Left, function()
                                local D = z.Lines[z.CursorY + 1] or ''

                                z.CursorX = z.CursorX - 1 - (D:sub(z.CursorX - 3, z.CursorX) == w and 3 or 0)

                                if z.CursorX < 0 then
                                    z.CursorY = z.CursorY - 1

                                    local E = z.Lines[z.CursorY + 1] or ''

                                    z.CursorX = #E
                                end

                                z.FloatCursorX = z.CursorX

                                z:UpdateCursor()
                                z:JumpToCursor()
                            end)
                        elseif C == B.Right then
                            setupMove(B.Right, function()
                                local D = z.Lines[z.CursorY + 1] or ''

                                z.CursorX = z.CursorX + 1 + (D:sub(z.CursorX + 1, z.CursorX + 4) == w and 3 or 0)

                                if z.CursorX > #D then
                                    z.CursorY = z.CursorY + 1
                                    z.CursorX = 0
                                end

                                z.FloatCursorX = z.CursorX

                                z:UpdateCursor()
                                z:JumpToCursor()
                            end)
                        elseif C == B.Backspace then
                            setupMove(B.Backspace, function()
                                local D, E

                                if z:IsValidRange() then
                                    D = z.SelectionRange[1]
                                    E = z.SelectionRange[2]
                                else
                                    E = {
                                        z.CursorX,
                                        z.CursorY,
                                    }
                                end
                                if not D then
                                    local F = z.Lines[z.CursorY + 1] or ''

                                    z.CursorX = z.CursorX - 1 - (F:sub(z.CursorX - 3, z.CursorX) == w and 3 or 0)

                                    if z.CursorX < 0 then
                                        z.CursorY = z.CursorY - 1

                                        local G = z.Lines[z.CursorY + 1] or ''

                                        z.CursorX = #G
                                    end

                                    z.FloatCursorX = z.CursorX

                                    z:UpdateCursor()

                                    D = D or {
                                        z.CursorX,
                                        z.CursorY,
                                    }
                                end

                                z:DeleteRange({D, E}, false, true)
                                z:ResetSelection(true)
                                z:JumpToCursor()
                            end)
                        elseif C == B.Delete then
                            setupMove(B.Delete, function()
                                local D, E

                                if z:IsValidRange() then
                                    D = z.SelectionRange[1]
                                    E = z.SelectionRange[2]
                                else
                                    D = {
                                        z.CursorX,
                                        z.CursorY,
                                    }
                                end
                                if not E then
                                    local F = z.Lines[z.CursorY + 1] or ''
                                    local G = z.CursorX + 1 + (F:sub(z.CursorX + 1, z.CursorX + 4) == w and 3 or 0)
                                    local H = z.CursorY

                                    if G > #F then
                                        H = H + 1
                                        G = 0
                                    end

                                    z:UpdateCursor()

                                    E = E or {G, H}
                                end

                                z:DeleteRange({D, E}, false, true)
                                z:ResetSelection(true)
                                z:JumpToCursor()
                            end)
                        elseif h:IsKeyDown(Enum.KeyCode.LeftControl) then
                            if C == B.A then
                                z.SelectionRange = {
                                    {0, 5},
                                    {
                                        #z.Lines[#z.Lines],
                                        #z.Lines - 1,
                                    },
                                }

                                z:SetCopyableSelection()
                                z:Refresh()
                            end
                        end
                    end)
                end
                o.DisconnectEditBoxEvent = function(z)
                    if z.EditBoxEvent then
                        z.EditBoxEvent:Disconnect()

                        n.BackgroundTransparency = 1

                        o.CursorAnim(z, false)
                    end
                end
                o.ResetSelection = function(z, A)
                    z.SelectionRange = {
                        {
                            -1,
                            -1,
                        },
                        {
                            -1,
                            -1,
                        },
                    }

                    if not A then
                        z:Refresh()
                    end
                end
                o.IsValidRange = function(z, A)
                    local B = A or z.SelectionRange
                    local C, D = B[1][1], B[1][2]
                    local E, F = B[2][1], B[2][2]

                    if C == -1 or (C == E and D == F) then
                        return false
                    end

                    return true
                end
                o.DeleteRange = function(z, A, B, C)
                    A = A or z.SelectionRange

                    if not z:IsValidRange(A) then
                        return
                    end

                    local D = z.Lines
                    local E, F = A[1][1], A[1][2]
                    local G, H = A[2][1], A[2][2]
                    local I = H - F

                    if not D[F + 1] or not D[H + 1] then
                        return
                    end

                    local J = D[F + 1]:sub(1, E)
                    local K = D[H + 1]:sub(G + 1)

                    D[F + 1] = J .. K

                    local L = table.remove

                    for M = 1, I do
                        L(D, F + 2)
                    end

                    if A == z.SelectionRange then
                        z.SelectionRange = {
                            {
                                -1,
                                -1,
                            },
                            {
                                -1,
                                -1,
                            },
                        }
                    end
                    if C then
                        z.CursorX = E
                        z.CursorY = F

                        z:UpdateCursor()
                    end
                    if not B then
                        z:ProcessTextChange()
                    end
                end
                o.AppendText = function(z, A)
                    z:DeleteRange(nil, true, true)

                    local B, C, D = z.Lines, z.CursorX, z.CursorY
                    local E = B[D + 1]
                    local F = E:sub(1, C)
                    local G = E:sub(C + 1)

                    A = A:gsub('\r\n', '\n')
                    A = z:ConvertText(A, true)

                    local H = A:split'\n'
                    local I = table.insert

                    for J = 1, #H do
                        local K = D + J

                        if J > 1 then
                            I(B, K, '')
                        end

                        local L = H[J]
                        local M = (J == 1 and F or '')
                        local N = (J == #H and G or '')

                        B[K] = M .. L .. N
                    end

                    if #H > 1 then
                        C = 0
                    end

                    z:ProcessTextChange()

                    z.CursorX = C + #H[#H]
                    z.CursorY = D + #H - 1

                    z:UpdateCursor()
                end
                o.ScrollDelta = function(z, A, B)
                    z.ScrollV:ScrollTo(z.ScrollV.Index + B)
                    z.ScrollH:ScrollTo(z.ScrollH.Index + A)
                end
                o.TabAdjust = function(z, A, B)
                    local C = z.Lines
                    local D = C[B + 1]

                    A = A + 1

                    if D then
                        local E = D:sub(A - 1, A - 1)
                        local F = D:sub(A, A)
                        local G = D:sub(A + 1, A + 1)
                        local H = (#E > 0 and E or ' ') .. (#F > 0 and F or ' ') .. (#G > 0 and G or ' ')

                        for I, J in pairs(x)do
                            if H:find(I) then
                                return J
                            end
                        end
                    end

                    return 0
                end
                o.SetEditing = function(z, A, B)
                    if B then
                        z:UpdateCursor(B)
                    end
                    if A then
                        if z.Editable then
                            z.GuiElems.EditBox.Text = ''

                            z.GuiElems.EditBox:CaptureFocus()
                        end
                    else
                        z.GuiElems.EditBox:ReleaseFocus()
                    end
                end
                o.CursorAnim = function(z, A)
                    local B = z.GuiElems.Cursor
                    local C = tick()

                    z.LastAnimTime = C

                    if not A then
                        return
                    end

                    y.Invis:Cancel()
                    y.Vis:Cancel()

                    B.BackgroundTransparency = 0

                    coroutine.wrap(function()
                        while z.Editable do
                            m.FastWait(0.5)

                            if z.LastAnimTime ~= C then
                                return
                            end

                            y.Invis:Play()
                            m.FastWait(0.5)

                            if z.LastAnimTime ~= C then
                                return
                            end

                            y.Vis:Play()
                        end
                    end)()
                end
                o.MoveCursor = function(z, A, B)
                    z.CursorX = A
                    z.CursorY = B

                    z:UpdateCursor()
                    z:JumpToCursor()
                end
                o.JumpToCursor = function(z)
                    z:Refresh()
                end
                o.UpdateCursor = function(z, A)
                    local B = z.GuiElems.LinesFrame
                    local C = z.GuiElems.Cursor
                    local D = math.max(0, B.AbsoluteSize.X)
                    local E = math.max(0, B.AbsoluteSize.Y)
                    local F = math.ceil(E / z.FontSize)
                    local G = math.ceil(D / math.ceil(z.FontSize / 2))
                    local H, I = z.ViewX, z.ViewY
                    local J = tostring(#z.Lines)
                    local K = math.ceil(z.FontSize / 2)
                    local L = #J * K + 4 * K

                    if A then
                        local M = z.GuiElems.LinesFrame
                        local N, O = M.AbsolutePosition.X, M.AbsolutePosition.Y
                        local P, Q = A.Position.X, A.Position.Y
                        local R, S = math.ceil(z.FontSize / 2), z.FontSize

                        z.CursorX = z.ViewX + math.round((P - N) / R)
                        z.CursorY = z.ViewY + math.floor((Q - O) / S)
                    end

                    local M, N = z.CursorX, z.CursorY
                    local O = z.Lines[N + 1] or ''

                    if M > #O then
                        M = #O
                    elseif M < 0 then
                        M = 0
                    end
                    if N >= #z.Lines then
                        N = math.max(0, #z.Lines - 1)
                    elseif N < 0 then
                        N = 0
                    end

                    M = M + z:TabAdjust(M, N)
                    z.CursorX = M
                    z.CursorY = N

                    local P = (M >= H) and (N >= I) and (M <= H + G) and (N <= I + F)

                    if P then
                        local Q = (M - H)
                        local R = (N - I)

                        C.Position = UDim2.new(0, L + Q * math.ceil(z.FontSize / 2) - 1, 0, R * z.FontSize)
                        C.Size = UDim2.new(0, 1, 0, z.FontSize + 2)
                        C.Visible = true

                        z:CursorAnim(true)
                    else
                        C.Visible = false
                    end
                end
                o.MapNewLines = function(z)
                    local A = {}
                    local B = 1
                    local C = z.Text
                    local D = string.find
                    local E = 1
                    local F = D(C, '\n', E, true)

                    while F do
                        A[B] = F
                        B = B + 1
                        E = F + 1
                        F = D(C, '\n', E, true)
                    end

                    z.NewLines = A
                end
                o.PreHighlight = function(z)
                    local A = z.Text:gsub('\\\\', '  ')
                    local B = #A
                    local C = {}
                    local D = {}
                    local E = {}
                    local F = string.find
                    local G = string.sub

                    z.ColoredLines = {}

                    local function findAll(H, I, J, K)
                        local L = #C + 1
                        local M = 1
                        local N, O, P = F(H, I, M, K)

                        while N do
                            C[L] = N
                            D[N] = J

                            if P then
                                E[N] = P
                            end

                            L = L + 1
                            M = O + 1
                            N, O, P = F(H, I, M, K)
                        end
                    end

                    findAll(A, '"', 1, true)
                    findAll(A, "'", 2, true)
                    findAll(A, '%[(=*)%[', 3)
                    findAll(A, '--', 4, true)
                    table.sort(C)

                    local H = z.NewLines
                    local I = 0
                    local J = 0
                    local K = 0
                    local L = {}

                    for M = 1, #C do
                        local N = C[M]

                        if N <= K then
                            continue
                        end

                        local O = N
                        local P = D[N]

                        if P == 1 then
                            O = F(A, '"', N + 1, true)

                            while O and G(A, O - 1, O - 1) == '\\' do
                                O = F(A, '"', O + 1, true)
                            end

                            if not O then
                                O = B
                            end
                        elseif P == 2 then
                            O = F(A, "'", N + 1, true)

                            while O and G(A, O - 1, O - 1) == '\\' do
                                O = F(A, "'", O + 1, true)
                            end

                            if not O then
                                O = B
                            end
                        elseif P == 3 then
                            _, O = F(A, ']' .. E[N] .. ']', N + 1, true)

                            if not O then
                                O = B
                            end
                        elseif P == 4 then
                            local Q = D[N + 2]

                            if Q == 3 then
                                _, O = F(A, ']' .. E[N + 2] .. ']', N + 1, true)

                                if not O then
                                    O = B
                                end
                            else
                                O = F(A, '\n', N + 1, true) or B
                            end
                        end

                        while N > J do
                            I = I + 1
                            J = H[I] or B + 1
                        end
                        while true do
                            local Q = L[I]

                            if not Q then
                                Q = {}
                                L[I] = Q
                            end

                            Q[N] = {P, O}

                            if O > J then
                                I = I + 1
                                J = H[I] or B + 1
                            else
                                break
                            end
                        end

                        K = O
                    end

                    z.PreHighlights = L
                end
                o.HighlightLine = function(z, A)
                    local B = z.ColoredLines[A]

                    if B then
                        return B
                    end

                    local C = string.sub
                    local D = string.find
                    local E = string.match
                    local F = {}
                    local G = z.PreHighlights[A] or {}
                    local H = z.Lines[A] or ''
                    local I = 0
                    local J = 0
                    local K
                    local L = false
                    local M = 0
                    local N = z.NewLines[A - 1] or 0
                    local O = {}

                    for P, Q in next, G do
                        local R = P - N

                        if R < 1 then
                            J = Q[1]
                            I = Q[2] - N
                        else
                            O[R] = {
                                Q[1],
                                Q[2] - N,
                            }
                        end
                    end

                    for P = 1, #H do
                        if P <= I then
                            F[P] = J

                            continue
                        end

                        local Q = O[P]

                        if Q then
                            J = Q[1]
                            I = Q[2]
                            F[P] = J
                            L = false
                            K = nil
                            M = 0
                        else
                            local R = C(H, P, P)

                            if D(R, '[%a_]') then
                                local S = E(H, '[%a%d_]+', P)
                                local T = (r[S] and 7) or (s[S] and 8)

                                I = P + #S - 1

                                if T ~= 7 then
                                    if L then
                                        local U = K and s[K]

                                        T = (U and type(U) == 'table' and U[S] and 8) or 10
                                    end
                                    if T ~= 8 then
                                        local U, V, W = D(H, '^%s*([%({"\'])', I + 1)

                                        if U then
                                            T = (M > 0 and W == '(' and 16) or 9
                                            M = 0
                                        end
                                    end
                                else
                                    T = q[S] or T
                                    M = (S == 'function' and 1 or 0)
                                end

                                K = S
                                L = false

                                if M > 0 then
                                    M = 1
                                end
                                if T then
                                    J = T
                                    F[P] = J
                                else
                                    J = nil
                                end
                            elseif D(R, '%p') then
                                local S = (R == '.')
                                local T = S and D(C(H, P + 1, P + 1), '%d')

                                F[P] = (T and 6 or 5)

                                if not T then
                                    local U = S and E(H, '%.%.?%.?', P)

                                    if U and #U > 1 then
                                        J = 5
                                        I = P + #U - 1
                                        L = false
                                        K = nil
                                        M = 0
                                    else
                                        if S then
                                            if L then
                                                K = nil
                                            else
                                                L = true
                                            end
                                        else
                                            L = false
                                            K = nil
                                        end

                                        M = ((S or R == ':') and M == 1 and 2) or 0
                                    end
                                end
                            elseif D(R, '%d') then
                                local S, T = D(H, '%x+', P)
                                local U = C(H, T, T + 1)

                                if (U == 'e+' or U == 'e-') and D(C(H, T + 2, T + 2), '%d') then
                                    T = T + 1
                                end

                                J = 6
                                I = T
                                F[P] = 6
                                L = false
                                K = nil
                                M = 0
                            else
                                F[P] = J

                                local S, T = D(H, '%s+', P)

                                if T then
                                    I = T
                                end
                            end
                        end
                    end

                    z.ColoredLines[A] = F

                    return F
                end
                o.Refresh = function(z)
                    local A = z.Frame.Lines
                    local B = math.max(0, A.AbsoluteSize.X)
                    local C = math.max(0, A.AbsoluteSize.Y)
                    local D = math.ceil(C / z.FontSize)
                    local E = math.ceil(B / math.ceil(z.FontSize / 2))
                    local F = string.gsub
                    local G = string.sub
                    local H, I = z.ViewX, z.ViewY
                    local J = ''

                    for K = 1, D do
                        local L = z.LineFrames[K]

                        if not L then
                            L = NewInstance'Frame'
                            L.Name = 'Line'
                            L.Position = UDim2.new(0, 0, 0, (K - 1) * z.FontSize)
                            L.Size = UDim2.new(1, 0, 0, z.FontSize)
                            L.BorderSizePixel = 0
                            L.BackgroundTransparency = 1

                            local M = NewInstance'Frame'

                            M.Name = 'SelectionHighlight'
                            M.BorderSizePixel = 0
                            M.BackgroundColor3 = d.Theme.Syntax.SelectionBack
                            M.Parent = L
                            M.BackgroundTransparency = 0.7

                            local N = NewInstance'TextLabel'

                            N.Name = 'Label'
                            N.BackgroundTransparency = 1
                            N.FontFace = z.FontFace
                            N.TextSize = z.FontSize
                            N.Size = UDim2.new(1, 0, 0, z.FontSize)
                            N.RichText = true
                            N.TextXAlignment = Enum.TextXAlignment.Left
                            N.TextColor3 = z.Colors.Text
                            N.ZIndex = 2
                            N.Parent = L
                            L.Parent = A
                            z.LineFrames[K] = L
                        end

                        local M = I + K
                        local N = z.Lines[M] or ''
                        local O = ''
                        local P = z:HighlightLine(M)
                        local Q = H + 1
                        local R = z.RichTemplates
                        local S = R.Text
                        local T = R.Selection
                        local U = P[Q]
                        local V = R[p[U] ] or S
                        local W = z.SelectionRange
                        local X = W[1]
                        local Y = W[2]
                        local Z = M - 1

                        if Z >= X[2] and Z <= Y[2] then
                            local _ = math.ceil(z.FontSize / 2)
                            local aa = (Z == X[2] and X[1] or 0) - H
                            local ab = (Z == Y[2] and Y[1] - aa - H or E + H)

                            L.SelectionHighlight.Position = UDim2.new(0, aa * _, 0, 0)
                            L.SelectionHighlight.Size = UDim2.new(0, ab * _, 1, 0)
                            L.SelectionHighlight.Visible = true
                        else
                            L.SelectionHighlight.Visible = false
                        end

                        for aa = 2, E do
                            local ab = H + aa
                            local _ = P[ab]

                            if _ ~= U then
                                local ac = R[p[_] ] or S

                                if ac ~= V then
                                    local ad = F(G(N, Q, ab - 1), '[\'"<>&]', u)

                                    O = O .. (V ~= S and (V .. ad .. '</font>') or ad)
                                    Q = ab
                                    V = ac
                                end

                                U = _
                            end
                        end

                        local aa = F(G(N, Q, H + E), '[\'"<>&]', u)

                        if #aa > 0 then
                            O = O .. (V ~= S and (V .. aa .. '</font>') or aa)
                        end
                        if z.Lines[M] then
                            J = J .. (M - 1 == z.CursorY and ('<b>' .. M .. '</b>\n') or M .. '\n')
                        end

                        L.Label.Text = O
                    end
                    for aa = D + 1, #z.LineFrames do
                        z.LineFrames[aa]:Destroy()

                        z.LineFrames[aa] = nil
                    end

                    z.Frame.LineNumbers.Text = J

                    z:UpdateCursor()
                end
                o.UpdateView = function(aa)
                    local ab = tostring(#aa.Lines)
                    local ac = math.ceil(aa.FontSize / 2)
                    local ad = #ab * ac + 4 * ac
                    local z = aa.Frame.Lines
                    local A = z.AbsoluteSize.X
                    local B = z.AbsoluteSize.Y
                    local C = math.ceil(B / aa.FontSize)
                    local D = aa.MaxTextCols * ac
                    local E = aa.ScrollV
                    local F = aa.ScrollH

                    E.VisibleSpace = C
                    E.TotalSpace = #aa.Lines + 1
                    F.VisibleSpace = math.ceil(A / ac)
                    F.TotalSpace = aa.MaxTextCols + 1
                    E.Gui.Visible = #aa.Lines + 1 > C
                    F.Gui.Visible = D > A

                    local G = aa.FrameOffsets

                    aa.FrameOffsets = Vector2.new(E.Gui.Visible and -10 or 0, F.Gui.Visible and 
-10 or 0)

                    if G ~= aa.FrameOffsets then
                        aa:UpdateView()
                    else
                        E:ScrollTo(aa.ViewY, true)
                        F:ScrollTo(aa.ViewX, true)

                        if E.Gui.Visible and F.Gui.Visible then
                            E.Gui.Size = UDim2.new(0, 10, 1, -10)
                            F.Gui.Size = UDim2.new(1, -10, 0, 10)
                            aa.GuiElems.ScrollCorner.Visible = true
                        else
                            E.Gui.Size = UDim2.new(0, 10, 1, 0)
                            F.Gui.Size = UDim2.new(1, 0, 0, 10)
                            aa.GuiElems.ScrollCorner.Visible = false
                        end

                        aa.ViewY = E.Index
                        aa.ViewX = F.Index
                        aa.Frame.Lines.Position = UDim2.new(0, ad, 0, 0)
                        aa.Frame.Lines.Size = UDim2.new(1, -ad + G.X, 1, G.Y)
                        aa.Frame.LineNumbers.Position = UDim2.new(0, ac, 0, 0)
                        aa.Frame.LineNumbers.Size = UDim2.new(0, #ab * ac, 1, G.Y)
                        aa.Frame.LineNumbers.TextSize = aa.FontSize
                    end
                end
                o.ProcessTextChange = function(aa)
                    local ab = 0
                    local ac = aa.Lines

                    for ad = 1, #ac do
                        local z = #ac[ad]

                        if z > ab then
                            ab = z
                        end
                    end

                    aa.MaxTextCols = ab

                    aa:UpdateView()

                    aa.Text = table.concat(aa.Lines, '\n')

                    aa:MapNewLines()
                    aa:PreHighlight()
                    aa:Refresh()
                end
                o.ConvertText = function(aa, ab, ac)
                    if ac then
                        local ad = ab:gsub('\t', '    ')

                        return ad:gsub('\t', (' %s%s '):format(v, v))
                    else
                        return ab:gsub((' %s%s '):format(v, v), '\t')
                    end
                end
                o.GetText = function(aa)
                    local ab = table.concat(aa.Lines, '\n')

                    return aa:ConvertText(ab, false)
                end
                o.SetText = function(aa, ab)
                    ab = aa:ConvertText(ab, true)

                    local ac = aa.Lines

                    table.clear(ac)

                    local ad = 1

                    for z in ab:gmatch'([^\n\r]*)[\n\r]?'do
                        ac[ad] = z
                        ad = ad + 1
                    end

                    aa:ProcessTextChange()
                end
                o.ClearText = function(aa)
                    local ab = aa:ConvertText('', true)
                    local ac = aa.Lines

                    table.clear(ac)

                    local ad = 1

                    for z in ab:gmatch'([^\n\r]*)[\n\r]?'do
                        ac[ad] = z
                        ad = ad + 1
                    end

                    aa:ProcessTextChange()
                end
                o.CompileText = function(aa)
                    local ab = pcall(function()
                        local ab = table.concat(aa.Lines, '\n')
                        local ac = aa:ConvertText(ab, false)

                        loadstring(ac)()
                    end)

                    return ab
                end
                o.ReturnErrors = function(aa)
                    local ab, ac = pcall(function()
                        local ab = table.concat(aa.Lines, '\n')
                        local ac = aa:ConvertText(ab, false)

                        loadstring(ac)()
                    end)

                    return not ab and ac or nil
                end
                o.GetVersion = function(aa)
                    return b
                end
                o.MakeRichTemplates = function(aa)
                    local ab = math.floor
                    local ac = {}

                    for ad, z in pairs(aa.Colors)do
                        ac[ad] = ('<font color="rgb(%s,%s,%s)">'):format(ab(z.r * 255), ab(z.g * 255), ab(z.b * 255))
                    end

                    aa.RichTemplates = ac
                end
                o.ApplyTheme = function(aa)
                    local ab = d.Theme.Syntax

                    aa.Colors = ab
                    aa.Frame.LineNumbers.TextColor3 = ab.Text
                    aa.Frame.BackgroundColor3 = ab.Background
                end

                local aa = {__index = o}

                local function new(ab)
                    ab = ab or {}

                    if not t then
                        initBuiltIn()
                    end

                    local ac = m.ScrollBar.new()
                    local ad = m.ScrollBar.new(true)

                    ad.Gui.Position = UDim2.new(0, 0, 1, -10)

                    local z = {
                        FontFace = Font.fromEnum(Enum.Font.Code),
                        FontSize = 14,
                        ViewX = 0,
                        ViewY = 0,
                        Colors = d.Theme.Syntax,
                        ColoredLines = {},
                        Lines = {
                            '',
                        },
                        LineFrames = {},
                        Editable = true,
                        Editing = false,
                        CursorX = 0,
                        CursorY = 0,
                        FloatCursorX = 0,
                        Text = '',
                        PreHighlights = {},
                        SelectionRange = {
                            {
                                -1,
                                -1,
                            },
                            {
                                -1,
                                -1,
                            },
                        },
                        NewLines = {},
                        FrameOffsets = Vector2.new(0, 0),
                        MaxTextCols = 0,
                        ScrollV = ac,
                        ScrollH = ad,
                    }
                    local A = Merge(z, ab)
                    local B = setmetatable(A, aa)

                    o.SetTextMultiplier = (function(C)
                        B.FontSize = C
                    end)
                    o.GetTextMultiplier = (function()
                        return B.FontSize
                    end)
                    ac.WheelIncrement = 3
                    ad.Increment = 2
                    ad.WheelIncrement = 7

                    ac.Scrolled:Connect(function()
                        B.ViewY = ac.Index

                        B:Refresh()
                    end)
                    ad.Scrolled:Connect(function()
                        B.ViewX = ad.Index

                        B:Refresh()
                    end)
                    B:MakeEditorFrame(B)
                    B:MakeRichTemplates()
                    B:ApplyTheme()
                    ac:SetScrollFrame(B.Frame.Lines)

                    ac.Gui.Parent = B.Frame
                    ad.Gui.Parent = B.Frame

                    B:UpdateView()
                    B:SetText(A.Text)
                    B.Frame:GetPropertyChangedSignal'AbsoluteSize':Connect(function(
                    )
                        B:UpdateView()
                        B:Refresh()
                    end)

                    return B
                end

                return {new = new}
            end)()

            return m
        end

        function a.a(): typeof(__modImpl())
            local aa = a.cache.a

            if not aa then
                aa = {
                    c = __modImpl(),
                }
                a.cache.a = aa
            end

            return aa.c
        end
    end
    do
        local function __modImpl()
            local aa = {
                Services = {},
                OnInitConnections = {},
            }
            local ab = get_hidden_gui or gethui
            local ac = cloneref or function(...): Instance
                return ...
            end
            local ad = aa.Services

            setmetatable(ad, {
                __index = function(b, c: string)
                    local d = game:GetService(c)

                    return ac(d)
                end,
            })

            local b = ad.CoreGui
            local c

            function aa.AddOnInit(d, e: (table__DARKLUA_TYPE_a) -> nil)
                local f = d.OnInitConnections

                table.insert(f, e)
            end
            function aa.NewReference(d, e: Instance): Instance
                return ac(e)
            end
            function aa.CallOnInitConnections(d, e, ...)
                local f = d.OnInitConnections

                c = e

                for g, h in next, f do
                    h(c, ...)
                end
            end
            function aa.SetProperties(d, e: Instance, f: table__DARKLUA_TYPE_a)
                for g: string, h in next, f do
                    pcall(function()
                        e[g] = h
                    end)
                end
            end
            function aa.NewClass(d, e: table__DARKLUA_TYPE_a, f: table__DARKLUA_TYPE_a?)
                f = f or {}
                e.__index = e

                return setmetatable(f, e)
            end
            function aa.CheckConfig(
                d,
                e: table__DARKLUA_TYPE_a,
                f: table__DARKLUA_TYPE_a,
                g: boolean?,
                h: table__DARKLUA_TYPE_a?
            )
                if not e then
                    return
                end

                for i: string?, j in next, f do
                    if e[i] ~= nil then
                        continue
                    end
                    if h then
                        if table.find(h, i) then
                            continue
                        end
                    end
                    if g then
                        j = j()
                    end

                    e[i] = j
                end

                return e
            end
            function aa.ResolveUIParent(d): GuiObject?
                local e = c.PlayerGui
                local f = c.Debug
                local g = {
                    [1] = function()
                        local g = ab()

                        if g.Parent == b then
                            return
                        end

                        return g
                    end,
                    [2] = function()
                        return b
                    end,
                    [3] = function()
                        return e
                    end,
                }
                local h = c:CreateInstance'ScreenGui'

                for i, j in next, g do
                    local k, l = pcall(j)

                    if not k or not l then
                        continue
                    end

                    local m = pcall(function()
                        h.Parent = l
                    end)

                    if not m then
                        continue
                    end
                    if f then
                        c:Warn(`Step: {i} was chosen as the parent!: {l}`)
                    end

                    return l
                end

                c:Warn'The ReGui container does not have a parent defined'

                return nil
            end
            function aa.GetChildOfClass(d, e: GuiObject, f: string): GuiObject
                local g = e:FindFirstChildOfClass(f)

                if not g then
                    g = c:CreateInstance(f, e)
                end

                return g
            end
            function aa.CheckAssetUrl(d, e: (string | number)): string
                if tonumber(e) then
                    return `rbxassetid://{e}`
                end

                return e
            end
            function aa.SetPadding(d, e: UIPadding, f: UDim)
                if not e then
                    return
                end

                d:SetProperties(e, {
                    PaddingBottom = f,
                    PaddingLeft = f,
                    PaddingRight = f,
                    PaddingTop = f,
                })
            end

            return aa
        end

        function a.b(): typeof(__modImpl())
            local aa = a.cache.b

            if not aa then
                aa = {
                    c = __modImpl(),
                }
                a.cache.b = aa
            end

            return aa.c
        end
    end
    do
        local function __modImpl()
            local aa = a.b()
            local ab = {
                DefaultTweenInfo = TweenInfo.new(0.08),
            }
            local ac = aa.Services
            local ad = ac.TweenService

            function ab.Tween(b, c: AnimationTween__DARKLUA_TYPE_d): Tween?
                local d = b.DefaultTweenInfo
                local e = c.Object
                local f = c.NoAnimation
                local g = c.Tweeninfo or d
                local h = c.EndProperties
                local i = c.StartProperties
                local j = c.Completed

                if i then
                    aa:SetProperties(e, i)
                end
                if f then
                    aa:SetProperties(e, h)

                    if j then
                        j()
                    end

                    return
                end

                local k

                for l, m in next, h do
                    local n = {[l] = m}
                    local o, p = pcall(function()
                        return ad:Create(e, g, n)
                    end)

                    if not o then
                        aa:SetProperties(e, n)

                        continue
                    end
                    if not k then
                        k = p
                    end

                    p:Play()
                end

                if j then
                    if k then
                        k.Completed:Connect(j)
                    else
                        j()
                    end
                end

                return k
            end
            function ab.Animate(b, c: Animate__DARKLUA_TYPE_e): Tween
                local d = c.NoAnimation
                local e = c.Objects
                local f = c.Tweeninfo
                local g = c.Completed
                local h

                for i, j in next, e do
                    local k = b:Tween{
                        NoAnimation = d,
                        Object = i,
                        Tweeninfo = f,
                        EndProperties = j,
                    }

                    if not h then
                        h = k
                    end
                end

                if g then
                    h.Completed:Connect(g)
                end

                return h
            end
            function ab.HeaderCollapseToggle(b, c: HeaderCollapseToggle__DARKLUA_TYPE_f)
                aa:CheckConfig(c, {
                    Rotations = {
                        Open = 90,
                        Closed = 0,
                    },
                })

                local d = c.Toggle
                local e = c.NoAnimation
                local f = c.Rotations
                local g = c.Collapsed
                local h = c.Tweeninfo
                local i = g and f.Closed or f.Open

                b:Tween{
                    Tweeninfo = h,
                    NoAnimation = e,
                    Object = d,
                    EndProperties = {Rotation = i},
                }
            end
            function ab.HeaderCollapse(b, c: HeaderCollapse__DARKLUA_TYPE_g): Tween
                local d = c.Tweeninfo
                local e = c.Collapsed
                local f = c.ClosedSize
                local g: UDim2 = c.OpenSize
                local h = c.Toggle
                local i = c.Resize
                local j = c.Hide
                local k = c.NoAnimation
                local l = c.NoAutomaticSize
                local m = c.IconRotations
                local n = c.Completed

                if not l then
                    i.AutomaticSize = Enum.AutomaticSize.None
                end
                if not e then
                    j.Visible = true
                end

                b:HeaderCollapseToggle{
                    Tweeninfo = d,
                    Collapsed = e,
                    NoAnimation = k,
                    Toggle = h,
                    Rotations = m,
                }

                local o = b:Tween{
                    Tweeninfo = d,
                    NoAnimation = k,
                    Object = i,
                    StartProperties = {
                        Size = e and g or f,
                    },
                    EndProperties = {
                        Size = e and f or g,
                    },
                    Completed = function()
                        j.Visible = not e

                        if n then
                            n()
                        end
                        if e then
                            return
                        end
                        if l then
                            return
                        end

                        i.Size = UDim2.fromScale(1, 0)
                        i.AutomaticSize = Enum.AutomaticSize.Y
                    end,
                }

                return o
            end

            return ab
        end

        function a.c(): typeof(__modImpl())
            local aa = a.cache.c

            if not aa then
                aa = {
                    c = __modImpl(),
                }
                a.cache.c = aa
            end

            return aa.c
        end
    end
    do
        local function __modImpl()
            local aa = {}::SignalClass__DARKLUA_TYPE_h

            aa.__index = aa

            local ab = a.b()

            function aa.Fire(ac, ...)
                local ad = ac:GetConnections()

                if #ad <= 0 then
                    return
                end

                for b, c in next, ad do
                    c(...)
                end
            end
            function aa.GetConnections(ac): table__DARKLUA_TYPE_i
                local ad = ac.Connections

                return ad
            end
            function aa.Connect(ac, ad: (...any) -> nil)
                local b = ac:GetConnections()

                table.insert(b, ad)
            end
            function aa.DisconnectConnections(ac)
                local ad = ac:GetConnections()

                table.clear(ad)
            end
            function aa.NewSignal(ac): SignalClass__DARKLUA_TYPE_h
                return ab:NewClass(aa, {Connections = {}})
            end

            return aa
        end

        function a.d(): typeof(__modImpl())
            local aa = a.cache.d

            if not aa then
                aa = {
                    c = __modImpl(),
                }
                a.cache.d = aa
            end

            return aa.c
        end
    end
    do
        local function __modImpl()
            return function(aa)
                local ab = aa:Window{
                    Title = 'Configuration saving',
                    Size = UDim2.fromOffset(300, 200),
                }
                local ac = ab:Row()
                local ad

                ac:Button{
                    Text = 'Dump Ini',
                    Callback = function()
                        print(aa:DumpIni(true))
                    end,
                }
                ac:Button{
                    Text = 'Save Ini',
                    Callback = function()
                        ad = aa:DumpIni(true)
                    end,
                }
                ac:Button{
                    Text = 'Load Ini',
                    Callback = function()
                        if not ad then
                            warn'No save data!'

                            return
                        end

                        aa:LoadIni(ad, true)
                    end,
                }
                ab:Separator()
                ab:SliderInt{
                    IniFlag = 'MySlider',
                    Value = 5,
                    Minimum = 1,
                    Maximum = 32,
                }
                ab:Checkbox{
                    IniFlag = 'MyCheckbox',
                    Value = true,
                }
                ab:InputText{
                    IniFlag = 'MyInput',
                    Value = 'Hello world!',
                }
                ab:Keybind{
                    IniFlag = 'MyKeybind',
                    Label = 'Keybind (w/ Q & Left-Click blacklist)',
                    KeyBlacklist = {
                        Enum.UserInputType.MouseButton1,
                        Enum.KeyCode.Q,
                    },
                }

                local b = aa:TabsWindow{
                    Title = 'Tabs window!',
                    Visible = false,
                    Size = UDim2.fromOffset(300, 200),
                }

                for c, d in {
                    'Avocado',
                    'Broccoli',
                    'Cucumber',
                }do
                    local e = b:CreateTab{Name = d}

                    e:Label{
                        Text = `This is the {d} tab!`,
                    }
                end

                local c = aa.Elements:Label{
                    Parent = aa.Container.Windows,
                    Visible = false,
                    UiPadding = UDim.new(0, 8),
                    CornerRadius = UDim.new(0, 2),
                    Position = UDim2.fromOffset(10, 10),
                    Size = UDim2.fromOffset(250, 50),
                    Border = true,
                    BorderThickness = 1,
                    BorderColor = aa.Accent.Gray,
                    BackgroundTransparency = 0.4,
                    BackgroundColor3 = aa.Accent.Black,
                }

                game:GetService'RunService'.RenderStepped:Connect(function(d)
                    local e = math.round(1 / d)
                    local f = DateTime.now():FormatLocalTime('dddd h:mm:ss A', 'en-us')
                    local g = `ReGui {aa:GetVersion()}\n`

                    g ..= `FPS: {e}\n`
                    g ..= `The time is {f}`

                    c.Text = g
                end)

                local d = aa:Window{
                    Title = 'Dear ReGui Demo',
                    Size = UDim2.new(0, 400, 0, 300),
                    NoScroll = true,
                }:Center()
                local e = d:MenuBar()
                local f = e:MenuItem{
                    Text = 'Menu',
                }

                f:Selectable{
                    Text = 'New',
                }
                f:Selectable{
                    Text = 'Open',
                }
                f:Selectable{
                    Text = 'Save',
                }
                f:Selectable{
                    Text = 'Save as',
                }
                f:Selectable{
                    Text = 'Exit',
                    Callback = function()
                        d:Close()
                    end,
                }

                local g = e:MenuItem{
                    Text = 'Examples',
                }

                g:Selectable{
                    Text = 'Print hello world',
                    Callback = function()
                        print'Hello world!'
                    end,
                }
                g:Selectable{
                    Text = 'Tabs window',
                    Callback = function()
                        b:ToggleVisibility()
                    end,
                }
                g:Selectable{
                    Text = 'Configuration saving',
                    Callback = function()
                        ab:ToggleVisibility()
                    end,
                }
                g:Selectable{
                    Text = 'Watermark',
                    Callback = function()
                        c.Visible = not c.Visible
                    end,
                }
                d:Label{
                    Text = `Dear ReGui says hello! ({aa:GetVersion()})`,
                }

                local h = d:ScrollingCanvas{
                    Fill = true,
                    UiPadding = UDim.new(0, 0),
                }
                local i = h:CollapsingHeader{
                    Title = 'Help',
                }

                i:Separator{
                    Text = 'ABOUT THIS DEMO:',
                }
                i:BulletText{
                    Rows = {
                        
[[Sections below are demonstrating many aspects of the library.]],
                    },
                }
                i:Separator{
                    Text = 'PROGRAMMER GUIDE:',
                }
                i:BulletText{
                    Rows = {
                        
[[See example FAQ, examples, and documentation at https://depso.gitbook.io/regui]],
                    },
                }
                i:Indent():BulletText{
                    Rows = {
                        'See example applications in the /demo folder.',
                    },
                }

                local j = h:CollapsingHeader{
                    Title = 'Configuration',
                }
                local k = j:TreeNode{
                    Title = 'Backend Flags',
                }

                k:Checkbox{
                    Label = 'ReGui:IsMobileDevice',
                    Disabled = true,
                    Value = aa:IsMobileDevice(),
                }
                k:Checkbox{
                    Label = 'ReGui:IsConsoleDevice',
                    Disabled = true,
                    Value = aa:IsConsoleDevice(),
                }

                local l = j:TreeNode{
                    Title = 'Style',
                }

                l:Combo{
                    Selected = 'DarkTheme',
                    Label = 'Colors',
                    Items = aa.ThemeConfigs,
                    Callback = function(m, n)
                        d:SetTheme(n)
                    end,
                }

                local m = h:CollapsingHeader{
                    Title = 'Window options',
                }:Table{MaxColumns = 3}:NextRow()
                local n = {
                    NoResize = false,
                    NoTitleBar = false,
                    NoClose = false,
                    NoCollapse = false,
                    OpenOnDoubleClick = true,
                    NoBringToFrontOnFocus = false,
                    NoMove = false,
                    NoSelect = false,
                    NoScrollBar = false,
                    NoBackground = false,
                }

                for o, p in pairs(n)do
                    local q = m:NextColumn()

                    q:Checkbox{
                        Value = p,
                        Label = o,
                        Callback = function(r, s)
                            d:UpdateConfig{[o] = s}
                        end,
                    }
                end

                local o = h:CollapsingHeader{
                    Title = 'Widgets',
                }
                local p = {
                    'Basic',
                    'Tooltips',
                    'Tree Nodes',
                    'Collapsing Headers',
                    'Bullets',
                    'Text',
                    'Images',
                    'Videos',
                    'Combo',
                    'Tabs',
                    'Plot widgets',
                    'Multi-component Widgets',
                    'Progress Bars',
                    'Picker Widgets',
                    'Code editor',
                    'Console',
                    'List layout',
                    'Indent',
                    'Viewport',
                    'Keybinds',
                    'Input',
                    'Text Input',
                }
                local q = {
                    Basic = function(q)
                        q:Separator{
                            Text = 'General',
                        }

                        local r = q:Row()
                        local s = r:Label{
                            Text = 'Thanks for clicking me!',
                            Visible = false,
                            LayoutOrder = 2,
                        }

                        r:Button{
                            Callback = function()
                                s.Visible = not s.Visible
                            end,
                        }
                        q:Checkbox()

                        local t = q:Row()

                        t:Radiobox{
                            Label = 'radio a',
                        }
                        t:Radiobox{
                            Label = 'radio b',
                        }
                        t:Radiobox{
                            Label = 'radio c',
                        }

                        local u = q:Row()

                        for v = 1, 7 do
                            local w = v / 7

                            u:Button{
                                Text = 'Click',
                                BackgroundColor3 = Color3.fromHSV(w, 0.6, 0.6),
                            }
                        end

                        local v = q:Button{
                            Text = 'Tooltip',
                        }

                        aa:SetItemTooltip(v, function(w)
                            w:Label{
                                Text = 'I am a tooltip',
                            }
                        end)
                        q:Separator{
                            Text = 'Inputs',
                        }
                        q:InputText{
                            Value = 'Hello world!',
                        }
                        q:InputText{
                            Placeholder = 'Enter text here',
                            Label = 'Input text (w/ hint)',
                            Value = '',
                        }
                        q:InputInt{Value = 50}
                        q:InputInt{
                            Label = 'Input Int (w/ limit)',
                            Value = 5,
                            Maximum = 10,
                            Minimum = 1,
                        }
                        q:Separator{
                            Text = 'Drags',
                        }
                        q:DragInt()
                        q:DragInt{
                            Maximum = 100,
                            Minimum = 0,
                            Label = 'Drag Int 0..100',
                            Format = '%d%%',
                        }
                        q:DragFloat{
                            Maximum = 1,
                            Minimum = 0,
                            Value = 0.5,
                        }
                        q:Separator{
                            Text = 'Sliders',
                        }
                        q:SliderInt{
                            Format = '%.d/%s',
                            Value = 5,
                            Minimum = 1,
                            Maximum = 32,
                            ReadOnly = false,
                        }:SetValue(8)
                        q:SliderInt{
                            Label = 'Slider Int (w/ snap)',
                            Value = 1,
                            Minimum = 1,
                            Maximum = 8,
                            Type = 'Snap',
                        }
                        q:SliderFloat{
                            Label = 'Slider Float',
                            Minimum = 0,
                            Maximum = 1,
                            Format = 'Ratio = %.3f',
                        }
                        q:SliderFloat{
                            Label = 'Slider Angle',
                            Minimum = -360,
                            Maximum = 360,
                            Format = '%.f deg',
                        }
                        q:SliderEnum{
                            Items = {
                                'Fire',
                                'Earth',
                                'Air',
                                'Water',
                            },
                            Value = 2,
                        }
                        q:SliderEnum{
                            Items = {
                                'Fire',
                                'Earth',
                                'Air',
                                'Water',
                            },
                            Value = 2,
                            Disabled = true,
                            Label = 'Disabled Enum',
                        }
                        q:SliderProgress{
                            Label = 'Progress Slider',
                            Value = 8,
                            Minimum = 1,
                            Maximum = 32,
                        }
                        q:Separator{
                            Text = 'Selectors/Pickers',
                        }
                        q:InputColor3{
                            Value = aa.Accent.Light,
                            Label = 'Color 1',
                        }
                        q:SliderColor3{
                            Value = aa.Accent.Light,
                            Label = 'Color 2',
                        }
                        q:InputCFrame{
                            Value = CFrame.new(1, 1, 1),
                            Minimum = CFrame.new(0, 0, 0),
                            Maximum = CFrame.new(200, 100, 50),
                            Label = 'CFrame 1',
                        }
                        q:SliderCFrame{
                            Value = CFrame.new(1, 1, 1),
                            Minimum = CFrame.new(0, 0, 0),
                            Maximum = CFrame.new(200, 100, 50),
                            Label = 'CFrame 2',
                        }
                        q:Combo{
                            Selected = 1,
                            Items = {
                                'AAAA',
                                'BBBB',
                                'CCCC',
                                'DDDD',
                                'EEEE',
                                'FFFF',
                                'GGGG',
                                'HHHH',
                                'IIIIIII',
                                'JJJJ',
                                'KKKKKKK',
                            },
                        }
                    end,
                    Tooltips = function(q)
                        q:Separator{
                            Text = 'General',
                        }

                        local r = q:Button{
                            Text = 'Basic',
                            Size = UDim2.fromScale(1, 0),
                        }

                        aa:SetItemTooltip(r, function(s)
                            s:Label{
                                Text = 'I am a tooltip',
                            }
                        end)

                        local s = q:Button{
                            Text = 'Fancy',
                            Size = UDim2.fromScale(1, 0),
                        }

                        aa:SetItemTooltip(s, function(t)
                            t:Label{
                                Text = 'I am a fancy tooltip',
                            }
                            t:Image{Image = 18395893036}

                            local u = t:Label()

                            while wait() do
                                u.Text = `Sin(time) = {math.sin(tick())}`
                            end
                        end)

                        local t = q:Button{
                            Text = 'Double tooltip',
                            Size = UDim2.fromScale(1, 0),
                        }

                        for u = 1, 3 do
                            aa:SetItemTooltip(t, function(v)
                                v:Label{
                                    Text = `I am tooltip {u}`,
                                }
                            end)
                        end
                    end,
                    Videos = function(q)
                        local r = q:VideoPlayer{
                            Video = 5608327482,
                            Looped = true,
                            Ratio = 1.7777777777777777,
                            RatioAspectType = Enum.AspectType.FitWithinMaxSize,
                            RatioAxis = Enum.DominantAxis.Width,
                            Size = UDim2.fromScale(1, 1),
                        }

                        r:Play()

                        local t = q:Row{Expanded = true}

                        t:Button{
                            Text = 'Pause',
                            Callback = function()
                                r:Pause()
                            end,
                        }
                        t:Button{
                            Text = 'Play',
                            Callback = function()
                                r:Play()
                            end,
                        }

                        if not r.IsLoaded then
                            r.Loaded:Wait()
                        end

                        local u = t:SliderInt{
                            Format = '%.f',
                            Value = 0,
                            Minimum = 0,
                            Maximum = r.TimeLength,
                            Callback = function(u, v)
                                r.TimePosition = v
                            end,
                        }

                        game:GetService'RunService'.RenderStepped:Connect(function(
                            v
                        )
                            u:SetValue(r.TimePosition)
                        end)
                    end,
                    ['Tree Nodes'] = function(q)
                        for r = 1, 5 do
                            local t = q:TreeNode{
                                Title = `Child {r}`,
                                Collapsed = r ~= 1,
                            }
                            local u = t:Row()

                            u:Label{
                                Text = 'Blah blah',
                            }
                            u:SmallButton{
                                Text = 'Button',
                            }
                        end

                        q:TreeNode{
                            Title = `With icon & NoArrow`,
                            NoArrow = true,
                            Icon = aa.Icons.Image,
                        }
                    end,
                    ['Collapsing Headers'] = function(q)
                        local r

                        q:Checkbox{
                            Value = true,
                            Label = 'Show 2nd header',
                            Callback = function(t, u)
                                if r then
                                    r:SetVisible(u)
                                end
                            end,
                        }
                        q:Checkbox{
                            Value = true,
                            Label = '2nd has arrow',
                            Callback = function(t, u)
                                if r then
                                    r:SetArrowVisible(u)
                                end
                            end,
                        }

                        local t = q:CollapsingHeader{
                            Title = 'Header',
                        }

                        for u = 1, 5 do
                            t:Label{
                                Text = `Some content {u}`,
                            }
                        end

                        r = q:CollapsingHeader{
                            Title = 'Second Header',
                        }

                        for u = 1, 5 do
                            r:Label{
                                Text = `More content {u}`,
                            }
                        end
                    end,
                    Bullets = function(q)
                        q:BulletText{
                            Rows = {
                                'Bullet point 1',
                                'Bullet point 2\nOn multiple lines',
                            },
                        }
                        q:TreeNode():BulletText{
                            Rows = {
                                'Another bullet point',
                            },
                        }
                        q:Bullet():Label{
                            Text = 'Bullet point 3 (two calls)',
                        }
                        q:Bullet():SmallButton()
                    end,
                    Text = function(q)
                        local r = q:TreeNode{
                            Title = 'Colorful Text',
                        }

                        r:Label{
                            TextColor3 = Color3.fromRGB(255, 0, 255),
                            Text = 'Pink',
                            NoTheme = true,
                        }
                        r:Label{
                            TextColor3 = Color3.fromRGB(255, 255, 0),
                            Text = 'Yellow',
                            NoTheme = true,
                        }
                        r:Label{
                            TextColor3 = Color3.fromRGB(59, 59, 59),
                            Text = 'Disabled',
                            NoTheme = true,
                        }

                        local t = q:TreeNode{
                            Title = 'Word Wrapping',
                        }

                        t:Label{
                            Text = 
[[This text should automatically wrap on the edge of the window. The current implementation for text wrapping follows simple rules suitable for English and possibly other languages.]],
                            TextWrapped = true,
                        }

                        local u

                        t:SliderInt{
                            Label = 'Wrap width',
                            Value = 400,
                            Minimum = 20,
                            Maximum = 600,
                            Callback = function(v, w)
                                if not u then
                                    return
                                end

                                u.Size = UDim2.fromOffset(w, 0)
                            end,
                        }
                        t:Label{
                            Text = 'Test paragraph:',
                        }

                        u = t:Label{
                            Text = 
[[The lazy dog is a good dog. This paragraph should fit. Testing a 1 character word. The quick brown fox jumps over the lazy dog.]],
                            TextWrapped = true,
                            Border = true,
                            BorderColor = Color3.fromRGB(255, 255, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            Size = UDim2.fromOffset(400, 0),
                        }
                    end,
                    Images = function(q)
                        q:Label{
                            TextWrapped = true,
                            Text = 
[[Below we are displaying the icons (which are the ones builtin to ReGui in this demo). Hover the texture for a zoomed view!]],
                        }
                        q:Label{
                            TextWrapped = true,
                            Text = `There is a total of {aa:GetDictSize(aa.Icons)} icons in this demo!`,
                        }

                        local r = q:List{Border = true}
                        local t
                        local u

                        aa:SetItemTooltip(r, function(v)
                            t = v:Label()
                            u = v:Image{
                                Size = UDim2.fromOffset(50, 50),
                            }
                        end)

                        for v, w in aa.Icons do
                            local x = r:Image{
                                Image = w,
                                Size = UDim2.fromOffset(30, 30),
                            }

                            aa:DetectHover(x, {
                                MouseEnter = true,
                                OnInput = function()
                                    t.Text = v
                                    u.Image = w
                                end,
                            })
                        end
                    end,
                    Tabs = function(q)
                        local r = q:TreeNode{
                            Title = 'Basic',
                        }
                        local t = r:TabSelector()
                        local u = {
                            'Avocado',
                            'Broccoli',
                            'Cucumber',
                        }

                        for v, w in next, u do
                            t:CreateTab{Name = w}:Label{
                                Text = `This is the {w} tab!\nblah blah blah blah blah`,
                            }
                        end

                        local v = q:TreeNode{
                            Title = 'Advanced & Close Button',
                        }
                        local w = v:TabSelector()
                        local x = {
                            'Artichoke',
                            'Beetroot',
                            'Celery',
                            'Daikon',
                        }

                        for y, z in next, x do
                            local A = w:CreateTab{
                                Name = z,
                                Closeable = true,
                            }

                            A:Label{
                                Text = `This is the {z} tab!\nblah blah blah blah blah`,
                            }
                        end

                        v:Button{
                            Text = 'Add tab',
                            Callback = function()
                                w:CreateTab{Closeable = true}:Label{
                                    Text = 'I am an odd tab.',
                                }
                            end,
                        }
                    end,
                    ['Plot widgets'] = function(q)
                        local r = q:PlotHistogram{
                            Points = {
                                0.6,
                                0.1,
                                1,
                                0.5,
                                0.92,
                                0.1,
                                0.2,
                            },
                        }

                        q:Button{
                            Text = 'Generate new graph',
                            Callback = function()
                                local v = {}

                                for w = 1, math.random(5, 10)do
                                    table.insert(v, math.random(1, 10))
                                end

                                r:PlotGraph(v)
                            end,
                        }
                    end,
                    ['Multi-component Widgets'] = function(q)
                        q:Separator{
                            Text = '2-wide',
                        }
                        q:InputInt2{
                            Value = {10, 50},
                            Minimum = {0, 0},
                            Maximum = {20, 100},
                            Callback = function(r, v)
                                print('1:', v[1], '2:', v[2])
                            end,
                        }
                        q:SliderInt2()
                        q:SliderFloat2()
                        q:DragInt2()
                        q:DragFloat2()
                        q:Separator{
                            Text = '3-wide',
                        }
                        q:InputInt3()
                        q:SliderInt3()
                        q:SliderFloat3()
                        q:DragInt3()
                        q:DragFloat3()
                        q:Separator{
                            Text = '4-wide',
                        }
                        q:InputInt4()
                        q:SliderInt4()
                        q:SliderFloat4()
                        q:DragInt4()
                        q:DragFloat4()
                    end,
                    ['Progress Bars'] = function(q)
                        local r = q:ProgressBar{
                            Label = 'Loading...',
                            Value = 80,
                        }

                        spawn(function()
                            local v = 0

                            while wait(0.02) do
                                v += 1

                                r:SetPercentage(v % 100)
                            end
                        end)
                    end,
                    ['Picker Widgets'] = function(q)
                        q:Separator{
                            Text = 'Color pickers',
                        }
                        q:DragColor3{
                            Value = aa.Accent.Light,
                        }
                        q:SliderColor3{
                            Value = aa.Accent.Red,
                        }
                        q:InputColor3{
                            Value = aa.Accent.Green,
                        }
                        q:Separator{
                            Text = 'CFrame pickers',
                        }
                        q:DragCFrame{
                            Value = CFrame.new(1, 1, 1),
                            Minimum = CFrame.new(0, 0, 0),
                            Maximum = CFrame.new(200, 100, 50),
                        }
                        q:SliderCFrame()
                        q:InputCFrame()
                    end,
                    ['Code editor'] = function(q)
                        q:CodeEditor{
                            Text = 'print("Hello from ReGui\'s editor!")',
                            Editable = true,
                        }
                    end,
                    Console = function(q)
                        local r = q:TreeNode{
                            Title = 'Basic',
                        }
                        local v = r:Console{
                            ReadOnly = true,
                            AutoScroll = true,
                            MaxLines = 50,
                        }
                        local w = q:TreeNode{
                            Title = 'Advanced & RichText',
                        }
                        local x = w:Console{
                            ReadOnly = true,
                            AutoScroll = true,
                            RichText = true,
                            MaxLines = 50,
                        }
                        local y = q:TreeNode{
                            Title = 'Editor',
                        }

                        y:Console{
                            Value = "print('Hello world!')",
                            LineNumbers = true,
                        }
                        coroutine.wrap(function()
                            while wait() do
                                local z = DateTime.now():FormatLocalTime('h:mm:ss A', 'en-us')

                                x:AppendText(`<font color="rgb(240, 40, 10)">[Random]</font>`, math.random())
                                v:AppendText(`[{z}] Hello world!`)
                            end
                        end)()
                    end,
                    Combo = function(q)
                        q:Combo{
                            WidthFitPreview = true,
                            Label = 'WidthFitPreview',
                            Selected = 1,
                            Items = {
                                'AAAAAAAAAAAA',
                                'BBBBBBBB',
                                'CCCCC',
                                'DDD',
                            },
                        }
                        q:Separator{
                            Text = 'One-liner variants',
                        }
                        q:Combo{
                            Label = 'Combo 1 (array)',
                            Selected = 1,
                            Items = {
                                'AAAA',
                                'BBBB',
                                'CCCC',
                                'DDDD',
                                'EEEE',
                                'FFFF',
                                'GGGG',
                                'HHHH',
                                'IIIIIII',
                                'JJJJ',
                                'KKKKKKK',
                            },
                        }
                        q:Combo{
                            Label = 'Combo 1 (dict)',
                            Selected = 'AAA',
                            Items = {
                                AAA = 'Apple',
                                BBB = 'Banana',
                                CCC = 'Orange',
                            },
                            Callback = print,
                        }
                        q:Combo{
                            Label = 'Combo 2 (function)',
                            Selected = 1,
                            GetItems = function()
                                return {
                                    'aaa',
                                    'bbb',
                                    'ccc',
                                }
                            end,
                        }
                    end,
                    Indent = function(q)
                        q:Label{
                            Text = 'This is not indented',
                        }

                        local r = q:Indent{Offset = 30}

                        r:Label{
                            Text = 'This is indented by 30 pixels',
                        }

                        local v = r:Indent{Offset = 30}

                        v:Label{
                            Text = 'This is indented by 30 more pixels',
                        }
                    end,
                    Viewport = function(q)
                        local r = aa:InsertPrefab'R15 Rig'
                        local v = q:Viewport{
                            Size = UDim2.new(1, 0, 0, 200),
                            Clone = true,
                            Model = r,
                        }
                        local w = v.Model

                        w:PivotTo(CFrame.new(0, -2.5, -5))

                        local x = game:GetService'RunService'

                        x.RenderStepped:Connect(function(y)
                            local z = CFrame.Angles(0, math.rad(30 * y), 0)
                            local A = w:GetPivot() * z

                            w:PivotTo(A)
                        end)
                    end,
                    ['List layout'] = function(q)
                        local r = q:List()

                        for v = 1, 10 do
                            r:Button{
                                Text = `Resize the window! {v}`,
                            }
                        end
                    end,
                    Keybinds = function(q)
                        local r = q:Checkbox{Value = true}

                        q:Keybind{
                            Label = 'Toggle checkbox',
                            IgnoreGameProcessed = false,
                            OnKeybindSet = function(v, w)
                                warn('[OnKeybindSet] .Value ->', w)
                            end,
                            Callback = function(v, w)
                                print(w)
                                r:Toggle()
                            end,
                        }
                        q:Keybind{
                            Label = 'Keybind (w/ Q & Left-Click blacklist)',
                            KeyBlacklist = {
                                Enum.UserInputType.MouseButton1,
                                Enum.KeyCode.Q,
                            },
                        }
                        q:Keybind{
                            Label = 'Toggle UI visibility',
                            Value = Enum.KeyCode.E,
                            Callback = function()
                                d:ToggleVisibility()
                            end,
                        }
                    end,
                    Input = function(q)
                        q:InputText{
                            Label = 'One Line Text',
                        }
                        q:InputTextMultiline{
                            Label = 'Multiline Text',
                        }
                        q:InputInt{
                            Label = 'Input int',
                        }
                    end,
                    ['Text Input'] = function(q)
                        local r = q:TreeNode{
                            Title = 'Multiline',
                        }

                        r:InputTextMultiline{
                            Size = UDim2.new(1, 0, 0, 117),
                            Value = 
[[/*The Pentium FOOF bug, shorthand for FO OF C7 C8,
    the hexadecimal encoding of one offending instruction,
    more formally, the invalid operand with locked CMPXCHG8B
    instruction bug, is a design flaw in the majority of
    Intel Pentium, Pentium MMX, and Pentium OverDrive
    processors (all in the P5 microarchitecture).#
    */]],
                        }
                    end,
                }

                for r, v in p do
                    local w = o:TreeNode{Title = v}
                    local x = q[v]

                    if x then
                        task.spawn(x, w)
                    end
                end

                local r = h:CollapsingHeader{
                    Title = 'Popups & child windows',
                }
                local v = r:TreeNode{
                    Title = 'Popups',
                }
                local w = v:Row()
                local x = w:Label{
                    Text = '<None>',
                    LayoutOrder = 2,
                }

                w:Button{
                    Text = 'Select..',
                    Callback = function(y)
                        local z = {
                            'Bream',
                            'Haddock',
                            'Mackerel',
                            'Pollock',
                            'Tilefish',
                        }
                        local A = v:PopupCanvas{
                            RelativeTo = y,
                            MaxSizeX = 200,
                        }

                        A:Separator{
                            Text = 'Aquarium',
                        }

                        for B, C in z do
                            A:Selectable{
                                Text = C,
                                Callback = function(D)
                                    x.Text = C

                                    A:ClosePopup()
                                end,
                            }
                        end
                    end,
                }

                local y = r:TreeNode{
                    Title = 'Child windows',
                }
                local z = y:Window{
                    Size = UDim2.fromOffset(300, 200),
                    NoMove = true,
                    NoClose = true,
                    NoCollapse = true,
                    NoResize = true,
                }

                z:Label{
                    Text = 'Hello, world!',
                }
                z:Button{
                    Text = 'Save',
                }
                z:InputText{
                    Label = 'string',
                }
                z:SliderFloat{
                    Label = 'float',
                    Minimum = 0,
                    Maximum = 1,
                }

                local A = r:TreeNode{
                    Title = 'Modals',
                }

                A:Label{
                    Text = 
[[Modal windows are like popups but the user cannot close them by clicking outside.]],
                    TextWrapped = true,
                }
                A:Button{
                    Text = 'Delete..',
                    Callback = function()
                        local B = A:PopupModal{
                            Title = 'Delete?',
                        }

                        B:Label{
                            Text = 
[[All those beautiful files will be deleted.
This operation cannot be undone!]],
                            TextWrapped = true,
                        }
                        B:Separator()
                        B:Checkbox{
                            Value = false,
                            Label = "Don't ask me next time",
                        }

                        local C = B:Row{Expanded = true}

                        C:Button{
                            Text = 'Okay',
                            Callback = function()
                                B:ClosePopup()
                            end,
                        }
                        C:Button{
                            Text = 'Cancel',
                            Callback = function()
                                B:ClosePopup()
                            end,
                        }
                    end,
                }
                A:Button{
                    Text = 'Stacked modals..',
                    Callback = function()
                        local B = A:PopupModal{
                            Title = 'Stacked 1',
                        }

                        B:Label{
                            Text = `Hello from Stacked The First\nUsing Theme["ModalWindowDimBg"] behind it.`,
                            TextWrapped = true,
                        }
                        B:Combo{
                            Items = {
                                'aaaa',
                                'bbbb',
                                'cccc',
                                'dddd',
                                'eeee',
                            },
                        }
                        B:DragColor3{
                            Value = Color3.fromRGB(102, 178, 0),
                        }
                        B:Button{
                            Text = 'Add another modal..',
                            Callback = function()
                                local C = A:PopupModal{
                                    Title = 'Stacked 2',
                                }

                                C:Label{
                                    Text = 'Hello from Stacked The Second!',
                                    TextWrapped = true,
                                }
                                C:DragColor3{
                                    Value = Color3.fromRGB(102, 178, 0),
                                }
                                C:Button{
                                    Text = 'Close',
                                    Callback = function()
                                        C:ClosePopup()
                                    end,
                                }
                            end,
                        }
                        B:Button{
                            Text = 'Close',
                            Callback = function()
                                B:ClosePopup()
                            end,
                        }
                    end,
                }

                local B = h:CollapsingHeader{
                    Title = 'Tables & Columns',
                }
                local C = B:TreeNode{
                    Title = 'Basic',
                }
                local D = C:Table()

                for E = 1, 3 do
                    local F = D:Row()

                    for G = 1, 3 do
                        local H = F:Column()

                        for I = 1, 4 do
                            H:Label{
                                Text = `Row {I} Column {G}`,
                            }
                        end
                    end
                end

                local E = B:TreeNode{
                    Title = 'Borders, background',
                }
                local F = E:Table{
                    RowBackground = true,
                    Border = true,
                    MaxColumns = 3,
                }

                for G = 1, 5 do
                    local H = F:NextRow()

                    for I = 1, 3 do
                        local J = H:NextColumn()

                        J:Label{
                            Text = `Hello {I},{G}`,
                        }
                    end
                end

                local G = B:TreeNode{
                    Title = 'With headers',
                }
                local H = G:Table{
                    Border = true,
                    RowBackground = true,
                    MaxColumns = 3,
                }
                local I = {
                    'One',
                    'Two',
                    'Three',
                }

                for J = 1, 7 do
                    if J == 1 then
                        w = H:HeaderRow()
                    else
                        w = H:Row()
                    end

                    for K, L in I do
                        if J == 1 then
                            local M = w:Column()

                            M:Label{Text = L}

                            continue
                        end

                        local M = w:NextColumn()

                        M:Label{
                            Text = `Hello {K},{J}`,
                        }
                    end
                end
            end
        end

        function a.e(): typeof(__modImpl())
            local aa = a.cache.e

            if not aa then
                aa = {
                    c = __modImpl(),
                }
                a.cache.e = aa
            end

            return aa.c
        end
    end
    do
        local function __modImpl()
            return {
                Dot = 'rbxasset://textures/whiteCircle.png',
                Arrow = 'rbxasset://textures/ui/AvatarContextMenu_Arrow.png',
                Close = 'rbxasset://textures/loading/cancelButton.png',
                Checkmark = 'rbxasset://textures/ui/Lobby/Buttons/nine_slice_button.png',
                Cat = 'rbxassetid://16211812161',
                Script = 'rbxassetid://11570895459',
                Settings = 'rbxassetid://9743465390',
                Info = 'rbxassetid://18754976792',
                Move = 'rbxassetid://6710235139',
                Roblox = 'rbxassetid://7414445494',
                Warning = 'rbxassetid://11745872910',
                Audio = 'rbxassetid://302250236',
                Shop = 'rbxassetid://6473525198',
                CharacterDance = 'rbxassetid://11932783331',
                Pants = 'rbxassetid://10098755331',
                Home = 'rbxassetid://4034483344',
                Robux = 'rbxassetid://5986143282',
                Badge = 'rbxassetid://16170504068',
                SpawnLocation = 'rbxassetid://6400507398',
                Sword = 'rbxassetid://7485051715',
                Clover = 'rbxassetid://11999300014',
                Star = 'rbxassetid://3057073083',
                Code = 'rbxassetid://11348555035',
                Paw = 'rbxassetid://13001190533',
                Shield = 'rbxassetid://7461510428',
                Shield2 = 'rbxassetid://7169354142',
                File = 'rbxassetid://7276823330',
                Book = 'rbxassetid://16061686835',
                Location = 'rbxassetid://13549782519',
                Puzzle = 'rbxassetid://8898417863',
                Discord = 'rbxassetid://84828491431270',
                Premium = 'rbxassetid://6487178625',
                Friend = 'rbxassetid://10885655986',
                User = 'rbxassetid://18854794412',
                Duplicate = 'rbxassetid://11833749507',
                ChatBox = 'rbxassetid://15839118471',
                ChatBox2 = 'rbxassetid://15839116089',
                Devices = 'rbxassetid://4458812712',
                Weight = 'rbxassetid://9855685269',
                Image = 'rbxassetid://123311808092347',
                Profile = 'rbxassetid://13585614795',
                Admin = 'rbxassetid://11656483170',
                PaintBrush = 'rbxassetid://12111879608',
                Speed = 'rbxassetid://12641434961',
                NoConnection = 'rbxassetid://9795340967',
                Connection = 'rbxassetid://119759670842477',
                Globe = 'rbxassetid://18870359747',
                Box = 'rbxassetid://140217940575618',
                Crown = 'rbxassetid://18826490498',
                Control = 'rbxassetid://18979524646',
                Send = 'rbxassetid://18940312887',
                FastForward = 'rbxassetid://112963221295680',
                Pause = 'rbxassetid://109949100737970',
                Reload = 'rbxassetid://11570018242',
                Joystick = 'rbxassetid://18749336354',
                Controller = 'rbxassetid://11894535915',
                Lock = 'rbxassetid://17783082088',
                Calculator = 'rbxassetid://85861816563977',
                Sun = 'rbxassetid://13492317832',
                Moon = 'rbxassetid://8498174594',
                Prohibited = 'rbxassetid://5248916036',
                Flag = 'rbxassetid://251346532',
                Website = 'rbxassetid://98455290625865',
                Telegram = 'rbxassetid://115860270107061',
                MusicNote = 'rbxassetid://18187351229',
                Music = 'rbxassetid://253830398',
                Headphones = 'rbxassetid://1311321471',
                Phone = 'rbxassetid://8411963035',
                Smartphone = 'rbxassetid://14040313879',
                Desktop = 'rbxassetid://3120635703',
                Desktop2 = 'rbxassetid://4728059490',
                Laptop = 'rbxassetid://4728059725',
                Server = 'rbxassetid://9692125126',
                Wedge = 'rbxassetid://9086583059',
                Drill = 'rbxassetid://11959189471',
                Character = 'rbxassetid://13285102351',
            }
        end

        function a.f(): typeof(__modImpl())
            local aa = a.cache.f

            if not aa then
                aa = {
                    c = __modImpl(),
                }
                a.cache.f = aa
            end

            return aa.c
        end
    end
    do
        local function __modImpl()
            return {
                Light = Color3.fromRGB(50, 150, 250),
                Dark = Color3.fromRGB(30, 66, 115),
                ExtraDark = Color3.fromRGB(28, 39, 53),
                White = Color3.fromRGB(240, 240, 240),
                Gray = Color3.fromRGB(172, 171, 175),
                Black = Color3.fromRGB(15, 19, 24),
                Yellow = Color3.fromRGB(230, 180, 0),
                Orange = Color3.fromRGB(230, 150, 0),
                Green = Color3.fromRGB(130, 188, 91),
                Red = Color3.fromRGB(255, 69, 69),
                ImGui = {
                    Light = Color3.fromRGB(66, 150, 250),
                    Dark = Color3.fromRGB(41, 74, 122),
                    Black = Color3.fromRGB(15, 15, 15),
                    Gray = Color3.fromRGB(36, 36, 36),
                },
            }
        end

        function a.g(): typeof(__modImpl())
            local aa = a.cache.g

            if not aa then
                aa = {
                    c = __modImpl(),
                }
                a.cache.g = aa
            end

            return aa.c
        end
    end
    do
        local function __modImpl()
            local aa = a.g()
            local ab = {}

            ab.DarkTheme = {
                Values = {
                    AnimationTweenInfo = TweenInfo.new(0.08),
                    TextFont = Font.fromEnum(Enum.Font.RobotoMono),
                    TextSize = 14,
                    Text = aa.White,
                    TextDisabled = aa.Gray,
                    ErrorText = aa.Red,
                    FrameBg = aa.Dark,
                    FrameBgTransparency = 0.4,
                    FrameBgActive = aa.Light,
                    FrameBgTransparencyActive = 0.4,
                    FrameRounding = UDim.new(0, 0),
                    SliderGrab = aa.Light,
                    ButtonsBg = aa.Light,
                    CollapsingHeaderBg = aa.Light,
                    CollapsingHeaderText = aa.White,
                    CheckMark = aa.Light,
                    ResizeGrab = aa.Light,
                    HeaderBg = aa.Gray,
                    HeaderBgTransparency = 0.7,
                    HistogramBar = aa.Yellow,
                    ProgressBar = aa.Yellow,
                    RegionBg = aa.Dark,
                    RegionBgTransparency = 0.1,
                    Separator = aa.Gray,
                    SeparatorTransparency = 0.5,
                    ConsoleLineNumbers = aa.White,
                    LabelPaddingTop = UDim.new(0, 0),
                    LabelPaddingBottom = UDim.new(0, 0),
                    MenuBar = aa.ExtraDark,
                    MenuBarTransparency = 0.1,
                    PopupCanvas = aa.Black,
                    TabTextPaddingTop = UDim.new(0, 3),
                    TabTextPaddingBottom = UDim.new(0, 8),
                    TabText = aa.Gray,
                    TabBg = aa.Dark,
                    TabTextActive = aa.White,
                    TabBgActive = aa.Light,
                    TabsBarBg = Color3.fromRGB(36, 36, 36),
                    TabsBarBgTransparency = 1,
                    TabPagePadding = UDim.new(0, 8),
                    ModalWindowDimBg = Color3.fromRGB(230, 230, 230),
                    ModalWindowDimTweenInfo = TweenInfo.new(0.2),
                    WindowBg = aa.Black,
                    WindowBgTransparency = 0.05,
                    Border = aa.Gray,
                    BorderTransparency = 0.8,
                    BorderTransparencyActive = 0.5,
                    Title = aa.White,
                    TitleAlign = Enum.TextXAlignment.Left,
                    TitleBarBg = aa.Black,
                    TitleBarTransparency = 0,
                    TitleActive = aa.White,
                    TitleBarBgActive = aa.Dark,
                    TitleBarTransparencyActive = 0.05,
                    TitleBarBgCollapsed = Color3.fromRGB(0, 0, 0),
                    TitleBarTransparencyCollapsed = 0.6,
                },
            }
            ab.LightTheme = {
                BaseTheme = ab.DarkTheme,
                Values = {
                    Text = aa.Black,
                    TextFont = Font.fromEnum(Enum.Font.Ubuntu),
                    TextSize = 14,
                    FrameBg = aa.Gray,
                    FrameBgTransparency = 0.4,
                    FrameBgActive = aa.Light,
                    FrameBgTransparencyActive = 0.6,
                    SliderGrab = aa.Light,
                    ButtonsBg = aa.Light,
                    CollapsingHeaderText = aa.Black,
                    Separator = aa.Black,
                    ConsoleLineNumbers = aa.Yellow,
                    MenuBar = Color3.fromRGB(219, 219, 219),
                    PopupCanvas = aa.White,
                    TabText = aa.Black,
                    TabTextActive = aa.Black,
                    WindowBg = aa.White,
                    Border = aa.Gray,
                    ResizeGrab = aa.Gray,
                    Title = aa.Black,
                    TitleAlign = Enum.TextXAlignment.Center,
                    TitleBarBg = aa.Gray,
                    TitleActive = aa.Black,
                    TitleBarBgActive = Color3.fromRGB(186, 186, 186),
                    TitleBarBgCollapsed = aa.Gray,
                },
            }
            ab.ImGui = {
                BaseTheme = ab.DarkTheme,
                Values = {
                    AnimationTweenInfo = TweenInfo.new(0),
                    Text = Color3.fromRGB(255, 255, 255),
                    FrameBg = aa.ImGui.Dark,
                    FrameBgTransparency = 0.4,
                    FrameBgActive = aa.ImGui.Light,
                    FrameBgTransparencyActive = 0.5,
                    FrameRounding = UDim.new(0, 0),
                    ButtonsBg = aa.ImGui.Light,
                    CollapsingHeaderBg = aa.ImGui.Light,
                    CollapsingHeaderText = aa.White,
                    CheckMark = aa.ImGui.Light,
                    ResizeGrab = aa.ImGui.Light,
                    MenuBar = aa.ImGui.Gray,
                    MenuBarTransparency = 0,
                    PopupCanvas = aa.ImGui.Black,
                    TabText = aa.Gray,
                    TabBg = aa.ImGui.Dark,
                    TabTextActive = aa.White,
                    TabBgActive = aa.ImGui.Light,
                    WindowBg = aa.ImGui.Black,
                    WindowBgTransparency = 0.05,
                    Border = aa.Gray,
                    BorderTransparency = 0.7,
                    BorderTransparencyActive = 0.4,
                    Title = aa.White,
                    TitleBarBg = aa.ImGui.Black,
                    TitleBarTransparency = 0,
                    TitleBarBgActive = aa.ImGui.Dark,
                    TitleBarTransparencyActive = 0,
                },
            }

            return ab
        end

        function a.h(): typeof(__modImpl())
            local aa = a.cache.h

            if not aa then
                aa = {
                    c = __modImpl(),
                }
                a.cache.h = aa
            end

            return aa.c
        end
    end
    do
        local function __modImpl()
            local aa = a.b()
            local ab

            aa:AddOnInit(function(ad)
                ab = ad
            end)

            return {
                {
                    Properties = {
                        'Center',
                    },
                    Callback = function<FlagFunc>(ad, b, c)
                        local d = b.Position

                        aa:SetProperties(b, {
                            Position = UDim2.new(c:find'X' and 0.5 or d.X.Scale, d.X.Offset, c:find'Y' and 0.5 or d.Y.Scale, d.Y.Offset),
                            AnchorPoint = Vector2.new(c:find'X' and 0.5 or 0, c:find'Y' and 0.5 or 0),
                        })
                    end,
                },
                {
                    Properties = {
                        'ElementStyle',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        ab:ApplyStyle(b, c)
                    end,
                },
                {
                    Properties = {
                        'ColorTag',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        local d = ad.Class
                        local e = ad.WindowClass
                        local g = d.NoAutoTheme

                        if not e then
                            return
                        end
                        if g then
                            return
                        end

                        ab:UpdateColors{
                            Object = b,
                            Tag = c,
                            NoAnimation = true,
                            Theme = e.Theme,
                        }
                    end,
                },
                {
                    Properties = {
                        'Animation',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        local d = ad.Class.NoAnimation

                        if d then
                            return
                        end

                        ab:SetAnimation(b, c)
                    end,
                },
                {
                    Properties = {
                        'Image',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        local d = ad.WindowClass

                        b.Image = aa:CheckAssetUrl(c)

                        ab:DynamicImageTag(b, c, d)
                    end,
                },
                {
                    Properties = {
                        'Icon',
                        'IconSize',
                        'IconRotation',
                        'IconPadding',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        local d = b:FindFirstChild('Icon', true)

                        if not d then
                            ab:Warn('No icon for', b)

                            return
                        end

                        local e = ad.Class

                        aa:CheckConfig(e, {
                            Icon = '',
                            IconSize = UDim2.fromScale(1, 1),
                            IconRotation = 0,
                            IconPadding = UDim2.new(0, 2),
                        })

                        local g = d.Parent:FindFirstChild'UIPadding'

                        aa:SetPadding(g, e.IconPadding)

                        local h = e.Icon

                        h = aa:CheckAssetUrl(h)

                        local i = ad.WindowClass

                        ab:DynamicImageTag(d, h, i)
                        aa:SetProperties(d, {
                            Visible = d ~= '',
                            Image = aa:CheckAssetUrl(h),
                            Size = e.IconSize,
                            Rotation = e.IconRotation,
                        })
                    end,
                },
                {
                    Properties = {
                        'BorderThickness',
                        'Border',
                        'BorderColor',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        local d = ad.Class
                        local e = d.Border == true

                        aa:CheckConfig(d, {
                            BorderTransparency = ad:GetThemeKey'BorderTransparencyActive',
                            BorderColor = ad:GetThemeKey'Border',
                            BorderThickness = 1,
                            BorderStrokeMode = Enum.ApplyStrokeMode.Border,
                        })

                        local g = aa:GetChildOfClass(b, 'UIStroke')

                        aa:SetProperties(g, {
                            Transparency = d.BorderTransparency,
                            Thickness = d.BorderThickness,
                            Color = d.BorderColor,
                            ApplyStrokeMode = d.BorderStrokeMode,
                            Enabled = e,
                        })
                    end,
                },
                {
                    Properties = {
                        'Ratio',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        local d = ad.Class

                        aa:CheckConfig(d, {
                            Ratio = 1.3333333333333333,
                            RatioAxis = Enum.DominantAxis.Height,
                            RatioAspectType = Enum.AspectType.ScaleWithParentSize,
                        })

                        local e = d.Ratio
                        local g = d.RatioAxis
                        local h = d.RatioAspectType
                        local i = aa:GetChildOfClass(b, 'UIAspectRatioConstraint')

                        aa:SetProperties(i, {
                            DominantAxis = g,
                            AspectType = h,
                            AspectRatio = e,
                        })
                    end,
                },
                {
                    Properties = {
                        'FlexMode',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        local d = aa:GetChildOfClass(b, 'UIFlexItem')

                        d.FlexMode = c
                    end,
                },
                {
                    Properties = {
                        'CornerRadius',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        local d = aa:GetChildOfClass(b, 'UICorner')

                        d.CornerRadius = c
                    end,
                },
                {
                    Properties = {
                        'Fill',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        if c ~= true then
                            return
                        end

                        local d = ad.Class

                        aa:CheckConfig(d, {
                            Size = UDim2.fromScale(1, 1),
                            UIFlexMode = Enum.UIFlexMode.Fill,
                            AutomaticSize = Enum.AutomaticSize.None,
                        })

                        local e = aa:GetChildOfClass(b, 'UIFlexItem')

                        e.FlexMode = d.UIFlexMode
                        b.Size = d.Size
                        b.AutomaticSize = d.AutomaticSize
                    end,
                },
                {
                    Properties = {
                        'Label',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        local d = ad.Class
                        local e = b:FindFirstChild'Label'

                        if not e then
                            return
                        end

                        e.Text = tostring(c)

                        function d.SetLabel(g, h)
                            e.Text = h

                            return g
                        end
                    end,
                },
                {
                    Properties = {
                        'NoGradient',
                    },
                    WindowProperties = {
                        'NoGradients',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        local d = b:FindFirstChildOfClass'UIGradient'

                        if not d then
                            return
                        end

                        d.Enabled = c
                    end,
                },
                {
                    Properties = {
                        'UiPadding',
                        'PaddingBottom',
                        'PaddingTop',
                        'PaddingRight',
                        'PaddingTop',
                    },
                    Callback = function<StyleFunc>(ad, b, c)
                        c = c or 0

                        if typeof(c) == 'number' then
                            c = UDim.new(0, c)
                        end

                        local d = ad.Class
                        local e = d.UiPadding

                        if e then
                            aa:CheckConfig(d, {
                                PaddingBottom = c,
                                PaddingLeft = c,
                                PaddingRight = c,
                                PaddingTop = c,
                            })
                        end

                        local g = aa:GetChildOfClass(b, 'UIPadding')

                        aa:SetProperties(g, {
                            PaddingBottom = d.PaddingBottom,
                            PaddingLeft = d.PaddingLeft,
                            PaddingRight = d.PaddingRight,
                            PaddingTop = d.PaddingTop,
                        })
                    end,
                },
                {
                    Properties = {
                        'Callback',
                    },
                    Callback = function<StyleFunc>(ad, b)
                        local c = ad.Class

                        function c.SetCallback(d, e)
                            d.Callback = e

                            return d
                        end
                        function c.FireCallback(d, e)
                            d.Callback(b)

                            return d
                        end
                    end,
                },
                {
                    Properties = {
                        'Value',
                    },
                    Callback = function<StyleFunc>(ad, b)
                        local c = ad.Class

                        aa:CheckConfig(c, {
                            GetValue = function(d)
                                return c.Value
                            end,
                        })
                    end,
                },
            }
        end

        function a.i(): typeof(__modImpl())
            local aa = a.cache.i

            if not aa then
                aa = {
                    c = __modImpl(),
                }
                a.cache.i = aa
            end

            return aa.c
        end
    end
    do
        local function __modImpl()
            local aa = {}

            aa.Coloring = {
                MenuBar = {
                    BackgroundColor3 = 'MenuBar',
                    BackgroundTransparency = 'MenuBarTransparency',
                },
                FrameRounding = {
                    CornerRadius = 'FrameRounding',
                },
                PopupCanvas = {
                    BackgroundColor3 = 'PopupCanvas',
                },
                ModalWindowDim = {
                    BackgroundColor3 = 'ModalWindowDimBg',
                },
                Selectable = 'Button',
                MenuButton = 'Button',
                Separator = {
                    BackgroundColor3 = 'Separator',
                    BackgroundTransparency = 'SeparatorTransparency',
                },
                Region = {
                    BackgroundColor3 = 'RegionBg',
                    BackgroundTransparency = 'RegionBgTransparency',
                },
                Label = {
                    TextColor3 = 'Text',
                    FontFace = 'TextFont',
                    TextSize = 'TextSize',
                },
                ImageFollowsText = {
                    ImageColor3 = 'Text',
                },
                ConsoleLineNumbers = {
                    TextColor3 = 'ConsoleLineNumbers',
                    FontFace = 'TextFont',
                    TextSize = 'TextSize',
                },
                ConsoleText = 'Label',
                LabelDisabled = {
                    TextColor3 = 'TextDisabled',
                    FontFace = 'TextFont',
                    TextSize = 'TextSize',
                },
                Plot = {
                    BackgroundColor3 = 'HistogramBar',
                },
                Header = {
                    BackgroundColor3 = 'HeaderBg',
                    BackgroundTransparency = 'HeaderBgTransparency',
                },
                WindowTitle = {
                    TextXAlignment = 'TitleAlign',
                    FontFace = 'TextFont',
                    TextSize = 'TextSize',
                },
                TitleBar = {
                    BackgroundColor3 = 'TitleBarBgActive',
                },
                Window = {
                    BackgroundColor3 = 'WindowBg',
                    BackgroundTransparency = 'WindowBgTransparency',
                },
                TitleBarBgCollapsed = {
                    BackgroundColor3 = 'TitleBarBgCollapsed',
                    BackgroundTransparency = 'TitleBarTransparencyCollapsed',
                },
                TitleBarBgActive = {
                    BackgroundColor3 = 'TitleBarBgActive',
                    BackgroundTransparency = 'TitleBarTransparencyActive',
                },
                TitleBarBg = {
                    BackgroundColor3 = 'TitleBarBg',
                    BackgroundTransparency = 'TitleBarTransparency',
                },
                TabsBar = {
                    BackgroundColor3 = 'TabsBarBg',
                    BackgroundTransparency = 'TabsBarBgTransparency',
                },
                Border = {
                    Color = 'Border',
                    Transparency = 'BorderTransparency',
                },
                ResizeGrab = {
                    TextColor3 = 'ResizeGrab',
                },
                BorderActive = {
                    Transparency = 'BorderTransparencyActive',
                },
                Frame = {
                    BackgroundColor3 = 'FrameBg',
                    BackgroundTransparency = 'FrameBgTransparency',
                    TextColor3 = 'Text',
                    FontFace = 'TextFont',
                    TextSize = 'TextSize',
                },
                FrameActive = {
                    BackgroundColor3 = 'FrameBgActive',
                    BackgroundTransparency = 'FrameBgTransparencyActive',
                },
                SliderGrab = {
                    BackgroundColor3 = 'SliderGrab',
                },
                Button = {
                    BackgroundColor3 = 'ButtonsBg',
                    TextColor3 = 'Text',
                    FontFace = 'TextFont',
                    TextSize = 'TextSize',
                },
                CollapsingHeader = {
                    FontFace = 'TextFont',
                    TextSize = 'TextSize',
                    TextColor3 = 'CollapsingHeaderText',
                    BackgroundColor3 = 'CollapsingHeaderBg',
                },
                Checkbox = {
                    BackgroundColor3 = 'FrameBg',
                },
                CheckMark = {
                    ImageColor3 = 'CheckMark',
                    BackgroundColor3 = 'CheckMark',
                },
                RadioButton = {
                    BackgroundColor3 = 'ButtonsBg',
                    TextColor3 = 'Text',
                    FontFace = 'TextFont',
                    TextSize = 'TextSize',
                },
            }
            aa.Styles = {
                RadioButton = {
                    Animation = 'RadioButtons',
                    CornerRadius = UDim.new(1, 0),
                },
                Button = {
                    Animation = 'Buttons',
                },
                CollapsingHeader = {
                    Animation = 'Buttons',
                },
                TreeNode = {
                    Animation = 'TransparentButtons',
                },
                TransparentButton = {
                    Animation = 'TransparentButtons',
                },
            }
            aa.Animations = {
                Invisible = {
                    Connections = {
                        MouseEnter = {Visible = true},
                        MouseLeave = {Visible = false},
                    },
                    Init = 'MouseLeave',
                },
                Buttons = {
                    Connections = {
                        MouseEnter = {BackgroundTransparency = 0.3},
                        MouseLeave = {BackgroundTransparency = 0.7},
                    },
                    Init = 'MouseLeave',
                },
                TextButtons = {
                    Connections = {
                        MouseEnter = {TextTransparency = 0.3},
                        MouseLeave = {TextTransparency = 0.7},
                    },
                    Init = 'MouseLeave',
                },
                TransparentButtons = {
                    Connections = {
                        MouseEnter = {BackgroundTransparency = 0.3},
                        MouseLeave = {BackgroundTransparency = 1},
                    },
                    Init = 'MouseLeave',
                },
                RadioButtons = {
                    Connections = {
                        MouseEnter = {BackgroundTransparency = 0.5},
                        MouseLeave = {BackgroundTransparency = 1},
                    },
                    Init = 'MouseLeave',
                },
                Inputs = {
                    Connections = {
                        MouseEnter = {BackgroundTransparency = 0},
                        MouseLeave = {BackgroundTransparency = 0.5},
                    },
                    Init = 'MouseLeave',
                },
                Plots = {
                    Connections = {
                        MouseEnter = {BackgroundTransparency = 0.3},
                        MouseLeave = {BackgroundTransparency = 0},
                    },
                    Init = 'MouseLeave',
                },
                Border = {
                    Connections = {
                        Selected = {
                            Transparency = 0,
                            Thickness = 1,
                        },
                        Deselected = {
                            Transparency = 0.7,
                            Thickness = 1,
                        },
                    },
                    Init = 'Selected',
                },
            }

            return aa
        end

        function a.j(): typeof(__modImpl())
            local aa = a.cache.j

            if not aa then
                aa = {
                    c = __modImpl(),
                }
                a.cache.j = aa
            end

            return aa.c
        end
    end
end

local aa = {
    Version = '1.4.7',
    Author = 'Depso',
    License = 'MIT',
    Repository = 'https://github.com/Jibbefr/Dear-ReGui-Edited/',
    Debug = false,
    PrefabsId = 122589944740561,
    DefaultTitle = 'ReGui',
    ContainerName = 'ReGui',
    DoubleClickThreshold = 0.3,
    TooltipOffset = 15,
    IniToSave = {
        'Value',
    },
    ClassIgnored = {
        'Visible',
        'Text',
    },
    Container = nil,
    Prefabs = nil,
    FocusedWindow = nil,
    HasTouchScreen = false,
    Services = nil,
    Elements = {},
    _FlagCache = {},
    _ErrorCache = {},
    Windows = {},
    ActiveTooltips = {},
    IniSettings = {},
    AnimationConnections = {},
}
local ab = a.a()
local ad = a.b()
local b = a.c()
local c = a.d()

aa.DemoWindow = a.e()
aa.Services = ad.Services
aa.Animation = b
aa.Icons = a.f()
aa.Accent = a.g()
aa.ThemeConfigs = a.h()
aa.ElementFlags = a.i()

local d = a.j()

aa.ElementColors = d.Coloring
aa.Animations = d.Animations
aa.Styles = d.Styles

ad:CallOnInitConnections(aa)

aa.DynamicImages = {
    [aa.Icons.Arrow] = 'ImageFollowsText',
    [aa.Icons.Close] = 'ImageFollowsText',
    [aa.Icons.Dot] = 'ImageFollowsText',
}

type table = {[any]: any}
type TagsList = {[GuiObject]: string}

local e = aa.Services
local g = e.HttpService
local h = e.Players
local i = e.UserInputService
local j = e.RunService
local k = e.InsertService
local l = ad:NewReference(h.LocalPlayer)

aa.PlayerGui = ad:NewReference(l.PlayerGui)
aa.Mouse = ad:NewReference(l:GetMouse())

local m = function() end

function GetAndRemove(n: string, o: table)
    local p = o[n]

    if p then
        o[n] = nil
    end

    return p
end
function MoveTableItem(n: table, o, p: number)
    local q = table.find(n, o)

    if not q then
        return
    end

    local r = table.remove(n, q)

    table.insert(n, p, r)
end
function Merge(n, o)
    for p, q in next, o do
        n[p] = q
    end
end
function Copy(n: table, o: table?)
    local p = table.clone(n)

    if o then
        Merge(p, o)
    end

    return p
end
function aa.Warn(n, ...: string?)
    warn('[ReGui]::', ...)
end
function aa.Error(n, ...: string?)
    local o = aa:Concat({...}, ' ')
    local p = `\n[ReGui]:: {o}`

    coroutine.wrap(error)(p)
end
function aa.IsDoubleClick(n, o: number): boolean
    local p = n.DoubleClickThreshold

    return o < p
end
function aa.StyleContainers(n)
    local o = n.Container
    local p = o.Overlays
    local q = o.Windows

    n:SetProperties(q, {OnTopOfCoreBlur = true})
    n:SetProperties(p, {OnTopOfCoreBlur = true})
end
function aa.Init(n, o: table?)
    o = o or {}

    if n.Initialised then
        return
    end

    Merge(n, o)
    Merge(n, {
        Initialised = true,
        HasGamepad = n:IsConsoleDevice(),
        HasTouchScreen = n:IsMobileDevice(),
    })
    n:CheckConfig(n, {
        ContainerParent = function()
            return ad:ResolveUIParent()
        end,
        Prefabs = function()
            return n:LoadPrefabs()
        end,
    }, true)
    n:CheckConfig(n, {
        Container = function()
            return n:InsertPrefab('Container', {
                Parent = n.ContainerParent,
                Name = n.ContainerName,
            })
        end,
    }, true)

    local p = n.Container
    local q = n.TooltipOffset
    local r = n.ActiveTooltips
    local v = p.Overlays
    local w = 0

    n:StyleContainers()

    n.TooltipsContainer = n.Elements:Overlay{Parent = v}

    i.InputBegan:Connect(function(x: InputObject)
        if not n:IsMouseEvent(x, true) then
            return
        end

        local y = tick()
        local z = y - w
        local A = n:IsDoubleClick(z)

        w = A and 0 or y

        n:UpdateWindowFocuses()
    end)

    local function InputUpdate()
        local x = n.TooltipsContainer
        local y = #r > 0

        x.Visible = y

        if not y then
            return
        end

        local z, A = aa:GetMouseLocation()
        local B = v.AbsolutePosition

        x.Position = UDim2.fromOffset(z - B.X + q, A - B.Y + q)
    end

    j.RenderStepped:Connect(InputUpdate)
end
function aa.CheckImportState(n)
    if n.Initialised then
        return
    end

    local o = n.PrefabsId
    local p = ad:CheckAssetUrl(o)
    local q, r = pcall(function()
        return ad:NewReference(k:LoadLocalAsset(p))
    end)

    n:Init{
        Prefabs = q and r or nil,
    }
end
function aa.GetVersion(n): string
    return n.Version
end
function aa.IsMobileDevice(n): boolean
    return i.TouchEnabled
end
function aa.IsConsoleDevice(n): boolean
    return i.GamepadEnabled
end
function aa.GetScreenSize(n): Vector2
    return workspace.CurrentCamera.ViewportSize
end
function aa.LoadPrefabs(n): Folder?
    local o = n.PlayerGui
    local p = 'ReGui-Prefabs'
    local q = script:WaitForChild(p, 2)

    if q then
        return q
    end

    local r = o:WaitForChild(p, 2)

    if r then
        return r
    end

    return nil
end
function aa.CheckConfig(n, o: table, p: table, q: boolean?, r: table?)
    return ad:CheckConfig(o, p, q, r)
end
function aa.CreateInstance(n, o, p, q): Instance
    local r = Instance.new(o, p)

    if q then
        local v = q.UsePropertiesList

        if not v then
            n:SetProperties(r, q)
        else
            n:ApplyFlags{
                Object = r,
                Class = q,
            }
        end
    end

    return r
end
function aa.ConnectMouseEvent(n, o: GuiButton, p)
    local q = p.Callback
    local r = p.DoubleClick
    local v = p.OnlyMouseHovering
    local w = 0
    local x

    if v then
        x = n:DetectHover(v)
    end

    o.Activated:Connect(function(...)
        local y = tick()
        local z = y - w

        if x and not x.Hovering then
            return
        end
        if r then
            if not aa:IsDoubleClick(z) then
                w = y

                return
            end

            w = 0
        end

        q(...)
    end)
end
function aa.GetAnimation(n, o: boolean?)
    return o and n.Animation or TweenInfo.new(0)
end
function aa.DynamicImageTag(n, o: Instance, p: string, q: table)
    local r = n.DynamicImages
    local v = r[p]

    if not v then
        return
    end
    if not q then
        return
    end

    q:TagElements{[o] = v}
end
function aa.GetDictSize(n, o: table): number
    local p = 0

    for q, r in o do
        p += 1
    end

    return p
end
function aa.RemoveAnimations(n, o: GuiObject)
    local p = n:GetAnimationData(o)
    local q = p.Connections

    for r, v in next, q do
        v:Disconnect()
    end
end
function aa.GetAnimationData(n, o: GuiObject): table
    local p = n.AnimationConnections
    local q = p[o]

    if q then
        return q
    end

    local r = {Connections = {}}

    p[o] = r

    return r
end
function aa.AddAnimationSignal(n, o: GuiObject, p: RBXScriptSignal)
    local q = n:GetAnimationData(o)
    local r = q.Connections

    table.insert(r, p)
end
function aa.SetAnimationsEnabled(n, o: boolean)
    n.NoAnimations = not o
end
function aa.SetAnimation(n, o: GuiObject, p: (string | table), q: GuiObject?)
    q = q or o

    local r = n.Animations
    local v = n.HasTouchScreen
    local w = p

    if typeof(p) ~= 'table' then
        w = r[p]
    end

    assert(w, `No animation data for Class {p}!`)
    n:RemoveAnimations(q)

    local x = w.Init
    local y = w.Connections
    local z = w.Tweeninfo
    local A = w.NoAnimation
    local B = n:GetAnimationData(o)
    local C = B.State
    local E
    local F = true
    local G
    local H = {}
    local I = {}

    function I.Reset(J, K: boolean?)
        if not E then
            return
        end

        E(K)
    end
    function I.FireSignal(J, K: string, L: boolean?)
        H[K](L)
    end
    function I.Refresh(J, K: boolean?)
        if not G then
            return
        end

        H[G](K)
    end
    function I.SetEnabled(J, K: boolean)
        F = K
    end

    for J: string, K in next, y do
        local function OnSignal(L: boolean?)
            L = L == true
            G = J

            local M = n.NoAnimations

            if M then
                return
            end
            if not F then
                return
            end

            B.State = J

            b:Tween{
                NoAnimation = L or A,
                Object = o,
                Tweeninfo = z,
                EndProperties = K,
            }
        end

        local L = q[J]

        if not v then
            local M = L:Connect(OnSignal)

            n:AddAnimationSignal(q, M)
        end

        H[J] = OnSignal

        if J == x then
            E = OnSignal
        end
    end

    if C then
        I:FireSignal(C)
    else
        I:Reset(true)
    end

    return I
end

export type ConnectDrag = {DragStart: () -> nil, DragEnd: () -> nil, DragMovement: () -> nil}

function aa.ConnectDrag(n, o: GuiObject, p)
    n:CheckConfig(p, {
        DragStart = m,
        DragEnd = m,
        DragMovement = m,
        OnDragStateChange = m,
    })

    local q = p.DragStart
    local r = p.DragEnd
    local v = p.DragMovement
    local w = p.OnDragStateChange
    local x = {
        StartAndEnd = {
            Enum.UserInputType.MouseButton1,
            Enum.UserInputType.Touch,
        },
        Movement = {
            Enum.UserInputType.MouseMovement,
            Enum.UserInputType.Touch,
        },
    }
    local y = false

    local function InputTypeAllowed(z, A: string)
        local B = z.UserInputType

        return table.find(x[A], B)
    end
    local function KeyToVector(z): Vector2
        local A = z.Position

        return Vector2.new(A.X, A.Y)
    end
    local function SetIsDragging(z: boolean)
        n._DraggingDisabled = z
        y = z

        w(z)
    end
    local function MakeSignal(z)
        local A = z.IsDragging
        local B = z.InputType
        local C = z.Callback

        return function(E)
            if z.DraggingRequired ~= y then
                return
            end
            if z.CheckDraggingDisabled and n._DraggingDisabled then
                return
            end
            if not InputTypeAllowed(E, B) then
                return
            end
            if z.UpdateState then
                SetIsDragging(A)
            end

            local F = KeyToVector(E)

            C(F)
        end
    end

    o.InputBegan:Connect(MakeSignal{
        CheckDraggingDisabled = true,
        DraggingRequired = false,
        UpdateState = true,
        IsDragging = true,
        InputType = 'StartAndEnd',
        Callback = q,
    })
    i.InputEnded:Connect(MakeSignal{
        DraggingRequired = true,
        UpdateState = true,
        IsDragging = false,
        InputType = 'StartAndEnd',
        Callback = r,
    })
    i.InputChanged:Connect(MakeSignal{
        DraggingRequired = true,
        InputType = 'Movement',
        Callback = v,
    })
end

type MakeDraggableFlags = {Move: Instance, Grab: Instance, Enabled: boolean?, SetPosition: (MakeDraggableFlags, Position:UDim2) -> nil, OnUpdate: ((Vector2) -> ...any)?, DragBegin: ((InputObject) -> ...any)?, StateChanged: ((MakeDraggableFlags) -> any)?, OnDragStateChange: ((IsDragging:boolean) -> any)?}

function aa.MakeDraggable(n, o: MakeDraggableFlags)
    local p = o.Move
    local q = o.Grab
    local r = o.OnDragStateChange
    local v
    local w
    local x = {}

    function x.SetEnabled(y, z: boolean)
        local A = o.StateChanged

        y.Enabled = z

        if A then
            A(y)
        end
    end
    function x.CanDrag(y, z): boolean
        return y.Enabled
    end

    local function DragStart(y)
        if not x:CanDrag() then
            return
        end

        local z = o.DragBegin

        w = y

        z(w)
    end
    local function DragMovement(y)
        if not x:CanDrag() then
            return
        end

        local z = y - w
        local A = o.OnUpdate

        A(z)
    end
    local function PositionBegan(y)
        v = p.Position
    end
    local function UpdatePosition(y: Vector2)
        local z = UDim2.new(v.X.Scale, v.X.Offset + y.X, v.Y.Scale, v.Y.Offset + y.Y)

        o:SetPosition(z)
    end
    local function SetPosition(y, z: UDim2)
        b:Tween{
            Object = p,
            EndProperties = {Position = z},
        }
    end

    n:CheckConfig(o, {
        Enabled = true,
        OnUpdate = UpdatePosition,
        SetPosition = SetPosition,
        DragBegin = PositionBegan,
    })
    n:ConnectDrag(q, {
        DragStart = DragStart,
        DragMovement = DragMovement,
        OnDragStateChange = r,
    })

    local y = o.Enabled

    x:SetEnabled(y)

    return x
end

export type MakeResizableFlags = {MinimumSize: Vector2, MaximumSize: Vector2?, Resize: Instance, OnUpdate: (UDim2) -> ...any}

function aa.MakeResizable(n, o: MakeResizableFlags)
    aa:CheckConfig(o, {
        MinimumSize = Vector2.new(160, 90),
        MaximumSize = Vector2.new(math.huge, math.huge),
    })

    local p = o.MaximumSize
    local q = o.MinimumSize
    local r = o.Resize
    local v = o.OnUpdate
    local w
    local x = aa:InsertPrefab('ResizeGrab', {Parent = r})

    local function StateChanged(y)
        x.Visible = y.Enabled
    end
    local function UpdateSize(y)
        local z = w + y
        local A = UDim2.fromOffset(math.clamp(z.X, q.X, p.X), math.clamp(z.Y, q.Y, p.Y))

        if v then
            v(A)

            return
        end

        b:Tween{
            Object = r,
            EndProperties = {Size = A},
        }
    end
    local function ResizeBegin(y)
        w = r.AbsoluteSize
    end

    local y = n:MakeDraggable{
        Grab = x,
        OnUpdate = UpdateSize,
        DragBegin = ResizeBegin,
        StateChanged = StateChanged,
    }

    y.Grab = x

    return y
end
function aa.IsMouseEvent(n, o: InputObject, p: boolean)
    local q = o.UserInputType.Name

    if p and q:find'Movement' then
        return
    end

    return q:find'Touch' or q:find'Mouse'
end

export type DetectHover = {OnInput: ((boolean, InputObject?) -> ...any?)?, Anykey: boolean?, MouseMove: boolean?, MouseOnly: boolean?, MouseEnter: boolean?, Hovering: boolean?}

function aa.DetectHover(n, o: GuiObject, p: DetectHover?)
    local q = p or {}

    q.Hovering = false

    local r = q.OnInput
    local v = q.OnHoverChange
    local w = q.Anykey
    local x = q.MouseMove
    local y = q.MouseEnter
    local z = q.MouseOnly

    local function Update(A, B: boolean?, C: boolean?)
        if A and z then
            if not aa:IsMouseEvent(A, true) then
                return
            end
        end
        if B ~= nil then
            local E = q.Hovering

            q.Hovering = B

            if B ~= E and v then
                v(B)
            end
        end
        if not y and C then
            return
        end
        if r then
            local E = q.Hovering

            r(E, A)

            return
        end
    end

    local A = {
        o.MouseEnter:Connect(function()
            Update(nil, true, true)
        end),
        o.MouseLeave:Connect(function()
            Update(nil, false, true)
        end),
    }

    if w or z then
        table.insert(A, i.InputBegan:Connect(function(B)
            Update(B)
        end))
    end
    if x then
        local B = o.MouseMoved:Connect(function()
            Update()
        end)

        table.insert(A, B)
    end

    function q.Disconnect(B)
        for C, E in next, A do
            E:Disconnect()
        end
    end

    return q
end
function aa.StackWindows(n)
    local o = n.Windows
    local p = 20

    for q, r in next, o do
        local v = r.WindowFrame
        local w = UDim2.fromOffset(p * q, p * q)

        r:Center()

        v.Position += w
    end
end
function aa.GetElementFlags(n, o: GuiObject): table?
    local p = n._FlagCache

    return p[o]
end

type UpdateColors = {Object: GuiObject, Tag: (string | table), NoAnimation: boolean?, Theme: string?, TagsList: TagsList?, Tweeninfo: TweenInfo?}

function aa.UpdateColors(n, o: UpdateColors)
    local p = o.Object
    local q = o.Tag
    local r = o.NoAnimation
    local v = o.TagsList
    local w = o.Theme
    local x = o.Tweeninfo
    local y = n.ElementColors
    local z = n:GetElementFlags(p)
    local A = n.Debug
    local B = y[q]

    if typeof(B) == 'string' then
        B = y[B]
    end
    if typeof(q) == 'table' then
        B = q
    elseif v then
        v[p] = q
    end
    if not B then
        return
    end

    local C = {}

    for E: string, F: string in next, B do
        local G = n:GetThemeKey(w, F)

        if z and z[E] then
            continue
        end
        if not G then
            if A then
                n:Warn(`Color: '{F}' does not exist!`)
            end

            continue
        end

        C[E] = G
    end

    b:Tween{
        Tweeninfo = x,
        Object = p,
        NoAnimation = r,
        EndProperties = C,
    }
end

export type MultiUpdateColorsConfig = {Objects: ObjectsTable, TagsList: TagsList?, Theme: string?, Animate: boolean?, Tweeninfo: TweenInfo?}

function aa.MultiUpdateColors(n, o: MultiUpdateColorsConfig)
    local p = o.Objects

    for q: GuiObject, r: string? in next, p do
        n:UpdateColors{
            TagsList = o.TagsList,
            Theme = o.Theme,
            NoAnimation = not o.Animate,
            Tweeninfo = o.Tweeninfo,
            Object = q,
            Tag = r,
        }
    end
end
function aa.ApplyStyle(n, o: GuiObject, p: string)
    local q = n.Styles
    local r = q[p]

    if not r then
        return
    end

    n:ApplyFlags{
        Object = o,
        Class = r,
    }
end
function aa.ClassIgnores(n, o: string): boolean
    local p = n.ClassIgnored
    local q = table.find(p, o)

    return q and true or false
end
function aa.MergeMetatables(n, o, p: GuiObject)
    local q = n.Debug
    local r = {}

    r.__index = function(v, w: string)
        local x = n:ClassIgnores(w)
        local y = o[w]

        if y ~= nil and not x then
            return y
        end

        local z, A = pcall(function()
            local z = p[w]

            return n:PatchSelf(p, z)
        end)

        return z and A or nil
    end
    r.__newindex = function(v, w: string, x)
        local y = n:ClassIgnores(w)
        local z = typeof(x) == 'function'
        local A = o[w] ~= nil or z

        if A and not y then
            o[w] = x

            return
        end

        xpcall(function()
            p[w] = x
        end, function(B)
            if q then
                n:Warn(`Newindex Error: {p}.{w} = {x}\n{B}`)
            end

            o[w] = x
        end)
    end

    return setmetatable({}, r)
end
function aa.Concat(n, o, p: ' ')
    local q = ''

    for r, v in next, o do
        q ..= tostring(v) .. (r ~= #o and p or '')
    end

    return q
end
function aa.GetValueFromAliases(n, o, p)
    for q, r: string in o do
        local v = p[r]

        if v ~= nil then
            return v
        end
    end

    return nil
end
function aa.RecursiveCall(n, o: GuiObject, p: (GuiObject) -> ...any)
    for q, r in next, o:GetDescendants()do
        p(r)
    end
end

export type ApplyFlags = {Object: Instance, Class: table, WindowClass: table?, GetThemeKey: (ApplyFlags, Tag:string) -> any}

function aa.ApplyFlags(n, o: ApplyFlags)
    local p = n.ElementFlags
    local q = o.Object
    local r = o.Class
    local v = o.WindowClass

    function o.GetThemeKey(w, x: string)
        if v then
            return v:GetThemeKey(x)
        else
            return aa:GetThemeKey(nil, x)
        end
    end

    n:SetProperties(q, r)

    for w, x in next, p do
        local y = x.Properties
        local z = x.Callback
        local A = x.Recursive
        local B = x.WindowProperties
        local C = n:GetValueFromAliases(y, r)

        if v and B and C == nil then
            C = n:GetValueFromAliases(B, v)
        end
        if C == nil then
            continue
        end

        z(o, q, C)

        if A then
            n:RecursiveCall(q, function(E)
                z(o, E, C)
            end)
        end
    end
end
function aa.SetProperties(n, o: Instance, p: table)
    return ad:SetProperties(o, p)
end
function aa.InsertPrefab(n, o: string, p): GuiObject
    local q = n.Prefabs
    local r = q.Prefabs
    local v = ad:NewReference(r:WaitForChild(o):Clone())

    if p then
        local w = p.UsePropertiesList

        if not w then
            n:SetProperties(v, p)
        else
            n:ApplyFlags{
                Object = v,
                Class = p,
            }
        end
    end

    return v
end
function aa.GetContentSize(n, o: GuiObject, p: boolean?): Vector2
    local q = o:FindFirstChildOfClass'UIListLayout'
    local r = o:FindFirstChildOfClass'UIPadding'
    local v = o:FindFirstChildOfClass'UIStroke'
    local w: Vector2

    if q and not p then
        w = q.AbsoluteContentSize
    else
        w = o.AbsoluteSize
    end
    if r then
        local x = r.PaddingTop.Offset
        local y = r.PaddingBottom.Offset
        local z = r.PaddingLeft.Offset
        local A = r.PaddingRight.Offset

        w += Vector2.new(z + A, x + y)
    end
    if v then
        local x = v.Thickness

        w += Vector2.new(x / 2, x / 2)
    end

    return w
end
function aa.PatchSelf(n, o, p, ...)
    if typeof(p) ~= 'function' then
        return p, ...
    end

    return function(q, ...)
        return p(o, ...)
    end
end

type MakeCanvas = {Element: Instance, WindowClass: WindowFlags?, Class: {}?}

function aa.MakeCanvas(n, o: MakeCanvas)
    local p = n.Elements
    local q = n.Debug
    local r = o.Element
    local v = o.WindowClass
    local w = o.Class
    local x = o.OnChildChange
    local y = c:NewSignal()

    if x then
        y:Connect(x)
    end
    if not v and q then
        n:Warn(`No WindowClass for {r}`)
        n:Warn(o)
    end

    local z = ad:NewClass(p, {
        Class = w,
        RawObject = r,
        WindowClass = v or false,
        OnChildChange = y,
        Elements = {},
    })
    local A = {
        __index = function(A, B: string)
            local C = z[B]

            if C ~= nil then
                return n:PatchSelf(z, C)
            end

            local E = w[B]

            if E ~= nil then
                return n:PatchSelf(w, E)
            end

            local F = r[B]

            return n:PatchSelf(r, F)
        end,
        __newindex = function(A, B: string, C)
            local E = w[B] ~= nil

            if E then
                w[B] = C
            else
                r[B] = C
            end
        end,
    }

    return setmetatable({}, A)
end
function aa.GetIniData(n, o): table
    local p = n.IniToSave
    local q = {}

    for r, v in next, p do
        q[v] = o[v]
    end

    return q
end
function aa.DumpIni(n, o: boolean?): table
    local p = n.IniSettings
    local q = {}

    for r, v in next, p do
        q[r] = n:GetIniData(v)
    end

    if o then
        return g:JSONEncode(q)
    end

    return q
end
function aa.LoadIniIntoElement(n, o, p: table)
    local q = {
        Value = function(q)
            o:SetValue(q)
        end,
    }

    for r, v in next, p do
        local w = q[r]

        if w then
            w(v)

            continue
        end

        o[r] = v
    end
end
function aa.LoadIni(n, o: (table | string), p: boolean?)
    local q = n.IniSettings

    assert(o, 'No Ini configuration was passed')

    if p then
        o = g:JSONDecode(o)
    end

    for r, v in next, o do
        local w = q[r]

        n:LoadIniIntoElement(w, v)
    end
end
function aa.AddIniFlag(n, o: string, p: table)
    local q = n.IniSettings

    q[o] = p
end

type OnElementCreateData = {Flags: table, Object: GuiObject, Canvas: table, Class: table?}

function aa.OnElementCreate(n, o: OnElementCreateData)
    local p = n._FlagCache
    local q = o.Flags
    local r = o.Object
    local v = o.Canvas
    local w = o.Class
    local x = v.WindowClass
    local y = q.NoAutoTag
    local z = q.NoAutoFlags
    local A = q.ColorTag
    local B = q.NoStyle
    local C = q.IniFlag

    p[r] = q

    if C then
        n:AddIniFlag(C, w)
    end
    if B then
        return
    end
    if not y and x then
        x:TagElements{[r] = A}
    end
    if x then
        x:LoadStylesIntoElement(o)
    end
    if not z then
        n:ApplyFlags{
            Object = r,
            Class = q,
            WindowClass = x,
        }
    end
end
function aa.VisualError(n, o, p, q: string)
    local r = n.Initialised and o.Error

    if not r then
        n:Error('Class:', q)

        return
    end

    o:Error{
        Parent = p,
        Text = q,
    }
end
function aa.WrapGeneration(n, o, p: table)
    local q = n._ErrorCache
    local r = p.Base
    local v = p.IgnoreDefaults

    return function(w, x, ...)
        x = x or {}

        n:CheckConfig(x, r)

        local y = x.CloneTable

        if y then
            x = table.clone(x)
        end

        local z = w.RawObject
        local A = w.Elements
        local B = w.OnChildChange

        n:CheckConfig(x, {
            Parent = z,
            Name = x.ColorTag,
        }, nil, v)

        if w == n then
            w = n.Elements
        end

        local C, E, F = pcall(o, w, x, ...)

        if C == false then
            if z then
                if q[z] then
                    return
                end

                q[z] = E
            end

            n:VisualError(w, z, E)
            n:Error('Class:', E)
            n:Error(debug.traceback())
        end
        if F == nil then
            F = E
        end
        if B then
            B:Fire(E)
        end
        if F then
            if A then
                table.insert(A, F)
            end

            n:OnElementCreate{
                Object = F,
                Flags = x,
                Class = E,
                Canvas = w,
            }
        end

        return E, F
    end
end
function aa.DefineElement(n, o: string, p)
    local q = n.Elements
    local r = n.ThemeConfigs
    local v = n.ElementColors
    local w = r.DarkTheme
    local x = p.Base
    local y = p.Create
    local z = p.Export
    local A = p.ThemeTags
    local B = p.ColorData

    n:CheckConfig(x, {
        ColorTag = o,
        ElementStyle = o,
    })

    if A then
        Merge(w, A)
    end
    if B then
        Merge(v, B)
    end

    local C = n:WrapGeneration(y, p)

    if z then
        n[o] = C
    end

    q[o] = C

    return C
end
function aa.DefineGlobalFlag(n, o)
    local p = n.ElementFlags

    table.insert(p, o)
end
function aa.DefineTheme(n, o: string, p: ThemeData)
    local q = n.ThemeConfigs

    n:CheckConfig(p, {
        BaseTheme = q.DarkTheme,
    })

    local r = GetAndRemove('BaseTheme', p)
    local v = {
        BaseTheme = r,
        Values = p,
    }

    q[o] = v

    return v
end
function aa.GetMouseLocation(n): (number,number)
    local o = n.Mouse

    return o.X, o.Y
end
function aa.SetWindowFocusesEnabled(n, o: boolean)
    n.WindowFocusesEnabled = o
end
function aa.UpdateWindowFocuses(n)
    local o = n.Windows
    local p = n.WindowFocusesEnabled

    if not p then
        return
    end

    for q, r in o do
        local v = r.HoverConnection

        if not v then
            continue
        end

        local w = v.Hovering

        if w then
            n:SetFocusedWindow(r)

            return
        end
    end

    n:SetFocusedWindow(nil)
end
function aa.WindowCanFocus(n, o: table): boolean
    if o.NoSelect then
        return false
    end
    if o.Collapsed then
        return false
    end
    if o._SelectDisabled then
        return false
    end

    return true
end
function aa.GetFocusedWindow(n): table?
    return n.FocusedWindow
end
function aa.BringWindowToFront(n, o: table)
    local p = n.Windows
    local q = o.NoBringToFrontOnFocus

    if q then
        return
    end

    MoveTableItem(p, o, 1)
end
function aa.SetFocusedWindow(n, o: table?)
    local p = n:GetFocusedWindow()
    local q = n.Windows

    if p == o then
        return
    end

    n.FocusedWindow = o

    if o then
        local r = n:WindowCanFocus(o)

        if not r then
            return
        end

        n:BringWindowToFront(o)
    end

    local r = #q

    for v, w in q do
        local x = n:WindowCanFocus(w)
        local y = w.WindowFrame

        if not x then
            continue
        end

        r -= 1

        if r then
            y.ZIndex = r
        end

        local z = w == o

        w:SetFocused(z, r)
    end
end
function aa.SetItemTooltip(n, o: GuiObject, p: (Elements) -> ...any)
    local q = n.Elements
    local r = n.TooltipsContainer
    local v = n.ActiveTooltips
    local w, x = r:Canvas{
        Visible = false,
        UiPadding = UDim.new(),
    }

    task.spawn(p, w)
    aa:DetectHover(o, {
        MouseMove = true,
        MouseEnter = true,
        OnHoverChange = function(y: boolean)
            if y then
                table.insert(v, w)

                return
            end

            local z = table.find(v, w)

            table.remove(v, z)
        end,
        OnInput = function(y: boolean, z)
            x.Visible = y
        end,
    })
end
function aa.CheckFlags(n, o, p)
    for q: string, r in next, o do
        local v = p[q]

        if not v then
            continue
        end

        r(v)
    end
end
function aa.GetThemeKey(n, o: (string | table)?, p: string)
    local q = n.ThemeConfigs

    if typeof(o) == 'string' then
        o = q[o]
    end

    local r = q.DarkTheme

    o = o or r

    local v = o.BaseTheme
    local w = o.Values
    local x = w[p]

    if x then
        return x
    end
    if v then
        return n:GetThemeKey(v, p)
    end

    return
end
function aa.SelectionGroup(n, o)
    local p
    local q = false

    local function ForEach(r, v)
        for w, x in next, o do
            if typeof(x) == 'Instance' then
                continue
            end
            if x == v then
                continue
            end

            r(x)
        end
    end
    local function Callback(r)
        if q then
            return
        end

        q = true

        local v = p

        p = r:GetValue()

        if not v then
            v = p
        end

        ForEach(function(w)
            w:SetValue(v)
        end, r)

        q = false
    end

    ForEach(function(r)
        r.Callback = Callback
    end)
end

local n = aa.Elements

n.__index = n

function n.GetObject(o)
    return o.RawObject
end
function n.ApplyFlags(o, p, q)
    local r = o.WindowClass

    aa:ApplyFlags{
        WindowClass = r,
        Object = p,
        Class = q,
    }
end
function n.Remove(o)
    local p = o.OnChildChange
    local q = o:GetObject()
    local r = o.Class
    local v = r.Remove

    if v then
        return v(r)
    end
    if p then
        p:Fire(r or o)
    end
    if r then
        table.clear(r)
    end

    q:Destroy()
    table.clear(o)
end
function n.GetChildElements(o): table
    local p = o.Elements

    return p
end
function n.ClearChildElements(o)
    local p = o:GetChildElements()

    for q, r in next, p do
        r:Destroy()
    end
end
function n.TagElements(o, p: table)
    local q = o.WindowClass
    local r = aa.Debug

    if not q then
        if r then
            aa:Warn('No WindowClass for TagElements:', p)
        end

        return
    end

    q:TagElements(p)
end
function n.GetThemeKey(o, p: string)
    local q = o.WindowClass

    if q then
        return q:GetThemeKey(p)
    end

    return aa:GetThemeKey(nil, p)
end
function n.SetColorTags(o, p: tables, q: boolean?)
    local r = o.WindowClass

    if not r then
        return
    end

    local v = r.TagsList
    local w = r.Theme

    aa:MultiUpdateColors{
        Animate = q,
        Theme = w,
        TagsList = v,
        Objects = p,
    }
end
function n.SetElementFocused(o, p: GuiObject, q)
    local r = o.WindowClass
    local v = aa.HasTouchScreen
    local w = q.Focused
    local x = q.Animation

    aa:SetAnimationsEnabled(not w)

    if not w and x then
        x:Refresh()
    end
    if not r then
        return
    end
    if not v then
        return
    end

    local y = r.ContentCanvas

    y.Interactable = not w
end

aa:DefineElement('Dropdown', {
    Base = {
        ColorTag = 'PopupCanvas',
        Disabled = false,
        AutoClose = true,
        OnSelected = m,
    },
    Create = function(o, p)
        p.Parent = aa.Container.Overlays

        local q = p.Selected
        local r = p.Items
        local v = p.OnSelected
        local w, x = o:PopupCanvas(p)
        local y = aa:MergeMetatables(p, w)
        local z = {}

        local function SetValue(A)
            v(A)
        end

        function p.ClearEntries(A)
            for B, C in z do
                C:Remove()
            end
        end
        function p.SetItems(A, B: table, C)
            local E = B[1]

            A:ClearEntries()

            for F, G in B do
                local H = E and G or F
                local I = F == C or G == C
                local J = w:Selectable{
                    Text = tostring(H),
                    Selected = I,
                    ZIndex = 6,
                    Callback = function()
                        return SetValue(H)
                    end,
                }

                table.insert(z, J)
            end
        end

        if r then
            p:SetItems(r, q)
        end

        return y, x
    end,
})
aa:DefineElement('OverlayScroll', {
    Base = {
        ElementClass = 'OverlayScroll',
        Spacing = UDim.new(0, 4),
    },
    Create = function(o, p)
        local q = o.WindowClass
        local r = p.ElementClass
        local v = p.Spacing
        local w = aa:InsertPrefab(r, p)
        local x = w:FindFirstChild'ContentFrame' or w
        local y = w:FindFirstChild('UIListLayout', true)

        y.Padding = v

        local z = aa:MergeMetatables(o, p)
        local A = aa:MakeCanvas{
            Element = x,
            WindowClass = q,
            Class = z,
        }

        function p.GetCanvasSize(B)
            return x.AbsoluteCanvasSize
        end

        return A, w
    end,
})
aa:DefineElement('Overlay', {
    Base = {
        ElementClass = 'Overlay',
    },
    Create = n.OverlayScroll,
})

export type Image = {Image: (string | number), Callback: ((...any) -> unknown)?}

aa:DefineElement('Image', {
    Base = {
        Image = '',
        Callback = m,
    },
    Create = function(o, p: Image): ImageButton
        local q = aa:InsertPrefab('Image', p)

        q.Activated:Connect(function(...)
            local r = p.Callback

            return r(q, ...)
        end)

        return q
    end,
})

export type VideoPlayer = {Video: (string | number), Callback: ((...any) -> unknown)?}

aa:DefineElement('VideoPlayer', {
    Base = {
        Video = '',
        Callback = m,
    },
    Create = function(o, p: VideoPlayer): VideoFrame
        local q = p.Video

        p.Video = ad:CheckAssetUrl(q)

        local r = aa:InsertPrefab('VideoPlayer', p)

        return r
    end,
})

export type Button = {Text: string?, DoubleClick: boolean?, Callback: ((...any) -> unknown)?, Disabled: boolean?, SetDisabled: (Button, Disabled:boolean) -> Button}

aa:DefineElement('Button', {
    Base = {
        Text = 'Button',
        DoubleClick = false,
        Callback = m,
    },
    Create = function(o, p: Button): TextButton
        local q = aa:InsertPrefab('Button', p)
        local r = aa:MergeMetatables(p, q)
        local v = p.DoubleClick

        function p.SetDisabled(w, x: boolean)
            w.Disabled = x
        end

        aa:ConnectMouseEvent(q, {
            DoubleClick = v,
            Callback = function(...)
                if p.Disabled then
                    return
                end

                local w = p.Callback

                return w(r, ...)
            end,
        })

        return r, q
    end,
})

export type Selectable = {Text: string?, Selected: boolean?, Disabled: boolean?, Callback: ((...any) -> unknown)?, SetSelected: (Selectable, Selected:boolean?) -> Selectable, SetDisabled: (Selectable, Disabled:boolean?) -> Selectable}

aa:DefineElement('Selectable', {
    Base = {
        Text = 'Selectable',
        Callback = m,
        Selected = false,
        Disabled = false,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        TextXAlignment = Enum.TextXAlignment.Left,
        AnimationTags = {
            Selected = 'Buttons',
            Unselected = 'TransparentButtons',
        },
    },
    Create = function(o, p: Selectable): (table,TextButton)
        local q = o.Class.AfterClick
        local r = p.Selected
        local v = p.Disabled
        local w = aa:InsertPrefab('Button', p)
        local x = aa:MergeMetatables(p, w)

        w.Activated:Connect(function(...)
            local y = p.Callback

            y(w, ...)

            if q then
                q(w, ...)
            end
        end)

        function p.SetSelected(y, z: boolean?)
            local A = y.AnimationTags
            local B = z and A.Selected or A.Unselected

            y.Selected = z

            aa:SetAnimation(w, B)

            return y
        end
        function p.SetDisabled(y, z: boolean?)
            y.Disabled = z
            w.Interactable = not z

            return y
        end

        p:SetSelected(r)
        p:SetDisabled(v)

        return x, w
    end,
})

export type ImageButton = {Image: (string | number), Callback: ((...any) -> unknown)?}

aa:DefineElement('ImageButton', {
    Base = {
        ElementStyle = 'Button',
        Callback = m,
    },
    Create = n.Image,
})
aa:DefineElement('SmallButton', {
    Base = {
        Text = 'Button',
        PaddingTop = UDim.new(),
        PaddingBottom = UDim.new(),
        PaddingLeft = UDim.new(0, 2),
        PaddingRight = UDim.new(0, 2),
        ColorTag = 'Button',
        ElementStyle = 'Button',
        Callback = m,
    },
    Create = n.Button,
})

type KeyId = (Enum.UserInputType | Enum.KeyCode)?
export type Keybind = {Value: Enum.KeyCode?, DeleteKey: Enum.KeyCode?, Enabled: boolean?, IgnoreGameProcessed: boolean?, Callback: ((KeyId) -> any)?, OnKeybindSet: ((KeyId) -> any)?, OnBlacklistedKeybindSet: ((KeyId) -> any)?, KeyBlacklist: {[number]: KeyId}, Label: string?, Disabled: boolean?, _WaitingForNewKey: boolean?, SetValue: (Keybind, New:Enum.KeyCode) -> Keybind, SetDisabled: (Keybind, Disabled:boolean) -> Keybind, WaitForNewKey: (Keybind) -> any, Connection: RBXScriptConnection}

aa:DefineElement('Keybind', {
    Base = {
        Label = 'Keybind',
        ColorTag = 'Frame',
        Value = nil,
        DeleteKey = Enum.KeyCode.Backspace,
        IgnoreGameProcessed = true,
        Enabled = true,
        Disabled = false,
        Callback = m,
        OnKeybindSet = m,
        OnBlacklistedKeybindSet = m,
        KeyBlacklist = {},
        UiPadding = UDim.new(),
        AutomaticSize = Enum.AutomaticSize.None,
        Size = UDim2.new(0.3, 0, 0, 19),
    },
    Create = function(o, p: Keybind)
        local q = p.Value
        local r = p.Label
        local v = p.Disabled
        local w = p.KeyBlacklist
        local x = aa:InsertPrefab('Button', p)
        local y = aa:MergeMetatables(p, x)
        local z = o:Label{
            Parent = x,
            Text = r,
            Position = UDim2.new(1, 4, 0.5),
            AnchorPoint = Vector2.new(0, 0.5),
        }

        local function Callback(A, ...)
            return A(x, ...)
        end
        local function KeyIsBlacklisted(A: KeyId)
            return table.find(w, A)
        end

        function p.SetDisabled(A, B: boolean)
            A.Disabled = B
            x.Interactable = not B

            o:SetColorTags({
                [z] = B and 'LabelDisabled' or 'Label',
            }, true)

            return A
        end
        function p.SetValue(A, B: KeyId)
            local C = A.OnKeybindSet
            local E = A.DeleteKey

            if B == E then
                B = nil
            end

            A.Value = B
            x.Text = B and B.Name or 'Not set'

            Callback(C, B)

            return A
        end
        function p.WaitForNewKey(A)
            A._WaitingForNewKey = true
            x.Text = '...'
            x.Interactable = false
        end

        local function GetKeyId(A: InputObject)
            local B = A.KeyCode
            local C = A.UserInputType

            if C ~= Enum.UserInputType.Keyboard then
                return C
            end

            return B
        end
        local function CheckNewKey(A: InputObject)
            local B = p.OnBlacklistedKeybindSet
            local C = p.Value
            local E = GetKeyId(A)

            if not i.WindowFocused then
                return
            end
            if KeyIsBlacklisted(E) then
                Callback(B, E)

                return
            end

            x.Interactable = true
            p._WaitingForNewKey = false

            if E.Name == 'Unknown' then
                return p:SetValue(C)
            end

            p:SetValue(E)

            return
        end
        local function InputBegan(A: InputObject, B: boolean)
            local C = p.IgnoreGameProcessed
            local E = p.DeleteKey
            local F = p.Enabled
            local G = p.Value
            local H = p.Callback
            local I = GetKeyId(A)

            if p._WaitingForNewKey then
                CheckNewKey(A)

                return
            end
            if not F and x.Interactable then
                return
            end
            if not C and B then
                return
            end
            if not G then
                return
            end
            if I == E then
                return
            end
            if I.Name ~= G.Name then
                return
            end

            Callback(H, I)
        end

        p:SetValue(q)
        p:SetDisabled(v)

        p.Connection = i.InputBegan:Connect(InputBegan)

        x.Activated:Connect(function()
            p:WaitForNewKey()
        end)
        aa:SetAnimation(x, 'Inputs')

        return y, x
    end,
})
aa:DefineElement('ArrowButton', {
    Base = {
        Direction = 'Left',
        ColorTag = 'Button',
        Icon = aa.Icons.Arrow,
        Size = UDim2.fromOffset(21, 21),
        IconSize = UDim2.fromScale(1, 1),
        IconPadding = UDim.new(0, 4),
        Rotations = {
            Left = 180,
            Right = 0,
        },
    },
    Create = function(o, p): ScrollingFrame
        local q = p.Direction
        local r = p.Rotations
        local v = r[q]

        p.IconRotation = v

        local w = aa:InsertPrefab('ArrowButton', p)

        w.Activated:Connect(function(...)
            local x = p.Callback

            return x(w, ...)
        end)

        return w
    end,
})

export type Label = {Text: string, Bold: boolean?, Italic: boolean?, Font: string?, FontFace: Font?}

aa:DefineElement('Label', {
    Base = {
        Font = 'Inconsolata',
    },
    ColorData = {
        LabelPadding = {
            PaddingTop = 'LabelPaddingTop',
            PaddingBottom = 'LabelPaddingBottom',
        },
    },
    Create = function(o, p: Label): TextLabel
        local q = p.Bold
        local r = p.Italic
        local v = p.Font
        local w = p.FontFace
        local x = Enum.FontWeight.Medium
        local y = Enum.FontWeight.Bold
        local z = Enum.FontStyle.Normal
        local A = Enum.FontStyle.Italic
        local B = q and y or x
        local C = r and A or z
        local E = q or r

        if not w and E then
            p.FontFace = Font.fromName(v, B, C)
        end

        local F = aa:InsertPrefab('Label', p)
        local G = F:FindFirstChildOfClass'UIPadding'

        o:TagElements{
            [G] = 'LabelPadding',
        }

        return F
    end,
})
aa:DefineElement('Error', {
    Base = {
        RichText = true,
        TextWrapped = true,
    },
    ColorData = {
        Error = {
            TextColor3 = 'ErrorText',
            FontFace = 'TextFont',
        },
    },
    Create = function(o, p: Label)
        local q = p.Text

        p.Text = `<b>\226\155\148 Error:</b> {q}`

        return o:Label(p)
    end,
})

export type CodeEditor = {Editable: boolean?, FontSize: number?, FontFace: Font?, Text: string?, ApplyTheme: (CodeEditor) -> nil, GetVersion: (CodeEditor) -> string, ClearText: (CodeEditor) -> nil, SetText: (CodeEditor, Text:string) -> nil, GetText: (CodeEditor) -> string, SetEditing: (CodeEditor, Editing:boolean) -> nil, AppendText: (CodeEditor, Text:string) -> nil, ResetSelection: (CodeEditor, NoRefresh:boolean?) -> nil, GetSelectionText: (CodeEditor) -> string, Gui: Frame, Editing: boolean}

aa:DefineElement('CodeEditor', {
    Base = {
        Editable = true,
        Fill = true,
        Text = '',
    },
    Create = function(o, p: CodeEditor)
        local q = o.WindowClass
        local r = ab.CodeFrame.new(p)
        local v = r.Gui

        p.Parent = o:GetObject()

        aa:ApplyFlags{
            Object = v,
            WindowClass = q,
            Class = p,
        }

        return r, v
    end,
})

local o = {Engaged = false}

o.__index = o

function o.SetEngaged(p, q: boolean)
    local r = p.WindowClass

    p.Engaged = q

    if r then
        r:SetCanvasInteractable(not q)
    end
end
function o.IsHovering(p): boolean
    local q = false

    p:Foreach(function(r)
        q = r.Popup:IsMouseHovering()

        return q
    end)

    return q
end
function o.Foreach(p, q)
    local r = p.Menus

    for v, w in next, r do
        local x = q(w)

        if x then
            break
        end
    end
end
function o.SetFocusedMenu(p, q)
    p:Foreach(function(r)
        local v = r == q

        r:SetActiveState(v)
    end)
end
function o.Close(p)
    p:SetEngaged(false)
    p:SetFocusedMenu(nil)
end
function o.MenuItem(p, q)
    local r = p.Canvas
    local v = p.Menus
    local w = r:MenuButton(q)
    local x = r:PopupCanvas{
        RelativeTo = w,
        MaxSizeX = 210,
        Visible = false,
        AutoClose = false,
        AfterClick = function()
            p:Close()
        end,
    }
    local y = {
        Popup = x,
        Button = w,
    }

    aa:DetectHover(w, {
        MouseEnter = true,
        OnInput = function()
            if not p.Engaged then
                return
            end

            p:SetFocusedMenu(y)
        end,
    })

    function y.SetActiveState(z, A: boolean)
        x:SetPopupVisible(A)
        w:SetSelected(A)
    end

    w.Activated:Connect(function()
        p:SetFocusedMenu(y)
        p:SetEngaged(true)
    end)
    table.insert(v, y)

    return x, y
end

aa:DefineElement('MenuBar', {
    Base = {},
    Create = function(p, q): Elements
        local r = p.WindowClass
        local v = aa:InsertPrefab('MenuBar', q)
        local w = aa:MakeCanvas{
            Element = v,
            WindowClass = r,
            Class = q,
        }
        local x = ad:NewClass(o, {
            WindowClass = r,
            Canvas = w,
            Object = v,
            Menus = {},
        })

        Merge(x, q)
        aa:DetectHover(v, {
            MouseOnly = true,
            OnInput = function()
                if not x.Engaged then
                    return
                end
                if x:IsHovering() then
                    return
                end

                x:Close()
            end,
        })

        local y = aa:MergeMetatables(x, w)

        return y, v
    end,
})
aa:DefineElement('MenuButton', {
    Base = {
        Text = 'MenuButton',
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        Size = UDim2.fromOffset(0, 19),
        AutomaticSize = Enum.AutomaticSize.XY,
    },
    Create = n.Selectable,
})

local p = {
    ColorTags = {
        BGSelected = {
            [true] = 'SelectedTab',
            [false] = 'DeselectedTab',
        },
        LabelSelected = {
            [true] = 'SelectedTabLabel',
            [false] = 'DeselectedTabLabel',
        },
    },
}

function p.SetButtonSelected(q, r: table, v: boolean)
    if r.IsSelected == v then
        return
    end

    r.IsSelected = v

    local w = q.NoAnimation
    local x = q.WindowClass
    local y = q.ColorTags
    local z = x.Theme
    local A = x.TagsList
    local B = y.BGSelected
    local C = y.LabelSelected
    local E = r.TabButton
    local F = E.Button
    local G = F.Label

    aa:MultiUpdateColors{
        Animate = not w,
        Theme = z,
        TagsList = A,
        Objects = {
            [F] = B[v],
            [G] = C[v],
        },
    }
end
function p.CompareTabs(q, r, v)
    if not r then
        return false
    end

    return r.MatchBy == v or r == v
end
function p.ForEachTab(q, r: (Tab | string), v: (Tab, IsMatch:boolean, Index:number) -> nil)
    local w = typeof(r) == 'string'
    local x = q.Tabs

    for y, z in x do
        local A = z.Name
        local B = false

        if w then
            B = A == r
        else
            B = q:CompareTabs(z, r)
        end

        v(z, B, y)
    end
end
function p.RemoveTab(q, r: (Tab | string))
    local v = q.OnTabRemove
    local w = q.Tabs

    q:ForEachTab(r, function(x, y, z)
        if not y then
            return
        end

        local A = x.TabButton
        local B = x.OnClosure

        table.remove(w, z)
        A:Destroy()
        v(q, x)
        B(x)
    end)

    return q
end

export type Tab = {Name: string, Focused: boolean?, TabButton: boolean?, Closeable: boolean?, OnClosure: (Tab) -> nil, Icon: (string | number)?}

function p.CreateTab(q, r: Tab): Elements
    r = r or {}

    aa:CheckConfig(r, {
        Name = 'Tab',
        AutoSize = 'Y',
        Focused = false,
        OnClosure = m,
    })

    local v = q.AutoSelectNewTabs
    local w = q.WindowClass
    local x = q.ParentCanvas
    local y = q.Tabs
    local z = q.TabsFrame
    local A = q.OnTabCreate
    local B = r.Focused
    local C = r.Name
    local E = r.Icon
    local F = B or #y <= 0 and v
    local G = aa:InsertPrefab('TabButton', r)

    G.Parent = z

    local H = G.Button
    local I = H:FindFirstChildOfClass'UIPadding'
    local J = H.Label

    J.Text = tostring(C)

    Merge(r, {TabButton = G})

    local function SetActive()
        q:SetActiveTab(r)
    end

    local K = {
        Closeable = function()
            local K = x:RadioButton{
                Parent = H,
                Visible = not q.NoClose,
                Icon = aa.Icons.Close,
                IconSize = UDim2.fromOffset(11, 11),
                LayoutOrder = 3,
                ZIndex = 2,
                UsePropertiesList = true,
                Callback = function()
                    q:RemoveTab(r)
                end,
            }
            local L = K.Icon

            aa:SetAnimation(L, {
                Connections = {
                    MouseEnter = {ImageTransparency = 0},
                    MouseLeave = {ImageTransparency = 1},
                },
                Init = 'MouseLeave',
            }, G)
        end,
    }

    H.Activated:Connect(SetActive)
    aa:CheckFlags(K, r)
    table.insert(y, r)

    if w then
        w:TagElements{
            [I] = 'TabPadding',
        }
    end

    aa:SetAnimation(H, 'Buttons')
    q:SetButtonSelected(r, F)
    x:ApplyFlags(G, r)

    local L = A(q, r)

    if F then
        q:SetActiveTab(r)
    end

    return L or r
end
function p.SetActiveTab(q, r: (table | string))
    local v = q.Tabs
    local w = q.NoAnimation
    local x = q.ActiveTab
    local y = q.OnActiveTabChange
    local z = typeof(r) == 'string'
    local A

    q:ForEachTab(r, function(B, C, E)
        if C then
            A = B
        end

        q:SetButtonSelected(B, C)
    end)

    if not A then
        return q
    end
    if q:CompareTabs(A, x) then
        return q
    end

    q.ActiveTab = A

    y(q, A, x)

    return q
end

export type TabBar = {AutoSelectNewTabs: boolean, OnActiveTabChange: ((TabBar, Tab:Tab, Previous:Tab) -> nil)?, OnTabCreate: ((TabBar, Tab:Tab) -> nil)?, OnTabRemove: ((TabBar, Tab:Tab) -> nil)?}

aa:DefineElement('TabBar', {
    Base = {
        AutoSelectNewTabs = true,
        OnActiveTabChange = m,
        OnTabCreate = m,
        OnTabRemove = m,
    },
    ColorData = {
        DeselectedTab = {
            BackgroundColor3 = 'TabBg',
        },
        SelectedTab = {
            BackgroundColor3 = 'TabBgActive',
        },
        DeselectedTabLabel = {
            FontFace = 'TextFont',
            TextColor3 = 'TabText',
        },
        SelectedTabLabel = {
            FontFace = 'TextFont',
            TextColor3 = 'TabTextActive',
        },
        TabsBarSeparator = {
            BackgroundColor3 = 'TabBgActive',
        },
        TabPadding = {
            PaddingTop = 'TabTextPaddingTop',
            PaddingBottom = 'TabTextPaddingBottom',
        },
        TabPagePadding = {
            PaddingBottom = 'TabPagePadding',
            PaddingLeft = 'TabPagePadding',
            PaddingRight = 'TabPagePadding',
            PaddingTop = 'TabPagePadding',
        },
    },
    Create = function(q, r: TabBar)
        local x = q.WindowClass
        local y = aa:InsertPrefab('TabsBar', r)
        local z = ad:NewClass(p)
        local A = y.Separator
        local B = y.TabsFrame
        local C = aa:MakeCanvas{
            Element = B,
            WindowClass = x,
            Class = z,
        }

        Merge(z, r)
        Merge(z, {
            ParentCanvas = q,
            Object = y,
            TabsFrame = B,
            WindowClass = x,
            Tabs = {},
        })
        q:TagElements{
            [y] = 'TabsBar',
            [A] = 'TabsBarSeparator',
        }

        local E = aa:MergeMetatables(C, y)

        return E, y
    end,
})

export type TabSelector = {NoTabsBar: boolean?, NoAnimation: boolean?}&TabBar

aa:DefineElement('TabSelector', {
    Base = {
        NoTabsBar = false,
        OnActiveTabChange = m,
        OnTabCreate = m,
        OnTabRemove = m,
    },
    Create = function(q, r: TabSelector): (TabSelector,GuiObject)
        local x = q.WindowClass
        local y = r.NoTabsBar
        local z = r.NoAnimation
        local A = aa:InsertPrefab('TabSelector', r)
        local B = A.Body
        local C = B.PageTemplate

        C.Visible = false

        local function OnTabCreate(E, F, ...)
            local G = F.AutoSize
            local H = F.Name
            local I = C:Clone()
            local J = ad:GetChildOfClass(I, 'UIPadding')

            aa:SetProperties(I, {
                Parent = B,
                Name = H,
                AutomaticSize = Enum.AutomaticSize[G],
                Size = UDim2.fromScale(G == 'Y' and 1 or 0, G == 'X' and 1 or 0),
            })
            q:TagElements{
                [J] = 'TabPagePadding',
            }

            local K = aa:MakeCanvas{
                Element = I,
                WindowClass = x,
                Class = F,
            }

            r.OnTabCreate(E, F, ...)
            Merge(F, {
                Page = I,
                MatchBy = K,
            })

            return K
        end
        local function OnActiveTabChange(E, F, ...)
            E:ForEachTab(F, function(G, H, I)
                local J = G.Page

                J.Visible = H

                if not H then
                    return
                end

                local K = q:GetThemeKey'AnimationTweenInfo'

                b:Tween{
                    Object = J,
                    Tweeninfo = K,
                    NoAnimation = z,
                    StartProperties = {
                        Position = UDim2.fromOffset(0, 4),
                    },
                    EndProperties = {
                        Position = UDim2.fromOffset(0, 0),
                    },
                }
            end)
            r.OnActiveTabChange(E, F, ...)
        end

        local E = q:TabBar{
            Parent = A,
            Visible = not y,
            OnTabCreate = OnTabCreate,
            OnActiveTabChange = OnActiveTabChange,
            OnTabRemove = function(E, F, ...)
                F.Page:Remove()
                r.OnTabRemove(...)
            end,
        }
        local F = aa:MergeMetatables(E, A)

        return F, A
    end,
})

export type RadioButton = {Icon: string?, IconRotation: number?, Callback: ((...any) -> unknown)?}

aa:DefineElement('RadioButton', {
    Base = {Callback = m},
    Create = function(q, r: RadioButton): GuiButton
        local x = aa:InsertPrefab('RadioButton', r)

        x.Activated:Connect(function(...)
            local y = r.Callback

            return y(x, ...)
        end)

        return x
    end,
})

export type Checkbox = {Label: string?, IsRadio: boolean?, Value: boolean, Disabled: boolean?, NoAnimation: boolean?, Callback: ((...any) -> unknown)?, SetValue: (self:Checkbox, Value:boolean, NoAnimation:boolean) -> ...any, Toggle: (self:Checkbox) -> ...any, TickedImageSize: UDim2, UntickedImageSize: UDim2, SetTicked: (Checkbox, Value:boolean) -> any, SetDisabled: (Checkbox, Disabled:boolean) -> Checkbox}

aa:DefineElement('Checkbox', {
    Base = {
        Label = 'Checkbox',
        IsRadio = false,
        Value = false,
        NoAutoTag = true,
        TickedImageSize = UDim2.fromScale(1, 1),
        UntickedImageSize = UDim2.fromScale(0, 0),
        Callback = m,
        Disabled = false,
    },
    Create = function(q, r: Checkbox): Checkbox
        local x = r.IsRadio
        local y = r.Value
        local z = r.Label
        local A = r.TickedImageSize
        local B = r.UntickedImageSize
        local C = r.Disabled
        local E = aa:InsertPrefab('CheckBox', r)
        local F = aa:MergeMetatables(r, E)
        local G = E.Tickbox
        local H = G.Tick

        H.Image = aa.Icons.Checkmark

        local I = G:FindFirstChildOfClass'UIPadding'
        local J = ad:GetChildOfClass(G, 'UICorner')
        local K = q:Label{
            Text = z,
            Parent = E,
            LayoutOrder = 2,
        }
        local L = UDim.new(0, 3)

        if x then
            H.ImageTransparency = 1
            H.BackgroundTransparency = 0
            J.CornerRadius = UDim.new(1, 0)
        else
            L = UDim.new(0, 2)
        end

        aa:SetProperties(I, {
            PaddingBottom = L,
            PaddingLeft = L,
            PaddingRight = L,
            PaddingTop = L,
        })

        local function Callback(...)
            local M = r.Callback

            return M(F, ...)
        end
        local function SetStyle(M: boolean, N: boolean)
            local O = q:GetThemeKey'AnimationTweenInfo'
            local P = M and A or B

            b:Tween{
                Object = H,
                Tweeninfo = O,
                NoAnimation = N,
                EndProperties = {Size = P},
            }
        end

        function r.SetDisabled(M, N: boolean)
            M.Disabled = N
            E.Interactable = not N

            q:SetColorTags({
                [K] = N and 'LabelDisabled' or 'Label',
            }, true)

            return M
        end
        function r.SetValue(M, N: boolean, O: boolean)
            M.Value = N

            SetStyle(N, O)
            Callback(N)

            return M
        end
        function r.SetTicked(M, ...)
            aa:Warn'Checkbox:SetTicked is deprecated, please use :SetValue'

            return M:SetValue(...)
        end
        function r.Toggle(M)
            local N = not M.Value

            M.Value = N

            M:SetValue(N)

            return M
        end

        local function Clicked()
            r:Toggle()
        end

        E.Activated:Connect(Clicked)
        G.Activated:Connect(Clicked)
        r:SetValue(y, true)
        r:SetDisabled(C)
        aa:SetAnimation(G, 'Buttons', E)
        q:TagElements{
            [H] = 'CheckMark',
            [G] = 'Checkbox',
        }

        return F, E
    end,
})
aa:DefineElement('Radiobox', {
    Base = {
        IsRadio = true,
        CornerRadius = UDim.new(1, 0),
    },
    Create = n.Checkbox,
})

export type PlotHistogram = {Label: string?, Points: {[number]: number}, Minimum: number?, Maximum: number?, GetBaseValues: (PlotHistogram) -> (number,number), UpdateGraph: (PlotHistogram) -> PlotHistogram, PlotGraph: (PlotHistogram, Points:{[number]: number}) -> PlotHistogram, Plot: (PlotHistogram, Value:number) -> {SetValue: (PlotHistogram, Value:number) -> nil, GetPointIndex: (PlotHistogram) -> number, Remove: (PlotHistogram, Value:number) -> nil}}

aa:DefineElement('PlotHistogram', {
    Base = {
        ColorTag = 'Frame',
        Label = 'Histogram',
    },
    Create = function(q, r: PlotHistogram)
        local x = r.Label
        local y = r.Points
        local z = aa:InsertPrefab('Histogram', r)
        local A = aa:MergeMetatables(r, z)
        local B = z.Canvas
        local C = B.PointTemplate

        C.Visible = false

        q:Label{
            Text = x,
            Parent = z,
            Position = UDim2.new(1, 4),
        }

        local E

        aa:SetItemTooltip(z, function(F)
            E = F:Label()
        end)
        Merge(r, {
            _Plots = {},
            _Cache = {},
        })

        function r.GetBaseValues(F): (number,number)
            local G = F.Minimum
            local H = F.Maximum

            if G and H then
                return G, H
            end

            local I = F._Plots

            for J, K in I do
                local L = K.Value

                if not G or L < G then
                    G = L
                end
                if not H or L > H then
                    H = L
                end
            end

            return G, H
        end
        function r.UpdateGraph(F)
            local G = F._Plots
            local H, I = F:GetBaseValues()

            if not H or not I then
                return
            end

            local J = I - H

            for K, L in G do
                local M = L.Point
                local N = L.Value
                local O = (N - H) / J

                O = math.clamp(O, 0.05, 1)
                M.Size = UDim2.fromScale(1, O)
            end

            return F
        end
        function r.Plot(F, G)
            local H = F._Plots
            local I = {}
            local J = C:Clone()
            local K = J.Bar

            aa:SetProperties(J, {
                Parent = B,
                Visible = true,
            })

            local L = aa:DetectHover(J, {
                MouseEnter = true,
                OnInput = function()
                    I:UpdateTooltip()
                end,
            })
            local M = {
                Object = J,
                Point = K,
                Value = G,
            }

            function I.UpdateTooltip(N)
                local O = I:GetPointIndex()

                E.Text = `{O}:\t{M.Value}`
            end
            function I.SetValue(N, O)
                M.Value = O

                r:UpdateGraph()

                if L.Hovering then
                    N:UpdateTooltip()
                end
            end
            function I.GetPointIndex(N): number
                return table.find(H, M)
            end
            function I.Remove(N, O)
                table.remove(H, N:GetPointIndex())
                J:Remove()
                r:UpdateGraph()
            end

            table.insert(H, M)
            F:UpdateGraph()
            aa:SetAnimation(K, 'Plots', J)
            q:TagElements{
                [K] = 'Plot',
            }

            return I
        end
        function r.PlotGraph(F, G)
            local H = F._Cache
            local I = #H - #G

            if I >= 1 then
                for J = 1, I do
                    local K = table.remove(H, J)

                    if K then
                        K:Remove()
                    end
                end
            end

            for J, K in G do
                local L = H[J]

                if L then
                    L:SetValue(K)

                    continue
                end

                H[J] = F:Plot(K)
            end

            return F
        end

        if y then
            r:PlotGraph(y)
        end

        return A, z
    end,
})

export type Viewport = {Model: Instance, WorldModel: WorldModel?, Viewport: ViewportFrame?, Camera: Camera?, Clone: boolean?, SetCamera: (self:Viewport, Camera:Camera) -> Viewport, SetModel: (self:Viewport, Model:Model, PivotTo:CFrame?) -> Model}

aa:DefineElement('Viewport', {
    Base = {IsRadio = true},
    Create = function(q, r: Viewport): Viewport
        local x = r.Model
        local y = r.Camera
        local z = aa:InsertPrefab('Viewport', r)
        local A = aa:MergeMetatables(r, z)
        local B = z.Viewport
        local C = B.WorldModel

        if not y then
            y = aa:CreateInstance('Camera', B)
            y.CFrame = CFrame.new(0, 0, 0)
        end

        Merge(r, {
            Camera = y,
            WorldModel = C,
            Viewport = B,
        })

        function r.SetCamera(E, F)
            E.Camera = F
            B.CurrentCamera = F

            return E
        end
        function r.SetModel(E, F: Model, G: CFrame?)
            local H = E.Clone

            C:ClearAllChildren()

            if H then
                F = F:Clone()
            end
            if G then
                F:PivotTo(G)
            end

            F.Parent = C
            E.Model = F

            return F
        end

        if x then
            r:SetModel(x)
        end

        r:SetCamera(y)

        return A, z
    end,
})

export type InputText = {Value: string, Placeholder: string?, MultiLine: boolean?, Label: string?, Disabled: boolean?, Callback: ((string, ...any) -> unknown)?, Clear: (InputText) -> InputText, SetValue: (InputText, Value:string) -> InputText, SetDisabled: (InputText, Disabled:boolean) -> InputText}

aa:DefineElement('InputText', {
    Base = {
        Value = '',
        Placeholder = '',
        Label = 'Input text',
        Callback = m,
        MultiLine = false,
        NoAutoTag = true,
        Disabled = false,
    },
    Create = function(q, r: InputText): InputText
        local x = r.MultiLine
        local y = r.Placeholder
        local z = r.Label
        local A = r.Disabled
        local B = r.Value
        local C = aa:InsertPrefab('InputBox', r)
        local E = C.Frame
        local F = E.Input
        local G = aa:MergeMetatables(r, C)

        q:Label{
            Parent = C,
            Text = z,
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2.fromOffset(0, 19),
            Position = UDim2.new(1, 4),
            LayoutOrder = 2,
        }
        aa:SetProperties(F, {
            PlaceholderText = y,
            MultiLine = x,
        })

        local function Callback(...)
            local H = r.Callback

            H(G, ...)
        end

        function r.SetValue(H, I: string?)
            F.Text = tostring(I)
            H.Value = I

            return H
        end
        function r.SetDisabled(H, I: boolean)
            H.Disabled = I
            C.Interactable = not I

            q:SetColorTags({
                [z] = I and 'LabelDisabled' or 'Label',
            }, true)

            return H
        end
        function r.Clear(H)
            F.Text = ''

            return H
        end

        local function TextChanged()
            local H = F.Text

            r.Value = H

            Callback(H)
        end

        F:GetPropertyChangedSignal'Text':Connect(TextChanged)
        r:SetDisabled(A)
        r:SetValue(B)
        q:TagElements{
            [F] = 'Frame',
        }

        return G, C
    end,
})

export type InputInt = {Value: number, Maximum: number?, Minimum: number?, Placeholder: string?, MultiLine: boolean?, NoButtons: boolean?, Disabled: boolean?, Label: string?, Increment: number?, Callback: ((string, ...any) -> unknown)?, SetValue: (InputInt, Value:number, NoTextUpdate:boolean?) -> InputInt, Decrease: (InputInt) -> nil, Increase: (InputInt) -> nil, SetDisabled: (InputInt, Disabled:boolean) -> InputInt}

aa:DefineElement('InputInt', {
    Base = {
        Value = 0,
        Increment = 1,
        Placeholder = '',
        Label = 'Input Int',
        Callback = m,
    },
    Create = function(q, r: InputInt): InputInt
        local x = r.Value
        local y = r.Placeholder
        local z = r.Label
        local A = r.Disabled
        local B = r.NoButtons
        local C = aa:InsertPrefab('InputBox', r)
        local E = aa:MergeMetatables(r, C)
        local F = C.Frame
        local G = F.Input

        G.PlaceholderText = y

        local H = q:Button{
            Text = '-',
            Parent = F,
            LayoutOrder = 2,
            Ratio = 1,
            AutomaticSize = Enum.AutomaticSize.None,
            FlexMode = Enum.UIFlexMode.None,
            Size = UDim2.fromScale(1, 1),
            Visible = not B,
            Callback = function()
                r:Decrease()
            end,
        }
        local I = q:Button{
            Text = '+',
            Parent = F,
            LayoutOrder = 3,
            Ratio = 1,
            AutomaticSize = Enum.AutomaticSize.None,
            FlexMode = Enum.UIFlexMode.None,
            Size = UDim2.fromScale(1, 1),
            Visible = not B,
            Callback = function()
                r:Increase()
            end,
        }
        local J = q:Label{
            Parent = C,
            Text = z,
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2.fromOffset(0, 19),
            Position = UDim2.new(1, 4),
            LayoutOrder = 4,
        }

        local function Callback(...)
            local K = r.Callback

            K(E, ...)
        end

        function r.Increase(K)
            local L = K.Value
            local M = K.Increment

            r:SetValue(L + M)
        end
        function r.Decrease(K)
            local L = K.Value
            local M = K.Increment

            r:SetValue(L - M)
        end
        function r.SetDisabled(K, L: boolean)
            K.Disabled = L
            C.Interactable = not L

            q:SetColorTags({
                [J] = L and 'LabelDisabled' or 'Label',
            }, true)

            return K
        end
        function r.SetValue(K, L: number | string)
            local M = K.Value
            local N = K.Minimum
            local O = K.Maximum

            L = tonumber(L)

            if not L then
                L = M
            end
            if N and O then
                L = math.clamp(L, N, O)
            end

            G.Text = L
            r.Value = L

            Callback(L)

            return K
        end

        local function TextChanged()
            local K = G.Text

            r:SetValue(K)
        end

        r:SetValue(x)
        r:SetDisabled(A)
        G.FocusLost:Connect(TextChanged)
        q:TagElements{
            [I] = 'Button',
            [H] = 'Button',
            [G] = 'Frame',
        }

        return E, C
    end,
})
aa:DefineElement('InputTextMultiline', {
    Base = {
        Label = '',
        Size = UDim2.new(1, 0, 0, 39),
        Border = false,
        ColorTag = 'Frame',
    },
    Create = function(q, r)
        return q:Console(r)
    end,
})

export type Console = {Enabled: boolean?, ReadOnly: boolean?, Value: string?, RichText: boolean?, TextWrapped: boolean?, LineNumbers: boolean?, AutoScroll: boolean, LinesFormat: string, MaxLines: number, Callback: (Console, Value:string) -> nil, Placeholder: string?, Update: (Console) -> nil, CountLines: (Console) -> number, UpdateLineNumbers: (Console) -> Console, UpdateScroll: (Console) -> Console, SetValue: (Console, Value:string) -> Console, GetValue: (Console) -> string, Clear: (Console) -> Console, AppendText: (Console, ...string) -> Console, CheckLineCount: (Console) -> Console}

aa:DefineElement('Console', {
    Base = {
        Enabled = true,
        Value = '',
        TextWrapped = false,
        Border = true,
        MaxLines = 300,
        LinesFormat = '%s',
        Callback = m,
    },
    Create = function(q, r: Console): Console
        local x = r.ReadOnly
        local y = r.LineNumbers
        local z = r.Value
        local A = r.Placeholder
        local B = aa:InsertPrefab('Console', r)
        local C = aa:MergeMetatables(r, B)
        local E: TextBox = B.Source
        local F = B.Lines

        F.Visible = y

        function r.CountLines(G, H: boolean?): number
            local I = E.Text:split'\n'
            local J = #I

            if J == 1 and I[1] == '' then
                return 0
            end

            return J
        end
        function r.UpdateLineNumbers(G)
            local H = G.LineNumbers
            local I = G.LinesFormat

            if not H then
                return
            end

            local J = G:CountLines()

            F.Text = ''

            for K = 1, J do
                local L = I:format(K)
                local M = K ~= J and '\n' or ''

                F.Text ..= `{L}{M}`
            end

            local K = F.AbsoluteSize.X

            E.Size = UDim2.new(1, -K, 0, 0)

            return G
        end
        function r.CheckLineCount(G)
            local H = r.MaxLines

            if not H then
                return
            end

            local I = E.Text
            local J = I:split'\n'

            if #J > H then
                local K = `{J[1]}\\n`
                local L = I:sub(#K)

                G:SetValue(L)
            end

            return G
        end
        function r.UpdateScroll(G)
            local H = B.AbsoluteCanvasSize

            B.CanvasPosition = Vector2.new(0, H.Y)

            return G
        end
        function r.SetValue(G, H: string?)
            if not G.Enabled then
                return
            end

            E.Text = tostring(H)

            G:Update()

            return G
        end
        function r.GetValue(G)
            return E.Text
        end
        function r.Clear(G)
            E.Text = ''

            G:Update()

            return G
        end
        function r.AppendText(G, ...)
            local H = G:CountLines(true)
            local I = aa:Concat({...}, ' ')

            if H == 0 then
                return G:SetValue(I)
            end

            local J = G:GetValue()
            local K = `{J}\n{I}`

            G:SetValue(K)

            return G
        end
        function r.Update(G)
            local H = G.AutoScroll

            G:CheckLineCount()
            G:UpdateLineNumbers()

            if H then
                G:UpdateScroll()
            end
        end

        local function Changed()
            local G = r:GetValue()

            r:Update()
            r:Callback(G)
        end

        r:SetValue(z)
        aa:SetProperties(E, r)
        aa:SetProperties(E, {
            TextEditable = not x,
            Parent = B,
            PlaceholderText = A,
        })
        q:TagElements{
            [E] = 'ConsoleText',
            [F] = 'ConsoleLineNumbers',
        }
        E:GetPropertyChangedSignal'Text':Connect(Changed)

        return C, B
    end,
})

export type Table = {Align: string?, Border: boolean?, RowBackground: boolean?, RowBgTransparency: number?, MaxColumns: number?, NextRow: (Table) -> Row, HeaderRow: (Table) -> Row, Row: (Table) -> {Column: (Row) -> Elements}, ClearRows: (Table) -> unknown}

aa:DefineElement('Table', {
    Base = {
        VerticalAlignment = Enum.VerticalAlignment.Top,
        RowBackground = false,
        RowBgTransparency = 0.87,
        Border = false,
        Spacing = UDim.new(0, 4),
    },
    Create = function(q, r: Table): Table
        local x = q.WindowClass
        local y = r.RowBgTransparency
        local z = r.RowBackground
        local A = r.Border
        local B = r.VerticalAlignment
        local C = r.MaxColumns
        local E = r.Spacing
        local F = aa:InsertPrefab('Table', r)
        local G = aa:MergeMetatables(r, F)
        local H = F.RowTemp
        local I = 0
        local J = {}
        local K = A and z

        function r.Row(L, M)
            M = M or {}

            local N = M.IsHeader
            local O = 0
            local P = {}
            local Q = H:Clone()

            aa:SetProperties(Q, {
                Name = 'Row',
                Visible = true,
                Parent = F,
            })

            local R = Q:FindFirstChildOfClass'UIListLayout'

            aa:SetProperties(R, {
                VerticalAlignment = B,
                Padding = not K and E or UDim.new(0, 1),
            })

            if N then
                q:TagElements{
                    [Q] = 'Header',
                }
            else
                I += 1
            end
            if z and not N then
                local S = I % 2 ~= 1 and y or 1

                Q.BackgroundTransparency = S
            end

            local S = {}
            local T = aa:MergeMetatables(S, Q)

            function S.Column(U, V)
                V = V or {}

                aa:CheckConfig(V, {
                    HorizontalAlign = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                })

                local W = Q.ColumnTemp:Clone()
                local X = W:FindFirstChildOfClass'UIListLayout'

                aa:SetProperties(X, V)

                local Y = W:FindFirstChildOfClass'UIStroke'

                Y.Enabled = A

                local Z = W:FindFirstChildOfClass'UIPadding'

                if not K then
                    Z:Destroy()
                end

                aa:SetProperties(W, {
                    Parent = Q,
                    Visible = true,
                    Name = 'Column',
                })

                return aa:MakeCanvas{
                    Element = W,
                    WindowClass = x,
                    Class = T,
                }
            end
            function S.NextColumn(U)
                O += 1

                local V = O % C + 1
                local W = P[V]

                if not W then
                    W = U:Column()
                    P[V] = W
                end

                return W
            end

            table.insert(J, S)

            return T
        end
        function r.NextRow(L)
            return L:Row()
        end
        function r.HeaderRow(L)
            return L:Row{IsHeader = true}
        end
        function r.ClearRows(L)
            I = 0

            for M, N: Frame in next, F:GetChildren()do
                if not N:IsA'Frame' then
                    continue
                end
                if N == H then
                    continue
                end

                N:Destroy()
            end

            return r
        end

        return G, F
    end,
})

export type List = {Spacing: number?}

aa:DefineElement('List', {
    Base = {
        Spacing = 4,
        HorizontalFlex = Enum.UIFlexAlignment.None,
        VerticalFlex = Enum.UIFlexAlignment.None,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        FillDirection = Enum.FillDirection.Horizontal,
    },
    Create = function(q, r)
        local x = q.WindowClass
        local y = r.Spacing
        local z = r.HorizontalFlex
        local A = r.VerticalFlex
        local B = r.HorizontalAlignment
        local C = r.VerticalAlignment
        local E = r.FillDirection
        local F = aa:InsertPrefab('List', r)
        local G = aa:MergeMetatables(r, F)
        local H: UIListLayout = F.UIListLayout

        aa:SetProperties(H, {
            Padding = UDim.new(0, y),
            HorizontalFlex = z,
            VerticalFlex = A,
            HorizontalAlignment = B,
            VerticalAlignment = C,
            FillDirection = E,
        })

        local I = aa:MakeCanvas{
            Element = F,
            WindowClass = x,
            Class = G,
        }

        return I, F
    end,
})

export type CollapsingHeader = {Title: string, CollapseIcon: string?, Icon: string?, NoAnimation: boolean?, Collapsed: boolean?, Offset: number?, NoArrow: boolean?, OpenOnDoubleClick: boolean?, OpenOnArrow: boolean?, Activated: (CollapsingHeader) -> nil, TitleBarProperties: table?, IconPadding: UDim?, Remove: (CollapsingHeader) -> nil, SetArrowVisible: (CollapsingHeader, Visible:boolean) -> nil, SetTitle: (CollapsingHeader, Title:string) -> nil, SetIcon: (CollapsingHeader, Icon:string) -> nil, SetVisible: (CollapsingHeader, Visible:boolean) -> nil, SetCollapsed: (CollapsingHeader, Open:boolean) -> CollapsingHeader}

aa:DefineElement('CollapsingHeader', {
    Base = {
        Title = 'Collapsing Header',
        CollapseIcon = aa.Icons.Arrow,
        Collapsed = true,
        Offset = 0,
        NoAutoTag = true,
        NoAutoFlags = true,
        IconPadding = UDim.new(0, 4),
        Activated = m,
    },
    Create = function(q, r: CollapsingHeader): CollapsingHeader
        local x = r.Title
        local y = r.Collapsed
        local z = r.ElementStyle
        local A = r.Offset
        local B = r.TitleBarProperties
        local C = r.OpenOnDoubleClick
        local E = r.OpenOnArrow
        local F = r.CollapseIcon
        local G = r.IconPadding
        local H = r.Icon
        local I = r.NoArrow
        local J = aa:InsertPrefab('CollapsingHeader', r)
        local K = J.TitleBar
        local L = K.Collapse
        local M = K.Icon

        q:ApplyFlags(M, {Image = H})

        local N = L.CollapseIcon
        local O = L.UIPadding

        ad:SetPadding(O, G)
        q:ApplyFlags(N, {Image = F})

        local P = q:Label{
            ColorTag = 'CollapsingHeader',
            Parent = K,
            LayoutOrder = 2,
        }
        local Q, R = q:Indent{
            Class = r,
            Parent = J,
            Offset = A,
            LayoutOrder = 2,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.None,
            PaddingTop = UDim.new(0, 4),
            PaddingBottom = UDim.new(0, 1),
        }

        local function Activated()
            local S = r.Activated

            S(Q)
        end

        function r.Remove(S)
            J:Destroy()
            table.clear(S)
        end
        function r.SetArrowVisible(S, T: boolean)
            N.Visible = T
        end
        function r.SetTitle(S, T: string)
            P.Text = T
        end
        function r.SetVisible(S, T: boolean)
            J.Visible = T
        end
        function r.SetIcon(S, T: string | number)
            local U = T and T ~= ''

            M.Visible = U

            if U then
                M.Image = ad:CheckAssetUrl(T)
            end
        end
        function r.SetCollapsed(S, T)
            S.Collapsed = T

            local U = aa:GetContentSize(R)
            local V = Q:GetThemeKey'AnimationTweenInfo'
            local W = UDim2.fromScale(1, 0)
            local X = W + UDim2.fromOffset(0, U.Y)

            b:HeaderCollapse{
                Tweeninfo = V,
                Collapsed = T,
                Toggle = N,
                Resize = R,
                Hide = R,
                ClosedSize = W,
                OpenSize = X,
            }

            return S
        end

        local function Toggle()
            r:SetCollapsed(not r.Collapsed)
        end

        if B then
            Q:ApplyFlags(K, B)
        end
        if not E then
            aa:ConnectMouseEvent(K, {
                DoubleClick = C,
                Callback = Toggle,
            })
        end

        N.Activated:Connect(Toggle)
        K.Activated:Connect(Activated)
        r:SetCollapsed(y)
        r:SetTitle(x)
        r:SetArrowVisible(not I)
        aa:ApplyStyle(K, z)
        Q:TagElements{
            [K] = 'CollapsingHeader',
        }

        return Q, J
    end,
})
aa:DefineElement('TreeNode', {
    Base = {
        Offset = 21,
        IconPadding = UDim.new(0, 2),
        TitleBarProperties = {
            Size = UDim2.new(1, 0, 0, 13),
        },
    },
    Create = n.CollapsingHeader,
})

export type Separator = {Text: string?}

aa:DefineElement('Separator', {
    Base = {
        NoAutoTag = true,
        NoAutoTheme = true,
    },
    Create = function(q, r)
        local x = r.Text
        local y = aa:InsertPrefab('SeparatorText', r)

        q:Label{
            Text = tostring(x),
            Visible = x ~= nil,
            Parent = y,
            LayoutOrder = 2,
            Size = UDim2.new(),
            PaddingLeft = UDim.new(0, 4),
            PaddingRight = UDim.new(0, 4),
        }
        q:TagElements{
            [y.Left] = 'Separator',
            [y.Right] = 'Separator',
        }

        return y
    end,
})

export type Canvas = {Scroll: boolean?, Class: table?}

aa:DefineElement('Canvas', {
    Base = {},
    Create = function(q, r: Canvas)
        local x = q.WindowClass
        local y = r.Scroll
        local z = r.Class or r
        local A = y and 'ScrollingCanvas' or 'Canvas'
        local B = aa:InsertPrefab(A, r)
        local C = aa:MakeCanvas{
            Element = B,
            WindowClass = x,
            Class = z,
        }

        return C, B
    end,
})
aa:DefineElement('ScrollingCanvas', {
    Base = {Scroll = true},
    Create = n.Canvas,
})

export type Region = {Scroll: boolean?}

aa:DefineElement('Region', {
    Base = {
        Scroll = false,
        AutomaticSize = Enum.AutomaticSize.Y,
    },
    Create = function(q, r: Region)
        local x = q.WindowClass
        local y = r.Scroll
        local z = y and 'ScrollingCanvas' or 'Canvas'
        local A = aa:InsertPrefab(z, r)
        local B = aa:MakeCanvas{
            Element = A,
            WindowClass = x,
            Class = r,
        }

        return B, A
    end,
})
aa:DefineElement('Group', {
    Base = {
        Scroll = false,
        AutomaticSize = Enum.AutomaticSize.Y,
    },
    Create = function(q, r)
        local x = q.WindowClass
        local y = aa:InsertPrefab('Group', r)
        local z = aa:MakeCanvas{
            Element = y,
            WindowClass = x,
            Class = r,
        }

        return z, y
    end,
})

export type Indent = {Offset: number?, PaddingTop: UDim?, PaddingBottom: UDim?, PaddingRight: UDim?, PaddingLeft: UDim?}

aa:DefineElement('Indent', {
    Base = {
        Offset = 15,
        PaddingTop = UDim.new(),
        PaddingBottom = UDim.new(),
        PaddingRight = UDim.new(),
    },
    Create = function(q, r: Indent)
        local x = r.Offset

        r.PaddingLeft = UDim.new(0, x)

        return q:Canvas(r)
    end,
})

export type BulletText = {Padding: number, Icon: (string | number)?, Rows: {[number]: string?}}

aa:DefineElement('BulletText', {
    Base = {},
    Create = function(q, r: BulletText)
        local x = r.Rows

        for y, z in next, x do
            local A = q:Bullet(r)

            A:Label{
                Text = tostring(z),
                LayoutOrder = 2,
                Size = UDim2.fromOffset(0, 14),
            }
        end
    end,
})

export type Bullet = {Padding: number?}

aa:DefineElement('Bullet', {
    Base = {
        Padding = 3,
        Icon = aa.Icons.Dot,
        IconSize = UDim2.fromOffset(5, 5),
    },
    Create = function(q, r: Bullet)
        local x = q.WindowClass
        local y = r.Padding
        local z = aa:InsertPrefab('Bullet', r)
        local A = aa:MakeCanvas{
            Element = z,
            WindowClass = x,
            Class = q,
        }
        local B = z.UIListLayout

        B.Padding = UDim.new(0, y)

        return A, z
    end,
})

export type Row = {Spacing: number?, Expanded: boolean?, HorizontalFlex: Enum.UIFlexAlignment?, VerticalFlex: Enum.UIFlexAlignment?, Expand: (Row) -> Row}

aa:DefineElement('Row', {
    Base = {
        Spacing = 4,
        Expanded = false,
        HorizontalFlex = Enum.UIFlexAlignment.None,
        VerticalFlex = Enum.UIFlexAlignment.None,
    },
    Create = function(q, r: Row)
        local x = q.WindowClass
        local y = r.Spacing
        local z = r.Expanded
        local A = r.HorizontalFlex
        local B = r.VerticalFlex
        local C = aa:InsertPrefab('Row', r)
        local E = aa:MergeMetatables(r, C)
        local F = C:FindFirstChildOfClass'UIListLayout'

        F.Padding = UDim.new(0, y)
        F.HorizontalFlex = A
        F.VerticalFlex = B

        local G = aa:MakeCanvas{
            Element = C,
            WindowClass = x,
            Class = E,
        }

        function r.Expand(H)
            F.HorizontalFlex = Enum.UIFlexAlignment.Fill

            return H
        end

        if z then
            r:Expand()
        end

        return G, C
    end,
})

export type SliderIntFlags = {Value: number?, Format: string?, Label: string?, Progress: boolean?, NoGrab: boolean?, Minimum: number, Maximum: number, NoAnimation: boolean?, Callback: (number) -> any?, ReadOnly: boolean?, SetValue: (SliderIntFlags, Value:number, IsSlider:boolean?) -> SliderIntFlags?, SetDisabled: (SliderIntFlags, Disabled:boolean) -> SliderIntFlags, MakeProgress: (SliderIntFlags) -> nil?}

aa:DefineElement('SliderBase', {
    Base = {
        Format = '%.f',
        Label = '',
        Type = 'Slider',
        Callback = m,
        NoGrab = false,
        NoClick = false,
        Minimum = 0,
        Maximum = 100,
        ColorTag = 'Frame',
        Disabled = false,
    },
    Create = function(q, r)
        local x = r.Value or r.Minimum
        local y = r.Format
        local z = r.Label
        local A = r.NoAnimation
        local B = r.NoGrab
        local C = r.NoClick
        local E = r.Type
        local F = r.Disabled
        local G = aa:InsertPrefab'Slider'
        local H = G.Track
        local I = H.Grab
        local J = H.ValueText
        local K = aa:MergeMetatables(r, G)
        local L = I.AbsoluteSize
        local M = aa:SetAnimation(G, 'Inputs')
        local N = q:Label{
            Parent = G,
            Text = z,
            Position = UDim2.new(1, 4),
            Size = UDim2.fromScale(0, 1),
        }

        Merge(r, {
            Grab = I,
            Name = z,
        })

        if E == 'Slider' then
            H.Position = UDim2.fromOffset(L.X / 2, 0)
            H.Size = UDim2.new(1, -L.X, 1, 0)
        end

        local O = {
            Slider = function(O)
                return {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(O, 0.5),
                }
            end,
            Progress = function(O)
                return {
                    Size = UDim2.fromScale(O, 1),
                }
            end,
            Snap = function(O, P, Q, R)
                local S = (math.round(P) - Q) / R

                return {
                    Size = UDim2.fromScale(1 / R, 1),
                    Position = UDim2.fromScale(S, 0.5),
                }
            end,
        }

        local function Callback(...)
            local P = r.Callback

            return P(K, ...)
        end

        function r.SetDisabled(P, Q: boolean)
            P.Disabled = Q
            G.Interactable = not Q

            q:SetColorTags({
                [N] = Q and 'LabelDisabled' or 'Label',
            }, true)

            return P
        end
        function r.SetValueText(P, Q: string)
            J.Text = tostring(Q)
        end
        function r.SetValue(P, Q, R: boolean)
            local S = q:GetThemeKey'AnimationTweenInfo'
            local T = r.Minimum
            local U = r.Maximum
            local V = Q
            local W = U - T

            if not R then
                V = (Q - T) / W
            else
                Q = T + (W * V)
            end

            V = math.clamp(V, 0, 1)

            local X = O[E](V, Q, T, U)

            b:Tween{
                Object = I,
                Tweeninfo = S,
                NoAnimation = A,
                EndProperties = X,
            }

            P.Value = Q

            P:SetValueText(y:format(Q, U))
            Callback(Q)

            return P
        end

        local function SetFocused(P: boolean)
            q:SetColorTags({
                [G] = P and 'FrameActive' or 'Frame',
            }, true)
            q:SetElementFocused(G, {
                Focused = P,
                Animation = M,
            })
        end
        local function CanDrag()
            if r.Disabled then
                return
            end
            if r.ReadOnly then
                return
            end

            return true
        end
        local function DragMovement(P)
            if not CanDrag() then
                return
            end

            local Q = H.AbsolutePosition.X
            local R = H.AbsoluteSize.X
            local S = P.X
            local T = S - Q
            local U = math.clamp(T / R, 0, 1)

            r:SetValue(U, true)
        end
        local function DragBegan(...)
            if not CanDrag() then
                return
            end

            SetFocused(true)

            if not C then
                DragMovement(...)
            end
        end
        local function DragEnded()
            SetFocused(false)
        end

        I.Visible = not B

        r:SetValue(x)
        r:SetDisabled(F)
        q:TagElements{
            [J] = 'Label',
            [I] = 'SliderGrab',
        }
        aa:ConnectDrag(H, {
            DragStart = DragBegan,
            DragMovement = DragMovement,
            DragEnd = DragEnded,
        })

        return K, G
    end,
})

export type SliderEnumFlags = {Items: {[number]: any}, Label: string, Value: number}&SliderIntFlags

aa:DefineElement('SliderEnum', {
    Base = {
        Items = {},
        Label = 'Slider Enum',
        Type = 'Snap',
        Minimum = 1,
        Maximum = 10,
        Value = 1,
        Callback = m,
        ColorTag = 'Frame',
    },
    Create = function(q, r: SliderEnumFlags)
        local x = r.Callback
        local y = r.Value

        local function Calculate(z, A: number)
            A = math.round(A)

            local B = z.Items

            z.Maximum = #B

            return B[A]
        end

        r.Callback = function(z, A)
            local B = Calculate(z, A)

            z:SetValueText(B)

            r.Value = B

            return x(z, B)
        end

        Calculate(r, y)

        return q:SliderBase(r)
    end,
})
aa:DefineElement('SliderInt', {
    Base = {
        Label = 'Slider Int',
        ColorTag = 'Frame',
    },
    Create = n.SliderBase,
})
aa:DefineElement('SliderFloat', {
    Base = {
        Label = 'Slider Float',
        Format = '%.3f',
        ColorTag = 'Frame',
    },
    Create = n.SliderBase,
})

export type DragIntFlags = {Format: string?, Label: string?, Callback: (DragIntFlags, number) -> any, Minimum: number?, Maximum: number?, Value: number?, ReadOnly: boolean?, Disabled: boolean?, SetDisabled: (DragIntFlags, Disabled:boolean) -> DragIntFlags, SetValue: (DragIntFlags, Value:number, IsPercentage:boolean?) -> DragIntFlags}

aa:DefineElement('DragInt', {
    Base = {
        Format = '%.f',
        Label = 'Drag Int',
        Callback = m,
        Minimum = 0,
        Maximum = 100,
        ColorTag = 'Frame',
        Disabled = false,
    },
    Create = function(q, r: DragIntFlags)
        local x = r.Value or r.Minimum
        local y = r.Format
        local z = r.Label
        local A = r.Disabled
        local B = aa:InsertPrefab'Slider'
        local C = aa:MergeMetatables(r, B)
        local E = B.Track
        local F = E.ValueText
        local G = E.Grab

        G.Visible = false

        local H = q:Label{
            Parent = B,
            Text = z,
            Position = UDim2.new(1, 7),
            Size = UDim2.fromScale(0, 1),
        }
        local I
        local J = 0
        local K = 0
        local L = aa:SetAnimation(B, 'Inputs')

        local function Callback(...)
            local M = r.Callback

            return M(C, ...)
        end

        function r.SetValue(M, N, O)
            local P = M.Minimum
            local Q = M.Maximum
            local R = Q - P

            if not O then
                J = ((N - P) / R) * 100
            else
                N = P + (R * (J / 100))
            end

            N = math.clamp(N, P, Q)
            M.Value = N
            F.Text = y:format(N, Q)

            Callback(N)

            return M
        end
        function r.SetDisabled(M, N)
            M.Disabled = N

            q:SetColorTags({
                [H] = N and 'LabelDisabled' or 'Label',
            }, true)

            return M
        end

        local function SetFocused(M)
            q:SetColorTags({
                [B] = M and 'FrameActive' or 'Frame',
            }, true)
            q:SetElementFocused(B, {
                Focused = M,
                Animation = L,
            })
        end
        local function CanDrag(): boolean?
            if r.Disabled then
                return
            end
            if r.ReadOnly then
                return
            end

            return true
        end
        local function DragStart(M)
            if not CanDrag() then
                return
            end

            SetFocused(true)

            I = M
            K = J
        end
        local function DragMovement(M)
            if not CanDrag() then
                return
            end

            local N = M.X - I.X
            local O = K + (N / 2)

            J = math.clamp(O, 0, 100)

            r:SetValue(J, true)
        end
        local function DragEnded()
            SetFocused(false)
        end

        r:SetValue(x)
        r:SetDisabled(A)
        aa:ConnectDrag(E, {
            DragStart = DragStart,
            DragEnd = DragEnded,
            DragMovement = DragMovement,
        })
        q:TagElements{
            [F] = 'Label',
        }

        return C, B
    end,
})
aa:DefineElement('DragFloat', {
    Base = {
        Format = '%.3f',
        Label = 'Drag Float',
        ColorTag = 'Frame',
    },
    Create = n.DragInt,
})
aa:DefineElement('MultiElement', {
    Base = {
        Callback = m,
        Label = '',
        Disabled = false,
        BaseInputConfig = {},
        InputConfigs = {},
        Value = {},
        Minimum = {},
        Maximum = {},
        MultiCallback = m,
    },
    Create = function(q, r)
        local x = r.Label
        local y = r.BaseInputConfig
        local z = r.InputConfigs
        local A = r.InputType
        local B = r.Disabled
        local C = r.Value
        local E = r.Minimum
        local F = r.Maximum

        assert(A, 'No input type provided for MultiElement')

        local G, H = q:Row{Spacing = 4}
        local I = G:Row{
            Size = UDim2.fromScale(0.65, 0),
            Expanded = true,
        }
        local J = G:Label{
            Size = UDim2.fromScale(0.35, 0),
            LayoutOrder = 2,
            Text = x,
        }
        local K = aa:MergeMetatables(r, G)
        local L = {}
        local M = false

        local function GetValue()
            local N = {}

            for O, P in L do
                N[O] = P:GetValue()
            end

            r.Value = N

            return N
        end
        local function Callback(...)
            local N = r.MultiCallback

            N(K, ...)
        end
        local function InputChanged()
            if #L ~= #z then
                return
            end
            if not M then
                return
            end

            local N = GetValue()

            Callback(N)
        end

        function r.SetDisabled(N, O: boolean)
            N.Disabled = O

            q:SetColorTags({
                [J] = O and 'LabelDisabled' or 'Label',
            }, true)

            for P, Q in L do
                Q:SetDisabled(O)
            end
        end
        function r.SetValue(N, O)
            M = false

            for P, Q in O do
                local R = L[P]

                assert(R, `No input object for index: {P}`)
                R:SetValue(Q)
            end

            M = true

            Callback(O)
        end

        y = Copy(y, {
            Size = UDim2.new(1, 0, 0, 19),
            Label = '',
            Callback = InputChanged,
        })

        for N, O in z do
            local P = Copy(y, O)

            aa:CheckConfig(P, {
                Minimum = E[N],
                Maximum = F[N],
            })

            local Q = I[A](I, P)

            table.insert(L, Q)
        end

        Merge(r, {
            Row = I,
            Inputs = L,
        })

        M = true

        r:SetDisabled(B)
        r:SetValue(C)

        return K, H
    end,
})

local function GenerateMultiInput(q: string, r: string, x: number, y)
    aa:DefineElement(q, {
        Base = {
            Label = q,
            Callback = m,
            InputType = r,
            InputConfigs = table.create(x, {}),
            BaseInputConfig = {},
        },
        Create = function(z, A)
            local B = A.BaseInputConfig

            if y then
                Merge(B, y)
            end

            aa:CheckConfig(B, {
                ReadOnly = A.ReadOnly,
                Format = A.Format,
            })

            A.MultiCallback = function(...)
                local C = A.Callback

                C(...)
            end

            return z:MultiElement(A)
        end,
    })
end

export type InputColor3Flags = {Label: string?, Value: Color3?, Callback: (InputColor3Flags, Value:Color3) -> any, InputConfigs: table, ValueChanged: (InputColor3Flags) -> nil, SetValue: (InputColor3Flags, Value:Color3) -> InputColor3Flags}

local function GenerateColor3Input(q: string, r: string)
    aa:DefineElement(q, {
        Base = {
            Label = q,
            Callback = m,
            Value = aa.Accent.Light,
            Disabled = false,
            Minimum = {0, 0, 0},
            Maximum = {
                255,
                255,
                255,
                100,
            },
            BaseInputConfig = {},
            InputConfigs = {
                [1] = {
                    Format = 'R: %.f',
                },
                [2] = {
                    Format = 'G: %.f',
                },
                [3] = {
                    Format = 'B: %.f',
                },
            },
        },
        Create = function(x, y: InputColor3Flags)
            local z = y.Value
            local A = Copy(y, {
                Value = {1, 1, 1},
                Callback = function(A, ...)
                    if y.ValueChanged then
                        y:ValueChanged(...)
                    end
                end,
            })
            local B, C = x[r](x, A)
            local E = aa:MergeMetatables(y, B)
            local F = B.Row
            local G = F:Button{
                BackgroundTransparency = 0,
                Size = UDim2.fromOffset(19, 19),
                UiPadding = 0,
                Text = '',
                Ratio = 1,
                ColorTag = '',
                ElementStyle = '',
            }

            local function Callback(...)
                local H = y.Callback

                return H(E, ...)
            end
            local function SetPreview(H: Color3)
                G.BackgroundColor3 = H

                Callback(H)
            end

            function y.ValueChanged(H, I)
                local J, K, L = I[1], I[2], I[3]
                local M = Color3.fromRGB(J, K, L)

                H.Value = M

                SetPreview(M)
            end
            function y.SetValue(H, I: Color3)
                H.Value = I

                SetPreview(I)
                B:SetValue{
                    math.round(I.R * 255),
                    math.round(I.G * 255),
                    math.round(I.B * 255),
                }
            end

            y:SetValue(z)

            return E, C
        end,
    })
end

export type InputCFrameFlags = {Label: string?, Value: CFrame?, Maximum: CFrame, Minimum: CFrame, Callback: (InputCFrameFlags, Value:CFrame) -> any, ValueChanged: (InputCFrameFlags) -> nil, SetValue: (InputCFrameFlags, Value:CFrame) -> InputCFrameFlags}

local function GenerateCFrameInput(q: string, r: string)
    aa:DefineElement(q, {
        Base = {
            Label = q,
            Callback = m,
            Disabled = false,
            Value = CFrame.new(10, 10, 10),
            Minimum = CFrame.new(0, 0, 0),
            Maximum = CFrame.new(100, 100, 100),
            BaseInputConfig = {},
            InputConfigs = {
                [1] = {
                    Format = 'X: %.f',
                },
                [2] = {
                    Format = 'Y: %.f',
                },
                [3] = {
                    Format = 'Z: %.f',
                },
            },
        },
        Create = function(x, y: InputCFrameFlags)
            local z = y.Value
            local A = y.Maximum
            local B = y.Minimum
            local C = Copy(y, {
                Maximum = {
                    A.X,
                    A.Y,
                    A.Z,
                },
                Minimum = {
                    B.X,
                    B.Y,
                    B.Z,
                },
                Value = {
                    z.X,
                    z.Y,
                    z.Z,
                },
                Callback = function(C, ...)
                    if y.ValueChanged then
                        y:ValueChanged(...)
                    end
                end,
            })
            local E, F = x[r](x, C)
            local G = aa:MergeMetatables(y, E)

            local function Callback(...)
                local H = y.Callback

                return H(G, ...)
            end

            function y.ValueChanged(H, I)
                local J, K, L = I[1], I[2], I[3]
                local M = CFrame.new(J, K, L)

                H.Value = M

                Callback(M)
            end
            function y.SetValue(H, I: CFrame)
                H.Value = I

                E:SetValue{
                    math.round(I.X),
                    math.round(I.Y),
                    math.round(I.Z),
                }
            end

            y:SetValue(z)

            return G, F
        end,
    })
end

aa:DefineElement('SliderProgress', {
    Base = {
        Label = 'Slider Progress',
        Type = 'Progress',
        ColorTag = 'Frame',
    },
    Create = n.SliderBase,
})

export type ProgressBar = {SetPercentage: (ProgressBar, Value:number) -> nil}

aa:DefineElement('ProgressBar', {
    Base = {
        Label = 'Progress Bar',
        Type = 'Progress',
        ReadOnly = true,
        MinValue = 0,
        MaxValue = 100,
        Format = '% i%%',
        Interactable = false,
        ColorTag = 'Frame',
    },
    Create = function(q, r)
        function r.SetPercentage(x, y: number)
            r:SetValue(y)
        end

        local x, y = q:SliderBase(r)
        local z = x.Grab

        q:TagElements{
            [z] = {
                BackgroundColor3 = 'ProgressBar',
            },
        }

        return x, y
    end,
})

export type Combo = {Label: string?, Placeholder: string?, Callback: (Combo, Value:any) -> any, Items: {[(number?)]: any}?, GetItems: (() -> table)?, NoAnimation: boolean?, Selected: any, WidthFitPreview: boolean?, Disabled: boolean?, Open: boolean?, ClosePopup: (Combo) -> nil, SetValueText: (Combo, Value:string) -> nil, SetDisabled: (Combo, Disabled:boolean) -> Combo, SetValue: (Combo, Value:any) -> Combo, SetOpen: (Combo, Open:boolean) -> Combo}

aa:DefineElement('Combo', {
    Base = {
        Value = '',
        Placeholder = '',
        Callback = m,
        Items = {},
        Disabled = false,
        WidthFitPreview = false,
        Label = 'Combo',
    },
    Create = function(q, r: Combo)
        local x = r.Placeholder
        local y = r.NoAnimation
        local z = r.Selected
        local A = r.Label
        local B = r.Disabled
        local C = r.WidthFitPreview
        local E = aa:InsertPrefab('Combo', r)
        local F = aa:MergeMetatables(r, E)
        local G = E.Combo
        local H
        local I = q:Label{
            Text = tostring(x),
            Parent = G,
            Name = 'ValueText',
        }
        local J = q:ArrowButton{
            Parent = G,
            Interactable = false,
            Size = UDim2.fromOffset(19, 19),
            LayoutOrder = 2,
        }
        local K = q:Label{
            Text = A,
            Parent = E,
            LayoutOrder = 2,
        }

        if C then
            aa:SetProperties(E, {
                AutomaticSize = Enum.AutomaticSize.XY,
                Size = UDim2.new(0, 0, 0, 0),
            })
            aa:SetProperties(G, {
                AutomaticSize = Enum.AutomaticSize.XY,
                Size = UDim2.fromScale(0, 1),
            })
        end

        local function Callback(L, ...)
            r:SetOpen(false)

            return r.Callback(F, L, ...)
        end
        local function SetAnimationState(L: boolean, M: boolean?)
            local N = q:GetThemeKey'AnimationTweenInfo'

            E.Interactable = not L

            b:HeaderCollapseToggle{
                Tweeninfo = N,
                NoAnimation = M,
                Collapsed = not L,
                Toggle = J.Icon,
            }
        end
        local function GetItems()
            local L = r.GetItems
            local M = r.Items

            if L then
                return L()
            end

            return M
        end

        function r.SetValueText(L, M: string?)
            I.Text = tostring(M)
        end
        function r.ClosePopup(L)
            if not H then
                return
            end

            H:ClosePopup(true)
        end
        function r.SetDisabled(L, M: boolean)
            L.Disabled = M
            E.Interactable = not M

            q:SetColorTags({
                [K] = M and 'LabelDisabled' or 'Label',
            }, true)

            return L
        end
        function r.SetValue(L, M)
            local N = GetItems()
            local O = N[M]
            local P = O or M

            L.Selected = M
            L.Value = P

            L:ClosePopup()

            if typeof(M) == 'number' then
                L:SetValueText(P)
            else
                L:SetValueText(M)
            end

            Callback(M, P)

            return L
        end
        function r.SetOpen(L, M: boolean)
            local N = L.Selected

            L.Open = M

            SetAnimationState(M, y)

            if not M then
                L:ClosePopup()

                return
            end

            H = q:Dropdown{
                RelativeTo = G,
                Items = GetItems(),
                Selected = N,
                OnSelected = function(...)
                    r:SetValue(...)
                end,
                OnClosed = function()
                    L:SetOpen(false)
                end,
            }

            return L
        end

        local function ToggleOpen()
            local L = r.Open

            r:SetOpen(not L)
        end

        G.Activated:Connect(ToggleOpen)
        SetAnimationState(false, true)
        r:SetDisabled(B)

        if z then
            r:SetValue(z)
        end

        aa:SetAnimation(G, 'Inputs')
        q:TagElements{
            [G] = 'Frame',
        }

        return F, E
    end,
})

local q = {
    TileBarConfig = {
        Close = {
            Image = aa.Icons.Close,
            IconPadding = UDim.new(0, 3),
        },
        Collapse = {
            Image = aa.Icons.Arrow,
            IconPadding = UDim.new(0, 3),
        },
    },
    CloseCallback = m,
    Collapsible = true,
    Open = true,
    Focused = false,
}

function q.Tween(r, x)
    aa:CheckConfig(x, {
        Tweeninfo = r:GetThemeKey'AnimationTweenInfo',
    })

    return b:Tween(x)
end
function q.TagElements(r, x: table)
    local y = r.TagsList
    local z = r.Theme

    aa:MultiUpdateColors{
        Theme = z,
        TagsList = y,
        Objects = x,
    }
end

export type TitleBarCanvas = {Right: table, Left: table}

function q.MakeTitleBarCanvas(r): TitleBarCanvas
    local x = r.TitleBar
    local y = aa:MakeCanvas{
        WindowClass = r,
        Element = x,
    }

    r.TitleBarCanvas = y

    return y
end
function q.AddDefaultTitleButtons(r)
    local x = r.TileBarConfig
    local y = x.Collapse
    local z = x.Close
    local A = r.TitleBarCanvas

    if not A then
        A = r:MakeTitleBarCanvas()
    end

    aa:CheckConfig(r, {
        Toggle = A:RadioButton{
            Icon = y.Image,
            IconPadding = y.IconPadding,
            LayoutOrder = 1,
            Ratio = 1,
            Size = UDim2.new(0, 0),
            Callback = function()
                r:ToggleCollapsed()
            end,
        },
        CloseButton = A:RadioButton{
            Icon = z.Image,
            IconPadding = z.IconPadding,
            LayoutOrder = 3,
            Ratio = 1,
            Size = UDim2.new(0, 0),
            Callback = function()
                r:SetVisible(false)
            end,
        },
        TitleLabel = A:Label{
            ColorTag = 'Title',
            LayoutOrder = 2,
            Size = UDim2.new(1, 0),
            Active = false,
            Fill = true,
            ClipsDescendants = true,
            AutomaticSize = Enum.AutomaticSize.XY,
        },
    })
    r:TagElements{
        [r.TitleLabel] = 'WindowTitle',
    }
end
function q.Close(r)
    local x = r.CloseCallback

    if x then
        local y = x(r)

        if y == false then
            return
        end
    end

    r:Remove()

    r.IsClosed = true
end
function q.SetVisible(r, x: boolean): WindowFlags
    local y = r.WindowFrame
    local z = r.NoFocusOnAppearing

    r.Visible = x
    y.Visible = x

    if x and not z then
        aa:SetFocusedWindow(r)
    end

    return r
end
function q.ToggleVisibility(r, x: boolean)
    local y = r.Visible

    r:SetVisible(not y)
end
function q.GetWindowSize(r): Vector2
    return r.WindowFrame.AbsoluteSize
end
function q.GetTitleBarSizeY(r): number
    local x = r.TitleBar

    return x.Visible and x.AbsoluteSize.Y or 0
end
function q.SetTitle(r, x: string?): WindowFlags
    r.TitleLabel.Text = tostring(x)

    return r
end
function q.SetPosition(r, x): WindowFlags
    r.WindowFrame.Position = x

    return r
end
function q.SetSize(r, x: (Vector2 | UDim2), y: boolean): WindowFlags
    local z = r.WindowFrame

    if typeof(x) == 'Vector2' then
        x = UDim2.fromOffset(x.X, x.Y)
    end

    z.Size = x
    r.Size = x

    return r
end
function q.SetCanvasInteractable(r, x: boolean)
    local y = r.Body

    y.Interactable = x
end
function q.Center(r): WindowFlags
    local x = r:GetWindowSize() / 2
    local y = UDim2.new(0.5, -x.X, 0.5, -x.Y)

    r:SetPosition(y)

    return r
end
function q.LoadStylesIntoElement(r, x)
    local y = x.Flags
    local z = x.Object
    local A = x.Canvas
    local B = {
        FrameRounding = function()
            if y.CornerRadius then
                return
            end
            if not A then
                return
            end

            local B = z:FindFirstChild('FrameRounding', true)

            if not B then
                return
            end

            A:TagElements{
                [B] = 'FrameRounding',
            }
        end,
    }

    for C, E in B do
        local F = r:GetThemeKey(C)

        if F == nil then
            continue
        end

        task.spawn(E, F)
    end
end
function q.SetTheme(r, x: string): WindowFlags
    local y = aa.ThemeConfigs
    local z = r.TagsList
    local A = r.WindowState

    x = x or r.Theme

    assert(y[x], `{x} is not a valid theme!`)

    r.Theme = x

    aa:MultiUpdateColors{
        Animate = false,
        Theme = x,
        Objects = z,
    }
    r:SetFocusedColors(A)

    return r
end
function q.SetFocusedColors(r, x: string)
    local y = r.WindowFrame
    local z = r.TitleBar
    local A = r.Theme
    local B = r.TitleLabel
    local C = r:GetThemeKey'AnimationTweenInfo'
    local E = y:FindFirstChildOfClass'UIStroke'
    local F = {
        Focused = {
            [E] = 'BorderActive',
            [z] = 'TitleBarBgActive',
            [B] = {
                TextColor3 = 'TitleActive',
            },
        },
        UnFocused = {
            [E] = 'Border',
            [z] = 'TitleBarBg',
            [B] = {
                TextColor3 = 'Title',
            },
        },
        Collapsed = {
            [E] = 'Border',
            [z] = 'TitleBarBgCollapsed',
            [B] = {
                TextColor3 = 'Title',
            },
        },
    }

    aa:MultiUpdateColors{
        Tweeninfo = C,
        Animate = true,
        Objects = F[x],
        Theme = A,
    }
end
function q.SetFocused(r, x: boolean?)
    x = x == nil and true or x

    local y = r.Collapsed
    local z = r.WindowState

    if x then
        aa:SetFocusedWindow(r)
    end

    local A = y and 'Collapsed' or x and 'Focused' or 'UnFocused'

    if A == z then
        return
    end

    r.Focused = x
    r.WindowState = A

    r:SetFocusedColors(A)
end
function q.GetThemeKey(r, x: string)
    return aa:GetThemeKey(r.Theme, x)
end
function q.SetCollapsible(r, x: boolean): WindowFlags
    r.Collapsible = x

    return r
end
function q.ToggleCollapsed(r, x: boolean?): WindowFlags
    local y = r.Collapsed
    local z = r.Collapsible

    if not x and not z then
        return r
    end

    r:SetCollapsed(not y)

    return r
end
function q.SetCollapsed(r, x: boolean, y: false): WindowFlags
    local z = r.WindowFrame
    local A = r.Body
    local B = r.Toggle
    local C = r.ResizeGrab
    local E = r.Size
    local F = r.AutoSize
    local G = r:GetThemeKey'AnimationTweenInfo'
    local H = r:GetWindowSize()
    local I = r:GetTitleBarSizeY()
    local J = B.Icon
    local K = UDim2.fromOffset(H.X, I)

    r.Collapsed = x

    r:SetCollapsible(false)
    r:SetFocused(not x)
    b:HeaderCollapse{
        Tweeninfo = G,
        NoAnimation = y,
        Collapsed = x,
        Toggle = J,
        Resize = z,
        NoAutomaticSize = not F,
        Hide = A,
        ClosedSize = K,
        OpenSize = E,
        Completed = function()
            r:SetCollapsible(true)
        end,
    }
    r:Tween{
        Object = C,
        NoAnimation = y,
        EndProperties = {
            TextTransparency = x and 1 or 0.6,
            Interactable = not x,
        },
    }

    return r
end
function q.UpdateConfig(r, x)
    local y = {
        NoTitleBar = function(y)
            local z = r.TitleBar

            z.Visible = not y
        end,
        NoClose = function(y)
            local z = r.CloseButton

            z.Visible = not y
        end,
        NoCollapse = function(y)
            local z = r.Toggle

            z.Visible = not y
        end,
        NoTabsBar = function(y)
            local z = r.WindowTabSelector

            if not z then
                return
            end

            local A = z.TabsBar

            A.Visible = not y
        end,
        NoScrollBar = function(y)
            local z = y and 0 or 9
            local A = r.NoScroll
            local B = r.WindowTabSelector
            local C = r.ContentCanvas

            if B then
                B.Body.ScrollBarThickness = z
            end
            if not A then
                C.ScrollBarThickness = z
            end
        end,
        NoScrolling = function(y)
            local z = r.NoScroll
            local A = r.WindowTabSelector
            local B = r.ContentCanvas

            if A then
                A.Body.ScrollingEnabled = not y
            end
            if not z then
                B.ScrollingEnabled = not y
            end
        end,
        NoMove = function(y)
            local z = r.DragConnection

            z:SetEnabled(not y)
        end,
        NoResize = function(y)
            local z = r.ResizeConnection

            z:SetEnabled(not y)
        end,
        NoBackground = function(y)
            local z = r:GetThemeKey'WindowBgTransparency'
            local A = r.CanvasFrame

            A.BackgroundTransparency = y and 1 or z
        end,
    }

    Merge(r, x)

    for z, A in x do
        local B = y[z]

        if B then
            B(A)
        end
    end

    return r
end
function q.Remove(r)
    local x = r.WindowFrame
    local y = r.WindowClass
    local z = aa.Windows
    local A = table.find(z, y)

    if A then
        table.remove(z, A)
    end

    x:Destroy()
end
function q.MenuBar(r, x, ...)
    local y = r.ContentCanvas
    local z = r.ContentFrame

    x = x or {}

    Merge(x, {
        Parent = z,
        Layout = -1,
    })

    return y:MenuBar(x, ...)
end

export type WindowFlags = {AutoSize: string?, CloseCallback: (WindowFlags) -> boolean?, IsClosed: boolean?, Collapsed: boolean?, IsDragging: boolean?, MinSize: Vector2?, Theme: any?, Title: string?, NoTabs: boolean?, NoMove: boolean?, NoResize: boolean?, NoTitleBar: boolean?, NoClose: boolean?, NoCollapse: boolean?, NoScrollBar: boolean?, NoSelectEffect: boolean?, NoFocusOnAppearing: boolean?, NoDefaultTitleBarButtons: boolean?, NoWindowRegistor: boolean?, OpenOnDoubleClick: boolean?, NoScroll: boolean?, AutoSelectNewTabs: boolean?, MinimumSize: Vector2?, SetTheme: (WindowFlags, ThemeName:string) -> WindowFlags, SetTitle: (WindowFlags, Title:string) -> WindowFlags, UpdateConfig: (WindowFlags, Config:table) -> WindowFlags, SetCollapsed: (WindowFlags, Collapsed:boolean, NoAnimation:boolean?) -> WindowFlags, SetCollapsible: (WindowFlags, Collapsible:boolean) -> WindowFlags, SetFocused: (WindowFlags, Focused:boolean) -> WindowFlags, Center: (WindowFlags) -> WindowFlags, SetVisible: (WindowFlags, Visible:boolean) -> WindowFlags, TagElements: (WindowFlags, Objects:{[GuiObject]: string}) -> nil, Close: (WindowFlags) -> nil, Parent: Instance, AutomaticSize: string?}

aa:DefineElement('Window', {
    Export = true,
    Base = {
        Theme = 'DarkTheme',
        NoSelect = false,
        NoTabs = true,
        NoScroll = false,
        Collapsed = false,
        Visible = true,
        AutoSize = false,
        MinimumSize = Vector2.new(160, 90),
        OpenOnDoubleClick = true,
        NoAutoTheme = true,
        NoWindowRegistor = false,
        NoBringToFrontOnFocus = false,
        IsDragging = false,
    },
    Create = function(r, x: WindowFlags)
        aa:CheckImportState()

        local y = aa.Windows
        local z = aa.Container.Windows

        aa:CheckConfig(x, {
            Parent = z,
            Title = aa.DefaultTitle,
        })

        local A = x.NoDefaultTitleBarButtons
        local B = x.Collapsed
        local C = x.MinimumSize
        local E = x.Title
        local F = x.NoTabs
        local G = x.NoScroll
        local H = x.Theme
        local I = x.AutomaticSize
        local J = x.NoWindowRegistor
        local K = x.AutoSelectNewTabs
        local L = x.Parent ~= z
        local M = {
            Scroll = not G,
            Fill = not I and true or nil,
            UiPadding = UDim.new(0, F and 8 or 0),
            AutoSelectNewTabs = K,
        }

        if I then
            Merge(M, {
                AutomaticSize = I,
                Size = UDim2.new(1, 0),
            })
        end

        local N = aa:InsertPrefab('Window', x)
        local O = N.Content
        local P = O.TitleBar
        local Q = ad:NewClass(q)
        local R = aa:MakeCanvas{
            Element = O,
            WindowClass = Q,
            Class = Q,
        }
        local S, T, U
        local V, W = R:Canvas(Copy(M, {
            Parent = O,
            CornerRadius = UDim.new(0, 0),
        }))
        local X = aa:MakeResizable{
            MinimumSize = C,
            Resize = N,
            OnUpdate = function(X)
                Q:SetSize(X, true)
            end,
        }

        Merge(Q, x)
        Merge(Q, {
            WindowFrame = N,
            ContentFrame = O,
            CanvasFrame = W,
            ResizeGrab = X.Grab,
            TitleBar = P,
            Elements = n,
            TagsList = {},
            _SelectDisabled = L,
            ResizeConnection = X,
            HoverConnection = aa:DetectHover(O),
            DragConnection = aa:MakeDraggable{
                Grab = O,
                Move = N,
                SetPosition = function(Y, Z: UDim2)
                    local _ = S:GetThemeKey'AnimationTweenInfo'

                    b:Tween{
                        Tweeninfo = _,
                        Object = Y.Move,
                        EndProperties = {Position = Z},
                    }
                end,
                OnDragStateChange = function(Y: boolean)
                    Q.IsDragging = Y
                    W.Interactable = not Y

                    if Y then
                        aa:SetFocusedWindow(U)
                    end

                    aa:SetWindowFocusesEnabled(not Y)
                end,
            },
        })

        if F then
            S, T = V, W
        else
            S, T = V:TabSelector(M)
            Q.WindowTabSelector = S
        end

        U = aa:MergeMetatables(Q, S)

        Merge(Q, {
            ContentCanvas = S,
            WindowClass = U,
            Body = T,
        })
        aa:ConnectMouseEvent(O, {
            DoubleClick = true,
            OnlyMouseHovering = P,
            Callback = function(...)
                if not Q.OpenOnDoubleClick then
                    return
                end
                if Q.NoCollapse then
                    return
                end

                Q:ToggleCollapsed()
            end,
        })

        if not A then
            Q:AddDefaultTitleButtons()
        end

        Q:SetTitle(E)
        Q:SetCollapsed(B, true)
        Q:SetTheme(H)
        Q:UpdateConfig(x)
        Q:SetFocused()

        if not J then
            table.insert(y, U)
        end

        local Y = X.Grab

        aa:SetAnimation(Y, 'TextButtons')
        aa:SetFocusedWindow(U)
        U:TagElements{
            [Y] = 'ResizeGrab',
            [P] = 'TitleBar',
            [W] = 'Window',
        }

        return U, N
    end,
})

export type TabsWindowFlags = {AutoSelectNewTabs: boolean?}&WindowFlags

aa:DefineElement('TabsWindow', {
    Export = true,
    Base = {
        NoTabs = false,
        AutoSelectNewTabs = true,
    },
    Create = function(r, x: TabsWindowFlags)
        return r:Window(x)
    end,
})

export type PopupCanvas = {Scroll: boolean?, AutoClose: boolean?, RelativeTo: GuiObject, MaxSizeY: number?, MinSizeX: number?, MaxSizeX: number?, Visible: boolean?, NoAnimation: boolean?, Parent: Instance, UpdateScale: (PopupCanvas) -> nil, UpdatePosition: (PopupCanvas) -> nil, ClosePopup: (PopupCanvas) -> nil, FetchScales: (PopupCanvas) -> nil, IsMouseHovering: (PopupCanvas) -> boolean, OnFocusLost: (PopupCanvas) -> nil, UpdateScales: (PopupCanvas, Visible:boolean, NoAnimation:boolean, Wait:boolean?) -> nil, GetScale: (PopupCanvas, Visible:boolean) -> UDim2, SetPopupVisible: (PopupCanvas, Visible:boolean) -> nil}

aa:DefineElement('PopupCanvas', {
    Base = {
        AutoClose = false,
        Scroll = false,
        Visible = true,
        Spacing = UDim.new(0, 1),
        AutomaticSize = Enum.AutomaticSize.XY,
        MaxSizeY = 150,
        MinSizeX = 100,
        MaxSizeX = math.huge,
        OnClosed = m,
    },
    Create = function(r, x: PopupCanvas)
        local y = x.RelativeTo
        local z = x.MaxSizeY
        local A = x.MinSizeX
        local B = x.MaxSizeX
        local C = x.Visible
        local E = x.AutoClose
        local F = x.NoAnimation

        x.Parent = aa.Container.Overlays

        local G, H = r:OverlayScroll(x)
        local I = H.UIStroke
        local J = I.Thickness
        local K = H.Parent.AbsolutePosition
        local L, M, N, O
        local P = aa:DetectHover(H, {
            MouseOnly = true,
            OnInput = function(P, Q)
                if P then
                    return
                end
                if not H.Visible then
                    return
                end

                x:OnFocusLost()
            end,
        })

        function x.FetchScales(Q)
            local R = G:GetCanvasSize()

            L = y.AbsolutePosition
            M = y.AbsoluteSize
            N = math.clamp(R.Y, M.Y, z)
            O = math.clamp(M.X, A, B)
        end
        function x.UpdatePosition(Q)
            H.Position = UDim2.fromOffset(L.X - K.X + J, L.Y - K.Y + M.Y)
        end
        function x.GetScale(Q, R: boolean): UDim2
            local S = UDim2.fromOffset(O, N)
            local T = UDim2.fromOffset(O, 0)

            return R and S or T
        end
        function x.IsMouseHovering(Q): boolean
            return P.Hovering
        end
        function x.OnFocusLost(Q)
            local R = Q.OnClosed

            Q:SetPopupVisible(false)
            R(Q)

            if E then
                Q:ClosePopup()
            end
        end
        function x.ClosePopup(Q, R: boolean?)
            Q:SetPopupVisible(false, F, R)
            P:Disconnect()
            H:Remove()
        end
        function x.SetPopupVisible(Q, R: boolean, S: boolean?)
            if H.Visible == R then
                return
            end

            y.Interactable = not R

            Q:UpdateScales(R, F, S)

            Q.Visible = R
        end
        function x.UpdateScales(Q, R: boolean, S: boolean, T: boolean?)
            local U = G:GetThemeKey'AnimationTweenInfo'

            R = R == nil and H.Visible or R

            x:FetchScales()
            x:UpdatePosition()

            local V = b:Tween{
                Tweeninfo = U,
                Object = H,
                NoAnimation = S,
                EndProperties = {
                    Size = x:GetScale(R),
                    Visible = R,
                },
            }

            if V and T then
                V.Completed:Wait()
            end
        end

        x:UpdateScales(false, true)
        x:SetPopupVisible(C)
        G.OnChildChange:Connect(x.UpdateScales)

        return G, H
    end,
})

export type PopupModal = {ClosePopup: (PopupModal) -> nil, NoAnimation: boolean?, Parent: Instance}&WindowFlags

aa:DefineElement('PopupModal', {
    Export = true,
    Base = {
        NoAnimation = false,
        NoCollapse = true,
        NoClose = true,
        NoResize = true,
        NoSelect = true,
        NoAutoFlags = true,
        NoWindowRegistor = true,
        NoScroll = true,
    },
    Create = function(r, x: PopupModal)
        local y = r.WindowClass
        local z = x.NoAnimation
        local A

        x.Parent = aa.Container.Overlays

        if y then
            A = y:GetThemeKey'ModalWindowDimTweenInfo'
            x.Theme = y.Theme
        end

        local B = aa:InsertPrefab('ModalEffect', x)
        local C = r:Window(Copy(x, {
            NoAutoFlags = false,
            Parent = B,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(372, 38),
            AutomaticSize = Enum.AutomaticSize.Y,
        }))

        function x.ClosePopup(E)
            b:Tween{
                Object = B,
                Tweeninfo = A,
                NoAnimation = z,
                EndProperties = {BackgroundTransparency = 1},
                Completed = function()
                    B:Destroy()
                end,
            }
            C:Close()
        end

        b:Tween{
            Object = B,
            Tweeninfo = A,
            NoAnimation = z,
            StartProperties = {BackgroundTransparency = 1},
            EndProperties = {BackgroundTransparency = 0.8},
        }
        r:TagElements{
            [B] = 'ModalWindowDim',
        }

        local E = aa:MergeMetatables(x, C)

        return E, B
    end,
})
GenerateMultiInput('InputInt2', 'InputInt', 2, {NoButtons = true})
GenerateMultiInput('InputInt3', 'InputInt', 3, {NoButtons = true})
GenerateMultiInput('InputInt4', 'InputInt', 4, {NoButtons = true})
GenerateMultiInput('SliderInt2', 'SliderInt', 2)
GenerateMultiInput('SliderInt3', 'SliderInt', 3)
GenerateMultiInput('SliderInt4', 'SliderInt', 4)
GenerateMultiInput('SliderFloat2', 'SliderFloat', 2)
GenerateMultiInput('SliderFloat3', 'SliderFloat', 3)
GenerateMultiInput('SliderFloat4', 'SliderFloat', 4)
GenerateMultiInput('DragInt2', 'DragInt', 2)
GenerateMultiInput('DragInt3', 'DragInt', 3)
GenerateMultiInput('DragInt4', 'DragInt', 4)
GenerateMultiInput('DragFloat2', 'DragFloat', 2)
GenerateMultiInput('DragFloat3', 'DragFloat', 3)
GenerateMultiInput('DragFloat4', 'DragFloat', 4)
GenerateColor3Input('InputColor3', 'InputInt3')
GenerateColor3Input('SliderColor3', 'SliderInt3')
GenerateColor3Input('DragColor3', 'DragInt3')
GenerateCFrameInput('InputCFrame', 'InputInt3')
GenerateCFrameInput('SliderCFrame', 'SliderInt3')
GenerateCFrameInput('DragCFrame', 'DragInt3')

return aa
