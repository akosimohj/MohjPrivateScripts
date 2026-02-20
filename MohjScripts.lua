print("--- STARTING JUMP TEST ---")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- This will make you jump 5 times automatically to prove the script is running
task.spawn(function()
    for i = 1, 5 do
        print("Jumping... " .. i)
        humanoid.Jump = true
        task.wait(1)
    end
    print("--- TEST COMPLETE ---")
end)
