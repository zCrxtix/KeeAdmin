local api = {}

function api:GetPlayer(player, args) -- im suprised this worked!! (ex. :walkspeed me 100, :kick all)
	if args[2] then
		if args[2] == "me" then
			return {player}
		elseif args[2] == "all" then
			local players = {}
			for _,v in pairs (game.Players:GetPlayers()) do
				table.insert(players, v)
			end
			return players
		else
			for _,v in pairs(game:GetService("Players"):GetPlayers()) do
				if string.find(v.Name, args[2]) then
					return {v}
				else
					print("Invalid name")
				end
			end
		end
	end
	return {player}
end


return api
