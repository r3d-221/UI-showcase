local HttpService = game:GetService("HttpService")
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
	for stat, base in stats do
		local rank = Util.weightedRandom(ranks)
		local newValue = base

		for rankName, multiplier in rankBoost do
			if rank == rankName then
				newValue = base + (base * multiplier)
			end
		end

		stats[stat] = {
			value = newValue,
			rank = rank,
		}
	end
end

local function createItem(id: string, category: string, num: number?): Item
	local itemData = ItemData[category][id]
	local item: Item
	if category ~= "materials" then
		item = {
			id = id,
			uid = HttpService:GenerateGUID(false),
			level = 1,
			locked = false,
			stats = table.clone(itemData.baseStats),
		}

		if item.stats then
			rollItem(item.stats)
		end
	else
		item = {
			id = id,
			amount = num,
		}
	end

	return item
end

function ItemService.addItem(player: Player, id: string, category: string, amount: number?)
	local item = createItem(id, category, amount)
	PlayerDataService.addItem(player, item, category)
end

function ItemService.onStart() end

return ItemService
