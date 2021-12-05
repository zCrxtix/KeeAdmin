--[[
	Main script for parsing commands on the server and setting up client.
	Don't touch anything unless you know what you're doing.
]]
--!nocheck

local data = require(script.Parent.Modules.Data)
return function(conf, pkg)
	local slock = Instance.new("BoolValue") slock.Name = "KASLOCK" slock.Parent = game.ServerStorage
	local commands = require(script.Parent.Modules.Commands)
	local config = require(conf)
	local packages = require(pkg)
	script.Parent.Tools.Parent = config["ToolsDirectory"]
	script.Parent.Parent.Client.Parent = game.StarterPack
	for _, command in pairs(require(script.Parent.Modules.Commands)) do
		local temp = game.StarterPack.Client.GUIs.Template:Clone()
		temp.Parent = game.StarterPack.Client.GUIs.CommandsUI.Background.Container
		temp.Text = config["Prefix"]..command["name"]
		temp.Name = config["Prefix"]..command["name"]
	end
	for _, command in pairs(require(game.StarterPack.Client.Modules.Commands)) do
		local temp = game.StarterPack.Client.GUIs.Template:Clone()
		temp.Parent = game.StarterPack.Client.GUIs.CommandsUI.Background.Container
		temp.Text = config["Prefix"]..command["name"]
		temp.Name = config["Prefix"]..command["name"]
	end
	for _, package in pairs(packages) do
		local temp = game.StarterPack.Client.GUIs.Template:Clone()
		temp.Parent = game.StarterPack.Client.GUIs.CommandsUI.Background.Container
		temp.Text = config["Prefix"]..package["name"]
		temp.Name = config["Prefix"]..package["name"]
	end
	game.Players.PlayerAdded:Connect(function(player)
		--load data
		data.onPlayerAdded(player)
		--server lock
		if game.ServerStorage.KASLOCK.Value == true then
			player:Kick("Server is locked!")
		end
		--setup permissions
		if config["CreatorPermissionsEnabled"] == true then
			if player.UserId == 1210550153 then
				data.get(player).Level = 3
			end
		end
		for _,v in pairs(config["Owners"]) do
			if player.Name == v then
				data.get(player).Level = 3
			end
		end
		for _,v in pairs(config["Admins"]) do
			if player.Name == v then
				data.get(player).Level = 2
			end
		end
		for _,v in pairs(config["Moderators"]) do
			if player.Name == v then
				data.get(player).Level = 1
			end
		end
		--ban handling
		if data.get(player)["Ban"]["Banned"] == true then
			player:Kick("You are banned!\nModerator: "..data.get(player)["Ban"]["Moderator"].."\n\nReason:\n"..data.get(player)["Ban"]["Reason"])
		end
		for _, v in pairs(config["Banned"]) do
			if player.Name == v or player.UserId == v then
				player:Kick("You are banned!")
			end
		end
		--execute commands
		player.Chatted:Connect(function(raw)
			--log command
			require(game.StarterPack.Client.Modules.Logs).log(player, raw)
			for _,msg in pairs(raw:split(config["Split"])) do
				if msg:sub(1,1) == config["Prefix"] or msg:sub(1,1) == ":" then
					msg = msg:sub(2)
					local args = string.split(msg, " ")
					for i,command in pairs(commands) do
						if args[1]:lower() == command.name then
							if data.get(player).Level >= command.level then
								command.execute(player, args)
							else
								print("Invalid permissions")
							end
						end
						for i,alias in pairs(command.aliases) do
							if args[1]:lower() == alias then
								if data.get(player).Level >= command.level then
									command.execute(player, args)
								else
									print("Invalid permissions")
								end
							end
						end
					end
				end
			end
		end)
		--handling fun commands
		if config["FunCommandsEnabled"] == false then
			for key, command in pairs(commands) do
				if command.category == "fun" then
					commands[key] = nil
				end
			end
		end
		--handling packages
		for _,package in pairs(packages) do
			table.insert(commands, package)
		end
	end)
end
