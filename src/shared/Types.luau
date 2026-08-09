--!strict
local Types = {}

export type Roll = {
	value: number,
	rank: string,
}

export type WeaponStatNames = {
	luck: string,
	damage: string,
	critRate: string,
	critDamage: string,
	attackSpeed: string,
	cooldownReduction: string,
}

export type ArmorStatNames = {
	armor: string,
	health: string,
	luck: string,
	speed: string,
}

export type RarityNames = {
	common: string,
	rare: string,
	epic: string,
	legendary: string,
	mythic: string,
	secret: string,
}

export type Weapon = {
	id: string,
	uid: string,
	level: number,
	locked: boolean,
	stats: WeaponsStats,
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

export type WeaponData = {
	name: string,
	rarity: Rarity,
	baseStats: { [WeaponStatNames]: number },
	passives: {},
	description: string,
	abilities: string,
}

export type Rarity = { [RarityNames]: number }
export type WeaponsList = { [string]: WeaponData }
export type WeaponsStats = { [WeaponStatNames]: Roll }
export type ArmorStats = { [ArmorStatNames]: Roll }
export type Stats = WeaponsStats | ArmorStats
export type Item = Weapon | Armor | Material

return Types
