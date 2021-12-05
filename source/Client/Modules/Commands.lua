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
			script.Parent.Parent.GUIs.CommandsUI:Clone().Parent = player.PlayerGui
		end,
	},
	{
		name = "chatlogs",
		aliases = {"logs", "clogs"},
		level = 1,

		execute = function(player, args)
			script.Parent.Parent.GUIs.LogsUI:Clone().Parent = player.PlayerGui
		end,
	},
	{
		name = "info",
		aliases = {"check"},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(api:GetPlayer(player, args)) do
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
				script.Parent.Parent.GUIs.InfoUI:Clone().Parent = v.PlayerGui
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
	{
		name = "chatcolor",
		aliases = {},
		level = 1,
		
		execute = function(player, args) --https://devforum.roblox.com/t/how-does-chat-service-work-and-what-can-i-do-with-it/1568578/3, probably not working yet
			for _,v in pairs(api:GetPlayer(player, args)) do
				local ChatService = game:GetService("ServerScriptService").ChatServiceRunner.ChatService
				local Speaker = ChatService:GetSpeaker(v)
				
				Speaker:SetExtraData("ChatColor", Color3.fromRGB(255, 255, 0))
			end
		end,
	}
}
