-- [[ MOHJ HUB: STABLE PRIVATE SUITE ]]
-- Features: NoClip, Infinite Jump, WalkSpeed
repeat task.wait() until game:IsLoaded()

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local JumpBtn = Instance.new("TextButton")
local NoClipBtn = Instance.new("TextButton")

-- GUI SETTINGS
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "MohjHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true -- You can drag the menu

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Text = "MOHJ HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20

local function makeBtn(text, yPos)
    local b = Instance.new("TextButton")
    b.Parent = MainFrame
    b.Size = UDim2.new(0.8, 0, 0, 40)
    b.Position = UDim2.new(0.1, 0, 0, yPos)
    b.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Text = text
    return b
end

-- 1. WALK SPEED (Toggle 100 Speed)
local speedActive = false
local speedBtn = makeBtn("Speed: OFF", 50)
speedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    speedBtn.Text = "Speed: " .. (speedActive and "100" or "OFF")
    speedBtn.BackgroundColor3 = speedActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    
    task.spawn(function()
        while speedActive do
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
            end
            task.wait(0.1)
        end
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end)
end)

-- 2. INFINITE JUMP
local infJump = false
local jumpBtn = makeBtn("Inf Jump: OFF", 105)
jumpBtn.MouseButton1Click:Connect(function()
    infJump = not infJump
    jumpBtn.Text = "Inf Jump: " .. (infJump and "ON" or "OFF")
    jumpBtn.BackgroundColor3 = infJump and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infJump then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
    end
end)

-- 3. NOCLIP
local noclip = false
local noclipBtn = makeBtn("NoClip: OFF", 160)
noclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    noclipBtn.Text = "NoClip: " .. (noclip and "ON" or "OFF")
    noclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)
