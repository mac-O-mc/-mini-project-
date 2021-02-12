-- Keys --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Promise = require(ReplicatedStorage.Modules["Util."].evaera_Promise)
local Event_SurgeStart = ReplicatedStorage.RemoteEvents:WaitForChild("SurgeStart",3)
local Event_SurgeBeamDrawn = ReplicatedStorage.RemoteEvents:WaitForChild("SurgeBeamDrawn",3)
local Event_SurgeEnd = ReplicatedStorage.RemoteEvents:WaitForChild("SurgeEnd",3)
local Function_SurgeCamAdjustFinal = ReplicatedStorage.RemoteFunctions:WaitForChild("SurgeCamAdjustFinal",3)

local LocalPlayer = Players.LocalPlayer.Character
local LocalCamera = workspace.CurrentCamera

-- Functions --
Event_SurgeStart.OnClientEvent:Connect(function()
	LocalPlayer.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	LocalCamera.CameraType = Enum.CameraType.Scriptable
end)

Event_SurgeBeamDrawn.OnClientEvent:Connect(function(lookat, TeleportPause)
--	LocalCamera.Focus
	TweenService:Create(LocalCamera,
		TweenInfo.new(0.05,Enum.EasingStyle.Linear),
		{CFrame = lookat}
	):Play()
end)

Function_SurgeCamAdjustFinal.OnClientInvoke = (function(lookat, TeleportPause)
--	LocalCamera.Focus
	local tween = TweenService:Create(LocalCamera,
		TweenInfo.new(0.05,Enum.EasingStyle.Linear),
		{CFrame = lookat}
	)
	tween:Play()
	-- Do I need to manually clean this's memory later?
	tween.Completed:Connect(function()
		Function_SurgeCamAdjustFinal:InvokeServer()
	end)
end)

Event_SurgeEnd.OnClientEvent:Connect(function()
	LocalPlayer.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	LocalCamera.CameraType = Enum.CameraType.Custom
end)

--function C_SparkSurge_DrawBeam(ATCH0, ATCH1, LightInfluence, TransparencyKeypoints)
--	local HomeDestBeam = Instance.new("Beam")
--	HomeDestBeam.Attachment0	= ATCH0
--	HomeDestBeam.Attachment1	= ATCH1
--	HomeDestBeam.Color			= ColorSequence.new({
--		ColorSequenceKeypoint.new(0,Color3.fromRGB(218, 193, 52)),
--		ColorSequenceKeypoint.new(1,Color3.fromRGB(218, 193, 52))
--	})
--	HomeDestBeam.FaceCamera		= 1
--	HomeDestBeam.LightEmission	= 1
--	HomeDestBeam.LightInfluence	= 0.5 or LightInfluence
--	HomeDestBeam.Transparency	= NumberSequence.new{
--		NumberSequenceKeypoint.new(0,	0.2),
--		NumberSequenceKeypoint.new(0.5,	0.7),
--		NumberSequenceKeypoint.new(1,	0.2)
--	} or TransparencyKeypoints
--	HomeDestBeam.Parent			= ATCH0.Parent -- or BeamParent
--	-- Worry about promises later, get the base shit working first
--	Promise.delay(2):andThen(HomeDestBeam:Destroy())
--end
--R_SurgeDrawBeam.OnClientEvent:Connect(C_SparkSurge_DrawBeam)