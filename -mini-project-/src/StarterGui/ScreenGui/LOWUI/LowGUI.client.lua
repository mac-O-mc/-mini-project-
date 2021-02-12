local TweenService = game:GetService("TweenService")

local player = game.Players.LocalPlayer
local chks = player.Checks

local lowui = script.Parent
local db = false

--[[
function ModeColours(Mode)
	lowui.ModeLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
	if Mode == "Standard" then
		lowui.ModeLabel.TextColor3 = Color3.fromRGB(255,255,255)
	elseif Mode == "Hard" then
		lowui.ModeLabel.TextColor3 = Color3.fromRGB(255,82,85)
		lowui.ModeLabel.Text = (string.upper(player.leaderstats.Mode.Value) .."MODE")
	elseif Mode == "Extreme" then
		lowui.ModeLabel.TextColor3 = Color3.fromRGB(82,82,170)
	elseif Mode == "Softcore" then
		lowui.ModeLabel.TextColor3 = Color3.fromRGB(106,255,98)
		lowui.ModeLabel.Text = (string.upper(player.leaderstats.Mode.Value))
	end
end
]]--

function LivesColours(Lives)
	if Lives <= 1 and player.leaderstats.Mode.Value == "Extreme" then
		lowui.LivesLabel.TextColor3 = Color3.fromRGB(82,82,170)
	elseif Lives <= 1 then
		lowui.LivesLabel.TextColor3 = Color3.fromRGB(255,82,85)
	else
		lowui.LivesLabel.TextColor3 = Color3.fromRGB(255,255,255)
	end
end

lowui.LivesLabel.Text = ("LIVES: "..tostring(player.Lives.Value))
LivesColours(player.Lives.Value)
lowui.ModeLabel.Text = (string.upper(game.ReplicatedStorage.Modes[player.leaderstats.Mode.Value].ModeDisplay.Value))
lowui.ModeLabel.TextColor3 = game.ReplicatedStorage.Modes[player.leaderstats.Mode.Value].ModeColor.Value
lowui.VersionLabel.Text = ("Server Version: "..lowui.VersionLabel.Version.Value)
lowui.StageLabel.Text = ("Stage Code: ["..string.upper(player.Path.Value).." "..player.leaderstats.Stage.Value.."]")

player.Lives:GetPropertyChangedSignal("Value"):Connect(function()
	lowui.LivesLabel.Text = ("LIVES: "..tostring(player.Lives.Value))
	LivesColours(player.Lives.Value)
end)

player.leaderstats.Mode:GetPropertyChangedSignal("Value"):Connect(function()
	lowui.ModeLabel.Text = (string.upper(game.ReplicatedStorage.Modes[player.leaderstats.Mode.Value].ModeDisplay.Value))
	lowui.ModeLabel.TextColor3 = game.ReplicatedStorage.Modes[player.leaderstats.Mode.Value].ModeColor.Value 
end)

player.Path:GetPropertyChangedSignal("Value"):Connect(function()
	lowui.StageLabel.Text = ("Stage Code: ["..string.upper(player.Path.Value).." "..player.leaderstats.Stage.Value.."]")
end)
player.leaderstats.Stage:GetPropertyChangedSignal("Value"):Connect(function()
	lowui.StageLabel.Text = ("Stage Code: ["..string.upper(player.Path.Value).." "..player.leaderstats.Stage.Value.."]")
end)

