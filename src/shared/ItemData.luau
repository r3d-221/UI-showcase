--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(ReplicatedStorage.Shared.Types)

type WeaponData = Types.WeaponDataMap
type Rarity = Types.RarityMap
type RarityName = Types.RarityName

type ItemsList = {
	weapons: { WeaponData },
	rarity: Rarity,
	itemFrames: { [RarityName]: string },
	rarityColors: {},
	statNames: {},
	statOrder: { string },
	statTypes: { [string]: string },
}

local ItemData: ItemsList = {
	weapons = {
		ironSword = {
			name = "Iron Sword",
			rarity = "common",
			type = "melee",
			tags = { "sword" },
			baseStats = {
				damage = 10,
				critRate = 0,
				critDamage = 1.1,
			},
			passives = {},
			abilities = {},
			description = "A basic iron sword.",
			keywords = { "iron", "melee", "sword", "blade", "common" },
		},
		crimsonBlade = {
			name = "Crimson Blade",
			rarity = "mythic",
			type = "melee",
			tags = { "sword", "unique" },
			baseStats = {
				damage = 25,
				critRate = 0.10,
				critDamage = 1.6,
			},
			passives = {},
			abilities = {},
			description = "A basic iron sword.",
			keywords = { "crimson", "melee", "sword", "blade", "mythic" },
		},
	},

	rarity = {
		common = 0.6,
		rare = 0.2,
		mythic = 0.01,
	},

	rarityColors = {
		common = Color3.fromHex("CBD5E0"),
		rare = Color3.fromHex("3182CE"),
		epic = Color3.fromHex("805AD5"),
		legendary = Color3.fromHex("D7DD20"),
		mythic = Color3.fromHex("F59326"),
		secret = Color3.fromHex("222324"),
	},

	itemFrames = {
		common = "rbxassetid://107102273200611",
		rare = "rbxassetid://125232445526828",
		epic = "rbxassetid://90154252114083",
		legendary = "rbxassetid://119592190921038",
		mythic = "rbxassetid://91129267111260",
		secret = "rbxassetid://89880526346253",
	},
	statNames = {
		damage = "Damage",
		critRate = "Crit rate",
		critDamage = "Crit Damage",
	},

	statOrder = {
		"damage",
		"critRate",
		"critDamage",
	},

	statTypes = {
		damage = "flat",
		critRate = "percent",
		critDamage = "percent",
	},
}

return ItemData
