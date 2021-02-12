-- Here just for Scripts to call this?
local MOD_Bouncer = {}

--------------- BEGIN FUNCTIONS ---------------
--[[Key Declaring]]--
local TargetJumpPower = 80
local BouncerTrigger		= game.ReplicatedStorage.RemoteEvents:WaitForChild("BouncerTrigger", 6) -- timeout default is 10

-- Sometimes server responds faster than client lol
local BouncerDebouncePeriod = 0.4

-- STAGING_ONLY VARS. / UNIMPLEMENTED
--local BouncerExhaustDuration = 0
--local BouncerUsageBeforeExhausted = 0
--local BouncerExhaustPeriodically = false
--local BouncerExhaustPeriodicallyDelay = 0

local TargetBoostDuration = 0
local TargetBoostWalkSpeedMultiplier = 1

---------------------------------------------
-- OnTouchBouncer(touched, bouncer)
-- Called when a Bouncer is touched by a Humanoid
---------------------------------------------

function MOD_Bouncer.OnTouched(touched, bouncer)
	local DEBOUNCE = false
	if not DEBOUNCE then
		local humanoid = touched.parent:FindFirstChild("Humanoid")
		if humanoid then
			if not bouncer:FindFirstChild("IsRecentlyBouncedOn") then
				DEBOUNCE = true
				--[[SETUP]]--
				local DEBUGBOX			= Instance.new("Part")
				DEBUGBOX.Anchored		= true
				DEBUGBOX.CanCollide		= false
				DEBUGBOX.CastShadow		= false
				DEBUGBOX.Size			= Vector3.new(0.7, 0.7, 0.7)
				DEBUGBOX.Name 			= "DEBUGBOX"
				DEBUGBOX.Position		= touched.position
				DEBUGBOX.Transparency	= 0.2
				DEBUGBOX.Color			= Color3.fromRGB(157, 255, 177)
				DEBUGBOX.Parent			= bouncer.Parent
				
				local IsRecentlyBounced		= Instance.new("IntValue")
				IsRecentlyBounced.Name 		= "IsRecentlyBounced"
				IsRecentlyBounced.Parent	= humanoid
				IsRecentlyBounced.Value		= 1
				
				local IsRecentlyBouncedon	= Instance.new("IntValue")
				IsRecentlyBouncedon.Name 	= "IsRecentlyBouncedOn"
				IsRecentlyBouncedon.Parent	= bouncer
				IsRecentlyBouncedon.Value	= 1
				
				--[[Prepare server communication]]
				local TouchedPlayer	= bouncer.TouchedPlayer
				TouchedPlayer.Value	= touched.Parent.Name
				
				delay(BouncerDebouncePeriod, function() IsRecentlyBounced:Destroy() IsRecentlyBouncedon:Destroy() end)
				
				delay(4, function() DEBUGBOX:Destroy() end)
			end	
		end
		DEBOUNCE = false
	end
end

function MOD_Bouncer.ClientNetworking(plr, toucher, orbjumppower, bouncer)
	local DEBOUNCE = false
	if not DEBOUNCE then
	--	if toucher.Parent:FindFirstChild("humanoid") then

			local bouncer_model = bouncer.Parent
			local bouncer_bbox_cframe, bouncer_bbox_size = bouncer_model:GetBoundingBox()

			if not bouncer:FindFirstChild("bouncer_bbox") then
				local bouncer_bbox 			= Instance.new("Part")
				bouncer_bbox.Anchored		= true
				bouncer_bbox.CanCollide		= false
				bouncer_bbox.CastShadow		= false
				bouncer_bbox.Name			= "bouncer_bbox"
				bouncer_bbox.CFrame			= bouncer_bbox_cframe
				bouncer_bbox.Size 			= bouncer_bbox_size
				bouncer_bbox.Transparency	= 0.4
				bouncer_bbox.Color			= Color3.fromRGB(229, 89, 54)
				bouncer_bbox.Parent			= bouncer
			end
			
			delay(0.5, function()
				if bouncer.Parent.TargetJumpPower.Value ~= orbjumppower then
					warn(tostring(plr) .. " returned " .. bouncer.Parent.TargetJumpPower.Value .. ", but server-side value is " .. orbjumppower .. "?")
				end
			end)
			delay(1, function() local ServerTouchedPlayer = bouncer:FindFirstChild("TouchedPlayer")
				if ServerTouchedPlayer then
					if ServerTouchedPlayer.Value == tostring(plr) then
						print("TOUCHER IDENTICAL")
					else
						warn("Event Caller '" .. tostring(plr) .. "' doesn't match with ServerTouchedPlayer's Value:" .. ServerTouchedPlayer.Value)
					end
				else
					error("Can't find TouchedPlayer!")
				end
			end)
	--	end	
	end
	DEBOUNCE = false
end

BouncerTrigger.OnServerEvent:Connect(MOD_Bouncer.ClientNetworking)

--------------- END FUNCTIONS ---------------

-- Here just for Modules to return a call?
return MOD_Bouncer
