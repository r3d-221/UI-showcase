--!strict

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Dependencies
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local SyncData = Remotes:WaitForChild("SyncData") :: RemoteEvent

local Types = require(ReplicatedStorage.Shared.Types)

-- Types
type Item = Types.Item

-----------------------------------
-- Module definition & state
-----------------------------------
local PlayerService = {}
local playerData = {}

-----------------------------------
-- Helper functions
-----------------------------------

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

local function setUpData(player: Player)
	if playerData[player] then
		return
	end

	local data = defaultData()
	playerData[player] = data
	SyncData:FireClient(player, data)
end

local function clearData(player: Player)
	playerData[player] = nil
	print("[PlayerService] Data cleaned up for: " .. player.Name)
end

-----------------------------------
-- Public functions
-----------------------------------

function PlayerService.onStart()
	for _, player in Players:GetPlayers() do
		task.spawn(setUpData, player)
	end

	Players.PlayerAdded:Connect(setUpData)
	Players.PlayerRemoving:Connect(clearData)
end

function PlayerService.getData(player: Player)
	local data = playerData[player]
	if not data then
		warn("[PlayerService] No data found for: " .. player.Name)
	end
	return data
end

function PlayerService.addItem(player: Player, item: Item, category: string)
	local data = PlayerService.getData(player)
	if not data then
		return
	end

	if category == "materials" then
		-- material stack
		table.insert(data.items.materials, item)
		SyncData:FireClient(player, data)
	else
		local categoryList = data.items[category]
		if categoryList then
			table.insert(categoryList, item)
			SyncData:FireClient(player, data)
		else
			warn(string.format("[PlayerService] Attempted to add item to invalid category: '%s'", tostring(category)))
		end
	end
end

return PlayerService
