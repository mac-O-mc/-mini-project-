local function OnPlayerJoin(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local checks = Instance.new("Folder")
	checks.Name = "Checks"
	checks.Parent = player
	
	local attrib = Instance.new("Folder")
	attrib.Name = "Attributes"
	attrib.Parent = player
	
	local plrsettings = Instance.new("Folder")
	plrsettings.Name = "PlayerSettings"
	plrsettings.Parent = player
	
	-- LEADERBOARD VALUES --
	local stage = Instance.new("IntValue")
	stage.Name = "Stage"
	stage.Value = 1
	stage.Parent = leaderstats
	
	local zone = Instance.new("StringValue")
	zone.Name = "Zone"
	zone.Value = "Lobby"
	zone.Parent = leaderstats
	
	local mode = Instance.new("StringValue")
	mode.Name = "Mode"
	mode.Value = "Standard"
	mode.Parent = leaderstats
	
	local path = Instance.new("StringValue")
	path.Name = "Path"
	path.Value = "Lobby"
	path.Parent = player
	
	-- VITAL VALUES --
	local health = Instance.new("IntValue")
	health.Name = "Health"
	health.Value = 3
	health.Parent = player
	
	local lives = Instance.new("IntValue")
	lives.Name = "Lives"
	lives.Value = 5
	lives.Parent = player
	
	-- PLAYER SETTINGS --
	
	local musicmute = Instance.new("BoolValue")
	musicmute.Name = "MusicMuted"
	musicmute.Value = false
	musicmute.Parent = plrsettings
	
	local hideui = Instance.new("BoolValue")
	hideui.Name = "HiddenUI"
	hideui.Value = false
	hideui.Parent = plrsettings
	
	-- OTHER VALUES --
	
	local musicfldr = Instance.new("Folder")
	musicfldr.Name = "MusicFolder"
	musicfldr.Parent = player
	
	local musictrack = Instance.new("StringValue")
	musictrack.Name = "CurrentTrack"
	musictrack.Value = "N/A"
	musictrack.Parent = musicfldr
	
	local musictrackartist = Instance.new("StringValue")
	musictrackartist.Name = "CurrentTrackArtist"
	musictrackartist.Value = "N/A"
	musictrackartist.Parent = musicfldr
	
	local musictrackalbum = Instance.new("StringValue")
	musictrackalbum.Name = "CurrentTrackAlbum"
	musictrackalbum.Value = "N/A"
	musictrackalbum.Parent = musicfldr
	
	-- CHECKS --
	
	local chkptvital = Instance.new("BoolValue")
	chkptvital.Name = "NoDamageDuringPreviousCheckpoint"
	chkptvital.Value = true
	chkptvital.Parent = checks
	
	local chancehp = Instance.new("BoolValue")
	chancehp.Name = "HealthFromChance"
	chancehp.Value = false
	chancehp.Parent = checks
	
	local chancelives = Instance.new("BoolValue")
	chancelives.Name = "LivesFromChance"
	chancelives.Value = false
	chancelives.Parent = checks
	
	local plrspawn = Instance.new("BoolValue")
	plrspawn.Name = "PlrHasSpawned"
	plrspawn.Value = false
	plrspawn.Parent = checks
	
	local dmgcooldown = Instance.new("BoolValue")
	dmgcooldown.Name = "DamageCooldown"
	dmgcooldown.Value = false
	dmgcooldown.Parent = checks
	
	-- PLAYER ATTRIBUTES -- 
--[[local playertag = Instance.new("BoolValue")
	if player.UserId == 34496596 then
		playertag.Name = "Owner"
		playertag.Parent = attrib 
	end 
	print(tostring(player).." is "..tostring(playertag.Name).."!")
	]]--
end

game.Players.PlayerAdded:Connect(OnPlayerJoin)