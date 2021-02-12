-- September 2020
-- Purpose: Update all scripts and particles and whatnot, so we don't have any weird things that are outdated
--- Sorta an initial game "loading" thing

local ENT_Folder_Childs = workspace.EntityPositionStorage:GetChildren()

local BouncerFolder = workspace.EntityAssetStorage.Bouncer

-- I got confused by these initially. Apparently, with pairs() or ipairs(), "k" and "v" are just there to store things in them.
-- Unlike the usual for loop, where you define things that already have things stored in them. 
for k,v in pairs(ENT_Folder_Childs) do
	if v.ClassName == "Model" and v.Name == "Bouncer" then
		local SpherePos = v.Sphere.Position
		
		--Slap those cloned assets
		local SyncedBouncer = BouncerFolder.BouncerSphere:Clone()
		SyncedBouncer.Parent = v
		SyncedBouncer.Position = SpherePos
		SyncedBouncer.Name = "BouncerSphere"
		v.Sphere:Destroy()
		v.PrimaryPart = SyncedBouncer
		if not v:FindFirstChild("TargetJumpPower") then
			local Ins_JumpPower = Instance.new("NumberValue")
			Ins_JumpPower.Parent = v
			Ins_JumpPower.Value = 80	-- This is the default value
		end
	end	
end

print("Done Refreshing Entities's Assets")