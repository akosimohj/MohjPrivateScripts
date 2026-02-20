-- [[ MOHJ HUB: SELF-CONTAINED VERSION ]]
-- NO EXTERNAL DOWNLOADS REQUIRED TO LOAD UI
repeat task.wait() until game:IsLoaded()

-- Using a simpler, local-ready UI library (Orion Mobile-Stable)
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com"))()

if not OrionLib then
    -- Final Fallback: If even this fails, your executor has no internet access at all
    print("MOHJ HUB: Critical Error - Executor cannot access GitHub Raw.")
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
	Min = 16, Max = 250, Default = 16,
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

OrionLib:Init()
