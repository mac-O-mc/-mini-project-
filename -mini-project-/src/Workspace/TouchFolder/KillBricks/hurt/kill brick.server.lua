-- on touch
script.Parent.Touched:Connect(function(hit)
	if hit.parent:FindFirstChild("Humanoid") and hit.parent:FindFirstChild("ForceField") == nil then
		local player = game.Players:GetPlayerFromCharacter(hit.parent)
		local debounce = player.Checks.DamageCooldown.Value
--		local humanoidstate = hit.parent.Humanoid.Humanoid
		if player.Health.Value >= 2 and player.Checks.DamageCooldown.Value == false then -- DAMAGE
			player.Checks.NoDamageDuringPreviousCheckpoint.Value = false
			player.Health.Value = player.Health.Value - 1
			player.Checks.DamageCooldown.Value = true
			wait(3)
			player.Checks.DamageCooldown.Value = false
		elseif player.Health.Value == 1 and player.Lives.Value == 1 and player.Checks.DamageCooldown.Value == false then -- RESET
			player.Checks.NoDamageDuringPreviousCheckpoint.Value = false
			player.Health.Value = 0
			player.Lives.Value = 0
			hit.parent.Humanoid.Health = 0
			player.Checks.DamageCooldown.Value = true
			wait(5)
			player.Checks.DamageCooldown.Value = false
		elseif player.Health.Value == 1 and player.Lives.Value >= 2 and player.Checks.DamageCooldown.Value == false then -- KILL
			player.Checks.NoDamageDuringPreviousCheckpoint.Value = false
			player.Health.Value = 0
			hit.parent.Humanoid.Health = 0
			player.Checks.DamageCooldown.Value = true
			wait(5)
			player.Checks.DamageCooldown.Value = false
		elseif debounce == true then
			print("player currently has damage cooldown")
		end
	end
end)