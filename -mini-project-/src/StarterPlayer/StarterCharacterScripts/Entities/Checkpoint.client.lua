local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local CheckpointTrigger = ReplicatedStorage.RemoteEvents:WaitForChild("CheckpointTrigger")
--local OrbEffect = ReplicatedStorage:WaitForChild("OrbClient")

-- Ignore the passed player; start with additional passed data
local function CheckpointAction(chkptBRICK, chkptMODEL)
	if chkptMODEL and chkptBRICK then
		local sphere = Instance.new("Part") -- create a sphere
		sphere.Name = "sphere"
		sphere.Shape = "Ball"
		sphere.Size = Vector3.new(1,1,1)
		sphere.BrickColor = chkptBRICK.BrickColor
		sphere.Material = "Neon"
		sphere.Anchored = true
		sphere.CFrame = CFrame.new(chkptBRICK.Position)
		sphere.Transparency = 0
		sphere.CanCollide = false
		sphere.CastShadow = false
		sphere.Parent = chkptMODEL
		local s = Instance.new("Sound")
		s.SoundId = "rbxassetid://145486970"
		SoundService:PlayLocalSound(s)
		local textpart = Instance.new("Part")
		textpart.CanCollide = false
		textpart.Anchored = false
		textpart.Transparency = 1
		textpart.CFrame = CFrame.new(chkptBRICK.Position)
		textpart.Size = Vector3.new(1,1,1)
		textpart.Velocity = textpart.Velocity + Vector3.new(0,50,0)
		textpart.Name = "billboard part"
		textpart.Parent = chkptMODEL
		local lol = game.ReplicatedStorage.CheckpointNum:Clone()
		lol.Parent = textpart
		lol.TextLabel.Text = (tostring(chkptMODEL.CheckpointNumber.Value).." / 30")
		lol.Enabled = true
		for i = 1,20 do 
			sphere.Size = sphere.Size + Vector3.new(2,2,2)
			sphere.Transparency = sphere.Transparency + 0.05
			wait()
		end 
		sphere:Destroy()
		wait(1)
		textpart:Destroy()
	end
end

--local function OrbAction(orbtype, orb)
--	if orbtype and orb:IsA("BasePart") then
--		if orbtype == "bouncer" then
--			SoundService:PlayLocalSound(orb.bouncer_touch)
--			orb.Attachment.Bouncer_Emit:Emit(1)
--		end
--	end
--end

--OrbEffect.OnClientEvent(OrbAction)
CheckpointTrigger.OnClientEvent:Connect(CheckpointAction)

--[[Bouncer: Model 2]]
-- big code block
