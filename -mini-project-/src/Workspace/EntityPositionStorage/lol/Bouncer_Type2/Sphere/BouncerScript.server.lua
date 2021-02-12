script.Parent.Touched:Connect(function(touched)
	if touched.parent:FindFirstChild("Humanoid") then
		
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local ServerScriptService = game:GetService("ServerScriptService")
		
		local RemoteFunction_Bouncer = ReplicatedStorage.RemoteEvents:WaitForChild("BouncerTrigger")
		local MOD_Bouncer = require(ServerScriptService.Modules.Entities.MOD_Bouncer)
		local bouncer = script.Parent.Parent

		MOD_Bouncer.OnTouchBouncer(touched, bouncer)
	end
end)