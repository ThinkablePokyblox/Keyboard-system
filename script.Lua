--\\Variables//--
--Services--
local Services = {
	PlayerService = game:GetService("Players"),
	TweenService = game:GetService("TweenService"),
	ChatService = game:GetService("Chat")
}
--Variables--
local CooldownTable = {
	
}
--\\Main-Code//--
for i, v in pairs(script.Parent.Keys:GetDescendants()) do
	if v:IsA("Part") then
		table.insert(
			CooldownTable,
			i,
			{
				v.Name,
				false
			}
		)
	end
end
print(CooldownTable)
--
for i, v in pairs(script.Parent.Keys:GetDescendants()) do
	if v:IsA("Part") then
		v.Touched:Connect(function(Hit)
			local Player = Services.PlayerService:GetPlayerFromCharacter(Hit.Parent) or Services.PlayerService:GetPlayerFromCharacter(Hit.Parent.Parent)
			if Player then
 				if CooldownTable[i][2] == false then
					CooldownTable[i][2] = true
					Services.TweenService:Create(
						v,
						TweenInfo.new(
							0.5,
							Enum.EasingStyle.Sine,
							Enum.EasingDirection.InOut,
							0,
							true,
							0
						),
						{
							Color = Color3.fromRGB(255, 255, 255)
						}
					):Play()
					if v.Parent.Name == "SpecialKeys" then
						if CooldownTable[i][1] == "Space" then
							script.Parent.Screen.SurfaceGui.TextLabel.Text = script.Parent.Screen.SurfaceGui.TextLabel.Text.." "
						elseif CooldownTable[i][1] == "Caps Lock" then
							if script.Parent.Values.CapsLock.Value == true then
								script.Parent.Values.CapsLock.Value = false
							else
								script.Parent.Values.CapsLock.Value = true
							end
						end
					else
						local Char = CooldownTable[i][1]
						if script.Parent.Values.CapsLock.Value == true then
							script.Parent.Screen.SurfaceGui.TextLabel.Text = Services.ChatService:FilterStringForBroadcast(script.Parent.Screen.SurfaceGui.TextLabel.Text..string.upper(Char),Player)
						elseif script.Parent.Values.CapsLock.Value == false then
							script.Parent.Screen.SurfaceGui.TextLabel.Text = Services.ChatService:FilterStringForBroadcast(script.Parent.Screen.SurfaceGui.TextLabel.Text..string.lower(Char),Player)
						end
					end
					wait(0.5)
					CooldownTable[i][2] = false
				end
			end
		end)
	end
end
