-- [[ SOLO HUNTERS PRIVATE SCRIPT ]]
-- Wait for game to load fully
repeat task.wait() until game:IsLoaded()

-- Load Orion Library (Stable GitHub Link)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com')))()

-- Create Main Window
local Window = OrionLib:MakeWindow({
    Name = "Solo Hunters | Private Suite", 
    HidePremium = true, 
    SaveConfig = true, 
    ConfigFolder = "SoloHunters_Private"
})

-- tabs
local MainTab = Window:MakeTab({
	Name = "Main Features",
	Icon = "rbxassetid://4483362458",
	PremiumOnly = false
})

-- [[ AUTO LOOT TOGGLE ]]
MainTab:AddToggle({
	Name = "Auto-Loot Gems/Gold",
	Default = false,
	Callback = function(Value)
		_G.AutoLoot = Value
		task.spawn(function()
			while _G.AutoLoot do
				-- Scan Workspace for dropped items
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

-- [[ SPEED SLIDER ]]
MainTab:AddSlider({
	Name = "Walkspeed",
	Min = 16,
	Max = 250,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

-- [[ JUMP POWER ]]
MainTab:AddSlider({
	Name = "Jump Power",
	Min = 50,
	Max = 300,
	Default = 50,
	Increment = 1,
	ValueName = "Power",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end    
})

OrionLib:Init()

-- Notification
OrionLib:MakeNotification({
	Name = "Script Loaded!",
	Content = "Welcome to your private Solo Hunters script.",
	Image = "rbxassetid://4483362458",
	Time = 5
})
