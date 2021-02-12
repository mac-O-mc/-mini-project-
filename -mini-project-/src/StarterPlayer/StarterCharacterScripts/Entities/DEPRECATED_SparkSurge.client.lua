-- Keys --
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BeamExtended = require(ReplicatedStorage.Modules.Custom.BeamExtended)
local R_SurgeStart = ReplicatedStorage.RemoteEvents:WaitForChild("R_SurgeStart",5)
local R_SurgeDrawBeam = ReplicatedStorage.RemoteEvents:WaitForChild("R_SurgeDrawBeam",5)
local R_SurgeEnd = ReplicatedStorage.RemoteEvents:WaitForChild("R_SurgeEnd",5)

local LocalPlayer = Players.LocalPlayer

-- Functions --
function C_SparkSurge_Start(character)
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		if not humanoid:FindFirstChild("IsSurging") then
			character.PrimaryPart.Anchored = true
			-- Leftover; For client use only
			local IsSurging = Instance.new("IntValue")
			IsSurging.Name = "IsSurging"
			IsSurging.Value = 1
			IsSurging.Parent = humanoid
			for k,v in pairs(character:GetChildren()) do
				if v.ClassName == "Part" then
					v.Transparency = 1
				elseif v.Name == "Head" and v.ClassName == "Part" then
					v:FindFirstChildOfClass("Decal").Transparency = 1
				end
			end
			local OrbPlayer = Instance.new("Part")
			OrbPlayer.Anchored = true
			OrbPlayer.CanCollide = false
			OrbPlayer.Size = Vector3.new(1.3,1.3,1.3)
			OrbPlayer.Shape = Enum.PartType.Ball
			OrbPlayer.Material = Enum.Material.SmoothPlastic
			OrbPlayer.Parent = character.PrimaryPart
			local character_face = character.Head:FindFirstChildOfClass("Decal"):Clone()
			character_face.Transparency = 0
			character_face.Parent = OrbPlayer
		else
			warn("C_SparkSurge_R_SurgeStart() fired when IsSurging active on player?")
		end
	end
end	
R_SurgeStart.OnClientEvent:Connect(C_SparkSurge_Start)


--function C_SparkSurge_UpdatePlayerCoords()
--end
function C_SparkSurge_DrawBeam(ATCH0, ATCH1, LightInfluence, TransparencyKeypoints)
	local HomeDestBeam = Instance.new("Beam")
	HomeDestBeam.Attachment0	= ATCH0
	HomeDestBeam.Attachment1	= ATCH1
	HomeDestBeam.Color			= ColorSequence.new({
		ColorSequenceKeypoint.new(0,Color3.fromRGB(218, 193, 52)),
		ColorSequenceKeypoint.new(1,Color3.fromRGB(218, 193, 52))
	})
	HomeDestBeam.FaceCamera		= 1
	HomeDestBeam.LightEmission	= 1
	HomeDestBeam.LightInfluence	= 0.5 or LightInfluence
	HomeDestBeam.Transparency	= NumberSequence.new{
		NumberSequenceKeypoint.new(0,	0.2),
		NumberSequenceKeypoint.new(0.5,	0.7),
		NumberSequenceKeypoint.new(1,	0.2)
	} or TransparencyKeypoints
	HomeDestBeam.Parent			= ATCH0.Parent -- or BeamParent
	-- Worry about promises later, get the base shit working first
	delay(2,function() HomeDestBeam:Destroy() end)
end
R_SurgeDrawBeam.OnClientEvent:Connect(C_SparkSurge_DrawBeam)

function C_SparkSurge_End(character)
	local OrbPlayer = character.PrimaryPart:FindFirstChild("OrbPlayer")
	if OrbPlayer then 
		OrbPlayer:Destroy()
	end	
	for k,v in pairs(LocalPlayer:GetChildren()) do
		if v.ClassName == "Part" and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 0
		elseif v.Name == "Head" and v.ClassName == "Part" then
			v:FindFirstChildOfClass("Decal").Transparency = 0
		end
	end
	character.PrimaryPart.Anchored = false
end
R_SurgeEnd.OnClientEvent:Connect(C_SparkSurge_End)

-- Soon ill be using this in a different manner, so i duped the code here
function AllocatePreviewParticles(StartLoc, EndLoc)
	-- It has to be individually!!!
	local StartEndDistance = math.abs(math.sqrt(
		(StartLoc.X - EndLoc.X)^2+
		(StartLoc.Y - EndLoc.Y)^2+
		(StartLoc.Z - EndLoc.Z)^2 
	)	)
	local StartEndMidPoint = Vector3.new(
		(StartLoc.X + EndLoc.X)/2,
		(StartLoc.Y + EndLoc.Y)/2,
		(StartLoc.Z + EndLoc.Z)/2
	)
	local StartEndTrail		= Instance.new("Part")
	StartEndTrail.Parent		= workspace.EntityDumpStorage
	StartEndTrail.Size			= Vector3.new(1, 0.5, StartEndDistance + 1)
	StartEndTrail.Anchored		= true
	StartEndTrail.CanCollide	= false
	StartEndTrail.Material		= Enum.Material.SmoothPlastic
	StartEndTrail.Transparency	= 0.4
	StartEndTrail.Shape			= Enum.PartType.Block
	-- CFrame and Vector3 are tables internally; They are not detectable by the "type" function.
	StartEndTrail.CFrame 		= CFrame.lookAt(StartEndMidPoint, Vector3.new(EndLoc.X, EndLoc.Y, EndLoc.Z))
end


-- DISABLED_CODE, OLD PART TRAILS
--[[
	local StartEndDistance = math.abs(math.sqrt(
		(HomePosition.X - DestPosition.X)^2+
		(HomePosition.Y - DestPosition.Y)^2+
		(HomePosition.Z - DestPosition.Z)^2 
	)	)
	local StartEndMidPoint = Vector3.new(
		(HomePosition.X + DestPosition.X)/2,
		(HomePosition.Y + DestPosition.Y)/2,
		(HomePosition.Z + DestPosition.Z)/2
	)
	local HomeDestTrail		= Instance.new("Part")
	HomeDestTrail.Parent		= workspace.EntityDumpStorage
	HomeDestTrail.Size			= Vector3.new(1, 0.5, StartEndDistance + 1)
	HomeDestTrail.Anchored		= true
	HomeDestTrail.CanCollide	= false
	HomeDestTrail.Material		= Enum.Material.SmoothPlastic
	HomeDestTrail.Transparency	= 0.4
	HomeDestTrail.Shape			= Enum.PartType.Block
	HomeDestTrail.CFrame 		= CFrame.lookAt(StartEndMidPoint, DestPosition)
	delay(2,function() HomeDestTrail:Destroy() end)
--]]