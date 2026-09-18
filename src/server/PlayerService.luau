local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes
local SyncData = Remotes.SyncData

local Types = require(ReplicatedStorage.Shared.Types)

local PlayerService = {}
local playerData = {}

local function defaultData()
	return {
		items = {
			weapons = {},
			armors = {},
			materials = {},
		},
		filter = {},
		settings = {},
	}
end

local function onPlayerAdded()
	Players.PlayerAdded:Connect(function(player: Player)
		local data = defaultData()
		playerData[player] = data
		SyncData:FireClient(player, data)
	end)
end

local function onPlayerLeaving()
	Players.PlayerRemoving:Connect(function(player: Player)
		playerData[player] = nil -- use janitor?
		print("[PlayerService] Player data removed for: " .. player.Name)
	end)
end

function PlayerService.onStart()
	onPlayerAdded()
	onPlayerLeaving()
end

function PlayerService.getData(player: Player)
	local data = playerData[player]
	if not data then
		warn("[PlayerService] No data found for: " .. player.Name)
	end

	return data
end

function PlayerService.addItem(player: Player, item: Types.Item, category: string)
	local data = PlayerService.getData(player)

	if category ~= "materials" then
		table.insert(data.items[category], item)
		print("[PlayerService] items info for: " .. player.Name)
		print(data.items[category])
		SyncData:FireClient(player, data)
	end
end

return PlayerService
