--!strict
local Types = {}

export type Roll = {
	value: number,
	rank: string,
}

export type WeaponStatName = "damage" | "critRate" | "critDamage" | "luck" | "attackSpeed" | "cooldownReduction"
export type ArmorStatName = "armor" | "health" | "luck" | "speed"
export type RarityName = "common" | "rare" | "epic" | "legendary" | "mythic" | "secret"

export type WeaponStats = { [WeaponStatName]: Roll }
export type ArmorStats = { [ArmorStatName]: Roll }

export type Stats = { [string]: Roll }

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

export type Item = {
	id: string,
	uid: string?,
	level: number?,
	amount: number?,
	locked: boolean?,
	stats: Stats?,
}

export type WeaponInfo = {
	name: string,
	rarity: RarityName,
	baseStats: { [WeaponStatName]: number },
	passives: { [string]: any },
	abilities: { [string]: any },
	description: string,
}

export type RarityMap = { [RarityName]: number }
export type WeaponDataMap = { [string]: WeaponInfo }

return Types
