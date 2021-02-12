-- cut the workload and just put one of those scripts in each of them-
script.Parent.Touched:Connect(function(Toucher)
	if Toucher.parent:FindFirstChild("Humanoid") then
		local MOD_Prankster = require(game.ServerScriptService.Modules.Entities.MOD_Prankster)
		local PranksterPlatformsSet = script.Parent.Parent
		local TouchedPlatform = script.Parent
		
		MOD_Prankster.PranksterTouchRespond(Toucher, TouchedPlatform, PranksterPlatformsSet)
	end
end)