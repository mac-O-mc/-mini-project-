local module = {}

--[[-- HOW TO USE ---------------------------------------------------------------------------------------

	Initially created by exwumm before being redone by mc (me!).
	
	To use it in the server console, you'd need to type like so:

	"local G = require(game.ServerScriptService.zoneWarp) G.StageTP("MCandRBfan", "sky", 4)"
	
	First field must be a string with the same cases. You could also send "game.workspace.MCandRBfan"
	or "workspace.MCandRBfan" without the quotation marks if you wanted.
	
	Second field must be a string of the zone's name. It is not case-sensitive
	
	Third field is the zone's stage number. See the Checkpoints folder for reference.

--]]-----------------------------------------------------------------------------------------------------

local STAGEDATA_DIRECTORY = workspace.Checkpoints

-- Zone must be in quotation marks, or the passed value will be nil
--- Can't convert it to string due to it

function module.StageTP(target, zone, stagenumber)
	-- who in the hell would send target as a string? :^)
	--- (this is just to send names quickly and easy, lol)
	if type(target) == "string" then
		if string.sub(tostring(target),1,15) ~= "game.workspace." or string.sub(tostring(target),1,10) ~= "workspace." then
			target = game.workspace[target]
		end
		print("Target name: " .. tostring(target))	
	end	

	if target:IsA("Model") and target:FindFirstChild("Humanoid") then
		if type(zone) ~= "string" then error("Zone name cannot be sent in a non-string value!") end

		local zonefolder_found = nil
		local FolderInstanceFound = false

		zone = string.upper(string.sub(zone,1,1)) .. string.lower(string.sub(zone, 2))

		for k,v in pairs(STAGEDATA_DIRECTORY:GetChildren()) do
			if v.Name == zone and v.ClassName == "Folder" then
				zonefolder_found = true
			end
		end

		if zonefolder_found ~= nil then
			local ZoneStageString = string.lower(zone .. tostring(stagenumber))
			if STAGEDATA_DIRECTORY [zone][ZoneStageString] then
				print(ZoneStageString)
				local player = game.Players:GetPlayerFromCharacter(target)
				local ls = player.leaderstats
				local chkpt = nil
				-- Special Case
				if ZoneStageString == "lobby1" then
					chkpt = workspace.Checkpoints.Lobby["lobby1"].SpawnLocation
				else
					chkpt = workspace.Checkpoints[zone][ZoneStageString].Touch
				end
				-- Sets the proper zone and stage data for the player's GUI, then teleport them
				ls.Stage.Value = stagenumber
				ls.Zone.Value = zone
				player.Path.Value = chkpt.Path.Value
				target.HumanoidRootPart.CFrame = chkpt.CFrame + Vector3.new(0,6,0)
				target.HumanoidRootPart.Orientation = chkpt.Orientation +  Vector3.new(0,0,90)
			end
		else
			warn("Can't Find Valid Folder")
		end
	else
		warn("Invalid Player Model Name")
	end
end

return module