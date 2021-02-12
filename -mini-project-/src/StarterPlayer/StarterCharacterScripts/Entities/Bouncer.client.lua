local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
---------------------------------------------
-- OnBouncerTouchedClient(toucher)
-- Purpose: Bouncer Client Responder
---------------------------------------------

local DEBOUNCE = false
local BouncerInsName = "BouncerSphere"

local function OnBouncerTouchedClient(toucher)
	local TargetBoostDuration = 0
	local TargetBoostWalkSpeedMultiplier = 1
	local TargetJumpPower = 80
	local BouncerDebouncePeriod = 0.4

	if DEBOUNCE == false then
		DEBOUNCE = true
		local bouncer = nil
		for idx,val in pairs(toucher:GetTouchingParts()) do
			if val.Name == BouncerInsName then
				bouncer = val
				break
			end	
		end

		--[[Actual humanoid things]]
		local humanoid = toucher.Parent:FindFirstChild("Humanoid")
		if humanoid and bouncer then
			if not bouncer:FindFirstChild("IsRecentlyBouncedon") then
				if bouncer.Parent:FindFirstChild("TargetJumpPower") then
					TargetJumpPower = bouncer.Parent.TargetJumpPower.Value
				end
				-- We call it this early 
				local BouncerTrigger = ReplicatedStorage.RemoteEvents:WaitForChild("BouncerTrigger")
				BouncerTrigger:FireServer(toucher, TargetJumpPower, bouncer)

				local IsRecentlyBouncedon	= Instance.new("IntValue")
				IsRecentlyBouncedon.Name 	= "IsRecentlyBouncedOn"
				IsRecentlyBouncedon.Parent	= bouncer
				IsRecentlyBouncedon.Value	= 1

				local DEBUGBOX				= Instance.new("Part")
				do -- wrapper for DEBUGBOX Props
					DEBUGBOX.Anchored		= true
					DEBUGBOX.CanCollide		= false
					DEBUGBOX.CastShadow		= false
					DEBUGBOX.Size			= Vector3.new(0.7, 0.7, 0.7)
					DEBUGBOX.Name 			= "DEBUGBOX"
					DEBUGBOX.Position		= toucher.Position
					DEBUGBOX.Transparency	= 0.4
					DEBUGBOX.Color			= Color3.fromRGB(132, 162, 255)
					DEBUGBOX.Parent			= bouncer
				end

				humanoid.JumpPower = TargetJumpPower
				-- Ok now jump so I can do the pretty things
				humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				wait(0.1)
				local bouncer_sound = bouncer:FindFirstChild("bouncer_touch")
				SoundService:PlayLocalSound(bouncer_sound)

				--[[Reset everything we changed and prepare for the next call]]
				humanoid.JumpPower = 50
				delay(BouncerDebouncePeriod - 0.1, function() IsRecentlyBouncedon:Destroy() end)
				delay(4, function() DEBUGBOX:Destroy() end)
			end	
		end
		DEBOUNCE = false
	end	
end

-- Connect every Bouncer's Touch to that above function
for i,v in pairs(workspace["EntityPositionStorage"]:GetChildren()) do
	if v.Name == "Bouncer" then
		v[BouncerInsName].Touched:Connect(OnBouncerTouchedClient)
	end
end
