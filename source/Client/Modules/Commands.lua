--[[
	Commands on the client
]]

local api = require(script.Parent.Parent.Modules.API)

return {
	{
		name = "commands",
		aliases = {"cmds"},
		level = 0,
			
		execute = function(player, args)
			local clone = script.Parent.Parent.GUIs.CommandsUI:Clone()
			repeat clone.Parent = player.PlayerGui until clone.Parent == player.PlayerGui
		end,
	},
	{
		name = "chatlogs",
		aliases = {"logs", "clogs"},
		level = 1,

		execute = function(player, args)
			local clone = script.Parent.Parent.GUIs.LogsUI:Clone()
			clone.Parent = player.PlayerGui
		end,
	},
	{
		name = "info",
		aliases = {"check", "profile"},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(api:GetPlayer(player, args)) do
				script.Parent.Parent.GUIs.InfoUI:Clone().Parent = player.PlayerGui
				local ui = v.PlayerGui
				local info = ui.InfoUI
				local container = info.Background.Container
				local age = container.Age
				local premium = container.Premium
				local id = container.UserId
				local name = container.Username

				age.Text = "Age: "..v.AccountAge
				if v.MembershipType == Enum.MembershipType.Premium then premium.Text = "Premium: true" else premium.Text = "Premium: false" end
				name.Text = "Username: "..v.Name
				id.Text = "UserId: "..v.UserId
			end
		end,
	},
	{
		name = "rejoin",
		aliases = {},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(api:GetPlayer(player, args)) do
				game:GetService("TeleportService"):Teleport(game.PlaceId, v)
			end
		end,
	},
	
}
