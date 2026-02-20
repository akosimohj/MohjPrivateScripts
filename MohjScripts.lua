-- [[ MOHJ HUB: SOLO HUNTERS PRIVATE ]]
repeat task.wait() until game:IsLoaded()

-- Stable Library Loader with Safety Check
local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com'))()
end)

if not success or not OrionLib then
    warn("MOHJ HUB: Failed to load UI Library. Check your executor's internet connection.")
    return
end

-- 1. Create the Main Window
local Window = OrionLib:MakeWindow({
    Name = "Mohj Hub | Solo Hunters", 
    HidePremium = true, 
    SaveConfig = true, 
    ConfigFolder = "MohjHub_Private"
})

-- 2. Create Tabs
local MainTab = Window:MakeTab({
	Name = "Main Features",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

local CombatTab = Window:MakeTab({
	Name = "Combat",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

-- 3. Features: Auto Loot
MainTab:AddToggle({
	Name = "Auto-Loot Gems/Gold",
	Default = false,
	Callback = function(Value)
		_G.AutoLoot = Value
		task.spawn(function()
			while _G.AutoLoot do
				for _, v in pairs(game.Workspace:GetChildren()) do
					if v.Name == "Gem" or v.Name == "Gold" or v.Name == "Coin" then
						if v:IsA("BasePart") then
							v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                            v.CanCollide = false
						end
					end
				end
				task.wait(0.3)
			end
		end)
	end    
})

-- 4. Features: Movement
MainTab:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 250,
	Default = 16,
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

-- 5. Features: Combat (Kill Aura Template)
CombatTab:AddToggle({
	Name = "Kill Aura (Closest Mob)",
	Default = false,
	Callback = function(Value)
		_G.KillAura = Value
		-- Add your specific Solo Hunters Damage Remote here later
	end    
})

OrionLib:Init()

-- Load Notification
OrionLib:MakeNotification({
	Name = "Mohj Hub Loaded!",
	Content = "Successfully initialized private suite.",
	Image = "rbxassetid://4483362458",
	Time = 5
})
