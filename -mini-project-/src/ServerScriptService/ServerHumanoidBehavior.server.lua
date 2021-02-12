game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		local hum = char:WaitForChild("Humanoid")
		hum.Died:Connect(function()
			plr.Health.Value = 0
			plr.Checks.PlrHasSpawned.Value = false
			if plr.Lives.Value >= 2 then
				plr.Lives.Value = plr.Lives.Value - 1
			end
			if plr.Lives.Value == 1 then
				if plr.Checks.DamageCooldown.Value == false then
					plr.Lives.Value = 0
					plr.leaderstats.Stage.Value = 1
					plr.leaderstats.Zone.Value = "Lobby"
					plr.Path.Value = "Lobby"
				end
			elseif plr.Lives.Value == 0 then
				plr.leaderstats.Stage.Value = 1
				plr.leaderstats.Zone.Value = "Lobby"
				plr.Path.Value = "Lobby"
			end
		end)
		
		-- global humanoid touch
		hum.Touched:Connect(function(touch)
			if touch.Name == "hurt" then
				local debounce = plr.Checks.DamageCooldown.Value
				if plr.Health.Value >= 2 and plr.Checks.DamageCooldown.Value == false then -- DAMAGE
					plr.Checks.NoDamageDuringPreviousCheckpoint.Value = false
					plr.Health.Value = plr.Health.Value - 1
					plr.Checks.DamageCooldown.Value = true
					wait(2)
					plr.Checks.DamageCooldown.Value = false
				elseif plr.Health.Value == 1 and plr.Lives.Value == 1 and plr.Checks.DamageCooldown.Value == false then -- RESET
					plr.Checks.NoDamageDuringPreviousCheckpoint.Value = false
					plr.Health.Value = 0
					plr.Lives.Value = 0
					hum.Health = 0
					plr.Checks.DamageCooldown.Value = true
					wait(2)
					plr.Checks.DamageCooldown.Value = false
				elseif plr.Health.Value == 1 and plr.Lives.Value >= 2 and plr.Checks.DamageCooldown.Value == false then -- KILL
					plr.Checks.NoDamageDuringPreviousCheckpoint.Value = false
					plr.Health.Value = 0
					hum.Health = 0
					plr.Checks.DamageCooldown.Value = true
					wait(2)
					plr.Checks.DamageCooldown.Value = false
--				elseif debounce == true then
--					print(plr.Name.." currently has damage cooldown")
				end
			elseif touch.Name == "Touch" and touch.Checkpoint.Value == true then
				local remoteEvent = game.ReplicatedStorage.RemoteEvents:WaitForChild("CheckpointTrigger", 5)
				local chkptmodel = touch.Parent
				if plr.leaderstats.Stage.Value == tonumber(chkptmodel.CheckpointNumber.Value) - 1 then -- if player's current stage is one less then this checkpoint's stage
					plr.leaderstats.Stage.Value = chkptmodel.CheckpointNumber.Value
					if plr.leaderstats.Zone.Value == chkptmodel.ZoneFrom.Value and plr.leaderstats.Zone.Value ~= chkptmodel.Zone.Value then -- if the player is in the zone from this checkpoints zone and if not currently in the checkpoint's zone
						plr.leaderstats.Zone.Value = chkptmodel.Zone.Value
						if plr.Path.Value ~= chkptmodel.Path.Value then
							plr.Path.Value = chkptmodel.Path.Value 
						end
					end
					if plr.Checks.NoDamageDuringPreviousCheckpoint.Value == true and plr.Health.Value < game.ReplicatedStorage.Modes[plr.leaderstats.Mode.Value].MaxHealth.Value then
						plr.Health.Value = plr.Health.Value + 1
					elseif plr.Checks.NoDamageDuringPreviousCheckpoint.Value == false and plr.leaderstats.Mode.Value ~= "Daredevil" then
						plr.Checks.NoDamageDuringPreviousCheckpoint.Value = true
					end
					remoteEvent:FireClient(plr, touch, chkptmodel)
				end
			end
		end)
--		wait(0.1)
--		hum.parent.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=5555246646"
--		hum.parent.Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=5555246646"
		hum.WalkSpeed = 20
	end)
end)
