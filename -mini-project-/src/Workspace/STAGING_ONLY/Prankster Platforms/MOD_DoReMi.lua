local MOD_DoReMi = {}

-- STAGING_ONLY PROOF OF CONCEPT

local RunService = game:GetService("RunService")
local MOD_Scripting	= require(game.ServerScriptService.Modules.MOD_Scripting)

local DoReMi_StateID = 0

function MOD_DoReMi.DoReMiPlatformsThink(DoReMi_Platforms)
	
	local ShouldThink
	local RethinkPeriod = 2
	
	local Do = DoReMi_Platforms.Do
	local Re = DoReMi_Platforms.Re
	local Mi = DoReMi_Platforms.Mi
	local Fa = DoReMi_Platforms.Fa
	
	--[[Render Thinker]]
	-- We put numbers in descending order so the Script doesn't call them all at once
	
	if ShouldThink then
		ShouldThink = false
		if Do.Transparency == 0 and Re.Transparency == 0 then
			Re.Transparency, 	Mi.Transparency,	Fa.Transparency	= 1, 1, 1
			Re.CanCollide,		Mi.CanCollide, 		Fa.CanCollide 	= false, false, false
			
			Do.Transparency, Do.CanCollide = 0, true
			DoReMi_StateID = 0
			print("STATE " .. DoReMi_StateID)
			do return end
		elseif Do.Transparency == 0 then
			Do.Transparency, 	Mi.Transparency,	Fa.Transparency	= 1, 1, 1
			Do.CanCollide,		Mi.CanCollide, 		Fa.CanCollide 	= false, false, false
			
			Re.Transparency, Re.CanCollide = 0, true
			DoReMi_StateID = 2
			print("STATE " .. DoReMi_StateID)
			do return end
		elseif Re.Transparency == 0 then
			Do.Transparency, 	Re.Transparency,	Fa.Transparency	= 1, 1, 1
			Do.CanCollide,		Re.CanCollide, 		Fa.CanCollide 	= false, false, false
			
			Mi.Transparency, Mi.CanCollide = 0, true
			DoReMi_StateID = 3
			print("STATE " .. DoReMi_StateID)
		elseif Mi.Transparency == 0 then
			Re.Transparency, 	Mi.Transparency,	Do.Transparency	= 1, 1, 1
			Re.CanCollide,		Mi.CanCollide, 		Do.CanCollide 	= false, false, false
			
			Fa.Transparency, Fa.CanCollide = 0, true
			DoReMi_StateID = 4
			print("STATE " .. DoReMi_StateID)
			do return end
		elseif Fa.Transparency == 0 then
			Re.Transparency, 	Mi.Transparency,	Fa.Transparency	= 1, 1, 1
			Re.CanCollide,		Mi.CanCollide, 		Fa.CanCollide 	= false, false, false
			
			Do.Transparency, Do.CanCollide = 0, true
			DoReMi_StateID = 1
			print("STATE " .. DoReMi_StateID)		
			do return end			
		end
	end
end

return MOD_DoReMi
