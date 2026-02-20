-- [[ MOHJ HUB: SOLO HUNTERS PRIVATE SUITE ]]
repeat task.wait() until game:IsLoaded()

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")

-- GUI SETTINGS
ScreenGui.Name = "MohjHub_UI"
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 360)
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

-- Global States
_G.MohjRunning = true
local killaura = false
local noclip = false
local infjump = false
local autoloot = false

local function createBtn(text, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.9, 0, 0, 35)
    b.BackgroundColor3 = color or Color3.fromRGB(130, 0, 0)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Text = text
    b.Parent = MainFrame
    return b
end

-- 1. SPEED TOGGLE
local sBtn = createBtn("Speed: OFF")
sBtn.MouseButton1Click:Connect(function()
    local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    hum.WalkSpeed = (hum.WalkSpeed == 16) and 100 or 16
    sBtn.Text = "Speed: " .. (hum.WalkSpeed == 100 and "100" or "OFF")
    sBtn.BackgroundColor3 = (hum.WalkSpeed == 100) and Color3.fromRGB(0, 130, 0) or Color3.fromRGB(130, 0, 0)
end)

-- 2. INF JUMP TOGGLE
local jBtn = createBtn("Inf Jump: OFF")
jBtn.MouseButton1Click:Connect(function()
    infjump = not infjump
    jBtn.Text = "Inf Jump: " .. (infjump and "ON" or "OFF")
    jBtn.BackgroundColor3 = infjump and Color3.fromRGB(0, 130, 0) or Color3.fromRGB(130, 0, 0)
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infjump and _G.MohjRunning then
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
        if hum then hum:ChangeState("Jumping") end
    end
end)

-- 3. NOCLIP TOGGLE
local nBtn = createBtn("NoClip: OFF")
nBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    nBtn.Text = "NoClip: " .. (noclip and "ON" or "OFF")
    nBtn.BackgroundColor3 = noclip and Color3.fromRGB(0, 130, 0) or Color3.fromRGB(130, 0, 0)
end)

game:GetService("RunService").Stepped:Connect(function()
    if noclip and _G.MohjRunning and game.Players.LocalPlayer.Character then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- 4. KILL AURA (Based on GotHit Remote)
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
                for _, v in pairs(game.Workspace:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v ~= char then
                        local dist = (char.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                        if dist < 25 and remote then
                            remote:FireServer(v, "Weapon_DualDaggers")
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- 5. AUTO-LOOT MAGNET
local lBtn = createBtn("Auto Loot: OFF")
lBtn.MouseButton1Click:Connect(function()
    autoloot = not autoloot
    lBtn.Text = "Auto Loot: " .. (autoloot and "ON" or "OFF")
    lBtn.BackgroundColor3 = autoloot and Color3.fromRGB(0, 130, 0) or Color3.fromRGB(130, 0, 0)
    
    task.spawn(function()
        while autoloot and _G.MohjRunning do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, v in pairs(game.Workspace:GetChildren()) do
                    -- Checks for common Solo Hunter drops
                    if v.Name == "Gem" or v.Name == "Gold" or v.Name == "Coin" or v.Name:find("Ore") then
                        if v:IsA("BasePart") then
                            v.CFrame = char.HumanoidRootPart.CFrame
                            v.CanCollide = false
                        end
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end)

-- 6. UNLOAD HUB
local uBtn = createBtn("UNLOAD HUB", Color3.fromRGB(50, 50, 50))
uBtn.MouseButton1Click:Connect(function()
    _G.MohjRunning = false
    ScreenGui:Destroy()
end)
