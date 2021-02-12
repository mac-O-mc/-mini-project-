script.Parent.Touched:Connect(function(touched)
	if touched.parent:FindFirstChild("Humanoid") then

		local MOD_Bouncer = require(game.ServerScriptService.Modules.Entities.MOD_Bouncer)
		local bouncer = script.Parent

		MOD_Bouncer.OnTouched(touched, bouncer)
	end
end)
