--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require(ReplicatedStorage.Shared.Types)

type WeaponData = Types.WeaponData
type Rarity = Types.Rarity
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
			baseStats = {
				damage = 10,
				critRate = 0,
				critDamage = 1.1,
			},
			passives = {},
			abilities = {},
			description = "A basic iron sword.",
		},
		crimsonBlade = {
			name = "Crimson Blade",
			rarity = "mythic",
			baseStats = {
				damage = 25,
				critRate = 0.10,
				critDamage = 1.6,
			},
			passives = {},
			abilities = {},
			description = "A basic iron sword.",
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
		common = "rbxassetid://126419482158052",
		rare = "rbxassetid://111734335113787",
		epic = "rbxassetid://101898754856766",
		legendary = "rbxassetid://108079644167723",
		mythic = "rbxassetid://75615909782162",
		secret = "rbxassetid://113901076644858",
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
