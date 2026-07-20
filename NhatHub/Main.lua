--[[
    .-------------------------------------------------------------------------------------------------.
    |  NHẬT░HUB░SUPREME░V920 (GOTHIC EDITION)                             |
    |  RESTORED ALL: GHOST VIP - KILL ALL - EMOTES - VISUALS.              |
    |          PHÍM Q/Z - AIM BODY/HEAD - NEW ANTI FLING                   |
    |          + TELE SẢNH + TELE MAP + TIẾT LỘ ID                        |
    |          + SHOOT MURDER NỘI BỘ + PREDICTION + PHÍM TẮT              |
    |          + ESP BAO BỌC + ESP DÂY + ESP RIÊNG MUR/SHEFF              |
    |          + GHOST V162 (PIN) + GOTHIC UI + ICONS                     |
    |          + FIX LAG NỘI BỘ (HIỆU ỨNG NGAY) + ZINDEX FIXED           |
    |          + NO EMOJI - CHỈ CHỮ + ICON ID                             |
    |          + ANTI-FLING MỚI (THAY TOYOTA HUB)                        |
    |          + FOV CUSTOM + AUTO KILL SHERIFF                          |
    |          + AUTO KILL TELE + TELE KILL ALL SERVER                   |
    |          + ESP SÚNG RƠI + SPECTATE SYSTEM                          |
    |          + NAMETAG ESP + TRACER ESP                               |
    |          + FLY SYSTEM (CHỈ FLY, KHÔNG CAN THIỆP WALK/RUN)         |
    |          + SPEED/JUMP TOGGLE FIXED                                |
    '--------------------------------------------------------------------------------------------------'
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Cam = workspace.CurrentCamera
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

-- [[ 1. INTRO ]]
local ig = Instance.new("ScreenGui", CoreGui)
ig.Name = "NhatHubIntro"
ig.ResetOnSpawn = false

local frame = Instance.new("Frame", ig)
frame.Size = UDim2.new(0, 0, 0, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
frame.BackgroundTransparency = 0.2
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(150, 30, 30)
stroke.Thickness = 2

local icon = Instance.new("ImageLabel", frame)
icon.Size = UDim2.new(0, 40, 0, 40)
icon.Position = UDim2.new(0, 20, 0.5, -20)
icon.BackgroundTransparency = 1
icon.Image = ""
icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
icon.ZIndex = 2

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1, -80, 1, 0)
txt.Position = UDim2.new(0, 70, 0, 0)
txt.Text = ""
txt.TextColor3 = Color3.fromRGB(255, 255, 255)
txt.TextSize = 28
txt.Font = Enum.Font.GothamBold
txt.BackgroundTransparency = 1
txt.TextTransparency = 1
txt.TextXAlignment = Enum.TextXAlignment.Left

local function showIntroText(iconId, text, color, duration)
    TweenService:Create(icon, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ImageTransparency = 1
    }):Play()
    TweenService:Create(txt, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play()
    
    task.wait(0.3)

    icon.Image = "rbxassetid://" .. iconId
    icon.ImageTransparency = 1
    icon.ImageColor3 = color
    
    txt.Text = text
    txt.TextColor3 = color
    txt.TextTransparency = 1

    TweenService:Create(icon, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 0
    }):Play()
    TweenService:Create(txt, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()

    task.wait(duration)
end

TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 500, 0, 120)
}):Play()

task.wait(0.4)

task.spawn(function()
    showIntroText("10747373176", " NHẬT HUB", Color3.fromRGB(200, 50, 50), 1.2)
    showIntroText("14260707709", " Script Murder Mystery 2", Color3.fromRGB(255, 100, 100), 1.2)
    showIntroText("10723434070", " Loading Script...", Color3.fromRGB(255, 255, 255), 1.5)
    showIntroText("10709790644", " Loaded Successful !", Color3.fromRGB(0, 128, 0), 1)

    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    task.wait(0.5)
    ig:Destroy()
end)

task.wait(5.5)

-- [[ 2. MENU SETUP ]]
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/Awesome-UI-Libraries/refs/heads/main/VenyxUI/source.lua"))()
local Venyx = Library.new("NHẬT HUB - MM2", "Gothic Edition")
local sg = Instance.new("ScreenGui", CoreGui); sg.Name = "NhatHub_V920"
local tBtn = Instance.new("ImageButton", sg); tBtn.Size = UDim2.new(0, 55, 0, 55); tBtn.Position = UDim2.new(0, 15, 0, 15)
tBtn.BackgroundColor3 = Color3.new(0,0,0); tBtn.Image = "rbxassetid://14260707709"; Instance.new("UICorner", tBtn)

tBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v:FindFirstChild("Main") then v.Enabled = not v.Enabled end
    end
end)

-- CÁC TAB
local pTab = Venyx:addPage("Player", 10747373176)
local kTab = Venyx:addPage("Combat", 10734975486)
local aTab = Venyx:addPage("SHOOT MURDER", 139192589041315)
local tTab = Venyx:addPage("Teleport", 10723434236)
local rTab = Venyx:addPage("Reveal", 138528222906635)
local fTab = Venyx:addPage("Farm", 10709811110)
local iTab = Venyx:addPage("Fix lag", 130551565616516)
local vTab = Venyx:addPage("Visuals", 10723346959)
local sTab = Venyx:addPage("System", 10734896881)
local mTab = Venyx:addPage("Music", 10734905958)

-- ===== BIẾN TOÀN CỤC =====
_G.SilentAim = false; _G.AutoShoot = false; _G.AimPart = "UpperTorso"
_G.AntiFling = false; _G.ESP = false; _G.ESP_Tracer = false; _G.ESP_Name = false; _G.ESPGun = false
_G.Speed = 16; _G.JumpPower = 50
_G.SpeedToggle = false; _G.JumpToggle = false
_G.Noclip = false; _G.Xray = false
_G.AutoKillAll = false; _G.InfiniteJump = false
_G.ExpandHitbox = false
_G.HitboxSize = 8
_G.AutoFarmCoin = false
_G.FarmSpeed = 50
_G.AutoGetGun = false
_G.AutoWallhop = false
_G.GhostEnabled = false
_G.GhostKeybind = Enum.KeyCode.G
_G.MurKeybind = Enum.KeyCode.Q
_G.ShefKeybind = Enum.KeyCode.Z
_G.ShootMurderKey = Enum.KeyCode.R
_G.ShootPrediction = 0.2
_G.PinFarm = false
_G.ShowFPSPing = true
_G.FOVToggle = false
_G.FOVValue = 70
_G.AutoKillSheriff = false
_G.AutoKillTele = false
_G.TeleKillAll = false
_G.SpecMurder = false
_G.SpecSheriff = false

-- Biến auto tiết lộ
_G.AutoRevealMurder = false
_G.AutoRevealSheriff = false
_G.AutoRevealBoth = false

-- Hàm gửi chat
local function SayToServer(text)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local textChannel = TextChatService.TextChannels.RBXGeneral
            textChannel:SendAsync(text)
        else
            local SayMessageEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
            if SayMessageEvent then SayMessageEvent:FireServer(text, "All") end
        end
    end)
end

-- Hàm tìm Mur & Sheff
local function findMurderAndSheriff()
    local mur = nil
    local sheff = nil
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local isM = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
            local isS = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
            if isM then mur = p end
            if isS then sheff = p end
        end
    end
    return mur, sheff
end

-- Hàm tìm tên Murder
local function findMurderName()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then return p.Name end
    end
    return nil
end

-- ===================================================================
-- [[ 3. CODE NHẢY VÔ HẠN ]]
-- ===================================================================
UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

-- ===================================================================
-- [[ 4. TAB PLAYER ]]
-- ===================================================================

-- === GHOST V162 ===
_G.GhostEnabled = false
_G.GhostKeybind = Enum.KeyCode.G

local GhostData = {
    IsActive = false,
    FakeChar = nil,
    SkyPos = Vector3.new(0, 1000, 0), -- Đã giảm từ 15000 xuống 1000
    FakeCharName = "Ghost_Pin_V162_" .. tostring(math.random(1000, 9999))
}

local function SetTransparency(char, trans)
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v.Transparency = trans
        end
    end
end

local function Ghost_Toggle()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")

    if not char or not hrp or not hum then return end

    if not _G.GhostEnabled then
        if GhostData.IsActive then
            RunService:UnbindFromRenderStep("GhostLogic")

            if GhostData.FakeChar then
                hrp.Velocity = Vector3.new(0, 0, 0)
                hrp.CFrame = GhostData.FakeChar.HumanoidRootPart.CFrame
                hrp.Anchored = true; task.wait(0.1); hrp.Anchored = false
                SetTransparency(char, 0)
                Cam.CameraSubject = hum
                GhostData.FakeChar:Destroy()
                GhostData.FakeChar = nil
            end
            GhostData.IsActive = false

            local keyName = _G.GhostKeybind.Name:gsub("KeyCode%.", "")
            ghostBtn.Text = "  GHOST [" .. keyName .. "]"
            ghostBtn.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
            ghostBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
            ghostStroke.Color = Color3.fromRGB(150, 30, 30)
        end
        return
    end

    GhostData.IsActive = not GhostData.IsActive

    if GhostData.IsActive then
        -- Tạo xác giả
        char.Archivable = true
        GhostData.FakeChar = char:Clone()
        GhostData.FakeChar.Parent = workspace
        GhostData.FakeChar.Name = GhostData.FakeCharName
        SetTransparency(GhostData.FakeChar, 0.5)
        GhostData.FakeChar.HumanoidRootPart.CanCollide = false

        -- Ẩn xác thật
        SetTransparency(char, 1)
        Cam.CameraSubject = GhostData.FakeChar.Humanoid

        RunService:BindToRenderStep("GhostLogic", 201, function()
            if not GhostData.IsActive or not GhostData.FakeChar then return end

            if Cam.CameraSubject ~= GhostData.FakeChar.Humanoid then
                Cam.CameraSubject = GhostData.FakeChar.Humanoid
            end

            local tool = char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
            local lookDir = Cam.CFrame.LookVector
            local flatLookDir = Vector3.new(lookDir.X, 0, lookDir.Z).Unit

            if tool then
                -- Cầm tool: Tele về + xoay theo Cam
                hrp.CFrame = CFrame.new(GhostData.FakeChar.HumanoidRootPart.Position, GhostData.FakeChar.HumanoidRootPart.Position + flatLookDir)
                hrp.Velocity = Vector3.new(0, 0, 0)
                SetTransparency(char, 0)
                ghostStroke.Color = Color3.fromRGB(255, 0, 0)
            else
                -- Không tool: Bay lên trời + tàng hình
                hrp.CFrame = CFrame.new(GhostData.SkyPos.X, GhostData.SkyPos.Y, GhostData.SkyPos.Z) * CFrame.Angles(0, math.atan2(-flatLookDir.X, -flatLookDir.Z), 0)
                hrp.Velocity = Vector3.new(0, 0, 0)
                SetTransparency(char, 1)
                ghostStroke.Color = Color3.fromRGB(0, 255, 0)
            end

            -- Đồng bộ xoay xác giả
            GhostData.FakeChar.HumanoidRootPart.CFrame = CFrame.new(GhostData.FakeChar.HumanoidRootPart.Position, GhostData.FakeChar.HumanoidRootPart.Position + flatLookDir)
            GhostData.FakeChar.Humanoid:Move(hum.MoveDirection)
            if hum.Jump then GhostData.FakeChar.Humanoid.Jump = true end
        end)

        local keyName = _G.GhostKeybind.Name:gsub("KeyCode%.", "")
        ghostBtn.Text = "  GHOST: ON [" .. keyName .. "]"
        ghostBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
        ghostBtn.TextColor3 = Color3.fromRGB(255, 50, 50)

    else
        RunService:UnbindFromRenderStep("GhostLogic")

        if GhostData.FakeChar then
            hrp.Velocity = Vector3.new(0, 0, 0)
            hrp.CFrame = GhostData.FakeChar.HumanoidRootPart.CFrame
            hrp.Anchored = true; task.wait(0.1); hrp.Anchored = false
            SetTransparency(char, 0)
            Cam.CameraSubject = hum
            GhostData.FakeChar:Destroy()
            GhostData.FakeChar = nil
        end

        local keyName = _G.GhostKeybind.Name:gsub("KeyCode%.", "")
        ghostBtn.Text = "  GHOST [" .. keyName .. "]"
        ghostBtn.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
        ghostBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
        ghostStroke.Color = Color3.fromRGB(150, 30, 30)
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == _G.GhostKeybind and _G.GhostEnabled then
        Ghost_Toggle()
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    if _G.GhostEnabled and GhostData.IsActive then
        GhostData.IsActive = false
        task.wait(0.5)
        Ghost_Toggle()
    end
end)

-- === PLAYER OPTIONS ===
local pSec = pTab:addSection("Player Options")

-- Toggle Ghost
local ghostToggle = pSec:addToggle("Ghost", false, function(t)
    _G.GhostEnabled = t
    Ghost_Toggle()
end)

-- Keybind Ghost
local ghostKeybind = pSec:addKeybind("Phím tắt Ghost", Enum.KeyCode.G, function(key)
    _G.GhostKeybind = key
    local keyName = key.Name:gsub("KeyCode%.", "")
    ghostBtn.Text = "  GHOST [" .. keyName .. "]"
end)

-- Nút Ghost Gothic + Icon
local ghostBtn = Instance.new("TextButton", sg)
ghostBtn.Size = UDim2.new(0, 140, 0, 45)
ghostBtn.Position = UDim2.new(0.02, 0, 0.3, 0)
ghostBtn.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
ghostBtn.BackgroundTransparency = 0.15
ghostBtn.Text = "  GHOST "
ghostBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
ghostBtn.Font = Enum.Font.GothamBold
ghostBtn.TextSize = 12
ghostBtn.Draggable = true
ghostBtn.Active = true
ghostBtn.Visible = false
Instance.new("UICorner", ghostBtn).CornerRadius = UDim.new(0, 8)

local ghostStroke = Instance.new("UIStroke", ghostBtn)
ghostStroke.Color = Color3.fromRGB(150, 30, 30)
ghostStroke.Thickness = 2
ghostStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Icon cho Ghost
local ghostIcon = Instance.new("ImageLabel", ghostBtn)
ghostIcon.Size = UDim2.new(0, 20, 0, 20)
ghostIcon.Position = UDim2.new(0, 6, 0.5, -10)
ghostIcon.BackgroundTransparency = 1
ghostIcon.Image = "rbxassetid://10723396107"
ghostIcon.ImageColor3 = Color3.fromRGB(200, 50, 50)
ghostIcon.ZIndex = 2

ghostBtn.MouseEnter:Connect(function()
    TweenService:Create(ghostBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30, 0, 0),
        TextColor3 = Color3.fromRGB(255, 80, 80)
    }):Play()
    TweenService:Create(ghostStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(255, 50, 50),
        Thickness = 3
    }):Play()
end)

ghostBtn.MouseLeave:Connect(function()
    TweenService:Create(ghostBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(15, 0, 0),
        TextColor3 = Color3.fromRGB(200, 50, 50)
    }):Play()
    TweenService:Create(ghostStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(150, 30, 30),
        Thickness = 2
    }):Play()
end)

ghostBtn.MouseButton1Click:Connect(function()
    _G.GhostEnabled = not _G.GhostEnabled
    Ghost_Toggle()

    local keyName = _G.GhostKeybind.Name:gsub("KeyCode%.", "")
    if _G.GhostEnabled then
        ghostBtn.Text = "  GHOST: ON [" .. keyName .. "]"
        ghostBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
        ghostBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
        ghostStroke.Color = Color3.fromRGB(255, 0, 0)
    else
        ghostBtn.Text = "  GHOST [" .. keyName .. "]"
        ghostBtn.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
        ghostBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
        ghostStroke.Color = Color3.fromRGB(150, 30, 30)
    end
end)

pSec:addToggle("Hiện nút Ghost trên màn hình", false, function(t)
    ghostBtn.Visible = t
end)

-- === SPEED & JUMP (SLIDER + TOGGLE) ===
local speedSec = pTab:addSection("Movement")

-- Biến lưu trạng thái
_G.SpeedToggle = false
_G.JumpToggle = false

-- Toggle tốc độ
speedSec:addToggle("Bật chỉnh tốc độ", false, function(t)
    _G.SpeedToggle = t
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        if t then
            char.Humanoid.WalkSpeed = _G.Speed
        else
            char.Humanoid.WalkSpeed = 16 -- Mặc định
        end
    end
end)

-- Slider tốc độ
local speedSlider = speedSec:addSlider("Tốc độ chạy", 16, 1, 500, function(val)
    _G.Speed = math.floor(val)
    if _G.SpeedToggle then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = _G.Speed
            end
        end)
    end
end)

-- Toggle nhảy cao
speedSec:addToggle("Bật chỉnh nhảy cao", false, function(t)
    _G.JumpToggle = t
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        if t then
            char.Humanoid.JumpPower = _G.JumpPower
        else
            char.Humanoid.JumpPower = 50 -- Mặc định
        end
    end
end)

-- Slider nhảy cao (đã sửa logic)
local jumpSlider = speedSec:addSlider("Nhảy cao", 50, 1, 500, function(val)
    _G.JumpPower = math.floor(val)
    if _G.JumpToggle then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.JumpPower = _G.JumpPower
            end
        end)
    end
end)

-- Vòng lặp duy trì chỉ số (chỉ chạy khi toggle bật)
coroutine.wrap(function()
    while task.wait(0.3) do
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    if _G.SpeedToggle then
                        hum.WalkSpeed = _G.Speed
                    end
                    if _G.JumpToggle then
                        hum.JumpPower = _G.JumpPower
                    end
                end
            end
        end)
    end
end)()

-- === WALLHOP ===
local wallhopSec = pTab:addSection("Wallhop")
wallhopSec:addToggle("Wallhop (Nhảy bám tường + quay 180 độ)", false, function(t)
    _G.AutoWallhop = t
    if t then
        coroutine.wrap(function()
            while _G.AutoWallhop do
                pcall(function()
                    local char = LocalPlayer.Character
                    if char then
                        local hum = char:FindFirstChild("Humanoid")
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hum and hrp then
                            local ray = Ray.new(hrp.Position, hrp.CFrame.LookVector * 3.5)
                            local part, pos = workspace:FindPartOnRay(ray, char)
                            
                            if part then
                                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(180), 0)
                                task.wait(0.05)
                                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                            end
                        end
                    end
                end)
                task.wait(0.12)
            end
        end)()
    end
end)

-- === INFINITE JUMP ===
local jumpSec = pTab:addSection("Infinite Jump")
jumpSec:addToggle("Nhảy vô hạn", false, function(t)
    _G.InfiniteJump = t
end)

-- === HITBOX (SLIDER) ===
local hitboxSec = pTab:addSection("Player Hitbox (Vùng chạm)")
local hitboxSlider = hitboxSec:addSlider("Kích thước hitbox", 8, 1, 50, function(val)
    _G.HitboxSize = math.floor(val)
end)
hitboxSec:addToggle("Bật phóng to hitbox", false, function(t)
    _G.ExpandHitbox = t
    if not t then
        pcall(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    for _, part in pairs(p.Character:GetChildren()) do
                        if part:IsA("BasePart") and part:FindFirstChild("NH_OriginalSize") then
                            part.Size = part.NH_OriginalSize.Value
                            part.NH_OriginalSize:Destroy()
                        end
                    end
                end
            end
        end)
    end
end)

-- ===================================================================
-- [[ 12. FLY SYSTEM - GOTHIC EDITION (TÁCH RIÊNG) ]]
-- ===================================================================

local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local PlayerModule = require(player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local controls = PlayerModule:GetControls()

-- === DEFAULT CONFIGURATION ===
local currentFlySpeed = 50

-- Animation Configuration (CHỈ DÙNG CHO FLY)
local animConfig = {
    flyIdle = "rbxassetid://91106826233224",
    flyMove = "rbxassetid://114833664438028"
}

-- === BIẾN TOÀN CỤC ===
local isFlying = false
local flyIdleTrack, flyMoveTrack
local flyVelocityHandler, flyOrientationHandler, flyAttachment, flyConnection
local flyUIVisible = true

-- === HÀM HỖ TRỢ ===
local function formatID(input)
    local num = string.match(input, "%d+")
    if num then return "rbxassetid://" .. num end
    return ""
end

local function playTrack(track)
    if track and track.Animation.AnimationId ~= "" and track.Animation.AnimationId ~= "rbxassetid://0" then
        if not track.IsPlaying then track:Play() end
    end
end

local function stopTrack(track)
    if track and track.IsPlaying then track:Stop() end
end

local function loadFlyAnim(animator, id, priority)
    local anim = Instance.new("Animation")
    anim.AnimationId = (id and id ~= "") and id or "rbxassetid://0"
    local track = animator:LoadAnimation(anim)
    track.Looped = true
    track.Priority = priority
    return track
end

-- === STOP FLYING ===
local function stopFlying(humanoid)
    isFlying = false
    stopTrack(flyIdleTrack)
    stopTrack(flyMoveTrack)
    
    if flyVelocityHandler then flyVelocityHandler:Destroy(); flyVelocityHandler = nil end
    if flyOrientationHandler then flyOrientationHandler:Destroy(); flyOrientationHandler = nil end
    if flyAttachment then flyAttachment:Destroy(); flyAttachment = nil end
    if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
    
    if humanoid then
        humanoid.PlatformStand = false
        humanoid.AutoRotate = true
    end
end

-- === START FLYING ===
local function startFlying(character, humanoid)
    local rootPart = character:WaitForChild("HumanoidRootPart")
    isFlying = true
    
    -- Chỉ play fly animation, KHÔNG can thiệp walk/run/idle/jump
    playTrack(flyIdleTrack)
    
    humanoid.PlatformStand = true
    humanoid.AutoRotate = false
    
    flyAttachment = Instance.new("Attachment")
    flyAttachment.Name = "FlyAttachment"
    flyAttachment.Parent = rootPart
    
    flyVelocityHandler = Instance.new("LinearVelocity")
    flyVelocityHandler.Name = "FlyVelocity"
    flyVelocityHandler.Attachment0 = flyAttachment
    flyVelocityHandler.MaxForce = 100000
    flyVelocityHandler.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    flyVelocityHandler.VectorVelocity = Vector3.new(0, 0, 0)
    flyVelocityHandler.Parent = rootPart
    
    flyOrientationHandler = Instance.new("AlignOrientation")
    flyOrientationHandler.Name = "FlyOrientation"
    flyOrientationHandler.Attachment0 = flyAttachment
    flyOrientationHandler.Mode = Enum.OrientationAlignmentMode.OneAttachment
    flyOrientationHandler.MaxTorque = 100000
    flyOrientationHandler.Responsiveness = 200
    flyOrientationHandler.CFrame = rootPart.CFrame
    flyOrientationHandler.Parent = rootPart
    
    flyConnection = RunService.RenderStepped:Connect(function()
        if not character or not character.Parent or not humanoid or humanoid.Health <= 0 then
            stopFlying(humanoid)
            return
        end
        
        local camera = workspace.CurrentCamera
        local moveVector = controls:GetMoveVector()
        
        if moveVector.Magnitude > 0 then
            stopTrack(flyIdleTrack)
            playTrack(flyMoveTrack)
            
            local camCFrame = camera.CFrame
            local flyDir = (camCFrame * CFrame.new(moveVector)).Position - camCFrame.Position
            flyVelocityHandler.VectorVelocity = flyDir.Unit * currentFlySpeed
            flyOrientationHandler.CFrame = camCFrame
        else
            stopTrack(flyMoveTrack)
            playTrack(flyIdleTrack)
            
            flyVelocityHandler.VectorVelocity = Vector3.new(0, 0, 0)
            flyOrientationHandler.CFrame = camera.CFrame
        end
    end)
end

-- === LOAD FLY ANIMATIONS ===
local function loadFlyAnimations(character)
    local humanoid = character:WaitForChild("Humanoid")
    local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
    
    -- Nuke cũ (chỉ xóa fly track cũ)
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        if track.Name == "FlyIdle" or track.Name == "FlyMove" then
            track:Stop(0)
        end
    end
    
    -- Load Fly Tracks với Priority Action4 (cao nhất, chỉ override khi đang bay)
    flyIdleTrack = loadFlyAnim(animator, animConfig.flyIdle, Enum.AnimationPriority.Action4)
    flyIdleTrack.Name = "FlyIdle"
    
    flyMoveTrack = loadFlyAnim(animator, animConfig.flyMove, Enum.AnimationPriority.Action4)
    flyMoveTrack.Name = "FlyMove"
end

-- === GUI STYLING (GOTHIC) ===
local function createUIStroke(parent)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(150, 30, 30)
    stroke.Thickness = 1.8
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

local function styleButton(button, text, yOffset)
    button.Size = UDim2.new(0, 140, 0, 40)
    button.Position = UDim2.new(1, -150, 0.5, yOffset)
    button.RichText = true  -- Cho phép hiển thị icon
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
    button.TextColor3 = Color3.fromRGB(200, 50, 50)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.AutoButtonColor = false

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 4)
    uicorner.Parent = button
    createUIStroke(button)
end

local function createInputRow(parent, labelText, yPos, currentVal, placeholder)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 80, 0, 30)
    label.Position = UDim2.new(0, 10, 0, yPos)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(200, 50, 50)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0, 160, 0, 30)
    textBox.Position = UDim2.new(0, 100, 0, yPos)
    textBox.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 12
    textBox.PlaceholderText = placeholder or "Paste ID here..."
    textBox.Text = currentVal or ""
    textBox.ClearTextOnFocus = false
    textBox.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = textBox
    createUIStroke(textBox)

    return textBox
end

-- === MAIN GUI BUILDER ===
local function initializeFlyGUI()
    local screenGui = player.PlayerGui:FindFirstChild("FlySystemGui")
    if screenGui then screenGui:Destroy() end
    
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FlySystemGui"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Enabled = flyUIVisible
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- 1. Fly Button
    local flyButton = Instance.new("TextButton")
    flyButton.Name = "FlyBtn"
    styleButton(flyButton, "FLY: OFF", 15)
    flyButton.Parent = screenGui

    -- 2. Settings Button (đã thay icon)
    local settingsButton = Instance.new("TextButton")
    settingsButton.Name = "SettingsBtn"
    styleButton(settingsButton, "<image src='rbxassetid://10734905958'/> SETTINGS", -45)
    settingsButton.Parent = screenGui

    -- 3. Settings Panel
    local settingsPanel = Instance.new("Frame")
    settingsPanel.Size = UDim2.new(0, 290, 0, 250)
    settingsPanel.Position = UDim2.new(0.5, -145, 0.5, -125)
    settingsPanel.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
    settingsPanel.Visible = false
    settingsPanel.Parent = screenGui

    local panelCorner = Instance.new("UICorner")
    panelCorner.CornerRadius = UDim.new(0, 8)
    panelCorner.Parent = settingsPanel
    createUIStroke(settingsPanel)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "FLY SETTINGS"
    title.TextColor3 = Color3.fromRGB(200, 50, 50)
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 18
    title.Parent = settingsPanel

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.Parent = settingsPanel

    -- Scroll Frame
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, 0, 1, -90)
    scrollFrame.Position = UDim2.new(0, 0, 0, 40)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 160)
    scrollFrame.ScrollBarThickness = 6
    scrollFrame.Parent = settingsPanel

    -- Animation Inputs (CHỈ FLY)
    local flyIdleInput = createInputRow(scrollFrame, "Fly Idle:", 5, string.match(animConfig.flyIdle, "%d+"))
    local flyMoveInput = createInputRow(scrollFrame, "Fly Move:", 45, string.match(animConfig.flyMove, "%d+"))
    local flySpeedInput = createInputRow(scrollFrame, "Fly Speed:", 85, tostring(currentFlySpeed), "50")

    -- Apply Button
    local applyBtn = Instance.new("TextButton")
    applyBtn.Size = UDim2.new(0, 260, 0, 35)
    applyBtn.Position = UDim2.new(0, 15, 1, -45)
    applyBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    applyBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    applyBtn.Font = Enum.Font.GothamBold
    applyBtn.Text = "APPLY & RELOAD"
    applyBtn.TextSize = 14
    applyBtn.Parent = settingsPanel
    
    local applyCorner = Instance.new("UICorner")
    applyCorner.CornerRadius = UDim.new(0, 4)
    applyCorner.Parent = applyBtn
    createUIStroke(applyBtn)

    -- 4. Button Logic
    settingsButton.MouseButton1Click:Connect(function()
        settingsPanel.Visible = not settingsPanel.Visible
    end)

    closeBtn.MouseButton1Click:Connect(function()
        settingsPanel.Visible = false
    end)

    applyBtn.MouseButton1Click:Connect(function()
        -- Save Fly Animation IDs
        animConfig.flyIdle = formatID(flyIdleInput.Text)
        animConfig.flyMove = formatID(flyMoveInput.Text)

        -- Save & Apply Speed
        if tonumber(flySpeedInput.Text) then
            currentFlySpeed = tonumber(flySpeedInput.Text)
        end

        if player.Character then
            loadFlyAnimations(player.Character)
            if isFlying then
                -- Nếu đang bay, reload fly animation
                stopFlying(player.Character.Humanoid)
                task.wait(0.1)
                startFlying(player.Character, player.Character.Humanoid)
            end
        end
        
        applyBtn.Text = "SAVED & RELOADED!"
        task.wait(1)
        applyBtn.Text = "APPLY & RELOAD"
    end)

    flyButton.MouseButton1Click:Connect(function()
        local character = player.Character
        if not character then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then return end
        
        if isFlying then
            stopFlying(humanoid)
            flyButton.Text = "FLY: OFF"
        else
            startFlying(character, humanoid)
            flyButton.Text = "FLY: ON"
        end
    end)
end

-- === MAIN INIT ===
local function initFlySystem()
    initializeFlyGUI()
    if player.Character then
        loadFlyAnimations(player.Character)
    end
end

initFlySystem()

player.CharacterAdded:Connect(function(character)
    loadFlyAnimations(character)
    initializeFlyGUI()
    -- Nếu đang bật fly khi respawn, tự động tắt
    if isFlying then
        isFlying = false
    end
end)

-- === TOGGLE HIỆN NÚT FLY & SETTINGS (THÊM VÀO TAB SYSTEM) ===
local flyUISec = pTab:addSection("Fly UI Settings")
flyUISec:addToggle("Hiện nút Fly & Settings", false, function(t)
    flyUIVisible = t
    local screenGui = player.PlayerGui:FindFirstChild("FlySystemGui")
    if screenGui then
        screenGui.Enabled = t
    end
end)

-- === NOCLIP & XRAY ===
local noclipSec = pTab:addSection("Noclip & Xray")
noclipSec:addToggle("Đi Xuyên Tường (NoClip)", false, function(t)
    _G.Noclip = t
end)

RunService.Stepped:Connect(function()
    if _G.Noclip and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

local xrayActive = false
noclipSec:addToggle("Xray (Xuyên thấu)", false, function(t)
    _G.Xray = t
    if t then
        pcall(function()
            local char = LocalPlayer.Character
            for _, v in ipairs(workspace:GetDescendants()) do
                pcall(function()
                    if v:IsA("BasePart") and (not char or not v:IsDescendantOf(char)) then
                        v.LocalTransparencyModifier = 0.7
                    end
                end)
            end
        end)
        xrayActive = true
        task.spawn(function()
            while xrayActive and _G.Xray do
                pcall(function()
                    local char = LocalPlayer.Character
                    for _, v in ipairs(workspace:GetDescendants()) do
                        if v:IsA("BasePart") and (not char or not v:IsDescendantOf(char)) then
                            v.LocalTransparencyModifier = 0.7
                        end
                    end
                end)
                task.wait(1)
            end
        end)
    else
        xrayActive = false
        pcall(function()
            for _, v in ipairs(workspace:GetDescendants()) do
                pcall(function()
                    if v:IsA("BasePart") then
                        v.LocalTransparencyModifier = 0
                    end
                end)
            end
        end)
    end
end)

-- === FOV CUSTOM ===
local fovSec = pTab:addSection("Camera")
fovSec:addSlider("Chỉnh FOV", 70, 30, 120, function(val)
    _G.FOVValue = val
    if _G.FOVToggle then Cam.FieldOfView = val end
end)

fovSec:addToggle("Bật FOV tùy chỉnh", false, function(t)
    _G.FOVToggle = t
    if t then
        Cam.FieldOfView = _G.FOVValue or 70
    else
        Cam.FieldOfView = 70
    end
end)

-- ===================================================================
-- [[ 5. TAB COMBAT ]]
-- ===================================================================
local kSec = kTab:addSection("Sheriff - Combat")
kSec:addToggle("Silent Aim (Always)-lỗi thời", false, function(t) _G.SilentAim = t end)
kSec:addToggle("Auto Shoot-lỗi thời", false, function(t) _G.AutoShoot = t end)

-- === AIM PANEL GOTHIC ===
local aPanel = Instance.new("Frame", sg)
aPanel.Size = UDim2.new(0, 140, 0, 100)
aPanel.Position = UDim2.new(0.8, 0, 0.2, 0)
aPanel.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
aPanel.BackgroundTransparency = 0.15
aPanel.Visible = false
Instance.new("UICorner", aPanel).CornerRadius = UDim.new(0, 8)

local aStroke = Instance.new("UIStroke", aPanel)
aStroke.Color = Color3.fromRGB(150, 30, 30)
aStroke.Thickness = 2
aStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local aTitle = Instance.new("TextLabel", aPanel)
aTitle.Size = UDim2.new(1, 0, 0, 20)
aTitle.Position = UDim2.new(0, 0, 0, 5)
aTitle.BackgroundTransparency = 1
aTitle.RichText = true
aTitle.Text = "<image src='rbxassetid://10734977012'/> AIM PART"
aTitle.TextColor3 = Color3.fromRGB(200, 50, 50)
aTitle.Font = Enum.Font.GothamBold
aTitle.TextSize = 14

local aH = Instance.new("TextButton", aPanel)
aH.Size = UDim2.new(0, 120, 0, 28)
aH.Position = UDim2.new(0.5, -60, 0, 30)
aH.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
aH.BackgroundTransparency = 0.1
aH.RichText = true
aH.Text = "<image src='rbxassetid://108070801288944'/> Đầu"
aH.TextColor3 = Color3.fromRGB(255, 50, 50)
aH.Font = Enum.Font.GothamBold
aH.TextSize = 12
Instance.new("UICorner", aH).CornerRadius = UDim.new(0, 6)

local aHStroke = Instance.new("UIStroke", aH)
aHStroke.Color = Color3.fromRGB(150, 30, 30)
aHStroke.Thickness = 1.5
aHStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

aH.MouseEnter:Connect(function()
    TweenService:Create(aH, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 0, 0), TextColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)
aH.MouseLeave:Connect(function()
    TweenService:Create(aH, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 0, 0), TextColor3 = Color3.fromRGB(255, 50, 50)}):Play()
end)
aH.MouseButton1Click:Connect(function() _G.AimPart = "Head" end)

local aB = Instance.new("TextButton", aPanel)
aB.Size = UDim2.new(0, 120, 0, 28)
aB.Position = UDim2.new(0.5, -60, 0, 65)
aB.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
aB.BackgroundTransparency = 0.1
aB.RichText = true
aB.Text = "<image src='rbxassetid://10747373176'/> Thân"
aB.TextColor3 = Color3.fromRGB(255, 50, 50)
aB.Font = Enum.Font.GothamBold
aB.TextSize = 12
Instance.new("UICorner", aB).CornerRadius = UDim.new(0, 6)

local aBStroke = Instance.new("UIStroke", aB)
aBStroke.Color = Color3.fromRGB(150, 30, 30)
aBStroke.Thickness = 1.5
aBStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

aB.MouseEnter:Connect(function()
    TweenService:Create(aB, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 0, 0), TextColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)
aB.MouseLeave:Connect(function()
    TweenService:Create(aB, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 0, 0), TextColor3 = Color3.fromRGB(255, 50, 50)}):Play()
end)
aB.MouseButton1Click:Connect(function() _G.AimPart = "UpperTorso" end)

kSec:addToggle("Bảng Chọn Aim", false, function(t) aPanel.Visible = t end)

-- === TK BUTTON GOTHIC + ICON ===
local tkBtn = Instance.new("TextButton", sg)
tkBtn.Size = UDim2.new(0, 180, 0, 60)
tkBtn.Position = UDim2.new(0.5, -90, 0.5, -30)
tkBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
tkBtn.BackgroundTransparency = 0.1
tkBtn.Text = "  TELE KILL"
tkBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
tkBtn.Font = Enum.Font.GothamBold
tkBtn.TextSize = 18
tkBtn.Draggable = true
tkBtn.Active = true
tkBtn.Visible = false
Instance.new("UICorner", tkBtn).CornerRadius = UDim.new(0, 8)

local tkStroke = Instance.new("UIStroke", tkBtn)
tkStroke.Color = Color3.fromRGB(180, 20, 20)
tkStroke.Thickness = 2.5
tkStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Icon cho TK
local tkIcon = Instance.new("ImageLabel", tkBtn)
tkIcon.Size = UDim2.new(0, 24, 0, 24)
tkIcon.Position = UDim2.new(0, 8, 0.5, -12)
tkIcon.BackgroundTransparency = 1
tkIcon.Image = "rbxassetid://83246673249608"
tkIcon.ImageColor3 = Color3.fromRGB(255, 50, 50)
tkIcon.ZIndex = 2

task.spawn(function()
    while true do
        if tkBtn.Visible then
            TweenService:Create(tkStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Color = Color3.fromRGB(255, 0, 0),
                Thickness = 4
            }):Play()
            task.wait(0.8)
            TweenService:Create(tkStroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Color = Color3.fromRGB(120, 10, 10),
                Thickness = 2
            }):Play()
            task.wait(0.8)
        else
            task.wait(0.5)
        end
    end
end)

tkBtn.MouseEnter:Connect(function()
    TweenService:Create(tkBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 0, 0),
        TextColor3 = Color3.fromRGB(255, 80, 80)
    }):Play()
    TweenService:Create(tkStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(255, 30, 30),
        Thickness = 4
    }):Play()
end)

tkBtn.MouseLeave:Connect(function()
    TweenService:Create(tkBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(20, 0, 0),
        TextColor3 = Color3.fromRGB(255, 50, 50)
    }):Play()
    TweenService:Create(tkStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(180, 20, 20),
        Thickness = 2.5
    }):Play()
end)

tkBtn.MouseButton1Click:Connect(function()
    local murName = findMurderName()
    if not murName then 
        tkBtn.Text = "  NO MURDER"
        tkBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(1)
        tkBtn.Text = "  TELE KILL"
        tkBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
        return 
    end

    local mur = Players[murName]
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and mur.Character and mur.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local murHRP = mur.Character.HumanoidRootPart
        local oldPos = hrp.CFrame

        hrp.CFrame = murHRP.CFrame * CFrame.new(0, 0, 8)
        
        local gun = char:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
        if gun then
            if gun.Parent ~= char then char.Humanoid:EquipTool(gun); task.wait(0.1) end
            local shootRemote = gun:FindFirstChild("Shoot")
            if shootRemote then
                shootRemote:FireServer(CFrame.new(hrp.Position), CFrame.new(murHRP.Position))
            end
        end

        tkBtn.Text = "  BANG!"
        tkBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        tkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        task.delay(0.5, function()
            hrp.CFrame = oldPos
            tkBtn.Text = "  TELE KILL"
            tkBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
            tkBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
        end)
    end
end)

local autoShootMurSec = kTab:addSection("Auto Shoot Mur")
autoShootMurSec:addToggle("Hiện Nút TK (Tele-Kill Mur)", false, function(t)
    tkBtn.Visible = t
end)

autoShootMurSec:addToggle("Auto Shoot Mur (Tự động TK khi có súng)", false, function(t)
    _G.AutoShootMur = t
    if t then
        coroutine.wrap(function()
            while _G.AutoShootMur do
                pcall(function()
                    local char = LocalPlayer.Character
                    if not char then return end
                    
                    local gun = char:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
                    if not gun then return end
                    
                    local murName = findMurderName()
                    if not murName then task.wait(0.5); return end
                    
                    local mur = Players[murName]
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local murHRP = mur.Character and mur.Character:FindFirstChild("HumanoidRootPart")
                    
                    if hrp and murHRP then
                        local oldPos = hrp.CFrame
                        hrp.CFrame = murHRP.CFrame * CFrame.new(0, 0, 8)
                        
                        if gun.Parent ~= char then char.Humanoid:EquipTool(gun); task.wait(0.05) end
                        local shootRemote = gun:FindFirstChild("Shoot")
                        if shootRemote then
                            shootRemote:FireServer(CFrame.new(hrp.Position), CFrame.new(murHRP.Position))
                        end
                        
                        task.wait(0.3)
                        pcall(function() hrp.CFrame = oldPos end)
                    end
                end)
                task.wait(3)
            end
        end)()
    end
end)

-- === AUTO GET GUN ===
local getGunSec = kTab:addSection("Auto Get Gun")
getGunSec:addToggle("Auto Get Gun (Tự động lấy súng)", false, function(t)
    _G.AutoGetGun = t
    if t then
        coroutine.wrap(function()
            while _G.AutoGetGun do
                pcall(function()
                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    
                    local hasGun = char:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
                    if hasGun then task.wait(1); return end
                    
                    local gun = nil
                    for _, v in pairs(workspace:GetDescendants()) do
                        if (v.Name == "GunDrop" or v.Name == "DroppedGun" or (v.Name:find("Gun") and v:IsA("Tool"))) and v:IsA("BasePart") then
                            gun = v
                            break
                        end
                    end
                    
                    if gun then
                        local oldPos = hrp.CFrame
                        hrp.CFrame = gun.CFrame
                        task.wait(0.1)
                        hrp.CFrame = oldPos
                    end
                end)
                task.wait(1.5)
            end
        end)()
    end
end)

-- === KILL ALL BUTTON GOTHIC + ICON ===
local mSec = kTab:addSection("Murderer - Combat")
local killBtn = Instance.new("TextButton", sg)
killBtn.Size = UDim2.new(0, 140, 0, 45)
killBtn.Position = UDim2.new(0.85, 0, 0.5, -22)
killBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
killBtn.BackgroundTransparency = 0.1
killBtn.Text = "  KILL ALL"
killBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
killBtn.Font = Enum.Font.GothamBold
killBtn.TextSize = 14
killBtn.Draggable = true
killBtn.Active = true
killBtn.Visible = false
Instance.new("UICorner", killBtn).CornerRadius = UDim.new(0, 8)

local killStroke = Instance.new("UIStroke", killBtn)
killStroke.Color = Color3.fromRGB(150, 30, 30)
killStroke.Thickness = 2
killStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Icon cho KILL ALL
local killIcon = Instance.new("ImageLabel", killBtn)
killIcon.Size = UDim2.new(0, 20, 0, 20)
killIcon.Position = UDim2.new(0, 6, 0.5, -10)
killIcon.BackgroundTransparency = 1
killIcon.Image = "rbxassetid://77322579126050"
killIcon.ImageColor3 = Color3.fromRGB(255, 50, 50)
killIcon.ZIndex = 2

killBtn.MouseEnter:Connect(function()
    TweenService:Create(killBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30, 0, 0),
        TextColor3 = Color3.fromRGB(255, 80, 80)
    }):Play()
    TweenService:Create(killStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(255, 50, 50),
        Thickness = 3
    }):Play()
end)

killBtn.MouseLeave:Connect(function()
    TweenService:Create(killBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(20, 0, 0),
        TextColor3 = Color3.fromRGB(255, 50, 50)
    }):Play()
    TweenService:Create(killStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(150, 30, 30),
        Thickness = 2
    }):Play()
end)

killBtn.MouseButton1Click:Connect(function()
    local k = LocalPlayer.Backpack:FindFirstChild("Knife") or LocalPlayer.Character:FindFirstChild("Knife")
    if k then 
        LocalPlayer.Character.Humanoid:EquipTool(k)
        for _, p in pairs(Players:GetPlayers()) do 
            if p ~= LocalPlayer and p.Character then 
                k.Handle.Size = Vector3.new(55,55,55)
                p.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-3)
                k:Activate() 
            end 
        end 
        killBtn.Text = "  DONE!"
        killBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(1)
        killBtn.Text = "  KILL ALL"
        killBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

mSec:addToggle("Hiện Nút KILL ALL", false, function(t)
    killBtn.Visible = t
end)

local autoKillSec = kTab:addSection("Auto Kill All")

autoKillSec:addToggle("Auto Kill All (Tự động bring + chém)", false, function(t)
    _G.AutoKillAll = t
    if t then
        task.spawn(function()
            while _G.AutoKillAll do
                pcall(function()
                    local char = LocalPlayer.Character
                    if not char then return end
                    local knife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
                    if not knife then return end
                    if knife.Parent ~= char then
                        char.Humanoid:EquipTool(knife)
                        task.wait(0.1)
                    end
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                            local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
                            if tRoot then
                                tRoot.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                                task.wait(0.05)
                                if knife:FindFirstChild("Handle") then
                                    knife.Handle.Size = Vector3.new(55, 55, 55)
                                end
                                knife:Activate()
                                task.wait(0.1)
                            end
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    end
end)

-- === AUTO KILL SHERIFF ===
autoKillSec:addToggle("Auto Kill Sheriff", false, function(t)
    _G.AutoKillSheriff = t
    if t then
        task.spawn(function()
            while _G.AutoKillSheriff do
                pcall(function()
                    local char = LocalPlayer.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                    
                    local knife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
                    if not knife then return end
                    if knife.Parent ~= char then char.Humanoid:EquipTool(knife) end

                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                            local gun = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
                            if gun then
                                local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
                                if tRoot then
                                    char.HumanoidRootPart.Anchored = true
                                    tRoot.Anchored = true
                                    tRoot.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1)
                                    knife:Activate()
                                    task.wait(0.2)
                                    tRoot.Anchored = false
                                    char.HumanoidRootPart.Anchored = false
                                end
                            end
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.Anchored = false
        end
    end
end)

-- === AUTO KILL TELE ===
autoKillSec:addToggle("Auto Kill (Tele đến chém)", false, function(t)
    _G.AutoKillTele = t
    if t then
        task.spawn(function()
            while _G.AutoKillTele do
                pcall(function()
                    local char = LocalPlayer.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                    
                    local knife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
                    if not knife then return end
                    if knife.Parent ~= char then char.Humanoid:EquipTool(knife) end

                    for _, p in pairs(Players:GetPlayers()) do
                        if _G.AutoKillTele and p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                            local tRoot = p.Character:FindFirstChild("HumanoidRootPart")
                            if tRoot then
                                char.HumanoidRootPart.CFrame = tRoot.CFrame * CFrame.new(0, 0, 1)
                                knife:Activate()
                                task.wait(1)
                            end
                        end
                    end
                end)
                task.wait(1)
            end
        end)
    end
end)

-- === TELE KILL ALL SERVER ===
autoKillSec:addToggle("Tele Kill All Server", false, function(t)
    _G.TeleKillAll = t
    if t then
        task.spawn(function()
            while _G.TeleKillAll do
                pcall(function()
                    local char = LocalPlayer.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                    
                    local knife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
                    if not knife then return end
                    if knife.Parent ~= char then char.Humanoid:EquipTool(knife) end
                    
                    char.HumanoidRootPart.CanCollide = false
                    
                    for _, p in pairs(Players:GetPlayers()) do
                        if _G.TeleKillAll and p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                            char.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                            knife:Activate()
                            task.wait(1)
                        end
                    end
                end)
                task.wait(1)
            end
        end)
    end
end)

-- ===================================================================
-- [[ 6. TAB SHOOT MURDER ]]
-- ===================================================================
local actionSec = aTab:addSection("SHOOT MURDER")

-- Slider Prediction
local predSlider = actionSec:addSlider("Độ chính xác (0.05 - 1.0)", 0.2, 0.05, 1.0, function(val)
    _G.ShootPrediction = val
end)

-- Keybind Shoot
local shootKeybind = actionSec:addKeybind("Phím tắt bắn", Enum.KeyCode.R, function(key)
    _G.ShootMurderKey = key
end)

-- Shoot Murder Button Gothic + Icon
local shootBtn = Instance.new("TextButton", sg)
shootBtn.Size = UDim2.new(0, 200, 0, 60)
shootBtn.Position = UDim2.new(0.5, -100, 0.8, 0)
shootBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
shootBtn.BackgroundTransparency = 0.1
shootBtn.Text = "  SHOOT MURDER"
shootBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
shootBtn.Font = Enum.Font.GothamBold
shootBtn.TextSize = 18
shootBtn.Draggable = true
shootBtn.Active = true
shootBtn.Visible = false
Instance.new("UICorner", shootBtn).CornerRadius = UDim.new(0, 8)

local shootStroke = Instance.new("UIStroke", shootBtn)
shootStroke.Color = Color3.fromRGB(150, 30, 30)
shootStroke.Thickness = 2
shootStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Icon cho Shoot Murder
local shootIcon = Instance.new("ImageLabel", shootBtn)
shootIcon.Size = UDim2.new(0, 24, 0, 24)
shootIcon.Position = UDim2.new(0, 8, 0.5, -12)
shootIcon.BackgroundTransparency = 1
shootIcon.Image = "rbxassetid://137439034393821"
shootIcon.ImageColor3 = Color3.fromRGB(255, 50, 50)
shootIcon.ZIndex = 2

shootBtn.MouseEnter:Connect(function()
    TweenService:Create(shootBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30, 0, 0),
        TextColor3 = Color3.fromRGB(255, 80, 80)
    }):Play()
    TweenService:Create(shootStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(255, 50, 50),
        Thickness = 3
    }):Play()
end)

shootBtn.MouseLeave:Connect(function()
    TweenService:Create(shootBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(20, 0, 0),
        TextColor3 = Color3.fromRGB(255, 50, 50)
    }):Play()
    TweenService:Create(shootStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(150, 30, 30),
        Thickness = 2
    }):Play()
end)

local function shootMurderFunc()
    local targetName = findMurderName()
    if not targetName then
        shootBtn.Text = "  NO MURDER"
        shootBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(1)
        shootBtn.Text = "  SHOOT MURDER"
        shootBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
        return
    end
    
    local targetChar = Players:FindFirstChild(targetName) and Players[targetName].Character
    local targetHRP = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
    
    if targetHRP then
        local predictedPos = targetHRP.Position + (targetHRP.Velocity * _G.ShootPrediction)
        
        local char = LocalPlayer.Character
        if char then
            local gun = char:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
            if gun then
                if gun.Parent ~= char then
                    char.Humanoid:EquipTool(gun)
                    task.wait(0.1)
                end
                local shootRemote = gun:FindFirstChild("Shoot")
                if shootRemote then
                    shootRemote:FireServer(CFrame.new(char.HumanoidRootPart.Position), CFrame.new(predictedPos))
                end
            end
        end
        
        shootBtn.Text = "  BANG!"
        shootBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        shootBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        task.wait(0.5)
        shootBtn.Text = "  SHOOT MURDER"
        shootBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
        shootBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end

shootBtn.MouseButton1Click:Connect(shootMurderFunc)

actionSec:addToggle("Hiện Nút SHOOT MURDER", false, function(t)
    shootBtn.Visible = t
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == _G.ShootMurderKey then
        shootMurderFunc()
    end
end)

-- ===================================================================
-- [[ 7. TAB TELEPORT ]]
-- ===================================================================
local tpSec = tTab:addSection("Teleport Target (Phím Q/Z)")

local murKeybind = tpSec:addKeybind("Phím Tele MUR", Enum.KeyCode.Q, function(key)
    _G.MurKeybind = key
end)

local shefKeybind = tpSec:addKeybind("Phím Tele SHEFF", Enum.KeyCode.Z, function(key)
    _G.ShefKeybind = key
end)

local function teleLobby()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local spawn = workspace:FindFirstChild("SpawnLocation") or workspace:FindFirstChild("Lobby") or workspace:FindFirstChild("Map")
    local farthestPlayer = nil; local farthestDist = 0
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if dist > farthestDist then farthestDist = dist; farthestPlayer = p end
        end
    end
    if farthestPlayer and farthestPlayer.Character then hrp.CFrame = farthestPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
    elseif spawn then hrp.CFrame = spawn.CFrame * CFrame.new(0, 5, 0) end
end

local function teleMap()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local mur, sheff = findMurderAndSheriff()
    local target = mur or sheff
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = target.Character.HumanoidRootPart.Position
        local dir = (hrp.Position - targetPos).Unit
        hrp.CFrame = CFrame.new(targetPos + dir * 50)
    else
        local map = workspace:FindFirstChildWhichIsA("Model")
        if map then hrp.CFrame = map:GetModelCFrame() * CFrame.new(0, 5, 0) end
    end
end

local function doTele(role)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local isM = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
            local isS = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
            if (role == "M" and isM) or (role == "S" and isS) then 
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 10) 
            end
        end
    end
end

tpSec:addButton("TELE SẢNH (Xa → Gần)", teleLobby)
tpSec:addButton("TELE MAP (Cách xa Mur/Sheff)", teleMap)

-- Teleport Frame Gothic
local tpFrame = Instance.new("Frame", sg)
tpFrame.Size = UDim2.new(0, 180, 0, 180)
tpFrame.Position = UDim2.new(0, 15, 0, 200)
tpFrame.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
tpFrame.BackgroundTransparency = 0.2
tpFrame.Visible = false
Instance.new("UICorner", tpFrame).CornerRadius = UDim.new(0, 8)

local tpStroke = Instance.new("UIStroke", tpFrame)
tpStroke.Color = Color3.fromRGB(150, 30, 30)
tpStroke.Thickness = 2
tpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local tpTitle = Instance.new("TextLabel", tpFrame)
tpTitle.Size = UDim2.new(1, 0, 0, 20)
tpTitle.Position = UDim2.new(0, 0, 0, 5)
tpTitle.BackgroundTransparency = 1
tpTitle.RichText = true
tpTitle.Text = "<image src='rbxassetid://10723404337'/> TELEPORT"
tpTitle.TextColor3 = Color3.fromRGB(200, 50, 50)
tpTitle.Font = Enum.Font.GothamBold
tpTitle.TextSize = 12

local function CreateTPButton(text, yPos, color, iconId, callback)
    local btn = Instance.new("TextButton", tpFrame)
    btn.Size = UDim2.new(0, 160, 0, 28)
    btn.Position = UDim2.new(0.5, -80, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    btn.BackgroundTransparency = 0.1
    btn.RichText = true
    btn.Text = "<image src='rbxassetid://" .. iconId .. "'/> " .. text
    btn.TextColor3 = color or Color3.fromRGB(200, 50, 50)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(150, 30, 30)
    stroke.Thickness = 1.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 0, 0),
            TextColor3 = Color3.fromRGB(255, 80, 80)
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(20, 0, 0),
            TextColor3 = color or Color3.fromRGB(200, 50, 50)
        }):Play()
    end)
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local btnM = CreateTPButton("TELE MUR", 30, Color3.fromRGB(255, 50, 50), "83246673249608", function() doTele("M") end)
local btnS = CreateTPButton("TELE SHEFF", 65, Color3.fromRGB(50, 100, 255), "10734939942", function() doTele("S") end)
local btnL = CreateTPButton("TELE SẢNH", 100, Color3.fromRGB(50, 255, 100), "10723407389", teleLobby)
local btnMap = CreateTPButton("TELE MAP", 135, Color3.fromRGB(255, 200, 50), "10734899018", teleMap)

tpSec:addToggle("Hiện Nút Tele (Mobile)", false, function(t)
    tpFrame.Visible = t
end)

UserInputService.InputBegan:Connect(function(input, processed) 
    if not processed then 
        if input.KeyCode == _G.MurKeybind then doTele("M") 
        elseif input.KeyCode == _G.ShefKeybind then doTele("S") end 
    end 
end)

-- ===================================================================
-- [[ 8. TAB REVEAL ]]
-- ===================================================================
local rSec = rTab:addSection("TIẾT LỘ ID MURDER & SHERIFF")

-- Reveal Labels Gothic
local murLabel = Instance.new("TextLabel", sg)
murLabel.Size = UDim2.new(0, 220, 0, 26)
murLabel.Position = UDim2.new(0.01, 0, 0.277, 0)
murLabel.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
murLabel.BackgroundTransparency = 0.2
murLabel.RichText = true
murLabel.Text = "<image src='rbxassetid://10734924029'/> Murder: Chưa quét"
murLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
murLabel.Font = Enum.Font.GothamBold
murLabel.TextSize = 12
murLabel.Visible = true
Instance.new("UICorner", murLabel).CornerRadius = UDim.new(0, 8)

local mLabelStroke = Instance.new("UIStroke", murLabel)
mLabelStroke.Color = Color3.fromRGB(150, 30, 30)
mLabelStroke.Thickness = 1.5
mLabelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local shefLabel = Instance.new("TextLabel", sg)
shefLabel.Size = UDim2.new(0, 220, 0, 26)
shefLabel.Position = UDim2.new(0.01, 0, 0.36, 0)
shefLabel.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
shefLabel.BackgroundTransparency = 0.2
shefLabel.RichText = true
shefLabel.Text = "<image src='rbxassetid://98777846316000'/> Sheriff: Chưa quét"
shefLabel.TextColor3 = Color3.fromRGB(80, 150, 255)
shefLabel.Font = Enum.Font.GothamBold
shefLabel.TextSize = 12
shefLabel.Visible = true
Instance.new("UICorner", shefLabel).CornerRadius = UDim.new(0, 8)

local sLabelStroke = Instance.new("UIStroke", shefLabel)
sLabelStroke.Color = Color3.fromRGB(50, 100, 200)
sLabelStroke.Thickness = 1.5
sLabelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local lastMurder = nil
local lastSheriff = nil
local lastMurderChat = ""
local lastSheriffChat = ""

rSec:addToggle("Auto tiết lộ MURDER", false, function(t)
    _G.AutoRevealMurder = t
    if not t then lastMurder = nil; lastMurderChat = "" end
end)

rSec:addToggle("Auto tiết lộ SHERIFF", false, function(t)
    _G.AutoRevealSheriff = t
    if not t then lastSheriff = nil; lastSheriffChat = "" end
end)

rSec:addToggle("Auto tiết lộ CẢ 2", false, function(t)
    _G.AutoRevealBoth = t
    if not t then lastMurder = nil; lastSheriff = nil; lastMurderChat = ""; lastSheriffChat = "" end
end)

-- ===================================================================
-- [[ 9. TAB FARM - PIN SLIM UI STYLE ]]
-- ===================================================================
_G.PinFarm = false
local coinBlacklist = {}
local SkyPart = nil
local FarmSpeed = 30

local function GetSkyBase()
    if not SkyPart or not SkyPart.Parent then
        SkyPart = Instance.new("Part")
        SkyPart.Name = "PinSkyBase"
        SkyPart.Size = Vector3.new(200, 1, 200)
        SkyPart.Position = Vector3.new(0, 800, 0)
        SkyPart.Anchored = true
        SkyPart.Transparency = 0.6
        SkyPart.BrickColor = BrickColor.new("Neon orange")
        SkyPart.Material = Enum.Material.Neon
        SkyPart.Parent = workspace
    end
    return SkyPart.CFrame * CFrame.new(0, 4, 0)
end

local farmSec = fTab:addSection("FARM XU - PIN STYLE")

-- Farm Speed Slider
local farmSpeedSlider = farmSec:addSlider("Tốc độ Farm", 50, 5, 200, function(val)
    FarmSpeed = math.floor(val)
end)

-- Farm Button Gothic + Icon
local farmBtn = Instance.new("TextButton", sg)
farmBtn.Size = UDim2.new(0, 200, 0, 60)
farmBtn.Position = UDim2.new(0.01, 0, 0.437, 0)
farmBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
farmBtn.BackgroundTransparency = 0.1
farmBtn.Text = "  FARM XU"
farmBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
farmBtn.Font = Enum.Font.GothamBold
farmBtn.TextSize = 18
farmBtn.Draggable = true
farmBtn.Active = true
farmBtn.Visible = false
Instance.new("UICorner", farmBtn).CornerRadius = UDim.new(0, 8)

local farmStroke = Instance.new("UIStroke", farmBtn)
farmStroke.Color = Color3.fromRGB(150, 30, 30)
farmStroke.Thickness = 2
farmStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Icon cho Farm
local farmIcon = Instance.new("ImageLabel", farmBtn)
farmIcon.Size = UDim2.new(0, 24, 0, 24)
farmIcon.Position = UDim2.new(0, 8, 0.5, -12)
farmIcon.BackgroundTransparency = 1
farmIcon.Image = "rbxassetid://10734921935"
farmIcon.ImageColor3 = Color3.fromRGB(255, 50, 50)
farmIcon.ZIndex = 2

farmBtn.MouseEnter:Connect(function()
    TweenService:Create(farmBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30, 0, 0),
        TextColor3 = Color3.fromRGB(255, 80, 80)
    }):Play()
    TweenService:Create(farmStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(255, 50, 50),
        Thickness = 3
    }):Play()
end)

farmBtn.MouseLeave:Connect(function()
    TweenService:Create(farmBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(20, 0, 0),
        TextColor3 = Color3.fromRGB(255, 50, 50)
    }):Play()
    TweenService:Create(farmStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(150, 30, 30),
        Thickness = 2
    }):Play()
end)

-- Farm Label Gothic
local farmLabel = Instance.new("TextLabel", sg)
farmLabel.Size = UDim2.new(0, 220, 0, 26)
farmLabel.Position = UDim2.new(0.01, 0, 0.44, 0)
farmLabel.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
farmLabel.BackgroundTransparency = 0.2
farmLabel.RichText = true
farmLabel.Text = "<image src='rbxassetid://10734919336'/> Farm: DỪNG"
farmLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
farmLabel.Font = Enum.Font.GothamBold
farmLabel.TextSize = 12
farmLabel.Visible = false
Instance.new("UICorner", farmLabel).CornerRadius = UDim.new(0, 8)

local fLabelStroke = Instance.new("UIStroke", farmLabel)
fLabelStroke.Color = Color3.fromRGB(150, 30, 30)
fLabelStroke.Thickness = 1.5
fLabelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

farmBtn.MouseButton1Click:Connect(function()
    _G.PinFarm = not _G.PinFarm
    if _G.PinFarm then
        farmBtn.Text = "  DỪNG FARM"
        farmBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        farmBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
        farmLabel.Text = "<image src='rbxassetid://10734923549'/> Farm: ĐANG CHẠY"
        farmLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        GetSkyBase()
    else
        farmBtn.Text = "  FARM XU"
        farmBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
        farmBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
        farmLabel.Text = "<image src='rbxassetid://10734919336'/> Farm: DỪNG"
        farmLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

farmSec:addToggle("Hiện Nút Farm Trên Màn Hình", false, function(t)
    farmBtn.Visible = t
    farmLabel.Visible = t
end)

-- Logic Farm
task.spawn(function()
    while task.wait(0.2) do
        if _G.PinFarm then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                
                local murPos = nil
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and (v.Character:FindFirstChild("Knife") or v.Backpack:FindFirstChild("Knife")) then
                        if (hrp.Position - v.Character.HumanoidRootPart.Position).Magnitude < 25 then
                            murPos = v.Character.HumanoidRootPart.Position
                            break
                        end
                    end
                end
                if murPos then
                    local retreatDir = (hrp.Position - murPos).Unit
                    local dist = 40
                    local duration = dist / FarmSpeed
                    TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(hrp.Position + (retreatDir * dist))}):Play()
                    task.wait(duration)
                    continue
                end
                
                local coins = {}
                for _, v in pairs(workspace:GetDescendants()) do
                    if (v.Name:find("Coin") or v.Name:find("Gold")) and v:IsA("BasePart") and not coinBlacklist[v] then
                        table.insert(coins, v)
                    end
                end
                
                if #coins > 0 then
                    table.sort(coins, function(a, b)
                        return (hrp.Position - a.Position).Magnitude < (hrp.Position - b.Position).Magnitude
                    end)
                    local target = coins[1]
                    
                    if (hrp.Position - target.Position).Magnitude > 350 then
                        hrp.CFrame = target.CFrame * CFrame.new(0, 3, 0)
                        task.wait(0.5)
                        continue
                    end
                    
                    coinBlacklist[target] = true
                    local dist = (hrp.Position - target.Position).Magnitude
                    local duration = math.max(dist / FarmSpeed, 0.05)
                    TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = target.CFrame}):Play()
                    task.wait(duration + 0.05)
                    pcall(function() target:Destroy() end)
                else
                    hrp.CFrame = GetSkyBase()
                    coinBlacklist = {}
                    task.wait(5)
                end
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    if _G.PinFarm and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- ===================================================================
-- [[ 10. TAB FIX LAG (NỘI BỘ - HIỆU ỨNG NGAY) ]]
-- ===================================================================

-- === FPS/PING COUNTER (GIỮA MÀN HÌNH - ZINDEX FIXED) ===
_G.ShowFPSPing = true

local fpsPingFrame = Instance.new("Frame", sg)
fpsPingFrame.Size = UDim2.new(0, 260, 0, 35)
fpsPingFrame.Position = UDim2.new(0.5, -130, 0, 20)
fpsPingFrame.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
fpsPingFrame.BackgroundTransparency = 0.2
fpsPingFrame.ZIndex = 1  -- Nền dưới
Instance.new("UICorner", fpsPingFrame).CornerRadius = UDim.new(0, 8)

local fpStroke = Instance.new("UIStroke", fpsPingFrame)
fpStroke.Color = Color3.fromRGB(150, 30, 30)
fpStroke.Thickness = 1.5
fpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local fpsLabel = Instance.new("TextLabel", fpsPingFrame)
fpsLabel.Size = UDim2.new(0.5, 0, 1, 0)
fpsLabel.Position = UDim2.new(0, 5, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: 0"
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
fpsLabel.TextScaled = true
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.ZIndex = 2  -- Chữ trên

local pingLabel = Instance.new("TextLabel", fpsPingFrame)
pingLabel.Size = UDim2.new(0.5, 0, 1, 0)
pingLabel.Position = UDim2.new(0.5, 0, 0, 0)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "Ping: 0ms"
pingLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
pingLabel.TextScaled = true
pingLabel.Font = Enum.Font.GothamBold
pingLabel.TextXAlignment = Enum.TextXAlignment.Right
pingLabel.ZIndex = 2  -- Chữ trên

-- === FPS/PING LOOP (CÓ ĐỔI MÀU THEO TRẠNG THÁI) ===
local fpsValues = {}
local pingValues = {}
local isStatsRunning = false

local function StartStatsLoop()
    if isStatsRunning then return end
    isStatsRunning = true
    coroutine.wrap(function()
        while true do
            task.wait()
            local fps = math.floor(1 / (RunService.RenderStepped:Wait() or 0.016))
            table.insert(fpsValues, fps)
            if #fpsValues > 10 then table.remove(fpsValues, 1) end
            local avgFps = 0
            for _, v in ipairs(fpsValues) do avgFps = avgFps + v end
            avgFps = math.floor(avgFps / #fpsValues)

            local ping = math.floor(Players.LocalPlayer:GetNetworkPing() * 1000)
            table.insert(pingValues, ping)
            if #pingValues > 10 then table.remove(pingValues, 1) end
            local avgPing = 0
            for _, v in ipairs(pingValues) do avgPing = avgPing + v end
            avgPing = math.floor(avgPing / #pingValues)

            if _G.ShowFPSPing then
                fpsLabel.Text = "FPS: " .. tostring(avgFps)
                pingLabel.Text = "Ping: " .. tostring(avgPing) .. "ms"

                -- Đổi màu FPS
                if avgFps >= 120 then
                    fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)   -- Xanh lá (tốt)
                elseif avgFps >= 60 then
                    fpsLabel.TextColor3 = Color3.fromRGB(0, 128, 0)   -- Xanh lá đậm (khá)
                elseif avgFps >= 30 then
                    fpsLabel.TextColor3 = Color3.fromRGB(255, 191, 0) -- Vàng (trung bình)
                else
                    fpsLabel.TextColor3 = Color3.fromRGB(255, 0, 0)   -- Đỏ (tệ)
                end

                -- Đổi màu Ping
                if avgPing <= 50 then
                    pingLabel.TextColor3 = Color3.fromRGB(0, 255, 0)   -- Xanh lá (tốt)
                elseif avgPing <= 100 then
                    pingLabel.TextColor3 = Color3.fromRGB(0, 128, 0)   -- Xanh lá đậm (khá)
                elseif avgPing <= 200 then
                    pingLabel.TextColor3 = Color3.fromRGB(255, 191, 0) -- Vàng (trung bình)
                else
                    pingLabel.TextColor3 = Color3.fromRGB(255, 0, 0)   -- Đỏ (tệ)
                end
            end
        end
    end)()
end

StartStatsLoop()

-- === FIX LAG LOGIC (HIỆU ỨNG NGAY) ===
local isFixLagRunning = false

local function StripPlayer(character)
    if not character then return end
    for _, p in ipairs(character:GetDescendants()) do
        if p:IsA("BasePart") then
            p.Material = Enum.Material.Plastic
            p.Color = Color3.fromRGB(100, 100, 105)
            p.Reflectance = 0
        end
        if p:IsA("Decal") or p:IsA("Texture") then
            p.Transparency = 1
        end
        if p:IsA("ParticleEmitter") or p:IsA("Trail") or p:IsA("Fire") or p:IsA("Sparkles") then
            pcall(function() p:Destroy() end)
        end
    end
end

local function RunFixLag()
    if isFixLagRunning then return end
    isFixLagRunning = true

    coroutine.wrap(function()
        -- 1. Cây cối (biến mất ngay)
        for _, c in ipairs(workspace:GetDescendants()) do
            if c:IsA("BasePart") then
                local n = c.Name:lower()
                if n:find("leaf") or n:find("tree") or n:find("plant") or n:find("bush") or n:find("grass") or n:find("flower") or n:find("foliage") or n:find("branch") or n:find("trunk") or n:find("log") or n:find("vegetation") or n:find("palm") or n:find("vine") or n:find("weed") then
                    c.Transparency = 1
                    c.CanCollide = false
                    c.CanQuery = false
                    c.CanTouch = false
                end
            end
        end

        -- 2. Nhựa xám toàn bộ map
        for _, c in ipairs(workspace:GetDescendants()) do
            if c:IsA("BasePart") and not c:FindFirstAncestorOfClass("Player") and not c:FindFirstAncestorOfClass("Tool") then
                c.Material = Enum.Material.Plastic
                c.Color = Color3.fromRGB(75, 75, 80)
                c.Reflectance = 0
            end
            if (c:IsA("Decal") or c:IsA("Texture")) and not c:FindFirstAncestorOfClass("Player") then
                c.Transparency = 1
            end
        end

        -- 3. Diệt Particle + Sound
        for _, c in ipairs(workspace:GetDescendants()) do
            if c:IsA("ParticleEmitter") or c:IsA("Smoke") or c:IsA("Fire") or c:IsA("Sparkles") or c:IsA("Trail") or c:IsA("Beam") then
                pcall(function() c:Destroy() end)
            end
            if c:IsA("Sound") then
                pcall(function() c:Destroy() end)
            end
        end

        -- 4. Strip người chơi hiện tại
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then StripPlayer(plr.Character) end
        end

        -- 5. Sky + Fog
        pcall(function()
            if Lighting.Sky then Lighting.Sky:Destroy() end
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 999999
            Lighting.FogStart = 999999
            Lighting.GlobalShadows = false
            Lighting.ShadowSoftness = 0
            Lighting.Ambient = Color3.fromRGB(180, 180, 180)
            Lighting.ColorShift_Top = Color3.fromRGB(180, 180, 180)
            Lighting.ColorShift_Bottom = Color3.fromRGB(80, 80, 80)
            Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
            Lighting.ExposureCompensation = 0.5
            for _, v in ipairs(workspace:GetChildren()) do
                if v:IsA("Sky") or v.Name:lower():find("sky") then v:Destroy() end
            end
        end)

        -- 6. Post FX
        pcall(function()
            local cam = workspace.CurrentCamera
            if cam then
                for _, v in ipairs(cam:GetDescendants()) do
                    if v:IsA("BlurEffect") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("ColorCorrectionEffect") then
                        pcall(function() v:Destroy() end)
                    end
                end
            end
        end)

        -- 7. Tool trắng
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") or obj:IsA("HopperBin") then
                for _, p in ipairs(obj:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.Material = Enum.Material.Plastic
                        p.Color = Color3.fromRGB(255, 255, 255)
                    end
                    if p:IsA("Decal") or p:IsA("Texture") then p.Transparency = 1 end
                end
            end
        end

        -- 8. Unlock FPS
        pcall(setfpscap, 200)

        -- 9. Event Listeners (để tự động strip người mới vào)
        Players.PlayerAdded:Connect(function(plr)
            plr.CharacterAdded:Connect(function(char)
                task.wait(1)
                StripPlayer(char)
            end)
        end)

        workspace.DescendantAdded:Connect(function(desc)
            if desc:IsA("ParticleEmitter") or desc:IsA("Fire") or desc:IsA("Smoke") or desc:IsA("Sparkles") or desc:IsA("Trail") or desc:IsA("Beam") then
                pcall(function() desc:Destroy() end)
            end
            if desc:IsA("Sound") then
                pcall(function() desc:Destroy() end)
            end
            if desc:IsA("BasePart") and (desc.Name:lower():find("leaf") or desc.Name:lower():find("tree") or desc.Name:lower():find("grass") or desc.Name:lower():find("foliage")) then
                desc.Transparency = 1
            end
            if desc:IsA("Decal") or desc:IsA("Texture") then
                if not desc:FindFirstAncestorOfClass("Player") then
                    desc.Transparency = 1
                end
            end
            if desc:IsA("BasePart") and not desc:FindFirstAncestorOfClass("Player") and not desc:FindFirstAncestorOfClass("Tool") then
                desc.Material = Enum.Material.Plastic
                desc.Color = Color3.fromRGB(75, 75, 80)
            end
        end)

        isFixLagRunning = false
    end)()
end

-- === UI FIX LAG ===
local fixSec = iTab:addSection("NHẬT HUB FIX LAG")

-- Toggle hiện FPS/Ping
local fpsToggle = fixSec:addToggle("Hiện FPS / Ping", true, function(t)
    _G.ShowFPSPing = t
    fpsPingFrame.Visible = t
end)

-- Nút Fix Lag (không cần status label)
fixSec:addButton("FIX LAG NGAY", function()
    RunFixLag()
end)

-- ===================================================================
-- [[ 11. TAB SYSTEM ]]
-- ===================================================================
local sysSec = sTab:addSection("ANTI AFK & ANTI VOID")

-- Anti AFK
local antiAFKActive = false
local antiAfkConn
sysSec:addToggle("Anti AFK", false, function(t)
    antiAFKActive = t
    if t then
        if antiAfkConn then antiAfkConn:Disconnect() end
        antiAfkConn = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
    else
        if antiAfkConn then
            antiAfkConn:Disconnect()
            antiAfkConn = nil
        end
    end
end)

-- Anti Void
local antiVoidActive = false
sysSec:addToggle("Anti Void", false, function(t)
    antiVoidActive = t
    if t then
        task.spawn(function()
            while antiVoidActive do
                pcall(function()
                    local char = LocalPlayer.Character
                    if char then
                        local hrp = char:FindFirstChild("HumanoidRootPart")
                        if hrp and hrp.Position.Y < -50 then
                            hrp.CFrame = CFrame.new(0, 50, 0)
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    end
end)

-- Anti Fling
local antiFlingActive = false
sysSec:addToggle("Anti Fling", false, function(t)
    antiFlingActive = t
end)

RunService.Stepped:Connect(function()
    if antiFlingActive then
        pcall(function()
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            
            if root then
                if root.Velocity.Magnitude > 100 or root.RotVelocity.Magnitude > 100 then
                    root.Velocity = Vector3.new(0, 0, 0)
                    root.RotVelocity = Vector3.new(0, 0, 0)
                end
                
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        for _, part in pairs(p.Character:GetChildren()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- Fling
local flingSec = sTab:addSection("FLING MURDER & SHERIFF")

local function findMurderPlayer()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local isM = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
            if isM then return p end
        end
    end
    return nil
end

local function findSheriffPlayer()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local isS = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
            if isS then return p end
        end
    end
    return nil
end

local function SkidFling(TargetPlayer)
    pcall(function()
        if not TargetPlayer or not TargetPlayer.Character then return end
        
        local Character = LocalPlayer.Character
        if not Character then return end
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart
        if not RootPart then return end
        
        local TCharacter = TargetPlayer.Character
        local THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
        local TRootPart = THumanoid and THumanoid.RootPart
        local THead = TCharacter:FindFirstChild("Head")
        
        if not TRootPart and not THead then return end
        
        getgenv().OldPos = RootPart.CFrame
        getgenv().FPDH = workspace.FallenPartsDestroyHeight
        workspace.FallenPartsDestroyHeight = 0/0
        
        local BV = Instance.new("BodyVelocity")
        BV.Name = "FlingBV"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        
        local TargetPart = TRootPart or THead
        local startTime = tick()
        
        repeat
            RootPart.CFrame = CFrame.new(TargetPart.Position) * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(tick() * 100), 0, 0)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            Character:SetPrimaryPartCFrame(CFrame.new(TargetPart.Position) * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(tick() * 100), 0, 0))
            task.wait()
        until TargetPart.Velocity.Magnitude > 500 or tick() > startTime + 3 or not TargetPlayer.Character or THumanoid.Health <= 0
        
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
        
        local resetTime = tick()
        repeat
            pcall(function()
                RootPart.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
                Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
                Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                for _, x in pairs(Character:GetChildren()) do
                    if x:IsA("BasePart") then
                        x.Velocity = Vector3.new()
                        x.RotVelocity = Vector3.new()
                    end
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25 or tick() > resetTime + 3
    end)
end

flingSec:addButton("FLING MURDER", function()
    local mur = findMurderPlayer()
    if mur then SkidFling(mur); print("✅ Đã fling Murder: " .. mur.Name)
    else print("❌ Không tìm thấy Murderer") end
end)

flingSec:addButton("FLING SHERIFF", function()
    local sheff = findSheriffPlayer()
    if sheff then SkidFling(sheff); print("✅ Đã fling Sheriff: " .. sheff.Name)
    else print("❌ Không tìm thấy Sheriff") end
end)

local autoFlingMur = false; local autoFlingSheff = false
flingSec:addToggle("Auto Fling MURDER", false, function(t)
    autoFlingMur = t
    if t then
        task.spawn(function()
            while autoFlingMur do
                pcall(function()
                    local mur = findMurderPlayer()
                    if mur then SkidFling(mur) end
                end)
                task.wait(5)
            end
        end)
    end
end)

flingSec:addToggle("Auto Fling SHERIFF", false, function(t)
    autoFlingSheff = t
    if t then
        task.spawn(function()
            while autoFlingSheff do
                pcall(function()
                    local sheff = findSheriffPlayer()
                    if sheff then SkidFling(sheff) end
                end)
                task.wait(5)
            end
        end)
    end
end)

-- ===================================================================
-- [[ 13. VISUALS - ESP ]]
-- ===================================================================
_G.ESP = false
_G.ESP_Tracer = false
_G.ESP_Name = false
_G.ESPGun = false

local espDrawings = {}

local function clearESP()
    for _, d in pairs(espDrawings) do
        pcall(function()
            d.Text:Remove()
            d.Box:Remove()
            d.Tracer:Remove()
            d.HealthBar:Remove()
            d.HealthBg:Remove()
        end)
    end
    espDrawings = {}
end

local function createPlayerESP(p)
    if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") or not p.Character:FindFirstChild("Head") then return end
    
    if espDrawings[p] then
        pcall(function()
            espDrawings[p].Text:Remove()
            espDrawings[p].Box:Remove()
            espDrawings[p].Tracer:Remove()
            espDrawings[p].HealthBar:Remove()
            espDrawings[p].HealthBg:Remove()
        end)
    end
    
    local isM = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
    local isS = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
    
    local color; local role
    if isM then color = Color3.fromRGB(255, 50, 50); role = "MURDER"
    elseif isS then color = Color3.fromRGB(50, 150, 255); role = "SHERIFF"
    else color = Color3.fromRGB(50, 255, 50); role = "INNOCENT" end
    
    local text = Drawing.new("Text"); text.Size = 16; text.Center = true; text.Outline = true; text.OutlineColor = Color3.fromRGB(0,0,0); text.Color = color; text.Font = 2; text.Visible = false
    local box = Drawing.new("Square"); box.Thickness = 2; box.Color = color; box.Filled = false; box.Transparency = 0.5; box.Visible = false
    local tracer = Drawing.new("Line"); tracer.Thickness = 2; tracer.Color = color; tracer.Transparency = 0.7; tracer.Visible = false
    local healthBg = Drawing.new("Square"); healthBg.Thickness = 0; healthBg.Color = Color3.fromRGB(0,0,0); healthBg.Filled = true; healthBg.Transparency = 0.3; healthBg.Visible = false
    local healthBar = Drawing.new("Square"); healthBar.Thickness = 0; healthBar.Filled = true; healthBar.Visible = false
    
    espDrawings[p] = { Text = text, Box = box, Tracer = tracer, HealthBar = healthBar, HealthBg = healthBg, Player = p, Role = role, Color = color, IsM = isM, IsS = isS }
end

local visSec = vTab:addSection("ESP BAO BỌC + DÂY")
visSec:addToggle("ESP Bao bọc (Box + Tên + Máu)", false, function(t)
    _G.ESP = t
    if not t and not _G.ESPMurder and not _G.ESPSheriff and not _G.ESPTracer then clearESP()
    else for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then createPlayerESP(p) end end end
end)

visSec:addToggle("ESP Tracer (Dây)", false, function(t)
    _G.ESP_Tracer = t
    if t then for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then createPlayerESP(p) end end end
end)

visSec:addToggle("ESP Tên (NameTag)", false, function(t)
    _G.ESP_Name = t
    if t then for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then createPlayerESP(p) end end end
end)

local murSec = vTab:addSection("ESP RIÊNG MURDER")
murSec:addToggle("ESP Murder (Chỉ Murder)", false, function(t)
    _G.ESPMurder = t
    if t then for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then createPlayerESP(p) end end end
end)

local shefSec = vTab:addSection("ESP RIÊNG SHERIFF")
shefSec:addToggle("ESP Sheriff (Chỉ Sheriff)", false, function(t)
    _G.ESPSheriff = t
    if t then for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then createPlayerESP(p) end end end
end)

-- === ESP SÚNG RƠI ===
local gunEspSec = vTab:addSection("ESP Súng")

local function createGunESP(item)
    if not item:FindFirstChild("NH_GunESP") then
        local hl = Instance.new("Highlight", item)
        hl.Name = "NH_GunESP"
        hl.FillColor = Color3.fromRGB(0, 150, 255)
        hl.OutlineColor = Color3.new(1, 1, 1)
        
        local bb = Instance.new("BillboardGui", item)
        bb.Name = "NH_GunESP"
        bb.Size = UDim2.new(0, 200, 0, 50)
        bb.AlwaysOnTop = true
        local label = Instance.new("TextLabel", bb)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = "SÚNG"
        label.TextColor3 = Color3.fromRGB(0, 150, 255)
        label.TextSize = 25
        label.Font = Enum.Font.SourceSansBold
    end
end

gunEspSec:addToggle("ESP Súng Rơi", false, function(t)
    _G.ESPGun = t
    if not t then
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "NH_GunESP" then v:Destroy() end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if _G.ESPGun then
        for _, v in pairs(workspace:GetDescendants()) do
            if (v.Name == "GunDrop" or v.Name == "DroppedGun") then
                createGunESP(v)
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        if _G.ESP or _G.ESP_Tracer or _G.ESP_Name or _G.ESPMurder or _G.ESPSheriff then createPlayerESP(p) end
    end)
end)

Players.PlayerRemoving:Connect(function(p)
    if espDrawings[p] then
        pcall(function()
            espDrawings[p].Text:Remove(); espDrawings[p].Box:Remove(); espDrawings[p].Tracer:Remove(); espDrawings[p].HealthBar:Remove(); espDrawings[p].HealthBg:Remove()
        end)
        espDrawings[p] = nil
    end
end)

-- === SPECTATE SYSTEM ===
local specSec = vTab:addSection("Theo dõi")

local function getTarget(roleType)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if roleType == "Murder" and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then
                return p
            elseif roleType == "Sheriff" and (p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")) then
                return p
            end
        end
    end
    return nil
end

specSec:addToggle("Theo dõi Murder", false, function(t)
    _G.SpecMurder = t
    if not t then Cam.CameraSubject = LocalPlayer.Character.Humanoid end
end)

specSec:addToggle("Theo dõi Sheriff", false, function(t)
    _G.SpecSheriff = t
    if not t then Cam.CameraSubject = LocalPlayer.Character.Humanoid end
end)

RunService.RenderStepped:Connect(function()
    if _G.SpecMurder then
        local target = getTarget("Murder")
        if target and target.Character then Cam.CameraSubject = target.Character.Humanoid end
    elseif _G.SpecSheriff then
        local target = getTarget("Sheriff")
        if target and target.Character then Cam.CameraSubject = target.Character.Humanoid end
    end
end)

-- ===================================================================
-- [[ 14. TAB MUSIC ]]
-- ===================================================================
local musicSec = mTab:addSection("NHẬT HUB MUSIC")
local musicIDs = {"110919391228823","133758365650956","87319495444901","85871550851299","1839246711","115712201149548","139780631670217","137215969559232","140709876805704"}
local musicNames = {"Nhạc 1","Nhạc 2","Nhạc 3","Nhạc 4","Nhạc 5","Nhạc 6","Nhạc 7","Nhạc 8","Nhạc 9"}
local currentMusic = nil; local musicPlaying = false

-- Music Stop Frame Gothic
local stopFrame = Instance.new("Frame", sg)
stopFrame.Name = "MusicStopFrame"
stopFrame.Size = UDim2.new(0, 220, 0, 60)
stopFrame.Position = UDim2.new(0.5, -100, 0.85, 0)
stopFrame.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
stopFrame.BackgroundTransparency = 0.15
stopFrame.Visible = false
Instance.new("UICorner", stopFrame).CornerRadius = UDim.new(0, 8)

local mStroke = Instance.new("UIStroke", stopFrame)
mStroke.Color = Color3.fromRGB(150, 30, 30)
mStroke.Thickness = 2
mStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local stopLabel = Instance.new("TextLabel", stopFrame)
stopLabel.Size = UDim2.new(1, 0, 0, 20)
stopLabel.Position = UDim2.new(0, 0, 0, 5)
stopLabel.BackgroundTransparency = 1
stopLabel.Text = "ĐANG PHÁT NHẠC"
stopLabel.TextColor3 = Color3.fromRGB(200, 50, 50)
stopLabel.Font = Enum.Font.GothamBold
stopLabel.TextSize = 12

local stopBtn = Instance.new("TextButton", stopFrame)
stopBtn.Size = UDim2.new(0, 160, 0, 28)
stopBtn.Position = UDim2.new(0.5, -80, 0, 30)
stopBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
stopBtn.BackgroundTransparency = 0.1
stopBtn.Text = "TẮT NHẠC"
stopBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 12
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)

local stopBtnStroke = Instance.new("UIStroke", stopBtn)
stopBtnStroke.Color = Color3.fromRGB(150, 30, 30)
stopBtnStroke.Thickness = 1.5
stopBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

stopBtn.MouseEnter:Connect(function()
    TweenService:Create(stopBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 0, 0), TextColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)
stopBtn.MouseLeave:Connect(function()
    TweenService:Create(stopBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 0, 0), TextColor3 = Color3.fromRGB(255, 50, 50)}):Play()
end)

stopBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if currentMusic then currentMusic:Stop(); currentMusic:Destroy(); currentMusic = nil end
    end)
    musicPlaying = false; stopFrame.Visible = false
end)

local function playMusic(id)
    pcall(function()
        if currentMusic then currentMusic:Stop(); currentMusic:Destroy(); currentMusic = nil end
    end)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. id
    sound.Volume = 1; sound.Looped = true; sound.Parent = workspace
    sound:Play(); currentMusic = sound; musicPlaying = true; stopFrame.Visible = true
end

for i, id in ipairs(musicIDs) do
    musicSec:addButton(musicNames[i], function() playMusic(id) end)
end

-- ===================================================================
-- [[ RENDER LOOP ]]
-- ===================================================================
RunService.RenderStepped:Connect(function()
    local anyESP = _G.ESP or _G.ESP_Tracer or _G.ESP_Name or _G.ESPMurder or _G.ESPSheriff
    local myChar = LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local screenSize = Cam.ViewportSize
    
    if anyESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                if not espDrawings[p] then createPlayerESP(p) end
                
                local d = espDrawings[p]
                if d and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Head") then
                    local hrp = p.Character.HumanoidRootPart
                    local head = p.Character.Head
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    
                    local isM = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
                    local isS = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
                    d.IsM = isM; d.IsS = isS
                    local newColor; local newRole
                    if isM then newColor = Color3.fromRGB(255, 50, 50); newRole = "MURDER"
                    elseif isS then newColor = Color3.fromRGB(50, 150, 255); newRole = "SHERIFF"
                    else newColor = Color3.fromRGB(50, 255, 50); newRole = "INNOCENT" end
                    d.Color = newColor; d.Role = newRole
                    
                    local show = false
                    if _G.ESP then show = true end
                    if _G.ESPMurder and isM then show = true end
                    if _G.ESPSheriff and isS then show = true end
                    
                    d.Box.Visible = show; d.Text.Visible = show; d.HealthBg.Visible = show; d.HealthBar.Visible = show
                    d.Tracer.Visible = show and _G.ESP_Tracer
                    
                    local headPos, headOnScreen = Cam:WorldToViewportPoint(head.Position)
                    local hrpPos, _ = Cam:WorldToViewportPoint(hrp.Position)
                    local footPos = hrp.Position - Vector3.new(0, 3, 0)
                    local footPos2D, _ = Cam:WorldToViewportPoint(footPos)
                    
                    if headOnScreen then
                        local head2D = Vector2.new(headPos.X, headPos.Y)
                        local foot2D = Vector2.new(footPos2D.X, footPos2D.Y)
                        local boxHeight = math.abs(head2D.Y - foot2D.Y)
                        local boxWidth = boxHeight * 0.55
                        local centerX = head2D.X
                        local centerY = (head2D.Y + foot2D.Y) / 2
                        
                        d.Box.Position = Vector2.new(centerX - boxWidth / 2, head2D.Y)
                        d.Box.Size = Vector2.new(boxWidth, boxHeight)
                        d.Box.Color = d.Color
                        
                        d.Text.Position = Vector2.new(centerX, head2D.Y - 20)
                        d.Text.Text = p.Name .. " [" .. d.Role .. "]"
                        d.Text.Color = d.Color
                        
                        d.Tracer.From = Vector2.new(screenSize.X / 2, screenSize.Y)
                        d.Tracer.To = foot2D
                        d.Tracer.Color = d.Color
                        
                        if hum then
                            local healthPct = hum.Health / hum.MaxHealth
                            local barWidth = boxWidth * 0.8
                            local barHeight = 4
                            local barX = centerX - barWidth / 2
                            local barY = foot2D.Y + 8
                            
                            d.HealthBg.Position = Vector2.new(barX, barY)
                            d.HealthBg.Size = Vector2.new(barWidth, barHeight)
                            
                            d.HealthBar.Position = Vector2.new(barX, barY)
                            d.HealthBar.Size = Vector2.new(barWidth * healthPct, barHeight)
                            if healthPct > 0.5 then d.HealthBar.Color = Color3.fromRGB(50, 255, 50)
                            elseif healthPct > 0.25 then d.HealthBar.Color = Color3.fromRGB(255, 255, 50)
                            else d.HealthBar.Color = Color3.fromRGB(255, 50, 50) end
                        end
                    else
                        d.Box.Visible = false; d.Text.Visible = false; d.Tracer.Visible = false
                        d.HealthBg.Visible = false; d.HealthBar.Visible = false
                    end
                end
            end
        end
    else
        for _, d in pairs(espDrawings) do
            pcall(function()
                d.Box.Visible = false; d.Text.Visible = false; d.Tracer.Visible = false
                d.HealthBg.Visible = false; d.HealthBar.Visible = false
            end)
        end
    end
    
    -- Hitbox
    if _G.ExpandHitbox then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                for _, part in pairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        if not part:FindFirstChild("NH_OriginalSize") then
                            local sizeVal = Instance.new("Vector3Value")
                            sizeVal.Name = "NH_OriginalSize"
                            sizeVal.Value = part.Size; sizeVal.Parent = part
                        end
                        local s = _G.HitboxSize
                        part.Size = Vector3.new(s, s, s)
                    end
                end
            end
        end
    end
    
    -- Auto Reveal
    if _G.AutoRevealMurder then
        local mur, _ = findMurderAndSheriff()
        if mur and mur ~= lastMurder then
            lastMurder = mur
            local msg = "⚠️ " .. mur.DisplayName .. " LÀ MURDERER! Tránh xa ra!"
            if msg ~= lastMurderChat then lastMurderChat = msg; SayToServer("📢 [NHẬT HUB] " .. msg) end
            murLabel.Text = "<image src='rbxassetid://10734975486'/> Murder: " .. mur.DisplayName
        elseif not mur then lastMurder = nil; murLabel.Text = "<image src='rbxassetid://10734975692'/> Murder: Không tìm thấy" end
    end
    
    if _G.AutoRevealSheriff then
        local _, shef = findMurderAndSheriff()
        if shef and shef ~= lastSheriff then
            lastSheriff = shef
            local msg = "📢 " .. shef.DisplayName .. " CẦM SÚNG (SHERIFF)!"
            if msg ~= lastSheriffChat then lastSheriffChat = msg; SayToServer("📢 [NHẬT HUB] " .. msg) end
            shefLabel.Text = "<image src='rbxassetid://76078495178149'/> Sheriff: " .. shef.DisplayName
        elseif not shef then lastSheriff = nil; shefLabel.Text = "<image src='rbxassetid://10747373176'/> Sheriff: Không tìm thấy" end
    end
    
    if _G.AutoRevealBoth then
        local mur, shef = findMurderAndSheriff()
        if mur and mur ~= lastMurder then
            lastMurder = mur
            local msg = "⚠️ " .. mur.DisplayName .. " LÀ MURDERER!"
            if msg ~= lastMurderChat then lastMurderChat = msg; SayToServer("📢 [NHẬT HUB] " .. msg) end
            murLabel.Text = "<image src='rbxassetid://10734975486'/> Murder: " .. mur.DisplayName
        elseif not mur then lastMurder = nil; murLabel.Text = "<image src='rbxassetid://10734975692'/> Murder: Không tìm thấy" end
        if shef and shef ~= lastSheriff then
            lastSheriff = shef
            local msg = "📢 " .. shef.DisplayName .. " CẦM SÚNG (SHERIFF)!"
            if msg ~= lastSheriffChat then lastSheriffChat = msg; SayToServer("📢 [NHẬT HUB] " .. msg) end
            shefLabel.Text = "<image src='rbxassetid://76078495178149'/> Sheriff: " .. shef.DisplayName
        elseif not shef then lastSheriff = nil; shefLabel.Text = "<image src='rbxassetid://10747373176'/> Sheriff: Không tìm thấy" end
    end
end)

Venyx:SelectPage(pTab, true)
