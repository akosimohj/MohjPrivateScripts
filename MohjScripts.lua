-- [[ MOHJ HUB: GHOST GOD MODE UPDATE ]]
repeat task.wait() until game:IsLoaded()

-- 1. AUTO-REFRESH: Cleans old versions
local oldUI = game.CoreGui:FindFirstChild("MohjHub_UI")
if oldUI then
    _G.MohjRunning = false 
    oldUI:Destroy()
    task.wait(0.1)
end

-- GUI SETTINGS
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "MohjHub_UI"
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 310)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "MOHJ HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18

UIListLayout.Parent = MainFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- States
_G.MohjRunning = true
local killaura, godmode = false, false

local function createBtn(text, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.BackgroundColor3 = color or Color3.fromRGB(130, 0, 0)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Text = text
    b.Parent = MainFrame
    return b
end

-- 2. GHOST GOD MODE (Attacks pass through you)
local gBtn = createBtn("God Mode: OFF")
gBtn.MouseButton1Click:Connect(function()
    godmode = not godmode
    gBtn.Text = "God Mode: " .. (godmode and "ON" or "OFF")
    gBtn.BackgroundColor3 = godmode and Color3.fromRGB(0, 130, 0) or Color3.fromRGB(130, 0, 0)
    
    task.spawn(function()
        while godmode and _G.MohjRunning do
            local char = game.Players.LocalPlayer.Character
            if char then
                -- Method: Makes character non-targetable by most mob scripts
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("BasePart") then
                        v.CanTouch = not godmode -- Disables damage touch events
                    end
                end
                -- Secondary: Keeps HP full if a remote hit still lands
                if char:FindFirstChild("Humanoid") then
                    char.Humanoid.Health = char.Humanoid.MaxHealth
                end
            end
            task.wait(0.1)
        end
        -- Reset on OFF
        for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") then v.CanTouch = true end
        end
    end)
end)

-- 3. KILL AURA (Exact Log Arguments Fix)
local kaBtn = createBtn("Kill Aura: OFF")
kaBtn.MouseButton1Click:Connect(function()
    killaura = not killaura
    kaBtn.Text = "Kill Aura: " .. (killaura and "ON" or "OFF")
    kaBtn.BackgroundColor3 = killaura and Color3.fromRGB(0, 130, 0) or Color3.fromRGB(130, 0, 0)
    
    task.spawn(function()
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("GotHit", true)
        while killaura and _G.MohjRunning do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, mob in pairs(game.Workspace:GetDescendants()) do
                    if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob ~= char then
                        local root = mob:FindFirstChild("HumanoidRootPart")
                        if root and (char.HumanoidRootPart.Position - root.Position).Magnitude < 35 then
                            if remote then 
                                -- Using the secret arguments from your logs
                                remote:FireServer(mob, "Weapon_DualDaggers", 0, "go hide it or smth") 
                            end
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- 4. SPEED BUTTON
local sBtn = createBtn("Speed: OFF")
sBtn.MouseButton1Click:Connect(function()
    local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    hum.WalkSpeed = (hum.WalkSpeed == 16) and 100 or 16
    sBtn.Text = "Speed: " .. (hum.WalkSpeed == 100 and "100" or "OFF")
    sBtn.BackgroundColor3 = (hum.WalkSpeed == 100) and Color3.fromRGB(0, 130, 0) or Color3.fromRGB(130, 0, 0)
end)

-- 5. UNLOAD BUTTON
local uBtn = createBtn("UNLOAD HUB", Color3.fromRGB(50, 50, 50))
uBtn.MouseButton1Click:Connect(function()
    _G.MohjRunning = false
    ScreenGui:Destroy()
end)
