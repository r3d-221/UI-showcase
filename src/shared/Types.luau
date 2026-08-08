--!strict
local Types = {}

export type WeaponsStats = {
	luck: number?,
	damage: number,
	critRate: number,
	critDamage: number,
	attackSpeed: number?,
	cooldownReduction: number?,
}

export type ArmorStats = {
	armor: number,
	health: number,
	luck: number?,
	speed: number?,
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

export type Stats = WeaponsStats | ArmorStats
export type Item = Weapon | Armor | Material

return Types
