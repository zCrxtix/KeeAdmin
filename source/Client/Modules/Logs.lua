--[[
	Logging chat messages and commands
]]

local logs = {}

function logs.log(player, msg)
	for _,v in pairs(game:GetDescendants()) do
		if v.Name == "LogsUI" then
			local temp = game.StarterPack.Client.GUIs.Template:Clone()
			temp.Text = player.Name..":"..msg
			temp.Parent = v.Background.Container
		end
	end
end

return logs
