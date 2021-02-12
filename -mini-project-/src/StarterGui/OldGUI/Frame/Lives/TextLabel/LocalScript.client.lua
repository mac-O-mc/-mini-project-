local player = game.Players.LocalPlayer

script.Parent.Text = ("LIVES: ".. tostring(player.Lives.Value)) -- fires on respawn/gui loaded
player.Lives:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = ("LIVES: ".. tostring(player.Lives.Value)) -- fire when changed
	if tonumber(script.Parent.Text) == 1 then
		script.Parent.TextColor3 = Color3.fromRGB(255,255,255)
		script.Parent.BackgroundColor3 = Color3.fromRGB(255,0,0)
	elseif script.Parent.TextColor3 == Color3.fromRGB(255,255,255) then
		script.Parent.TextColor = Color3.fromRGB(0,0,0)
		script.Parent.BackgroundColor3 = Color3.fromRGB(255,255,255)
	end
end)