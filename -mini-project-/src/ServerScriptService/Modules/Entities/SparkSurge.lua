-- No need to change the 'module' things's name iirc but i gotta use them to copy paste lol
local SparkSurge = {}

---------------------------------------------
-- Keys --
local DEBOUNCE = false
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Promise = require(ReplicatedStorage.Modules["Util."].evaera_Promise)
local Event_SurgeStart = ReplicatedStorage.RemoteEvents:WaitForChild("SurgeStart",3)
local Event_SurgeBeamDrawn = ReplicatedStorage.RemoteEvents:WaitForChild("SurgeBeamDrawn",3)
local Event_SurgeEnd = ReplicatedStorage.RemoteEvents:WaitForChild("SurgeEnd",3)
local Function_SurgeCamAdjustFinal = ReplicatedStorage.RemoteFunctions:WaitForChild("SurgeCamAdjustFinal",3)

local BeamLifetime = 2
local OrbOnTeleportPause = 0.4
local NextPointPrefix = "SurgeDest"

---------------------------------------------
-- Functions --
function SparkSurge.GetSurgableNodes(orb)
	local SurgeNodesCount = 0
	for _,InsName in pairs(orb.Parent:GetChildren()) do
		if string.sub(tostring(InsName),1,string.len(NextPointPrefix)) == NextPointPrefix then
			SurgeNodesCount += 1
		end
	end
	print("TotalDestCount: " .. tostring(SurgeNodesCount))
	if SurgeNodesCount == 0 then
		error("Can't find any Destination nodes?")
	end
	return SurgeNodesCount
end

function SparkSurge.OnTouched(touched, orb)
	if not DEBOUNCE then
		DEBOUNCE = true
		local humanoid = touched.parent:FindFirstChild("Humanoid")
		if humanoid then
			local character		= humanoid.Parent
			local character_plr	= Players:GetPlayerFromCharacter(character)
			local PlayerSurgedCount		= nil
			local PlayerSurgedCountIns	= humanoid:FindFirstChild("SurgedCount")
			local TotalDestCount 		= SparkSurge.GetSurgableNodes(orb)
			-- for later
			if PlayerSurgedCountIns == nil then
				print("SurgedCount not found; creating new one")
				PlayerSurgedCountIns  = Instance.new("IntValue")
				PlayerSurgedCountIns.Name = "SurgedCount"
				PlayerSurgedCountIns.Value = 0
				PlayerSurgedCountIns.Parent = humanoid
				PlayerSurgedCount = PlayerSurgedCountIns.Value
			end
			-- Staaart the Surge visuals
			character.PrimaryPart.Anchored = true
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
			OrbPlayer.Parent = workspace.EntityDumpStorage
			local character_face = character.Head:FindFirstChildOfClass("Decal"):Clone()
			character_face.Transparency = 0
			character_face.Parent = OrbPlayer
			Event_SurgeStart:FireClient(character_plr)
			-- 0 < 2, then 1 < 2, then 2 < 2.
			-- first two are valid, so 2 teleport chances which is just what we need! :thumbsup:
			while PlayerSurgedCount < TotalDestCount do
				PlayerSurgedCount += 1
				print(PlayerSurgedCount)
				local HomeName = "SurgeOrb"
				local DestName = NextPointPrefix .. tostring(PlayerSurgedCount)
				if orb.Parent:FindFirstChild(DestName) then
					if PlayerSurgedCount > 1 then
						HomeName = NextPointPrefix..tostring(PlayerSurgedCount - 1)
					end
					local HomeOrb = orb.Parent[HomeName]
					local DestOrb = orb.Parent[DestName]
					local HomeAttachment = HomeOrb.Attachment
					local DestAttachment = DestOrb.Attachment
					local HomeDestLookAt = CFrame.lookAt(HomeOrb.CFrame.Position,DestOrb.CFrame.Position)
					character:SetPrimaryPartCFrame(HomeDestLookAt)	
					OrbPlayer.CFrame = HomeDestLookAt
					Promise.delay(OrbOnTeleportPause):await()
					-- we don't need to worry about orienting the player again as for how the while loop works
					--- Just do the positioning
					character:SetPrimaryPartCFrame(DestOrb.CFrame)
					OrbPlayer.CFrame = DestOrb.CFrame
					-- Draw the beams
					do
						local HomeDestBeam = Instance.new("Beam")
						HomeDestBeam.Attachment0	= HomeAttachment
						HomeDestBeam.Attachment1	= DestAttachment
						HomeDestBeam.Color			= ColorSequence.new{
							ColorSequenceKeypoint.new(0,Color3.fromRGB(218, 193, 52)),
							ColorSequenceKeypoint.new(1,Color3.fromRGB(218, 193, 52))
						}
						HomeDestBeam.FaceCamera		= 1
						HomeDestBeam.LightEmission	= 1
						HomeDestBeam.LightInfluence	= 0.5
						HomeDestBeam.Transparency	= NumberSequence.new{
							NumberSequenceKeypoint.new(0,	0.2),
							NumberSequenceKeypoint.new(0.5,	0.7),
							NumberSequenceKeypoint.new(1,	0.2)
						}
						HomeDestBeam.Parent	= HomeAttachment.Parent
						Promise.delay(BeamLifetime):andThen(function() HomeDestBeam:Destroy() end)
						if PlayerSurgedCount == TotalDestCount then
							character:SetPrimaryPartCFrame(DestOrb.CFrame)	
							OrbPlayer.CFrame = DestOrb.CFrame
							Function_SurgeCamAdjustFinal.OnServerInvoke = (function()
								Promise.delay(0.1):await()
								OrbPlayer:Destroy()
								Event_SurgeEnd:FireClient(character_plr)
								character.Humanoid[tostring(PlayerSurgedCountIns)]:Destroy()
								character.HumanoidRootPart.Velocity = Vector3.new(0,0,0) 
								character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame + Vector3.new(0,5,0))
							end)	
							Function_SurgeCamAdjustFinal:InvokeClient(character_plr, HomeOrb.CFrame, OrbOnTeleportPause)
						else
							Event_SurgeBeamDrawn:FireClient(character_plr, HomeDestLookAt, OrbOnTeleportPause)
						end	
					end
				else
					warn("Can't find any Destinations but there's still more to reach???")
				end
			end
			for k,v in pairs(character:GetChildren()) do
				if v.ClassName == "Part" and v.Name ~= "HumanoidRootPart" then
					v.Transparency = 0
				end
				if v.Name == "Head" and v.ClassName == "Part" then
					v:FindFirstChildOfClass("Decal").Transparency = 0
				end
			end
			character.PrimaryPart.Anchored = false
		end
		DEBOUNCE = false
	end
end

return SparkSurge


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