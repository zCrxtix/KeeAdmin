local DATA_TEMPLATE = {
	Ban = {
		Banned = false,
		Reason = "N/A",
		Moderator = nil
	},
	Level = 0,
	Warnings = 0
}
local data = {}
local data_cache = {}
local DS = game:GetService("DataStoreService"):GetDataStore("AdminDS")
local Players = game:GetService("Players")


function data.onPlayerAdded(player)
	local data = DS:GetAsync("UID_"..player.UserId) or DATA_TEMPLATE

	local val = Instance.new("IntValue")
	val.Name = "KALVL"
	val.Value = data.Level
	val.Parent = player

	for index, value in pairs(DATA_TEMPLATE) do
		if not data[index] then
			data[index] = value
		end
	end

	data_cache[player] = data
end
function data.get(player)
	return data_cache[player]
end

function data.set(player)
	local success, err = pcall(function() DS:SetAsync("UID_"..player.UserId, data_cache[player]) end)
	if not success then
		print(err)
	end
end


return data
