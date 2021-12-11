--[[
	Handle everything on the client. Commands and GUIs
]]
local player = game.Players.LocalPlayer
player.CharacterAdded:Wait()
local commands = require(script.Parent.Modules.Commands)
local mouse = player:GetMouse()

--print("Client is awake :o")

player.Chatted:Connect(function(message, recipient)
	if recipient then return end
	if message:sub(1,1) == require(game.Workspace.KeeAdmin.CORE.Settings)["Prefix"] or message:sub(1,1) == ":" then
		message = message:sub(2)
		local args = message:split(" ")
		local level = player:WaitForChild("KALVL").Value
		for _, command in pairs(commands) do
			if args[1]:lower() == command.name then
				if level >= command.level then
					command.execute(player, args)
				end
			end
			for _, alias in pairs(command.aliases) do
				if args[1]:lower() == alias then
					if level >= command.level then
						command.execute(player, args)
					end
				end
			end
		end
		
	end	
end)

