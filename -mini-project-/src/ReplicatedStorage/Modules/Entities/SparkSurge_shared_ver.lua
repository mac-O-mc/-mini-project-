-- No need to change the 'module' things's name iirc but i gotta use them to copy paste lol
local CSparkSurge = {}

---------------------------------------------
-- Keys --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BeamExtended = require(ReplicatedStorage.Modules.Custom.BeamExtended)
local R_SurgeStart = ReplicatedStorage.RemoteEvents:WaitForChild("R_SurgeStart",5)
local R_SurgeDrawBeam = ReplicatedStorage.RemoteEvents:WaitForChild("R_SurgeDrawBeam",5)
local R_SurgeEnd = ReplicatedStorage.RemoteEvents:WaitForChild("R_SurgeEnd",5)

local OrbOnTeleportPause = 0.5 -- this high value is for testing
local NextPointPrefix = "SurgeDest"
local DEBOUNCE = true

---------------------------------------------
-- Functions --

function CSparkSurge.IsTouched(touched, orb)
	-- TEMPORARILY DEPRECATED
end	

return CSparkSurge


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