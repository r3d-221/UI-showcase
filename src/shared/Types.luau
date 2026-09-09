--!strict
local Types = {}

export type Roll = {
	value: number,
	rank: string,
}

export type WeaponStatName = "damage" | "critRate" | "critDamage" | "luck" | "attackSpeed" | "cooldownReduction"
export type ArmorStatName = "armor" | "health" | "luck" | "speed"
export type RarityName = "common" | "rare" | "epic" | "legendary" | "mythic" | "secret"

export type Weapon = {
	id: string,
	uid: string,
	level: number,
	locked: boolean,
	stats: WeaponStats,
}

export type Armor = {
	id: string,
	uid: string,
	level: number,
	locked: boolean,
	stats: ArmorStats,
}

export type Material = {
	id: string,
	uid: string,
	amount: number,
}

export type WeaponInfo = {
	name: string,
	rarity: RarityName,
	baseStats: { [WeaponStatName]: number },
	passives: {},
	abilities: {},
	description: string,
}

export type Item = {
	id: string,
	uid: string?,
	level: string?,
	amount: number?,
	locked: boolean?,
	stats: { Stat }?,
}

export type StatsList = { Stat }
export type Stat = WeaponStats | ArmorStats
export type Rarity = { [RarityName]: number }
export type WeaponData = { [string]: WeaponInfo }
export type WeaponStats = { [WeaponStatName]: Roll }
export type ArmorStats = { [ArmorStatName]: Roll }

return Types
