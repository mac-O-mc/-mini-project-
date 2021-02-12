local BeamEXT = {}
-- BeamExtended

function BeamEXT.IsBeam(beam, shouldpcall)
	if beam.Classname == "Beam" then
		return true
	elseif shouldpcall == true then
		warn("Not a Beam!")
		return false
	else
		error("Not a Beam!")
	end
end

function BeamEXT.SetLifetime(beam, lifetime)
	-- can be easily made in the script but figured it'd be good if I made this wrapper
	--- yer want delay replaced? Not needed till I make a timer Module, so don't worry 'bout tat
	if BeamEXT.IsBeam(beam, false) == true then
		delay(lifetime,function() beam:Destroy() end)
	end
end

-- Code assisted by: sub#9640
--- Untested, but not in my scope right now
local TweenService = game:GetService("TweenService")
-- Grabs only the Transparency value from each keypoint
function BeamEXT.TweenIndividualKeypoints(beam, tweeninfo_table)
	local keypoints = beam.Transparency.Keypoints
	for i=1, #keypoints do
		TweenService:Create(keypoints[i].Value, tweeninfo_table[i])
	end
end

return BeamEXT