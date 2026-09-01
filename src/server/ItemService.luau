local PlayerDataService = game:GetService("PlayerDataService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ItemData = require(ReplicatedStorage.Shared.ItemData)
local Types = require(ReplicatedStorage.Shared.Types)
local Util = require(ReplicatedStorage.Shared.Util)
local ItemService = {}

type Stat = Types.Stat
type Item = Types.Item

local ranks = {
	SSS = 0.005,
	SS = 0.015,
	S = 0.05,
	A = 0.15,
	B = 0.20,
	C = 0.25,
	D = 0.35,
}

local rankBoost = {
	SSS = 0.30,
	SS = 0.25,
	S = 0.20,
	A = 0.15,
	B = 0.10,
	C = 0.05,
	D = -0.05,
}

local function rollItem(stats: { Stat })
	for key, value in stats do
		local rank = Util.weightedRandom(ranks)

		for k, v in rankBoost do
			if rank == k then
				value *= v
			end
		end
	end
end

local function createItem(id: string, category: string): Item
	local itemData = ItemData[category][id]
	local item: Item = {
		id = id,
		uid = "",
		level = 1,
		locked = false,
		stats = {},
	}

	for _, child in itemData.baseStats do
		table.insert(item.stats, child)
	end

	rollItem(item.stats)

	return item
end

function ItemService.addItem(player: Player, id: string, category: string)
	local item = createItem(id, category)
	PlayerDataService.addItem(player, item)
end

function ItemService.onStart() end

return ItemService
