-- ============================================================
-- NHẬT HUB - MODULE (LOGIC)
-- ============================================================

local NhatHub = {}

-- [[ 1. BIẾN TOÀN CỤC ]]
NhatHub.SilentAim = false
NhatHub.AutoShoot = false
NhatHub.AimPart = "UpperTorso"
NhatHub.AntiFling = false
NhatHub.ESP = false
NhatHub.ESP_Tracer = false
NhatHub.ESP_Name = false
NhatHub.ESPMurder = false
NhatHub.ESPSheriff = false
NhatHub.ESPGun = false
NhatHub.Speed = 16
NhatHub.JumpPower = 50
NhatHub.SpeedToggle = false
NhatHub.JumpToggle = false
NhatHub.Noclip = false
NhatHub.Xray = false
NhatHub.AutoKillAll = false
NhatHub.InfiniteJump = false
NhatHub.ExpandHitbox = false
NhatHub.HitboxSize = 8
NhatHub.AutoFarmCoin = false
NhatHub.FarmSpeed = 50
NhatHub.AutoGetGun = false
NhatHub.AutoWallhop = false
NhatHub.GhostEnabled = false
NhatHub.GhostKeybind = Enum.KeyCode.G
NhatHub.MurKeybind = Enum.KeyCode.Q
NhatHub.ShefKeybind = Enum.KeyCode.Z
NhatHub.ShootMurderKey = Enum.KeyCode.R
NhatHub.ShootPrediction = 0.2
NhatHub.PinFarm = false
NhatHub.ShowFPSPing = true
NhatHub.FOVToggle = false
NhatHub.FOVValue = 70
NhatHub.AutoKillSheriff = false
NhatHub.AutoKillTele = false
NhatHub.TeleKillAll = false
NhatHub.SpecMurder = false
NhatHub.SpecSheriff = false
NhatHub.AutoRevealMurder = false
NhatHub.AutoRevealSheriff = false
NhatHub.AutoRevealBoth = false

-- Fly System
NhatHub.isFlying = false
NhatHub.flyUIVisible = true
NhatHub.currentFlySpeed = 50

-- Speed Glitch & Jump
NhatHub.glitchEnabled = false
NhatHub.glitchPower = 16
NhatHub.glitchLoop = nil
NhatHub.glitchPercent = 0
NhatHub.jumppower = 50
NhatHub.jumpEnabled = false

-- ESP
NhatHub.espDrawings = {}
NhatHub.lastMurder = nil
NhatHub.lastSheriff = nil
NhatHub.lastMurderChat = ""
NhatHub.lastSheriffChat = ""

-- Fix Lag
NhatHub.isFixLagRunning = false

-- FPS/Ping
NhatHub.fpsValues = {}
NhatHub.pingValues = {}
NhatHub.isStatsRunning = false

-- Music
NhatHub.currentMusic = nil
NhatHub.musicPlaying = false

-- [[ 2. HÀM HỖ TRỢ ]]

-- Hàm gửi chat
function NhatHub.SayToServer(text)
    pcall(function()
        local TextChatService = game:GetService("TextChatService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(text)
        else
            local SayMessageEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
            if SayMessageEvent then SayMessageEvent:FireServer(text, "All") end
        end
    end)
end

-- Hàm tìm Murder và Sheriff
function NhatHub.findMurderAndSheriff()
    local mur = nil; local sheff = nil
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local isM = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
            local isS = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
            if isM then mur = p end; if isS then sheff = p end
        end
    end
    return mur, sheff
end

function NhatHub.findMurderName()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and (p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")) then return p.Name end
    end
    return nil
end

-- [[ 3. GHOST SYSTEM ]]
NhatHub.GhostData = {
    IsActive = false,
    FakeChar = nil,
    SkyPos = Vector3.new(0, 1000, 0),
    FakeCharName = "Ghost_Pin_V162_" .. tostring(math.random(1000, 9999))
}

function NhatHub.SetTransparency(char, trans)
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            v.Transparency = trans
        end
    end
end

function NhatHub.ToggleGhost()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Cam = workspace.CurrentCamera
    local RunService = game:GetService("RunService")
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")

    if not char or not hrp or not hum then return end

    if not NhatHub.GhostEnabled then
        if NhatHub.GhostData.IsActive then
            RunService:UnbindFromRenderStep("GhostLogic")
            if NhatHub.GhostData.FakeChar then
                hrp.Velocity = Vector3.new(0, 0, 0)
                hrp.CFrame = NhatHub.GhostData.FakeChar.HumanoidRootPart.CFrame
                hrp.Anchored = true; task.wait(0.1); hrp.Anchored = false
                NhatHub.SetTransparency(char, 0)
                Cam.CameraSubject = hum
                NhatHub.GhostData.FakeChar:Destroy()
                NhatHub.GhostData.FakeChar = nil
            end
            NhatHub.GhostData.IsActive = false
        end
        return
    end

    NhatHub.GhostData.IsActive = not NhatHub.GhostData.IsActive

    if NhatHub.GhostData.IsActive then
        char.Archivable = true
        NhatHub.GhostData.FakeChar = char:Clone()
        NhatHub.GhostData.FakeChar.Parent = workspace
        NhatHub.GhostData.FakeChar.Name = NhatHub.GhostData.FakeCharName
        NhatHub.SetTransparency(NhatHub.GhostData.FakeChar, 0.5)
        NhatHub.GhostData.FakeChar.HumanoidRootPart.CanCollide = false

        NhatHub.SetTransparency(char, 1)
        Cam.CameraSubject = NhatHub.GhostData.FakeChar.Humanoid

        RunService:BindToRenderStep("GhostLogic", 201, function()
            if not NhatHub.GhostData.IsActive or not NhatHub.GhostData.FakeChar then return end
            if Cam.CameraSubject ~= NhatHub.GhostData.FakeChar.Humanoid then
                Cam.CameraSubject = NhatHub.GhostData.FakeChar.Humanoid
            end

            local tool = char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
            local lookDir = Cam.CFrame.LookVector
            local flatLookDir = Vector3.new(lookDir.X, 0, lookDir.Z).Unit

            if tool then
                hrp.CFrame = CFrame.new(NhatHub.GhostData.FakeChar.HumanoidRootPart.Position, NhatHub.GhostData.FakeChar.HumanoidRootPart.Position + flatLookDir)
                hrp.Velocity = Vector3.new(0, 0, 0)
                NhatHub.SetTransparency(char, 0)
            else
                hrp.CFrame = CFrame.new(NhatHub.GhostData.SkyPos.X, NhatHub.GhostData.SkyPos.Y, NhatHub.GhostData.SkyPos.Z) * CFrame.Angles(0, math.atan2(-flatLookDir.X, -flatLookDir.Z), 0)
                hrp.Velocity = Vector3.new(0, 0, 0)
                NhatHub.SetTransparency(char, 1)
            end

            NhatHub.GhostData.FakeChar.HumanoidRootPart.CFrame = CFrame.new(NhatHub.GhostData.FakeChar.HumanoidRootPart.Position, NhatHub.GhostData.FakeChar.HumanoidRootPart.Position + flatLookDir)
            NhatHub.GhostData.FakeChar.Humanoid:Move(hum.MoveDirection)
            if hum.Jump then NhatHub.GhostData.FakeChar.Humanoid.Jump = true end
        end)
    else
        RunService:UnbindFromRenderStep("GhostLogic")
        if NhatHub.GhostData.FakeChar then
            hrp.Velocity = Vector3.new(0, 0, 0)
            hrp.CFrame = NhatHub.GhostData.FakeChar.HumanoidRootPart.CFrame
            hrp.Anchored = true; task.wait(0.1); hrp.Anchored = false
            NhatHub.SetTransparency(char, 0)
            Cam.CameraSubject = hum
            NhatHub.GhostData.FakeChar:Destroy()
            NhatHub.GhostData.FakeChar = nil
        end
    end
end

-- [[ 4. SPEED GLITCH & JUMP POWER ]]
function NhatHub.toggleSpeedGlitch(state)
    NhatHub.glitchEnabled = state
    if state then
        NhatHub.glitchLoop = RunService.Heartbeat:Connect(function()
            if not NhatHub.glitchEnabled then return end
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                local hum = char.Humanoid
                local root = char:FindFirstChild("HumanoidRootPart")
                if hum.FloorMaterial == Enum.Material.Air then
                    hum.WalkSpeed = NhatHub.glitchPower
                    if root and NhatHub.glitchPercent > 0 then
                        root.Velocity = root.Velocity + (root.CFrame.LookVector * (NhatHub.glitchPercent/100) * 1.5)
                    end
                else
                    if hum.WalkSpeed ~= 16 then hum.WalkSpeed = 16 end
                end
            end
        end)
    else
        if NhatHub.glitchLoop then
            NhatHub.glitchLoop:Disconnect()
            NhatHub.glitchLoop = nil
        end
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
    end
end

function NhatHub.applyJump()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = NhatHub.jumpEnabled and NhatHub.jumppower or 50
        end
    end
end

-- [[ 5. FLY SYSTEM ]]
local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local PlayerModule = require(player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local controls = PlayerModule:GetControls()

local flyIdleTrack, flyMoveTrack, flyVelocityHandler, flyOrientationHandler, flyAttachment, flyConnection

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

function NhatHub.StopFlying(humanoid)
    NhatHub.isFlying = false
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

function NhatHub.StartFlying(character, humanoid)
    local rootPart = character:WaitForChild("HumanoidRootPart")
    NhatHub.isFlying = true
    
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
            NhatHub.StopFlying(humanoid)
            return
        end
        
        local camera = workspace.CurrentCamera
        local moveVector = controls:GetMoveVector()
        
        if moveVector.Magnitude > 0 then
            stopTrack(flyIdleTrack)
            playTrack(flyMoveTrack)
            
            local camCFrame = camera.CFrame
            local flyDir = (camCFrame * CFrame.new(moveVector)).Position - camCFrame.Position
            flyVelocityHandler.VectorVelocity = flyDir.Unit * NhatHub.currentFlySpeed
            flyOrientationHandler.CFrame = camCFrame
        else
            stopTrack(flyMoveTrack)
            playTrack(flyIdleTrack)
            
            flyVelocityHandler.VectorVelocity = Vector3.new(0, 0, 0)
            flyOrientationHandler.CFrame = camera.CFrame
        end
    end)
end

function NhatHub.LoadFlyAnimations(character)
    local humanoid = character:WaitForChild("Humanoid")
    local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
    
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        if track.Name == "FlyIdle" or track.Name == "FlyMove" then
            track:Stop(0)
        end
    end
    
    flyIdleTrack = loadFlyAnim(animator, "rbxassetid://91106826233224", Enum.AnimationPriority.Action4)
    flyIdleTrack.Name = "FlyIdle"
    
    flyMoveTrack = loadFlyAnim(animator, "rbxassetid://114833664438028", Enum.AnimationPriority.Action4)
    flyMoveTrack.Name = "FlyMove"
end

function NhatHub.InitFlySystem()
    if NhatHub.flyUIVisible then
        NhatHub.LoadFlyAnimations(LocalPlayer.Character)
    end
end

-- [[ 6. FIX LAG ]]
function NhatHub.StripPlayer(character)
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

function NhatHub.RunFixLag()
    if NhatHub.isFixLagRunning then return end
    NhatHub.isFixLagRunning = true

    coroutine.wrap(function()
        local workspace = game:GetService("Workspace")
        local Lighting = game:GetService("Lighting")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

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

        for _, c in ipairs(workspace:GetDescendants()) do
            if c:IsA("ParticleEmitter") or c:IsA("Smoke") or c:IsA("Fire") or c:IsA("Sparkles") or c:IsA("Trail") or c:IsA("Beam") then
                pcall(function() c:Destroy() end)
            end
            if c:IsA("Sound") then
                pcall(function() c:Destroy() end)
            end
        end

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then NhatHub.StripPlayer(plr.Character) end
        end

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

        pcall(setfpscap, 200)

        Players.PlayerAdded:Connect(function(plr)
            plr.CharacterAdded:Connect(function(char)
                task.wait(1)
                NhatHub.StripPlayer(char)
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

        NhatHub.isFixLagRunning = false
    end)()
end

-- [[ 7. ESP ]]
function NhatHub.CreatePlayerESP(p)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") or not p.Character:FindFirstChild("Head") then return end
    
    if NhatHub.espDrawings[p] then
        pcall(function()
            NhatHub.espDrawings[p].Text:Remove()
            NhatHub.espDrawings[p].Box:Remove()
            NhatHub.espDrawings[p].Tracer:Remove()
            NhatHub.espDrawings[p].HealthBar:Remove()
            NhatHub.espDrawings[p].HealthBg:Remove()
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
    
    NhatHub.espDrawings[p] = { Text = text, Box = box, Tracer = tracer, HealthBar = healthBar, HealthBg = healthBg, Player = p, Role = role, Color = color, IsM = isM, IsS = isS }
end

function NhatHub.RenderLoop()
    local RunService = game:GetService("RunService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Cam = workspace.CurrentCamera
    
    local anyESP = NhatHub.ESP or NhatHub.ESP_Tracer or NhatHub.ESP_Name or NhatHub.ESPMurder or NhatHub.ESPSheriff
    local myChar = LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local screenSize = Cam.ViewportSize
    
    if anyESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                if not NhatHub.espDrawings[p] then NhatHub.CreatePlayerESP(p) end
                
                local d = NhatHub.espDrawings[p]
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
                    if NhatHub.ESP then show = true end
                    if NhatHub.ESPMurder and isM then show = true end
                    if NhatHub.ESPSheriff and isS then show = true end
                    
                    d.Box.Visible = show; d.Text.Visible = show; d.HealthBg.Visible = show; d.HealthBar.Visible = show
                    d.Tracer.Visible = show and NhatHub.ESP_Tracer
                    
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
        for _, d in pairs(NhatHub.espDrawings) do
            pcall(function()
                d.Box.Visible = false; d.Text.Visible = false; d.Tracer.Visible = false
                d.HealthBg.Visible = false; d.HealthBar.Visible = false
            end)
        end
    end
    
    -- Hitbox
    if NhatHub.ExpandHitbox then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                for _, part in pairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        if not part:FindFirstChild("NH_OriginalSize") then
                            local sizeVal = Instance.new("Vector3Value")
                            sizeVal.Name = "NH_OriginalSize"
                            sizeVal.Value = part.Size; sizeVal.Parent = part
                        end
                        local s = NhatHub.HitboxSize
                        part.Size = Vector3.new(s, s, s)
                    end
                end
            end
        end
    end
    
    -- Auto Reveal
    if NhatHub.AutoRevealMurder then
        local mur = NhatHub.findMurderAndSheriff()
        if mur and mur ~= NhatHub.lastMurder then
            NhatHub.lastMurder = mur
            local msg = "⚠️ " .. mur.DisplayName .. " LÀ MURDERER! Tránh xa ra!"
            if msg ~= NhatHub.lastMurderChat then
                NhatHub.lastMurderChat = msg
                NhatHub.SayToServer("📢 [NHẬT HUB] " .. msg)
            end
        end
    end
    
    if NhatHub.AutoRevealSheriff then
        local mur, shef = NhatHub.findMurderAndSheriff()
        if shef and shef ~= NhatHub.lastSheriff then
            NhatHub.lastSheriff = shef
            local msg = "📢 " .. shef.DisplayName .. " CẦM SÚNG (SHERIFF)!"
            if msg ~= NhatHub.lastSheriffChat then
                NhatHub.lastSheriffChat = msg
                NhatHub.SayToServer("📢 [NHẬT HUB] " .. msg)
            end
        end
    end
end

-- [[ 8. MUSIC ]]
function NhatHub.playMusic(id)
    pcall(function()
        if NhatHub.currentMusic then
            NhatHub.currentMusic:Stop()
            NhatHub.currentMusic:Destroy()
            NhatHub.currentMusic = nil
        end
    end)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. id
    sound.Volume = 1
    sound.Looped = true
    sound.Parent = workspace
    sound:Play()
    NhatHub.currentMusic = sound
    NhatHub.musicPlaying = true
end

-- [[ 9. FPS/PING LOOP ]]
function NhatHub.StartStatsLoop()
    if NhatHub.isStatsRunning then return end
    NhatHub.isStatsRunning = true
    coroutine.wrap(function()
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        while true do
            task.wait()
            local fps = math.floor(1 / (RunService.RenderStepped:Wait() or 0.016))
            table.insert(NhatHub.fpsValues, fps)
            if #NhatHub.fpsValues > 10 then table.remove(NhatHub.fpsValues, 1) end
            local avgFps = 0
            for _, v in ipairs(NhatHub.fpsValues) do avgFps = avgFps + v end
            avgFps = math.floor(avgFps / #NhatHub.fpsValues)

            local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
            table.insert(NhatHub.pingValues, ping)
            if #NhatHub.pingValues > 10 then table.remove(NhatHub.pingValues, 1) end
            local avgPing = 0
            for _, v in ipairs(NhatHub.pingValues) do avgPing = avgPing + v end
            avgPing = math.floor(avgPing / #NhatHub.pingValues)

            if NhatHub.ShowFPSPing then
                -- Cập nhật label sẽ do UI xử lý
            end
        end
    end)()
end

-- [[ 10. TELEPORT FUNCTIONS ]]
function NhatHub.teleLobby()
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

function NhatHub.teleMap()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local mur, sheff = NhatHub.findMurderAndSheriff()
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

function NhatHub.doTele(role)
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

-- [[ 11. AUTO KILL FUNCTIONS ]]
function NhatHub.StartAutoShootMur()
    task.spawn(function()
        while NhatHub.AutoShootMur do
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local gun = char:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
                if not gun then return end
                local murName = NhatHub.findMurderName()
                if not murName then task.wait(0.5); return end
                local mur = Players[murName]
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local murHRP = mur.Character and mur.Character:FindFirstChild("HumanoidRootPart")
                if hrp and murHRP then
                    local oldPos = hrp.CFrame
                    hrp.CFrame = murHRP.CFrame * CFrame.new(0, 0, 8)
                    if gun.Parent ~= char then char.Humanoid:EquipTool(gun); task.wait(0.05) end
                    local shootRemote = gun:FindFirstChild("Shoot")
                    if shootRemote then shootRemote:FireServer(CFrame.new(hrp.Position), CFrame.new(murHRP.Position)) end
                    task.wait(0.3)
                    pcall(function() hrp.CFrame = oldPos end)
                end
            end)
            task.wait(3)
        end
    end)
end

function NhatHub.StartAutoGetGun()
    task.spawn(function()
        while NhatHub.AutoGetGun do
            pcall(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local hasGun = char:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
                if hasGun then task.wait(1); return end
                local gun = nil
                for _, v in pairs(workspace:GetDescendants()) do
                    if (v.Name == "GunDrop" or v.Name == "DroppedGun" or (v.Name:find("Gun") and v:IsA("Tool"))) and v:IsA("BasePart") then
                        gun = v; break
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
    end)
end

function NhatHub.StartAutoKillAll()
    task.spawn(function()
        while NhatHub.AutoKillAll do
            pcall(function()
                local char = LocalPlayer.Character
                if not char then return end
                local knife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
                if not knife then return end
                if knife.Parent ~= char then char.Humanoid:EquipTool(knife); task.wait(0.1) end
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

function NhatHub.StartAutoKillSheriff()
    task.spawn(function()
        while NhatHub.AutoKillSheriff do
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
end

function NhatHub.StartAutoKillTele()
    task.spawn(function()
        while NhatHub.AutoKillTele do
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local knife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
                if not knife then return end
                if knife.Parent ~= char then char.Humanoid:EquipTool(knife) end
                for _, p in pairs(Players:GetPlayers()) do
                    if NhatHub.AutoKillTele and p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
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

function NhatHub.StartTeleKillAll()
    task.spawn(function()
        while NhatHub.TeleKillAll do
            pcall(function()
                local char = LocalPlayer.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                local knife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
                if not knife then return end
                if knife.Parent ~= char then char.Humanoid:EquipTool(knife) end
                char.HumanoidRootPart.CanCollide = false
                for _, p in pairs(Players:GetPlayers()) do
                    if NhatHub.TeleKillAll and p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
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

-- [[ 12. FLING FUNCTIONS ]]
function NhatHub.findMurderPlayer()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local isM = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
            if isM then return p end
        end
    end
    return nil
end

function NhatHub.findSheriffPlayer()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local isS = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
            if isS then return p end
        end
    end
    return nil
end

function NhatHub.SkidFling(TargetPlayer)
    pcall(function()
        if not TargetPlayer or not TargetPlayer.Character then return end
        local Character = LocalPlayer.Character; if not Character then return end
        local Humanoid = Character:FindFirstChildOfClass("Humanoid"); local RootPart = Humanoid and Humanoid.RootPart; if not RootPart then return end
        local TCharacter = TargetPlayer.Character; local THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
        local TRootPart = THumanoid and THumanoid.RootPart; local THead = TCharacter:FindFirstChild("Head")
        if not TRootPart and not THead then return end
        getgenv().OldPos = RootPart.CFrame; getgenv().FPDH = workspace.FallenPartsDestroyHeight; workspace.FallenPartsDestroyHeight = 0/0
        local BV = Instance.new("BodyVelocity"); BV.Name = "FlingBV"; BV.Parent = RootPart; BV.Velocity = Vector3.new(9e8, 9e8, 9e8); BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false); local TargetPart = TRootPart or THead; local startTime = tick()
        repeat
            RootPart.CFrame = CFrame.new(TargetPart.Position) * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(tick() * 100), 0, 0)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7); RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            Character:SetPrimaryPartCFrame(CFrame.new(TargetPart.Position) * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(tick() * 100), 0, 0))
            task.wait()
        until TargetPart.Velocity.Magnitude > 500 or tick() > startTime + 3 or not TargetPlayer.Character or THumanoid.Health <= 0
        BV:Destroy(); Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true); workspace.FallenPartsDestroyHeight = getgenv().FPDH
        local resetTime = tick()
        repeat
            pcall(function()
                RootPart.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0); Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
                Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                for _, x in pairs(Character:GetChildren()) do if x:IsA("BasePart") then x.Velocity = Vector3.new(); x.RotVelocity = Vector3.new() end end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25 or tick() > resetTime + 3
    end)
end

function NhatHub.FlingMurder()
    local mur = NhatHub.findMurderPlayer()
    if mur then NhatHub.SkidFling(mur); print("✅ Đã fling Murder: " .. mur.Name)
    else print("❌ Không tìm thấy Murderer") end
end

function NhatHub.FlingSheriff()
    local sheff = NhatHub.findSheriffPlayer()
    if sheff then NhatHub.SkidFling(sheff); print("✅ Đã fling Sheriff: " .. sheff.Name)
    else print("❌ Không tìm thấy Sheriff") end
end

-- [[ 13. ANTI AFK ]]
function NhatHub.StartAntiAFK()
    local VirtualUser = game:GetService("VirtualUser")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- [[ 14. ANTI VOID ]]
function NhatHub.StartAntiVoid()
    task.spawn(function()
        while NhatHub.AntiVoid do
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp and hrp.Position.Y < -50 then
                    hrp.CFrame = CFrame.new(0, 50, 0)
                end
            end
            task.wait(0.3)
        end
    end)
end

-- [[ 15. ANTI FLING ]]
function NhatHub.StartAntiFling()
    task.spawn(function()
        while NhatHub.AntiFling do
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
            task.wait(0.1)
        end
    end)
end

-- [[ 16. SPECTATE ]]
function NhatHub.getTarget(roleType)
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

-- [[ 17. INIT ]]
function NhatHub.Init()
    NhatHub.StartStatsLoop()
    NhatHub.InitFlySystem()
    NhatHub.StartAntiAFK()
end

NhatHub.Init()

return NhatHub
