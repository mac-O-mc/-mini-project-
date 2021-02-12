local DEBOUNCE = false
local base
function OnTouchCheckpoint(hit)
	if DEBOUNCE == false then
		DEBOUNCE = true
		-- local player = game.Players:GetPlayerFromCharacter(game.Players.LocalPlayer)
		if game.Players.LocalPlayer.leaderstats.Stage.Value == tonumber(base.CheckpointNumber.Value) - 1 then
			local sphere = Instance.new("Part") -- create a sphere
			sphere.Name = "sphere"
			sphere.Shape = "Ball"
			sphere.Size = Vector3.new(1,1,1)
			sphere.BrickColor = base.Touch.BrickColor
			sphere.Material = "Neon"
			sphere.Anchored = true
			sphere.CFrame = CFrame.new(base.Touch.Position)
			sphere.Transparency = 0
			sphere.CanCollide = false
			sphere.Parent = base
			for i = 1,20 do 
				sphere.Size = sphere.Size + Vector3.new(1.5,1.5,1.5)
				sphere.Transparency = sphere.Transparency + 0.05
				wait()
			end 
			sphere:Destroy()
			wait(1)
			DEBOUNCE = false
		end
	end
end

 -- workspace.Checkpoint.Touch.Touched:connect(OnTouchCheckpoint)

--[[
y ffor i,v in pairs(workspace:GetChildren()) do
	if v.Name == "Checkpoint" then
		v.Touch.Touched:connect(OnTouchCheckpoint)
		local base = v.
	end
end
]]
--[[]]--
