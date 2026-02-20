-- [[ TORA ISME STYLE PRIVATE HUB: SOLO HUNTERS ]]
repeat task.wait() until game:IsLoaded()

local repo = 'https://raw.githubusercontent.com'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()

-- 1. Create the Main Window
local Window = Library:CreateWindow({
    Title = 'Solo Hunters | Private Hub',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

-- 2. Create Navigation Tabs
local Tabs = {
    Main = Window:AddTab('Main Features'),
    Combat = Window:AddTab('Combat'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- 3. Create Groupboxes (The "Tora" look)
local FarmBox = Tabs.Main:AddLeftGroupbox('Automation')
local MovementBox = Tabs.Main:AddRightGroupbox('Movement')
local CombatBox = Tabs.Combat:AddLeftGroupbox('Attack Features')

-- 4. Automation Features
FarmBox:AddToggle('AutoLoot', {
    Text = 'Auto-Loot Gems/Gold',
    Default = false,
    Tooltip = 'Pulls all dropped items to you instantly',
    Callback = function(Value)
        _G.AutoLoot = Value
        task.spawn(function()
            while _G.AutoLoot do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "Gem" or v.Name == "Gold" or v.Name == "Coin" then
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
    end
})

-- 5. Movement Features
MovementBox:AddSlider('Speed', {
    Text = 'WalkSpeed',
    Default = 16,
    Min = 16,
    Max = 250,
    Rounding = 0,
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

MovementBox:AddSlider('Jump', {
    Text = 'Jump Power',
    Default = 50,
    Min = 50,
    Max = 300,
    Rounding = 0,
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end
})

-- 6. Combat Features
CombatBox:AddToggle('KillAura', {
    Text = 'Kill Aura (Closest)',
    Default = false,
    Callback = function(Value)
        _G.KillAura = Value
        task.spawn(function()
            while _G.KillAura do
                -- Logic for finding closest mob and firing remote goes here
                task.wait(0.1)
            end
        end)
    end
})

-- 7. Theme Manager (Customize colors)
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('MohjPrivateHub')
ThemeManager:ApplyToTab(Tabs['UI Settings'])

Library:Notify('Private Hub Loaded Successfully!', 5)
