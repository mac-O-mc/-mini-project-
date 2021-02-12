script.Parent.Touched:Connect(function(hit)
	if hit.parent:FindFirstChild("Humanoid") then
		local player = game.Players:GetPlayerFromCharacter(hit.parent)
		if player.leaderstats.Mode.Value == "Standard" then	
			player.leaderstats.Mode.Value = tostring(script.Parent.Parent.Name)
			player.Health.Value = game.ReplicatedStorage.Modes[script.Parent.Parent.Name].MaxHealth.Value
			player.Lives.Value = game.ReplicatedStorage.Modes[script.Parent.Parent.Name].MaxLives.Value
			player.leaderstats.Zone.Value = "Lobby"
			player.leaderstats.Stage.Value = 1
			player.Path.Value = "Lobby"
			hit.Parent.HumanoidRootPart.CFrame = workspace.Checkpoints.Lobby.lobby1.SpawnLocation.CFrame + Vector3.new(0,6,0)
			hit.Parent.HumanoidRootPart.Orientation = workspace.Checkpoints.Lobby.lobby1.SpawnLocation.Orientation + Vector3.new(0,0,90)
		end	
	end
end)

-- this is just to make the number spin
while true do
	for i = 1,20 do
		script.Parent.SurfaceGui.TextBox.Rotation = script.Parent.SurfaceGui.TextBox.Rotation + 2
		wait(0.1)
	end
	for i = 1,20 do
		script.Parent.SurfaceGui.TextBox.Rotation = script.Parent.SurfaceGui.TextBox.Rotation - 2
		wait(0.1)
	end
end