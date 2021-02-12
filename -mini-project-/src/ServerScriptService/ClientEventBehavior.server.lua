local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerMusicProperty	= ReplicatedStorage:WaitForChild("PlayerMusicProperty")
local db = false 

local function MusicChange(player, desire)
	if db == false then
		if desire == "mute" then
			player.PlayerSettings.MusicMuted.Value = true
		elseif desire == "play" then
			player.PlayerSettings.MusicMuted.Value = false
		end
	end
end

PlayerMusicProperty.OnServerEvent:Connect(MusicChange)