script.Parent.SurfaceGui.TextBox.Text = tostring(script.Parent.Parent.CheckpointNumber.Value)
while true do
	for i = 1,20 do
		script.Parent.SurfaceGui.TextBox.Rotation = script.Parent.SurfaceGui.TextBox.Rotation + 2
		wait(0.1)
	end
	for i = 1,20 do
		script.Parent.SurfaceGui.TextBox.Rotation = script.Parent.SurfaceGui.TextBox.Rotation - 2
		wait(0.1)
	end
end
