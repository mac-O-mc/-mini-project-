local TweenService = game:GetService("TweenService")

local player = game.Players.LocalPlayer
local chks = player.Checks
local plrsettings = player.PlayerSettings

local MS = script.Parent.MusicSetting
local IS = script.Parent.InterfaceSetting

local db = false

if plrsettings.MusicMuted == true then
	MS.MusicInteractable.Text = "MUTED"
	MS.MusicInteractable.TextColor3 = Color3.fromRGB(255,82,85)
end

if plrsettings.HiddenUI == true then
	
end

MS.MusicInteractable.MouseButton1Down:Connect(function()
	if db == false then
		if MS.MusicInteractable.Text == "PLAYING" and plrsettings.MusicMuted.Value == false then
			db = true
			MS.MusicInteractable.Text = "MUTED"
			MS.MusicInteractable.TextColor3 = Color3.fromRGB(255,82,85)
			game.ReplicatedStorage.PlayerMusicProperty:FireServer("mute")
			wait(2)
			db = false
		elseif MS.MusicInteractable.Text == "MUTED" and plrsettings.MusicMuted.Value == true then
			db = true
			MS.MusicInteractable.Text = "PLAYING"
			MS.MusicInteractable.TextColor3 = Color3.fromRGB(106,255,98)
			game.ReplicatedStorage.PlayerMusicProperty:FireServer("play")
			wait(2)
			db = false
		end
	end
end)
--[[
IS.MusicInteractable.MouseButton1Down:Connect(function()
	if db == false then
		if IS.MusicInteractable.Text == "PLAYING" and chks.PlayerMusicEnabled.Value == true then
			db = true
			IS.MusicInteractable.Text = "MUTED"
			IS.MusicInteractable.TextColor3 = Color3.fromRGB(255,82,85)
			game.ReplicatedStorage.PlayerMusicProperty:FireServer("mute")
			wait(2)
			db = false
		elseif IS.MusicInteractable.Text == "MUTED" and chks.PlayerMusicEnabled.Value == false then
			db = true
			IS.MusicInteractable.Text = "PLAYING"
			IS.MusicInteractable.TextColor3 = Color3.fromRGB(106,255,98)
			game.ReplicatedStorage.PlayerMusicProperty:FireServer("play")
			wait(2)
			db = false
		end
	end
end)

]]