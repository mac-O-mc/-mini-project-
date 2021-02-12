local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local player = game.Players.LocalPlayer

local s = workspace.BGM

if player.leaderstats.Zone.Value == "Lobby" and player.MusicFolder.CurrentTrack.Value ~= "Shaft" then
	player.MusicFolder.CurrentTrack.Value = "Shaft"
	player.MusicFolder.CurrentTrackArtist.Value = "Purely Grey"
	player.MusicFolder.CurrentTrackAlbum.Value = "Hyperflex"
	s.SoundId = "rbxassetid://5601479927"
	if player.PlayerSettings.MusicMuted.Value == false then
		s.Volume = 0.5
		s:Play()
	end
end



local s = workspace:FindFirstChild("BGM")
local tweentime = TweenInfo.new(2)
local fadeout = TweenService:Create(s,tweentime,{Volume = 0})
local fadein = TweenService:Create(s,tweentime,{Volume = 0.5})

player.leaderstats.Zone:GetPropertyChangedSignal("Value"):Connect(function()
	if player.PlayerSettings.MusicMuted.Value == false then
		if s.IsPlaying == true then
			fadeout:Play()
			wait(2)
		end
		s.Volume = 0
		s:Pause()
	end
	-- LIST ZONE CONDITIONALS --
	-- might seperate into individual conditionals depending on the path so less performance is used up --
	if player.leaderstats.Zone.Value == "Lobby" then
		player.MusicFolder.CurrentTrack.Value = "Shaft"
		player.MusicFolder.CurrentTrackArtist.Value = "Purely Grey"
		player.MusicFolder.CurrentTrackAlbum.Value = "Hyperflex"
		s.SoundId = "rbxassetid://5601479927"
	elseif player.leaderstats.Zone.Value == "Main" then
		player.MusicFolder.CurrentTrack.Value = "Under the Moon"
		player.MusicFolder.CurrentTrackArtist.Value = "Ap0c"
		player.MusicFolder.CurrentTrackAlbum.Value = "Chiptunes = WIN: Volume 2"
		s.SoundId = "rbxassetid://5155362745"
	elseif player.leaderstats.Zone.Value == "Sky" then
		player.MusicFolder.CurrentTrack.Value = "Sand Castle"
		player.MusicFolder.CurrentTrackArtist.Value = "WillRock"
		player.MusicFolder.CurrentTrackAlbum.Value = "Chiptunes = WIN: Volume 4"
		s.SoundId = "rbxassetid://5667592210"
	elseif player.leaderstats.Zone.Value == "Abyss" then
		player.MusicFolder.CurrentTrack.Value = "Abyss"
		player.MusicFolder.CurrentTrackArtist.Value = "ROBLOX (APM Music)"
		player.MusicFolder.CurrentTrackAlbum.Value = "N/A"
		s.SoundId = "rbxassetid://1844652676"
	elseif player.leaderstats.Zone.Value == "Void" then
		player.MusicFolder.CurrentTrack.Value = "A Glacier Eventually Farts"
		player.MusicFolder.CurrentTrackArtist.Value = "Chris Christodoulou"
		player.MusicFolder.CurrentTrackAlbum.Value = "Risk of Rain 2"
		s.SoundId = "rbxassetid://5604154500"
	end
	if player.PlayerSettings.MusicMuted.Value == false then
		s.TimePosition = 0
		if s.IsPlaying == false then
			s:Play()
			fadein:Play()
		end
	end
end)

player.PlayerSettings.MusicMuted:GetPropertyChangedSignal("Value"):Connect(function()
	if player.PlayerSettings.MusicMuted.Value == true then
		fadeout:Play()
		wait(2)
		s.Volume = 0
		s:Pause()
	elseif player.PlayerSettings.MusicMuted.Value == false then
		s.TimePosition = 0
		s:Play()
		fadein:Play()
	end
end)