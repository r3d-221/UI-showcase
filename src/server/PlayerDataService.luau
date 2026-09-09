local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(ReplicatedStorage.Shared.Types)
local PlayerDataService = {}

local playerData = {
	items = {
		weapons = {},
		armors = {},
		materials = {},
	},
	filter = {},
	settings = {},
}

local function onPlayerAdded()
	Players.PlayerAdded:Connect(function(player: Player)
		playerData[player] = {}
	end)
end

function PlayerDataService.onStart()
	onPlayerAdded()
end

function PlayerDataService.getPlayerData(player: Player)
	local data = playerData[player]
	if not data then
		warn("No data found for: " .. player.Name)
	end

	return data
end

function PlayerDataService.addItem(player: Player, item: Types.Item, category: string)
	-- for materials, an amount limit will be set
	-- add checks
	local data = PlayerDataService.getPlayerData(player)

	if category ~= "materials" then
		table.insert(data.items[category], item)
	end
end

return PlayerDataService
