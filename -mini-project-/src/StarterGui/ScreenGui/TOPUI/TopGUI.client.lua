local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OverheadEvent = ReplicatedStorage:WaitForChild("OverheadStatus")

local player = game.Players.LocalPlayer
local chks = player.Checks

local topui = script.Parent
local healthui = script.Parent.Health
local leftui = script.Parent.Left
local rightui = script.Parent.Right


healthui.HealthLabel.Text = tostring(player.Health.Value)
healthui.HPImage.ImageColor3 = Color3.fromRGB(255,82,85)
topui.PlayerStatusMessageLabel.Visible = false

leftui.ZoneLabel.Text = player.leaderstats.Zone.Value
leftui.StageLabel.Text = ("Stage "..player.leaderstats.Stage.Value.." / 30")
leftui.Dash.TextColor3 = Color3.fromRGB(255,82,85)

rightui.SongTitle.Text = player.MusicFolder.CurrentTrack.Value
rightui.ArtistLabel.Text = ("by "..player.MusicFolder.CurrentTrackArtist.Value)
rightui.AlbumGameLabel.Text = ("seen in "..player.MusicFolder.CurrentTrackAlbum.Value)
rightui.Dash.TextColor3 = Color3.fromRGB(255,82,85)

local CURRENTHPVALUE = player.Health.Value

player.Health:GetPropertyChangedSignal("Value"):Connect(function()
	healthui.HealthLabel.Text = tostring(player.Health.Value)
	if player.Health.Value <= CURRENTHPVALUE then -- if player's health is lower then it was before it changed
		local tweentime = TweenInfo.new(0.5)
		local dmgtime = TweenInfo.new(1)
		local leftdashtween = TweenService:Create(leftui.Dash,tweentime,{TextColor3 = Color3.fromRGB(255,82,85)})
		local rightdashtween = TweenService:Create(rightui.Dash,tweentime,{TextColor3 = Color3.fromRGB(255,82,85)})
		local hearttween = TweenService:Create(healthui.HPImage,tweentime,{ImageColor3 = Color3.fromRGB(255,82,85)})
		local vignettetween = TweenService:Create(script.Parent.Parent.DamageVignette,dmgtime,{ImageTransparency = 1})
		local a = TweenInfo.new(5)
		local b = TweenService:Create(script.Parent.Parent.DamageVignette,a,{ImageTransparency = 1})
		leftui.Dash.TextColor3 = Color3.fromRGB(100,14,14)
		rightui.Dash.TextColor3 = Color3.fromRGB(100,14,14)
		healthui.HPImage.ImageColor3 = Color3.fromRGB(100,14,14)
		script.Parent.Parent.DamageVignette.ImageTransparency = 0.2
		if player.Health.Value ~= 0 then
			leftdashtween:Play()
			rightdashtween:Play()
			hearttween:Play()
			vignettetween:Play()
		elseif player.Health.Value == 0 then
			b:Play()
		end
		for i = 12,0,-1 do
			healthui.HPImage.Position = UDim2.new(-0.1, math.random(-i,i), 0, math.random(-i,i))
			wait(0.05)
		end
	elseif player.Health.Value >= CURRENTHPVALUE and CURRENTHPVALUE ~= 0 then
		local tweentime = TweenInfo.new(1)
		local leftdashtween = TweenService:Create(leftui.Dash,tweentime,{TextColor3 = Color3.fromRGB(255,82,85)})
		local rightdashtween = TweenService:Create(rightui.Dash,tweentime,{TextColor3 = Color3.fromRGB(255,82,85)})
		local hearttween = TweenService:Create(healthui.HPImage,tweentime,{ImageColor3 = Color3.fromRGB(255,82,85)})
		leftui.Dash.TextColor3 = Color3.fromRGB(106,255,98)
		rightui.Dash.TextColor3 = Color3.fromRGB(106,255,98)
		healthui.HPImage.ImageColor3 = Color3.fromRGB(106,255,98)
		leftdashtween:Play()
		rightdashtween:Play()
		hearttween:Play()
--[[	if healthui.HPImage.ImageColor3 ~= Color3.fromRGB(255,195,12) and player.Health.Value >= 4 then
			healthui.HPImage.ImageColor3 = Color3.fromRGB(255,195,12)
			rightui.Dash.TextColor3 = Color3.fromRGB(255,195,12)
			leftui.Dash.TextColor3 = Color3.fromRGB(255,195,12)
		end
	elseif player.Health.Value <= CURRENTHPVALUE and player.Health.Value >= 4 then
		print("it works")
		local tweentime = TweenInfo.new(1)
		if CURRENTHPVALUE == 4 then
			local leftdashtween = TweenService:Create(leftui.Dash,tweentime,{TextColor3 = Color3.fromRGB(255,82,85)})
			local rightdashtween = TweenService:Create(rightui.Dash,tweentime,{TextColor3 = Color3.fromRGB(255,82,85)})
			local hearttween = TweenService:Create(healthui.HPImage,tweentime,{ImageColor3 = Color3.fromRGB(255,82,85)})
		end
		print("if")
		if healthui.HPImage.ImageColor3 ~= Color3.fromRGB(255,195,12) then
			healthui.HPImage.ImageColor3 = Color3.fromRGB(255,195,12)
			rightui.Dash.TextColor3 = Color3.fromRGB(255,195,12)
			leftui.Dash.TextColor3 = Color3.fromRGB(255,195,12)
		end
		print("if2")
		for i = 24,0,-2 do
			UDim2.new(-0.1, i, 0, 0)
			wait(0.05)
			UDim2.new(-0.1, -i, 0, 0)
			wait(0.05)
		end
		print("im done")
	elseif player.Health.Value >= CURRENTHPVALUE and player.Health.Value >= 4 then
		print("high")
	else
		print("im pooping") ]]--
	end
	CURRENTHPVALUE = player.Health.Value -- update value to reflect new player health value
end)

--[[
chks.DamageCooldown:GetPropertyChangedSignal("Value"):Connect(function()
	local db = false
	if chks.DamageCooldown.Value == true and player.Health.Value ~= 0 and db ~= true and player.leaderstats.Mode.Value == "Softcore" then
		healthui.CooldownLabel.Visible = true
		db = true
		for i = 2,1,-1 do
			healthui.CooldownLabel.Text = "DAMAGE BUFFER: "..i.."s"
			wait(1)
		end
		healthui.CooldownLabel.Visible = false
		db = false
	end
end)
]]--

OverheadEvent.OnClientEvent:Connect(function(text, duration, colourR, colourG, colourB)
	local colour = Color3.fromRGB(colourR,colourG,colourB)
	if text and colour and duration then
		topui.PlayerStatusMessageLabel.Text = text
		topui.PlayerStatusMessageLabel.TextColor3 = colour
		topui.PlayerStatusMessageLabel.Visible = true
		wait(duration)
		topui.PlayerStatusMessageLabel.Visible = false
	end
end)

player.leaderstats.Stage:GetPropertyChangedSignal("Value"):Connect(function()
	leftui.StageLabel.Text = ("Stage "..player.leaderstats.Stage.Value.." / 30")
end)

player.leaderstats.Zone:GetPropertyChangedSignal("Value"):Connect(function()
	leftui.ZoneLabel.Text = player.leaderstats.Zone.Value
end)

player.MusicFolder.CurrentTrack:GetPropertyChangedSignal("Value"):Connect(function()
	rightui.SongTitle.Text = player.MusicFolder.CurrentTrack.Value
end)
player.MusicFolder.CurrentTrackArtist:GetPropertyChangedSignal("Value"):Connect(function()
	rightui.ArtistLabel.Text = ("by "..player.MusicFolder.CurrentTrackArtist.Value)
end)
player.MusicFolder.CurrentTrackAlbum:GetPropertyChangedSignal("Value"):Connect(function()
	rightui.AlbumGameLabel.Text = ("seen in "..player.MusicFolder.CurrentTrackAlbum.Value)
end)
