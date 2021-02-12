local player = game.Players.LocalPlayer

script.Parent.Text = (string.upper(player.leaderstats.Mode.Value) .." MODE") -- fires on respawn/gui loaded
player.Lives:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = (string.upper(player.leaderstats.Mode.Value) .." MODE") -- fire when changed
end)