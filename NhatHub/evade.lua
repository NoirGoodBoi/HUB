local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Evade Hub",
    LoadingTitle = "Đang tải Evade Hub...",
    LoadingSubtitle = "by NHATHUB",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

local FloatingGui = Instance.new("ScreenGui")
FloatingGui.Name = "PinCustomButtonsGui"

if syn and syn.protect_gui then
    syn.protect_gui(FloatingGui)
    FloatingGui.Parent = CoreGui
elseif gethui then
    FloatingGui.Parent = gethui()
else
    FloatingGui.Parent = CoreGui
end

_G.ButtonWidth = 140
_G.ButtonHeight = 40
_G.ButtonTransparency = 0.65

local Icons = {
    Speed = "rbxassetid://94959783129799",
    Jump = "rbxassetid://103689239525832",
    Moon = "rbxassetid://133378404835359",
    AutoJump = "rbxassetid://129303130603241",
    Bhop = "rbxassetid://137009384800610",
    TpDowned = "rbxassetid://126587578410655",
    LagSwitch = "rbxassetid://137149549886852",
    AntiAfk = "rbxassetid://135548958804125",
    FpsBoost = "rbxassetid://125934100055431",
    Bright = "rbxassetid://73708402464015",
    EspBody = "rbxassetid://107815971101498",
    EspName = "rbxassetid://129517577270214",
    EspBox = "rbxassetid://122997226258883",
    EspTracer = "rbxassetid://86386337337958",
    EspDowned = "rbxassetid://113714744350666",
    AfkFarm = "rbxassetid://137370389604364",
    AutoItem = "rbxassetid://129989433311409",
    Settings = "rbxassetid://14007344336",
    Width = "rbxassetid://123446436762366",
    Height = "rbxassetid://123446436762366",
    Transparency = "rbxassetid://100277767266983",
    Info = "rbxassetid://10709752906",
    TikTok = "rbxassetid://117711060446092",
    Messenger = "rbxassetid://10709789810",
    Discord = "rbxassetid://75871011309830",
}

local function CreateGothicButton(name, text, position, iconId, onClick)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, _G.ButtonWidth or 140, 0, _G.ButtonHeight or 40)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    btn.BackgroundTransparency = _G.ButtonTransparency or 0.65
    btn.Text = ""
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Active = true
    btn.Draggable = true
    btn.Parent = FloatingGui
    
    local icon = Instance.new("ImageLabel")
    icon.Name = "ButtonIcon"
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Position = UDim2.new(0.05, 0, 0.5, -10)
    icon.BackgroundTransparency = 1
    icon.Image = iconId
    icon.ScaleType = Enum.ScaleType.Fit
    icon.Parent = btn
    
    local label = Instance.new("TextLabel")
    label.Name = "ButtonText"
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0.25, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextStrokeColor3 = Color3.fromRGB(100, 0, 0)
    label.TextStrokeTransparency = 0.3
    label.Parent = btn
    
    local status = Instance.new("Frame")
    status.Name = "StatusIndicator"
    status.Size = UDim2.new(0, 8, 0, 8)
    status.Position = UDim2.new(0.92, 0, 0.5, -4)
    status.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    status.BackgroundTransparency = 0
    status.Parent = btn
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = status
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2.5
    stroke.Color = Color3.fromRGB(200, 0, 0)
    stroke.Transparency = 0.2
    stroke.Parent = btn
    
    btn.MouseEnter:Connect(function()
        stroke.Color = Color3.fromRGB(255, 50, 50)
        stroke.Transparency = 0
        label.TextColor3 = Color3.fromRGB(255, 50, 50)
    end)
    
    btn.MouseLeave:Connect(function()
        stroke.Color = Color3.fromRGB(200, 0, 0)
        stroke.Transparency = 0.2
        label.TextColor3 = Color3.fromRGB(255, 0, 0)
    end)
    
    btn.MouseButton1Click:Connect(function()
        onClick(btn, label, status)
    end)
    
    return btn, label, status
end

local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateSection("Movement")

_G.SpeedActive = false
_G.SpeedVal = 40

MainTab:CreateToggle({
    Name = "Chạy Nhanh",
    CurrentValue = false,
    Flag = "SpeedToggle",
    Callback = function(value)
        _G.SpeedActive = value
    end
})

MainTab:CreateSlider({
    Name = "Tốc Độ Chạy",
    Range = {10, 200},
    Increment = 5,
    CurrentValue = 40,
    Flag = "SpeedSlider",
    Callback = function(value)
        _G.SpeedVal = value
    end
})

_G.JumpActive = false
_G.JumpVal = 100

MainTab:CreateToggle({
    Name = "Nhảy Cao",
    CurrentValue = false,
    Flag = "JumpToggle",
    Callback = function(value)
        _G.JumpActive = value
    end
})

MainTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 500},
    Increment = 10,
    CurrentValue = 100,
    Flag = "JumpSlider",
    Callback = function(value)
        _G.JumpVal = value
    end
})

_G.MoonActive = false
local MoonToggleState = false

local function CreateMoonButton()
    if _G.MoonBtnRef then
        _G.MoonBtnRef:Destroy()
        _G.MoonBtnRef = nil
    end
    
    local btn, label, status = CreateGothicButton(
        "MoonFloatingButton",
        "MOON: OFF",
        UDim2.new(0.05, 0, 0.3, 0),
        Icons.Moon,
        function(btn, label, status)
            _G.MoonActive = not _G.MoonActive
            if _G.MoonActive then
                label.Text = "MOON: ON"
                btn.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
                label.TextColor3 = Color3.fromRGB(255, 100, 100)
                status.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            else
                label.Text = "MOON: OFF"
                btn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                status.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                workspace.Gravity = 196.2
            end
        end
    )
    
    _G.MoonBtnRef = btn
    _G.MoonLabelRef = label
    _G.MoonStatusRef = status
end

MainTab:CreateToggle({
    Name = "Gravity Mặt Trăng (Nút Nổi)",
    CurrentValue = false,
    Flag = "MoonToggle",
    Callback = function(value)
        MoonToggleState = value
        if value then
            CreateMoonButton()
            _G.MoonBtnRef.Visible = true
        else
            if _G.MoonBtnRef then
                _G.MoonBtnRef:Destroy()
                _G.MoonBtnRef = nil
            end
            _G.MoonActive = false
            workspace.Gravity = 196.2
        end
    end
})

_G.AutoJumpActive = false
local AutoJumpToggleState = false

local function CreateAutoJumpButton()
    if _G.AutoJumpBtnRef then
        _G.AutoJumpBtnRef:Destroy()
        _G.AutoJumpBtnRef = nil
    end
    
    local btn, label, status = CreateGothicButton(
        "AutoJumpFloatingButton",
        "AUTO JUMP: OFF",
        UDim2.new(0.05, 0, 0.4, 0),
        Icons.AutoJump,
        function(btn, label, status)
            _G.AutoJumpActive = not _G.AutoJumpActive
            if _G.AutoJumpActive then
                label.Text = "AUTO JUMP: ON"
                btn.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
                label.TextColor3 = Color3.fromRGB(255, 100, 100)
                status.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            else
                label.Text = "AUTO JUMP: OFF"
                btn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                status.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            end
        end
    )
    
    _G.AutoJumpBtnRef = btn
    _G.AutoJumpLabelRef = label
    _G.AutoJumpStatusRef = status
end

MainTab:CreateToggle({
    Name = "Auto Jump (Nút Nổi)",
    CurrentValue = false,
    Flag = "AutoJumpToggle",
    Callback = function(value)
        AutoJumpToggleState = value
        if value then
            CreateAutoJumpButton()
            _G.AutoJumpBtnRef.Visible = true
        else
            if _G.AutoJumpBtnRef then
                _G.AutoJumpBtnRef:Destroy()
                _G.AutoJumpBtnRef = nil
            end
            _G.AutoJumpActive = false
        end
    end
})

_G.BhopActive = false
local BhopToggleState = false

local function CreateBhopButton()
    if _G.BhopBtnRef then
        _G.BhopBtnRef:Destroy()
        _G.BhopBtnRef = nil
    end
    
    local btn, label, status = CreateGothicButton(
        "BhopFloatingButton",
        "BHOP: OFF",
        UDim2.new(0.05, 0, 0.5, 0),
        Icons.Bhop,
        function(btn, label, status)
            _G.BhopActive = not _G.BhopActive
            if _G.BhopActive then
                label.Text = "BHOP: ON"
                btn.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
                label.TextColor3 = Color3.fromRGB(255, 100, 100)
                status.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            else
                label.Text = "BHOP: OFF"
                btn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                status.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            end
        end
    )
    
    _G.BhopBtnRef = btn
    _G.BhopLabelRef = label
    _G.BhopStatusRef = status
end

MainTab:CreateToggle({
    Name = "BHop Strafe (Nút Nổi)",
    CurrentValue = false,
    Flag = "BhopToggle",
    Callback = function(value)
        BhopToggleState = value
        if value then
            CreateBhopButton()
            _G.BhopBtnRef.Visible = true
        else
            if _G.BhopBtnRef then
                _G.BhopBtnRef:Destroy()
                _G.BhopBtnRef = nil
            end
            _G.BhopActive = false
        end
    end
})

MainTab:CreateSection("Helper")

local TpDownedState = false

local function CreateTpDownedButton()
    if _G.TpDownedBtnRef then
        _G.TpDownedBtnRef:Destroy()
        _G.TpDownedBtnRef = nil
    end
    
    local btn, label, status = CreateGothicButton(
        "TpDownedFloatingButton",
        "TP DOWNED",
        UDim2.new(0.05, 0, 0.7, 0),
        Icons.TpDowned,
        function(btn, label, status)
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then
                return
            end
            
            local nearest = nil
            local nearestDist = math.huge
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local root = player.Character:FindFirstChild("HumanoidRootPart")
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    
                    if root and humanoid and humanoid.Health <= 0 then
                        local dist = (char.HumanoidRootPart.Position - root.Position).Magnitude
                        if dist < nearestDist then
                            nearestDist = dist
                            nearest = player
                        end
                    end
                end
            end
            
            if nearest then
                char.HumanoidRootPart.CFrame = nearest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                Rayfield:Notify({
                    Title = "Thành công",
                    Content = "Đã dịch chuyển đến đồng đội bị thương!",
                    Duration = 3,
                    Image = 4483362458
                })
                status.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                task.wait(0.5)
                status.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            else
                Rayfield:Notify({
                    Title = "Thông báo",
                    Content = "Không tìm thấy đồng đội nào đang bị thương/gục!",
                    Duration = 3,
                    Image = 4483362458
                })
            end
        end
    )
    
    _G.TpDownedBtnRef = btn
    _G.TpDownedLabelRef = label
    _G.TpDownedStatusRef = status
end

MainTab:CreateToggle({
    Name = "Nút Nổi TP Cứu Đồng Đội (TP Downed)",
    CurrentValue = false,
    Flag = "TpDownedToggle",
    Callback = function(value)
        TpDownedState = value
        if value then
            CreateTpDownedButton()
            _G.TpDownedBtnRef.Visible = true
        else
            if _G.TpDownedBtnRef then
                _G.TpDownedBtnRef:Destroy()
                _G.TpDownedBtnRef = nil
            end
        end
    end
})

MainTab:CreateSection("Lag Switch")

_G.LagSwitchSeconds = 2
_G.LagSwitchRunning = false
local LagSwitchToggleState = false

local function CreateLagSwitchButton()
    if _G.LagSwitchBtnRef then
        _G.LagSwitchBtnRef:Destroy()
        _G.LagSwitchBtnRef = nil
    end
    
    local btn, label, status = CreateGothicButton(
        "LagSwitchFloatingButton",
        "LAG SWITCH",
        UDim2.new(0.05, 0, 0.6, 0),
        Icons.LagSwitch,
        function(btn, label, status)
            if _G.LagSwitchRunning then return end
            
            _G.LagSwitchRunning = true
            label.Text = "PAUSED..."
            btn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
            status.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
            
            local duration = _G.LagSwitchSeconds or 2
            local startTime = tick()
            
            task.spawn(function()
                while _G.LagSwitchRunning and tick() - startTime < duration do
                    local sum = 0
                    for i = 1, 20000000 do
                        sum = sum + math.tan(i)
                    end
                    RunService.RenderStepped:Wait()
                end
                
                _G.LagSwitchRunning = false
                label.Text = "LAG SWITCH"
                btn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
                status.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            end)
        end
    )
    
    _G.LagSwitchBtnRef = btn
    _G.LagSwitchLabelRef = label
    _G.LagSwitchStatusRef = status
end

MainTab:CreateToggle({
    Name = "Bật Nút Lag Switch Nổi",
    CurrentValue = false,
    Flag = "LagSwitchToggle",
    Callback = function(value)
        LagSwitchToggleState = value
        if value then
            CreateLagSwitchButton()
            _G.LagSwitchBtnRef.Visible = true
        else
            if _G.LagSwitchBtnRef then
                _G.LagSwitchBtnRef:Destroy()
                _G.LagSwitchBtnRef = nil
            end
            _G.LagSwitchRunning = false
        end
    end
})

MainTab:CreateSlider({
    Name = "Thời Gian Lag (giây)",
    Range = {1, 10},
    Increment = 0.5,
    CurrentValue = 2,
    Flag = "LagSwitchSlider",
    Callback = function(value)
        _G.LagSwitchSeconds = value
    end
})

MainTab:CreateSection("Misc")

_G.AntiAfkActive = false

LocalPlayer.Idled:Connect(function()
    if _G.AntiAfkActive then
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
end)

MainTab:CreateToggle({
    Name = "Chống AFK (Anti AFK)",
    CurrentValue = false,
    Flag = "AntiAfkToggle",
    Callback = function(value)
        _G.AntiAfkActive = value
    end
})

_G.FpsBoostActive = false

local function OptimizePart(part)
    if _G.FpsBoostActive then
        if part:IsA("BasePart") then
            part.Material = Enum.Material.SmoothPlastic
            part.Reflectance = 0
        elseif part:IsA("Decal") or part:IsA("Texture") then
            part.Transparency = 1
        elseif part:IsA("Explosion") then
            part.BlastPressure = 1
            part.BlastRadius = 1
        end
    end
end

local function ApplyFpsBoost()
    for _, obj in ipairs(workspace:GetDescendants()) do
        OptimizePart(obj)
    end
    
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9000000000
    Lighting.Brightness = 2
end

workspace.DescendantAdded:Connect(function(obj)
    if _G.FpsBoostActive then
        OptimizePart(obj)
    end
end)

MainTab:CreateToggle({
    Name = "FPS Boost & Fix Lag Map Mới",
    CurrentValue = false,
    Flag = "FpsBoostToggle",
    Callback = function(value)
        _G.FpsBoostActive = value
        if value then
            ApplyFpsBoost()
        end
    end
})

local VisualTab = Window:CreateTab("Visual", 4483362458)

_G.FullBrightActive = false

VisualTab:CreateToggle({
    Name = "Nhìn Trong Bóng Tối (Siêu Sáng)",
    CurrentValue = false,
    Flag = "BrightToggle",
    Callback = function(value)
        _G.FullBrightActive = value
        if not value then
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end
    end
})

VisualTab:CreateSection("ESP")

_G.EspBodyActive = false
_G.EspBoxActive = false
_G.EspTracerActive = false
_G.EspNameActive = false
_G.EspDownedActive = false

VisualTab:CreateToggle({
    Name = "ESP Highlight Body",
    CurrentValue = false,
    Flag = "EspBodyToggle",
    Callback = function(value)
        _G.EspBodyActive = value
        if not value then
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character then
                    local highlight = player.Character:FindFirstChild("PinHighlight")
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
        end
    end
})

VisualTab:CreateToggle({
    Name = "ESP Tên",
    CurrentValue = false,
    Flag = "EspNameToggle",
    Callback = function(value)
        _G.EspNameActive = value
    end
})

VisualTab:CreateToggle({
    Name = "ESP 2D Box",
    CurrentValue = false,
    Flag = "EspBoxToggle",
    Callback = function(value)
        _G.EspBoxActive = value
    end
})

VisualTab:CreateToggle({
    Name = "ESP Tracer (Dây)",
    CurrentValue = false,
    Flag = "EspTracerToggle",
    Callback = function(value)
        _G.EspTracerActive = value
    end
})

VisualTab:CreateToggle({
    Name = "ESP Đồng Đội Gục (Downed)",
    CurrentValue = false,
    Flag = "EspDownedToggle",
    Callback = function(value)
        _G.EspDownedActive = value
        if not value then
            for _, player in ipairs(Players:GetPlayers()) do
                if espCache[player] and espCache[player].downedTag then
                    espCache[player].downedTag.Visible = false
                end
            end
        end
    end
})

local FarmTab = Window:CreateTab("Farm", 4483362458)

_G.FarmButtonVisible = false
_G.AfkFarmActive = false
_G.AutoItemActive = false
_G.AfkFarmOriginalPos = nil

local function TeleportToGround(hrp)
    if not hrp then return end
    
    hrp.Anchored = false
    if _G.AfkFarmOriginalPos then
        local downPos = _G.AfkFarmOriginalPos - Vector3.new(0, 200, 0)
        local ray = Ray.new(downPos + Vector3.new(0, 10, 0), Vector3.new(0, -50, 0))
        local hit, pos = workspace:FindPartOnRay(ray, LocalPlayer.Character)
        if pos then
            hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
        else
            hrp.CFrame = CFrame.new(downPos)
        end
    end
    _G.AfkFarmOriginalPos = nil
end

local function CreateAfkFarmButton()
    if _G.AfkFarmBtnRef then
        _G.AfkFarmBtnRef:Destroy()
        _G.AfkFarmBtnRef = nil
    end
    
    local btn, label, status = CreateGothicButton(
        "AfkFarmFloatingButton",
        "AFK FARM: OFF",
        UDim2.new(0.05, 0, 0.8, 0),
        Icons.AfkFarm,
        function(btn, label, status)
            _G.AfkFarmActive = not _G.AfkFarmActive
            
            if _G.AfkFarmActive then
                label.Text = "AFK FARM: ON"
                btn.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
                label.TextColor3 = Color3.fromRGB(255, 100, 100)
                status.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        _G.AfkFarmOriginalPos = hrp.Position + Vector3.new(0, 200, 0)
                        hrp.CFrame = CFrame.new(_G.AfkFarmOriginalPos)
                        task.wait(0.1)
                        hrp.Anchored = true
                    end
                end
            else
                label.Text = "AFK FARM: OFF"
                btn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                status.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        TeleportToGround(hrp)
                    end
                end
            end
        end
    )
    
    _G.AfkFarmBtnRef = btn
    _G.AfkFarmLabelRef = label
    _G.AfkFarmStatusRef = status
end

local function CreateAutoItemButton()
    if _G.AutoItemBtnRef then
        _G.AutoItemBtnRef:Destroy()
        _G.AutoItemBtnRef = nil
    end
    
    local btn, label, status = CreateGothicButton(
        "AutoItemFloatingButton",
        "AUTO ITEM: OFF",
        UDim2.new(0.05, 0, 0.88, 0),
        Icons.AutoItem,
        function(btn, label, status)
            _G.AutoItemActive = not _G.AutoItemActive
            
            if _G.AutoItemActive then
                label.Text = "AUTO ITEM: ON"
                btn.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
                label.TextColor3 = Color3.fromRGB(255, 100, 100)
                status.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            else
                label.Text = "AUTO ITEM: OFF"
                btn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                status.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
            end
        end
    )
    
    _G.AutoItemBtnRef = btn
    _G.AutoItemLabelRef = label
    _G.AutoItemStatusRef = status
end

local function isPlayerAsset(instance)
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and instance:IsDescendantOf(player.Character) then
            return true
        end
    end
    return false
end

local function getAllItems()
    local items = {}
    for _, v in pairs(workspace:GetDescendants()) do
        if (v:IsA("BasePart") or v:IsA("Model")) then
            local nameLower = string.lower(v.Name)
            if string.find(nameLower, "bubble") or string.find(nameLower, "coconut") then
                local isVisualEffect = v:FindFirstChildWhichIsA("ParticleEmitter") 
                                    or v:FindFirstChildWhichIsA("Trail") 
                                    or v:FindFirstChildWhichIsA("Beam")
                                    or v.ClassName == "Accessory"
                local hasAnimation = v:FindFirstChildWhichIsA("Animation") or v:FindFirstChildWhichIsA("Animator")
                
                if not isVisualEffect and not hasAnimation and not isPlayerAsset(v) then
                    local part = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")
                    if part then
                        table.insert(items, part)
                    end
                end
            end
        end
    end
    return items
end

local function isNextbotNear(position)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:GetAttribute("Nextbot") == true then
            local root = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart")
            if root then
                local distance = (position - root.Position).Magnitude
                if distance <= 12 then 
                    return true
                end
            end
        end
    end
    return false
end

local function getClosestSafeItem(hrp, items)
    local closest, minDst = nil, math.huge
    for _, part in ipairs(items) do
        local dst = (hrp.Position - part.Position).Magnitude
        if dst < minDst and not isNextbotNear(part.Position) then
            closest = part
            minDst = dst
        end
    end
    return closest
end

local function teleportTo(hrp, pos, duration)
    local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
    tween:Play()
    tween.Completed:Wait()
end

local noItemTimer = 0

task.spawn(function()
    while true do
        task.wait(0.5)
        
        local char = LocalPlayer.Character
        if not char then 
            task.wait(1)
            continue 
        end
        
        local isDowned = char:GetAttribute("Downed")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then 
            task.wait(1)
            continue 
        end
        
        local items = getAllItems()
        
        if _G.AfkFarmActive and not isDowned then
            if #items == 0 then
                noItemTimer = noItemTimer + 0.5
                if noItemTimer >= 20 then
                    _G.AfkFarmActive = false
                    if _G.AfkFarmBtnRef then
                        local label = _G.AfkFarmBtnRef:FindFirstChild("ButtonText")
                        local status = _G.AfkFarmBtnRef:FindFirstChild("StatusIndicator")
                        if label then
                            label.Text = "AFK FARM: OFF"
                        end
                        _G.AfkFarmBtnRef.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
                        if status then
                            status.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                        end
                    end
                    TeleportToGround(hrp)
                    noItemTimer = 0
                end
            else
                noItemTimer = 0
                if hrp.Anchored == false then
                    local pos = hrp.Position + Vector3.new(0, 200, 0)
                    hrp.CFrame = CFrame.new(pos)
                    task.wait(0.1)
                    hrp.Anchored = true
                end
            end
        end
        
        if _G.AutoItemActive and not isDowned and #items > 0 then
            local item = getClosestSafeItem(hrp, items)
            if item then
                local startPos = hrp.Position
                hrp.Anchored = false
                
                teleportTo(hrp, item.Position, 0.2)
                
                pcall(function()
                    local collectId = item.Parent:GetAttribute("Id") or item:GetAttribute("Id") or "a19ac91bff904b7385e826fd6a23dc01"
                    ReplicatedStorage.Events.Collectibles.Invoke:InvokeServer(LocalPlayer, collectId, "Collect")
                end)
                
                task.wait(0.5)
                
                if _G.AfkFarmActive and _G.AfkFarmOriginalPos then
                    teleportTo(hrp, _G.AfkFarmOriginalPos, 0.2)
                    hrp.Anchored = true
                else
                    teleportTo(hrp, startPos, 0.2)
                end
            end
        end
    end
end)

FarmTab:CreateToggle({
    Name = "Hiện Nút Nổi Farm (AFK Farm + Auto Item)",
    CurrentValue = false,
    Flag = "FarmButtonVisible",
    Callback = function(value)
        _G.FarmButtonVisible = value
        
        if value then
            CreateAfkFarmButton()
            _G.AfkFarmBtnRef.Visible = true
            
            CreateAutoItemButton()
            _G.AutoItemBtnRef.Visible = true
            
        else
            if _G.AfkFarmBtnRef then
                _G.AfkFarmBtnRef:Destroy()
                _G.AfkFarmBtnRef = nil
                _G.AfkFarmActive = false
                
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        TeleportToGround(hrp)
                    end
                end
            end
            
            if _G.AutoItemBtnRef then
                _G.AutoItemBtnRef:Destroy()
                _G.AutoItemBtnRef = nil
                _G.AutoItemActive = false
            end
           
        end
    end
})

LocalPlayer.CharacterAdded:Connect(function(char)
    char:GetAttributeChangedSignal("Downed"):Connect(function()
        local isDowned = char:GetAttribute("Downed")
        
        if isDowned then
            _G.AfkFarmActive = false
            _G.AutoItemActive = false
            
            if _G.AfkFarmBtnRef then
                local label = _G.AfkFarmBtnRef:FindFirstChild("ButtonText")
                local status = _G.AfkFarmBtnRef:FindFirstChild("StatusIndicator")
                if label then
                    label.Text = "AFK FARM: OFF"
                end
                _G.AfkFarmBtnRef.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
                if status then
                    status.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                end
            end
            
            if _G.AutoItemBtnRef then
                local label = _G.AutoItemBtnRef:FindFirstChild("ButtonText")
                local status = _G.AutoItemBtnRef:FindFirstChild("StatusIndicator")
                if label then
                    label.Text = "AUTO ITEM: OFF"
                end
                _G.AutoItemBtnRef.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
                if status then
                    status.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                end
            end
            
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                TeleportToGround(hrp)
            end
        end
    end)
end)

local SettingsTab = Window:CreateTab("Cài Đặt Nút", 4483362458)

SettingsTab:CreateSection("Tùy Chỉnh Nút Nổi")

SettingsTab:CreateSlider({
    Name = "Chiều Rộng Nút (Width)",
    Range = {50, 300},
    Increment = 5,
    CurrentValue = 140,
    Flag = "BtnWidthSlider",
    Callback = function(value)
        _G.ButtonWidth = value
        UpdateButtonSizes()
    end
})

SettingsTab:CreateSlider({
    Name = "Chiều Cao Nút (Height)",
    Range = {20, 100},
    Increment = 5,
    CurrentValue = 40,
    Flag = "BtnHeightSlider",
    Callback = function(value)
        _G.ButtonHeight = value
        UpdateButtonSizes()
    end
})

SettingsTab:CreateSlider({
    Name = "Độ Mờ Nút (Transparency)",
    Range = {0, 1},
    Increment = 0.05,
    CurrentValue = 0.65,
    Flag = "BtnTransparencySlider",
    Callback = function(value)
        _G.ButtonTransparency = value
        UpdateButtons()
    end
})

local InfoTab = Window:CreateTab("Info", 4483362458)

InfoTab:CreateSection("Thông Tin & Tác Giả")

InfoTab:CreateParagraph({
    Title = "EVADE HUB V1",
    Content = [[
• Tác giả: NHẠC T HUB
• Tính năng: Chạy nhanh, Nhảy cao, Moon Gravity, Auto Jump, BHop Strafe, Lag Switch, ESP Downed Players, Nút nổi TP Cứu Đồng Đội, Thanh kéo chỉnh kích thước/độ mờ nút, Anti AFK, FPS Boost & ESP Player.
    ]]
})

InfoTab:CreateButton({
    Name = "Sao Chép TikTok NHẠC T HUB (@nht.hub)",
    Callback = function()
        setclipboard("https://www.tiktok.com/@nht.hub")
        Rayfield:Notify({
            Title = "Thành công",
            Content = "Đã sao chép link TikTok NHẠC T HUB!",
            Duration = 3,
            Image = 4483362458
        })
    end
})

InfoTab:CreateButton({
    Name = "Sao Chép TikTok NHẠC T HUB 2 (@quyh935)",
    Callback = function()
        setclipboard("https://www.tiktok.com/@quyh935")
        Rayfield:Notify({
            Title = "Thành công",
            Content = "Đã sao chép link TikTok NHẠC T HUB 2!",
            Duration = 3,
            Image = 4483362458
        })
    end
})

InfoTab:CreateButton({
    Name = "Sao Chép Link Tham Gia Messenger",
    Callback = function()
        setclipboard("https://m.me/j/AbYnZEmU6n4ctgyF/")
        Rayfield:Notify({
            Title = "Thành công",
            Content = "Đã sao chép link Messenger!",
            Duration = 3,
            Image = 4483362458
        })
    end
})

InfoTab:CreateButton({
    Name = "Sao Chép Link Tham Gia Discord",
    Callback = function()
        setclipboard("https://discord.com/invite/26K3VWgP9X")
        Rayfield:Notify({
            Title = "Thành công",
            Content = "Đã sao chép link Discord!",
            Duration = 3,
            Image = 4483362458
        })
    end
})

function UpdateButtons()
    local btnRefs = {
        _G.MoonBtnRef,
        _G.AutoJumpBtnRef,
        _G.BhopBtnRef,
        _G.LagSwitchBtnRef,
        _G.TpDownedBtnRef,
        _G.AfkFarmBtnRef,
        _G.AutoItemBtnRef
    }
    
    for _, btn in ipairs(btnRefs) do
        if btn then
            btn.BackgroundTransparency = _G.ButtonTransparency or 0.65
            local stroke = btn:FindFirstChild("UIStroke")
            if stroke then
                stroke.Thickness = 2.5
                stroke.Color = Color3.fromRGB(200, 0, 0)
            end
        end
    end
end

function UpdateButtonSizes()
    local btnRefs = {
        _G.MoonBtnRef,
        _G.AutoJumpBtnRef,
        _G.BhopBtnRef,
        _G.LagSwitchBtnRef,
        _G.TpDownedBtnRef,
        _G.AfkFarmBtnRef,
        _G.AutoItemBtnRef
    }
    
    for _, btn in ipairs(btnRefs) do
        if btn then
            btn.Size = UDim2.new(0, _G.ButtonWidth or 140, 0, _G.ButtonHeight or 40)
        end
    end
end

RunService.RenderStepped:Connect(function()
    if _G.FullBrightActive then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    end
end)

local espCache = {}

Players.PlayerRemoving:Connect(function(player)
    if espCache[player] then
        for _, obj in pairs(espCache[player]) do
            if typeof(obj) == "Instance" then
                obj:Destroy()
            elseif type(obj) == "table" and obj.Remove then
                pcall(function() obj:Remove() end)
            end
        end
        espCache[player] = nil
    end
end)

local bhopAngle = 0

RunService.RenderStepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        
        if not rootPart or not humanoid then return end
        
        if _G.MoonActive then
            workspace.Gravity = 35
        end
        
        if _G.AutoJumpActive and humanoid.FloorMaterial ~= Enum.Material.Air then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        
        if _G.BhopActive then
            if humanoid.FloorMaterial ~= Enum.Material.Air then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
            
            bhopAngle = (bhopAngle + 0.15) % (math.pi * 2)
            local camera = workspace.CurrentCamera
            if camera then
                rootPart.Velocity = rootPart.Velocity + camera.CFrame.RightVector * math.sin(bhopAngle) * 0.4 * 15
            end
        end
        
        if _G.JumpActive then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = _G.JumpVal
        end
        
        local speedBV = rootPart:FindFirstChild("PinRunBV")
        local speedBG = rootPart:FindFirstChild("PinRunBG")
        
        if _G.SpeedActive then
            humanoid.PlatformStand = true
            
            if not speedBV then
                speedBV = Instance.new("BodyVelocity")
                speedBV.Name = "PinRunBV"
                speedBV.MaxForce = Vector3.new(math.huge, 0, math.huge)
                speedBV.Parent = rootPart
            end
            
            if not speedBG then
                speedBG = Instance.new("BodyGyro")
                speedBG.Name = "PinRunBG"
                speedBG.MaxTorque = Vector3.new(0, math.huge, 0)
                speedBG.Parent = rootPart
            end
            
            local moveDir = humanoid.MoveDirection
            if moveDir.Magnitude > 0 then
                speedBV.Velocity = moveDir * _G.SpeedVal
                speedBG.CFrame = CFrame.new(Vector3.new(), moveDir)
            else
                speedBV.Velocity = Vector3.new(0, 0, 0)
            end
        else
            if speedBV then speedBV:Destroy() end
            if speedBG then speedBG:Destroy() end
            humanoid.PlatformStand = false
        end
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if not espCache[player] then
                    espCache[player] = {}
                end
                
                local pChar = player.Character
                if pChar then
                    local pRoot = pChar:FindFirstChild("HumanoidRootPart")
                    local pHumanoid = pChar:FindFirstChildOfClass("Humanoid")
                    
                    if pRoot and pHumanoid then
                        if _G.EspBodyActive then
                            local highlight = pChar:FindFirstChild("PinHighlight")
                            if not highlight then
                                highlight = Instance.new("Highlight")
                                highlight.Name = "PinHighlight"
                                highlight.FillColor = Color3.fromRGB(0, 150, 255)
                                highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                                highlight.OutlineTransparency = 0
                                highlight.Parent = pChar
                            else
                                highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                            end
                        else
                            local highlight = pChar:FindFirstChild("PinHighlight")
                            if highlight then
                                highlight:Destroy()
                            end
                        end
                        
                        local camera = workspace.CurrentCamera
                        local pos, onScreen = camera:WorldToViewportPoint(pRoot.Position)
                        
                        if onScreen then
                            local dist = (rootPart.Position - pRoot.Position).Magnitude
                            
                            if _G.EspNameActive then
                                if not espCache[player].nameTag then
                                    local tag = Drawing.new("Text")
                                    tag.Size = 16
                                    tag.Center = true
                                    tag.Outline = true
                                    tag.OutlineColor = Color3.fromRGB(0, 0, 0)
                                    tag.Color = Color3.fromRGB(255, 255, 0)
                                    espCache[player].nameTag = tag
                                end
                                
                                espCache[player].nameTag.Visible = true
                                espCache[player].nameTag.Text = "[" .. math.floor(dist) .. "m] " .. player.Name
                                espCache[player].nameTag.Position = Vector2.new(pos.X, pos.Y - 45)
                            else
                                if espCache[player].nameTag then
                                    espCache[player].nameTag.Visible = false
                                end
                            end
                            
                            if _G.EspTracerActive then
                                if not espCache[player].tracer then
                                    local tracer = Drawing.new("Line")
                                    tracer.Thickness = 1.5
                                    tracer.Color = Color3.fromRGB(0, 255, 255)
                                    espCache[player].tracer = tracer
                                end
                                
                                espCache[player].tracer.Visible = true
                                espCache[player].tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                                espCache[player].tracer.To = Vector2.new(pos.X, pos.Y)
                            else
                                if espCache[player].tracer then
                                    espCache[player].tracer.Visible = false
                                end
                            end
                            
                            if _G.EspBoxActive then
                                if not espCache[player].box then
                                    local box = Drawing.new("Square")
                                    box.Thickness = 1.5
                                    box.Filled = false
                                    box.Color = Color3.fromRGB(0, 255, 0)
                                    espCache[player].box = box
                                end
                                
                                espCache[player].box.Visible = true
                                local size = Vector2.new(2500 / pos.Z, 3500 / pos.Z)
                                espCache[player].box.Size = size
                                espCache[player].box.Position = Vector2.new(pos.X - size.X / 2, pos.Y - size.Y / 2)
                            else
                                if espCache[player].box then
                                    espCache[player].box.Visible = false
                                end
                            end
                        else
                            if espCache[player].nameTag then espCache[player].nameTag.Visible = false end
                            if espCache[player].tracer then espCache[player].tracer.Visible = false end
                            if espCache[player].box then espCache[player].box.Visible = false end
                        end
                        
                        if _G.EspDownedActive and pHumanoid.Health <= 0 then
                            local camera = workspace.CurrentCamera
                            local pos2, onScreen2 = camera:WorldToViewportPoint(pRoot.Position)
                            if onScreen2 then
                                if not espCache[player].downedTag then
                                    local tag = Drawing.new("Text")
                                    tag.Size = 18
                                    tag.Center = true
                                    tag.Outline = true
                                    tag.OutlineColor = Color3.fromRGB(0, 0, 0)
                                    tag.Color = Color3.fromRGB(255, 50, 50)
                                    espCache[player].downedTag = tag
                                end
                                
                                espCache[player].downedTag.Visible = true
                                espCache[player].downedTag.Text = "[CẦN CỨU!] " .. player.Name .. " (" .. math.floor((rootPart.Position - pRoot.Position).Magnitude) .. "m)"
                                espCache[player].downedTag.Position = Vector2.new(pos2.X, pos2.Y - 25)
                            else
                                if espCache[player].downedTag then
                                    espCache[player].downedTag.Visible = false
                                end
                            end
                        else
                            if espCache[player].downedTag then
                                espCache[player].downedTag.Visible = false
                            end
                        end
                    end
                end
            end
        end
    end)
end)

task.spawn(function()
    local gui = LocalPlayer:WaitForChild("PlayerGui")
    local done = false
    
    while not done do
        task.wait(0.2)
        pcall(function()
            for _, obj in ipairs(gui:GetDescendants()) do
                if obj:IsA("TextLabel") and obj.Text == "PIN EVADE HUB V1" then
                    local frame = obj.Parent
                    if frame then
                        frame.Size = UDim2.new(1, 0, 0, 95)
                        obj.Position = UDim2.new(0, 90, 0, 10)
                        obj.Size = UDim2.new(1, -100, 0, 20)
                        
                        for _, child in ipairs(frame:GetChildren()) do
                            if child:IsA("TextLabel") and child ~= obj then
                                child.Position = UDim2.new(0, 90, 0, 32)
                                child.Size = UDim2.new(1, -100, 0, 55)
                            end
                        end
                        
                        local icon = Instance.new("ImageLabel")
                        icon.Name = "PinInfoSquareImg"
                        icon.Size = UDim2.new(0, 70, 0, 70)
                        icon.Position = UDim2.new(0, 10, 0.5, -35)
                        icon.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        icon.Image = Icons.Info
                        icon.ScaleType = Enum.ScaleType.Fit
                        icon.Parent = frame
                        
                        local corner = Instance.new("UICorner")
                        corner.CornerRadius = UDim.new(0, 8)
                        corner.Parent = icon
                        
                        done = true
                    end
                end
            end
        end)
    end
end)

print("script loaded")
print("nhat was here :)")
