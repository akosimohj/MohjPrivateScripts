-- [[ SELF-CONTAINED PRIVATE HUB - NO EXTERNAL DOWNLOADS ]]
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com"))()

-- This check prevents the 'nil' error by stopping the script if the link fails
if not Library then 
    warn("UI Library failed to load. Check your internet/executor.")
    return 
end

local Window = Library:MakeWindow({
    Name = "Solo Hunters | Private Hub", 
    HidePremium = true, 
    SaveConfig = true, 
    ConfigFolder = "Mohj_Private"
})

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
					if v.Name == "Gem" or v.Name == "Gold" then
						if v:IsA("BasePart") then
							v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
						end
					end
				end
				task.wait(0.5)
			end
		end)
	end    
})

MainTab:AddSlider({
	Name = "Walkspeed",
	Min = 16, Max = 250, Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(v)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
	end    
})

Library:Init()
