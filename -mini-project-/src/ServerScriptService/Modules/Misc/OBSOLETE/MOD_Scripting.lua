-- Here just for Scripts to call this?
local MOD_Scripting = {}

--------------- BEGIN FUNCTIONS ---------------
local DEBOUNCE = false
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local DevModeLevel = 0 -- [[We don't have something to take from as DEV MODE LEVEL yet..]]

--[[Developer Mode related]]
--
-- DeveloperModePrint(minlevel, ...)
-- Print messages if the corresponding Dev Mode level is active.
-- "..." represents the area you put what you'd put in print(""). See more at Lua's "variable arguments".
--
--

function MOD_Scripting.DeveloperModePrint(minlevel, ...)
	if RunService:IsStudio() and DevModeLevel < 1 then
		DevModeLevel = 1
	end

	if minlevel <= DevModeLevel then
		print(...)
	end
end

function MOD_Scripting.DeveloperModeWarn(minlevel, ...)
	if RunService:IsStudio() and DevModeLevel < 1 then
		DevModeLevel = 1
	end
	
	if minlevel <= DevModeLevel then
		warn(...)
	end
end

-- DeveloperModeSetLevel(level)
-- Sets the Dev Mode level.

function MOD_Scripting.DeveloperModeSetLevel(level)
	DevModeLevel = level
	MOD_Scripting.DeveloperModePrint(1, "Dev Mode Level: " .. DevModeLevel)
end

-- DeveloperModeGetLevel(level)
-- Gets the Dev Mode level.

function MOD_Scripting.DeveloperModeGetLevel()
	return DevModeLevel
end

--[[Scripting Utility]]

-- CapsFirstLetterOnly(str)
-- Capitilize only the first letter, and uncapitilize the letters after it.

function CapsFirstLetterOnly(str)
	return string.upper(string.sub(str,1,1)) .. string.lower(string.sub(str, 2))
end

-- GetPlayerNamesInServer()
-- Returns names of all Players connected to the server.

function MOD_Scripting.GetPlayerNamesInServer()
	for i, player in pairs(Players:GetPlayers()) do
		if player then
			print(player.Name)
		else
			print("no playerdata instances exist")
		end
	end
end

-- GetDistance()
-- Grabs distance between two Instances.

function MOD_Scripting.GetDistance(InsStart, InsEnd)
	local posstart	= InsStart.CFrame
	local posend	= InsEnd.CFrame
	return math.abs( math.sqrt( (posstart.X - posend.X)^2 + (posstart.Y - posend.Y)^2 + (posstart.Z - posend.Z)^2 ) )
end

-- CFrameToVector3()
-- Converts CFrame to Vector3.

function MOD_Scripting.CFrameToVector3(cframeval)
	return Vector3.new(cframeval.X, cframeval.Y, cframeval.Z)
end

-- VectorToDegree()
-- Converts Vector3 to use degree rotation values. Keys such as Part.Orientation and Part.Rotation use degree rotations.
--- Created by NPOSim / subsimple

function MOD_Scripting.VectorToDegree(vectorRot)
	local xDeg = math.atan(vectorRot.y/vectorRot.z)
	local yDeg = nil
	local zDeg = nil
	return Vector3(xDeg, yDeg, zDeg)
end

-- WaitForFramesReloopCount(count)
-- The amount of times we should wait for HeartBeat to reloop itself. The function is hard-coded to expect 60 FPS.
---- Honestly should be deprecating this because I feel this is generally an overcomplication to problems, and kills performance.
--function MOD_Scripting.WaitHeartBeatReloopCount(count)
--	local Expected_FPS = 60
--	local function Heartbeat_event()
--		local i = 0
--		local destination = count * Expected_FPS
--		while i < destination do
--			i=i+1
--		end
--		if i > destination then
--			RunService.Heartbeat:Disconnect()
--			MOD_Scripting.DeveloperModePrint(1, "DONE HEARTBEAT RELOOP")
--			return 1
--		end
--	end
--end

--------------- END FUNCTIONS ---------------

-- Here just for Modules to return a call?
return MOD_Scripting
