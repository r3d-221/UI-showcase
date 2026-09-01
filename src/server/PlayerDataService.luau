local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(ReplicatedStorage.Shared.Types)
local PlayerDataService = {}

local playerData = {}

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

function PlayerDataService.addItem(player: Player, item: Types.Item) end

return PlayerDataService
