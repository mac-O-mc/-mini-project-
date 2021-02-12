local player = game.Players.LocalPlayer

script.Parent.Text = tostring(player.Health.Value) -- fires on respawn/gui loaded
player.Health:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = tostring(player.Health.Value) -- fire when changed
	local CurrentHealth = script.Parent.Text
	local TweenService = game:GetService("TweenService")
	local tweenInfo1 = TweenInfo.new(0.5)
	local tweenInfo2 = TweenInfo.new(1)
	local part = script.Parent.Parent
	local tween1 = TweenService:Create(part,tweenInfo1,{BackgroundColor3 = Color3.fromRGB(255,185,186)})
	local int = script.Parent
	local healthlabel = script.Parent.Parent.TextLabel
	local tween2 = TweenService:Create(part,tweenInfo2,{BackgroundColor3 = Color3.fromRGB(255,185,186)})
	local tween3 = TweenService:Create(int,tweenInfo2,{TextColor3 = Color3.fromRGB(0,0,0)})
	local tween4 = TweenService:Create(healthlabel,tweenInfo2,{TextColor3 = Color3.fromRGB(0,0,0)})
	
	if player.Checks.NoDamageDuringPreviousCheckpoint.Value == true or player.Checks.HealthFromChance.Value == true then
		script.Parent.Parent.BackgroundColor3 = Color3.fromRGB(106,255,98)
		script.Parent.TextColor3 = Color3.fromRGB(255,255,255)
		script.Parent.Parent.TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
		tween2:Play()
		tween3:Play()
		tween4:Play()
	elseif player.Checks.PlrHasSpawned.value == true then
		script.Parent.Parent.BackgroundColor3 = Color3.fromRGB(100,14,14)
		tween1:Play()
		script.parent.Position = UDim2.new(-0, math.random(-12,12), 0.2, math.random(-12,12))
		wait(0.05)
		script.parent.Position = UDim2.new(-0, math.random(-11,11), 0.2, math.random(-11,11))
		wait(0.05)
		script.parent.Position = UDim2.new(-0, math.random(-10,10), 0.2, math.random(-10,10))
		wait(0.05)
		script.parent.Position = UDim2.new(-0, math.random(-9,9), 0.2, math.random(-9,9))
		wait(0.05)
		script.parent.Position = UDim2.new(-0, math.random(-8,8), 0.2, math.random(-8,8))
		wait(0.05)
		script.parent.Position = UDim2.new(-0, math.random(-7,7), 0.2, math.random(-7,7))
		wait(0.05)
		script.parent.Position = UDim2.new(-0, math.random(-6,6), 0.2, math.random(-6,6))
		wait(0.05)
		script.parent.Position = UDim2.new(-0, math.random(-5,5), 0.2, math.random(-5,5))
		wait(0.05)
		script.parent.Position = UDim2.new(-0, math.random(-4,4), 0.2, math.random(-4,4))
		wait(0.05)
		script.parent.Position = UDim2.new(-0, math.random(-3,3), 0.2, math.random(-3,3))
		wait(0.05)
		script.parent.Position = UDim2.new(-0, math.random(-2,2), 0.2, math.random(-2,2))
		wait(0.05)
		script.parent.Position = UDim2.new(-0, math.random(-1,1), 0.2, math.random(-1,1))
		wait(0.05)
		script.Parent.Position = UDim2.new(-0,0,0.2,0)
	end
end)