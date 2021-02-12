script.Parent.Touched:Connect(function(touched)
	if touched.parent:FindFirstChild("Humanoid") then

		local SparkSurge = require(game.ServerScriptService.Modules.Entities.SparkSurge)
		local orb = script.Parent

		SparkSurge.OnTouched(touched, orb)
	end
end)