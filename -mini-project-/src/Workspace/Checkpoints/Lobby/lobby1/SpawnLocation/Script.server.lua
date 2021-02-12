-- this is just to make the number spin
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
