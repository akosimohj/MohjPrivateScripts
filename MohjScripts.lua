-- [[ REPLACED LIBRARY TO FIX NIL ERROR ]]
repeat task.wait() until game:IsLoaded()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

local Window = Rayfield:CreateWindow({
   Name = "Solo Hunters | Private",
   LoadingTitle = "Loading Private Suite...",
   LoadingSubtitle = "by PrivateUser",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateToggle({
   Name = "Auto-Loot Gems",
   CurrentValue = false,
   Flag = "LootToggle", 
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
   end,
})

Rayfield:Notify({
   Title = "Success!",
   Content = "The script has loaded correctly.",
   Duration = 5,
})
