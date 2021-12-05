local data = require(script.Parent.Data)
local api = require(script.Parent.API)

local GetPlayer = function(player, args)
	return api:GetPlayer(player, args)
end

local commands = {
	Commands = {
		name = "walkspeed",
		aliases = {"ws", "speed"},
		category = "fun",
		level = 1,

		execute = function(player, args)
			if args[3] then
				for _,v in pairs(GetPlayer(player, args)) do
					v.Character.Humanoid.WalkSpeed = tonumber(args[3])
				end
			end	
		end,
	},
	{
		name = "sword",
		aliases = {},
		category = "fun",
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				--[[for _,v in pairs(game:GetDescendants()) do
					if v.Name == "Tools" and v:FindFirstChild("Sword") then
						v.ClassicSword:Clone().Parent = plr.Backpack
					end
				end]]
				game.ReplicatedStorage:WaitForChild("Tools").Sword:Clone().Parent = v.Backpack
			end
		end,
	},
	{
		name = "give",
		aliases = {},
		category = "misc",
		level = 1,

		execute = function(player, args)
			if not args[3] then return end
			for _,v in pairs(GetPlayer(player, args)) do
				local dir = game.ReplicatedStorage:WaitForChild("Tools")
				if dir:FindFirstChild(args[3]) then
					dir[args[3]]:Clone().Parent = v.Backpack
				else
					print("Couldn't find "..args[3])
				end
			end
		end,
	},
	{
		name = "respawn",
		aliases = {"re", "res"},
		category = "misc",
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				v:LoadCharacter()
			end
		end,
	},
	{
		name = "kick",
		aliases = {},
		category = "moderation",
		level = 1,
		
		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				if not args[2] then return end
				if not args[3] then
					print(v)
				else
					local result = {}
					for i = 3, #args do
						table.insert(result, args[i])
					end
					v:Kick("You were kicked from the game.\nModerator: "..player.Name..".\n\nReason:\n"..table.concat(result, " "))
				end
			end
		end,
	},
	{
		name = "ban",
		aliases = {},
		category = "moderation",
		level = 2,

		execute = function(player, args) --i feel like this is inefficent, but at least it works
			for _,v in pairs(GetPlayer(player, args)) do --get player
				if not args[2] then return end 
				if not args[3] then
					local data_ = data.get(player) --get data
					if data_.Ban.Moderator == nil then data_.Ban.Moderator = player.Name end
					if not data_.Ban.Reason then data_.Ban.Reason = "N/A" end
					data_.Ban.Banned = true
					data.set(player)
					v:Kick("You were kicked from the game.\nModerator: "..data_.Ban.Moderator..".\n\nReason:\n"..data_.Ban.Reason)
				else
					local data_ = data.get(player)
					local result = {}
					for i = 3, #args do
						table.insert(result, args[i])
					end
					if data_.Ban.Moderator == nil then data_.Ban.Moderator = player.Name end
					if data_.Ban.Reason == "N/A" then data_.Ban.Reason = table.concat(result, " ") end
					data_.Ban.Banned = true
					data.set(player)
					print(data_)
					v:Kick("You were kicked from the game.\nModerator: "..data_.Ban.Moderator..".\n\nReason:\n"..data_.Ban.Reason)
				end
			end
		end,
	},
	{
		name = "forcefield",
		aliases = {"ff"},
		category = "fun",
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				if not v.Character:FindFirstChild("ForceField") then
					Instance.new("ForceField", v.Character)
				end
			end
		end,
	},
	{
		name = "unforcefield",
		aliases = {"unff"},
		category = "fun",
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				if v.Character:FindFirstChild("ForceField") then
					v.Character.ForceField:Destroy()
				end
			end
		end,
	},
	{
		name = "sparkles",
		aliases = {},
		category = "fun",
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				if not v.Character:FindFirstChild("Sparkles") then
					Instance.new("Sparkles", player.Character.HumanoidRootPart)
				end
			end
		end,
	},
	{
		name = "unsparkles",
		aliases = {},
		category = "fun",
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				if v.Character:FindFirstChild("Sparkles") then
					v.Character.Sparkles:Destroy()
				end
			end
		end,
	},
	{
		name = "music",
		aliases = {"sound", "play"},
		category = "misc",
		level = 1,

		execute = function(player, args)
			if not game.Workspace:FindFirstChild("KeeAdminSound") then
				local sound = Instance.new("Sound")
				sound.Name = "KeeAdminSound"
				sound.Parent = game.Workspace
				if args[2] then
					sound.SoundId = "rbxassetid://"..args[2]
					sound:Play()
				else
					sound:Destroy()
				end
			end
		end,
	},
	{
		name = "mod",
		aliases = {},
		category = "moderation",
		level = 2,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				if v == player then print("Can't update self") return end
				data.get(v).Level = 1
			end
		end,
	},
	{
		name = "admin",
		aliases = {},
		category = "moderation",
		level = 3,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				if v == player then print("Can't update self") return end
				data.get(v).Level = 2
			end
		end,
	},
	{
		name = "unadmin",
		aliases = {"unmod"},
		category = "moderation",
		level = 2,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				if v == player then print("Can't update self") return end
				data.get(v).Level = 0
			end
		end,
	},
	{
		name = "shutdown",
		aliases = {},
		category = "moderation",
		level = 2,

		execute = function(player, args)
			if args[2] then
				for _, v in pairs(game.Players:GetPlayers()) do
					v:Kick("Server shutting down.\n\nMessage:\nN/A")
				end
			else
				local message = {}
				for i = 3, #args do
					table.insert(message, args[i])
				end
				for _, v in pairs(game.Players:GetPlayers()) do
					v:Kick("Server shutting down.\n\nMessage:\n"..table.concat(message, " "))
				end
			end
		end,
	},
	{
		name = "warn",
		aliases = {},
		category = "moderation",
		level = 2,

		execute = function(player, args)
			if not args[2] then return end
			for _,v in pairs(GetPlayer(player, args)) do
				if not args[3] then
					if not v.Character.Head:FindFirstChild("OverheadGui") then
						local ui = game.StarterPack:WaitForChild("Client").GUIs.OverheadGui:Clone()
						ui.Enabled = true
						data.get(v).Warnings += 1
						ui.TextLabel.Text = "Warnings: "..data.get(v).Warnings.."\nReason: N/A"
						ui.Parent = v.Character.Head
						ui.Adornee = v.Character.Head
					else
						local ui = v.Character.Head.OverheadGui
						ui.Enabled = true
						data.get(v).Warnings += 1
						ui.TextLabel.Text = "Warnings: "..data.get(v).Warnings.."\nReason: N/A"
						ui.Parent = v.Character.Head
						ui.Adornee = v.Character.Head
					end
				else
					local result = {}
					for i = 3, #args do
						table.insert(result, args[i])
					end
					if not v.Character.Head:FindFirstChild("OverheadGui") then
						local ui = game.StarterPack:WaitForChild("Client").GUIs.OverheadGui:Clone()
						ui.Enabled = true
						data.get(v).Warnings += 1
						ui.TextLabel.Text = "Warnings: "..data.get(v).Warnings.."\nReason: "..table.concat(result, " ")
						ui.Parent = v.Character.Head
						ui.Adornee = v.Character.Head
					else
						local ui = v.Character.Head.OverheadGui
						ui.Enabled = true
						data.get(v).Warnings += 1
						ui.TextLabel.Text = "Warnings: "..data.get(v).Warnings.."\nReason: "..table.concat(result, " ")
						ui.Parent = v.Character.Head
						ui.Adornee = v.Character.Head
					end
				end
			end
		end,
	},
	{
		name = "unwarn",
		aliases = {},
		category = "moderation",
		level = 2,

		execute = function(player, args)
			if player.Character.Head:FindFirstChild("OverheadGui") then
				player.Character.Head.OverheadGui:Destroy()
			end
		end,
	},
	{
		name = "to",
		aliases = {"goto"},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				player.Character.HumanoidRootPart.Position = v.Character.HumanoidRootPart.Position - Vector3.new(0, 0, 2)
			end
		end,
	},
	{
		name = "bring",
		aliases = {},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				v.Character.HumanoidRootPart.Position = player.Character.HumanoidRootPart.Position - Vector3.new(0, 0, 2)
			end
		end,
	},
	{
		name = "change",
		aliases = {"set"},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				if not args[3] then return end
				if not args[4] then return end
				if not v:FindFirstChild("leaderstats") then return end
				v.leaderstats[args[3]].Value = tonumber(args[4])
			end
		end,
	},
	{
		name = "title",
		aliases = {},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				if not args[3] then return end
				if not v.Character.Head:FindFirstChild("OverheadGui") then
					local ui = game.StarterPack:WaitForChild("Client").GUIs.OverheadGui:Clone()
					ui.Enabled = true
					ui.Parent = v.Character.Head
					ui.Adornee = v.Character.Head
					local result = {}
					for i=3,#args do
						table.insert(result, args[i])
					end
					ui.TextLabel.Text = table.concat(result, " ")
				end
			end
		end,
	},
	{
		name = "untitle",
		aliases = {},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				if v.Character.Head:FindFirstChild("OverheadGui") then
					v.Character.Head.OverheadGui:Destroy()
				end
			end
		end,
	},
	{
		name = "name",
		aliases = {},
		level = 1,

		execute = function(player, args)
			if not args[3] then return end
			for _,v in pairs(GetPlayer(player, args)) do
				local result = {}
				for i=3,#args do
					table.insert(result, args[i])
				end
				v.Character.Humanoid.DisplayName = table.concat(result, " ")
			end
		end,
	},
	{
		name = "unname",
		aliases = {},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				v.Character.Humanoid.DisplayName = v.Name
			end
		end,
	},
	{
		name = "god",
		aliases = {},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				v.Character.Humanoid.MaxHealth = math.huge
				v.Character.Humanoid.Health = math.huge
			end
		end,
	},
	{
		name = "ungod",
		aliases = {"heal"},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				v.Character.Humanoid.MaxHealth = 100
				v.Character.Humanoid.Health = 100
			end
		end,
	},
	{
		name = "serverlock",
		aliases = {"slock"},
		level = 1,

		execute = function(player, args)
			game.ServerStorage.KASLOCK.Value = true
		end,
	},
	{
		name = "unserverlock",
		aliases = {"unslock"},
		level = 1,

		execute = function(player, args)
			game.ServerStorage.KASLOCK.Value = false
		end,
	},
	{
		name = "sit",
		aliases = {},
		level = 1,

		execute = function(player, args)
			for _,v in pairs(GetPlayer(player, args)) do
				v.Character.Humanoid.Sit = true
			end
		end,
	}
	
	
				}
return commands
