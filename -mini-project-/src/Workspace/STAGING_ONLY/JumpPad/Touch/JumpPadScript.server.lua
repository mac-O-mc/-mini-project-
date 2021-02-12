script.Parent.Touched:Connect(function(hit)
	if hit.parent:FindFirstChild("Humanoid") then

		-- Keys part of the Humanoid class that we'll use:
		--
		-- BOOL		Jump:			Whether the Humanoid is jumping. If set to true, it will cause the Humanoid to jump.
		-- FLOAT	JumpHeight: 	Provides control over the force with which a Humanoid jumps (Air Control?)
		-- FLOAT	JumpPower:		Determines how much upwards force is applied to the Humanoid when jumping (True Jump Height?)
		--
		-- Default values:
		-- JumpHeight - 7.1999998092651
		-- JumpPower - 50
		
		local MOD_JumpPad = require(game.ServerScriptService.Modules.Entities.MOD_JumpPad)
		local jumppad = script.Parent.Parent

		MOD_JumpPad.OnTouchJumpPad(hit, jumppad)
	end
end)