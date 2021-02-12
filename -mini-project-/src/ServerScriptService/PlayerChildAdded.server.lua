function PlrToCheckpoint(plr)
	local player = game.Players:GetPlayerFromCharacter(plr)
	if player then 
		local plrchkptFolder = workspace.Checkpoints:FindFirstChild(player.leaderstats.Zone.Value)
		for i,v in pairs(plrchkptFolder:GetChildren()) do
			if v.CheckpointNumber.Value == player.leaderstats.Stage.Value and v:FindFirstChild("Touch")then
				wait(0.2)
				plr.HumanoidRootPart.CFrame = v.Touch.CFrame + Vector3.new(0,6,0)
				plr.HumanoidRootPart.Orientation = v.Touch.Orientation +  Vector3.new(0,0,90)
			end
		end
	end
end

function StringReset(plr)
	local player = game.Players:GetPlayerFromCharacter(plr)
	if player then
		if player.Lives.Value == 0 then
			player.Lives.Value = 5
			player.leaderstats.Mode.Value = "Standard"
		end 
		if player.Health.Value == 0 then
			local mode = player.leaderstats.Mode.Value
			player.Health.Value = game.ReplicatedStorage.Modes[mode].MaxHealth.Value
		end
		if player.Checks.PlrHasSpawned.Value == false then
			player.Checks.PlrHasSpawned.Value = true
		end
	end
end

game.Workspace.ChildAdded:Connect(StringReset)
game.Workspace.ChildAdded:connect(PlrToCheckpoint)