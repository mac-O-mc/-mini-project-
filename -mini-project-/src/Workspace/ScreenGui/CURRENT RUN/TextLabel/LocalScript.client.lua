local player = game.Players.LocalPlayer

while true do
	wait(0.5)
hp = player.leaderstats.Stage.Value
maxhp = script.Parent.Parent.Stages.Value
health = maxhp/hp
script.Parent.Size = UDim2.new(0,800/health,0,10)
end