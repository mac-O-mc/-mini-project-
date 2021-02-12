local Pathfinding = {}
--[[ December 26 2020
-- Manual handling of AI related actions
//-------------------------------------------------
--]]
local PathfindingService = game:GetService("PathfindingService")

function Pathfinding.SetNPCPathComputeParams(humanoid, pathparamstable)
	for k,v in pairs(pathparamstable) do
		
	end
end

function Pathfinding.MoveToPos(humanoid, location)
	local path = PathfindingService:CreatePath()
	path.Parent = humanoid
end

function Pathfinding.MoveToPart(humanoid, part)
	local path = PathfindingService:CreatePath()
	path.Parent = humanoid
end

return Pathfinding
