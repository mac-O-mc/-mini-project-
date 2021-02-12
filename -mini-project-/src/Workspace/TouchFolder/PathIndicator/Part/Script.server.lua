script.Parent.Touched:Connect(function(hit)
	if hit.parent:FindFirstChild("Humanoid") then
		local player = game.Players:GetPlayerFromCharacter(hit.parent)
		player.Path.Value = script.Parent.Path.Value
	end
end)