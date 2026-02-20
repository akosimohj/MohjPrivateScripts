-- [[ MOHJ HUB: NO-DOWNLOAD STABLE VERSION ]]
repeat task.wait() until game:IsLoaded()

-- Using a more stable loader link for Orion
local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com'))()
end)

if not success or not OrionLib then
    -- If the library fails, this will make your character jump as a backup test
    warn("MOHJ HUB: Connection Error. Character jump triggered as test.")
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
    return
end

-- 1. Create the Main Window
local Window = OrionLib:MakeWindow({
    Name = "Mohj Hub | Solo Hunters", 
    HidePremium = true, 
    SaveConfig = true, 
    ConfigFolder = "MohjHub_Private"
})

-- 2. Main Tab
local MainTab = Window:MakeTab({
	Name = "Main Features",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

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
						end
					end
				end
				task.wait(0.3)
			end
		end)
	end    
})

MainTab:AddSlider({
	Name = "WalkSpeed",
	Min = 16, Max = 200, Default = 16,
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

OrionLib:Init()
