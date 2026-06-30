extends Node

# Typed dictionary: Keys are Strings (ids), values are Dictionaries
const ZONE_REGISTRY: Dictionary[String, Dictionary] = {
	"ruins": {
		"zone_name": "Ancient Ruins",
		"bgm": "res://audio/music/ruins_theme.ogg"
	},
	"caves": {
		"zone_name": "Forgotten Caves",
		"bgm": "res://audio/music/caves_theme.ogg"
	}
}

const ROOM_REGISTRY: Dictionary[String, Dictionary] = {
	"01_a": {
		"zone_id": "ruins",
		"exits": { 1: "01_b", 2: "01_boss" }
	},
	"01_b": {
		"zone_id": "ruins",
		"exits": { 1: "01_a" }
	},
	"01_boss": {
		"zone_id": "ruins", 
		"banner_override": "The Corrupted Guardian", 
		"bgm_override": "res://audio/music/boss_battle_theme.ogg",
		"exits": { 1: "01_a" }
	}
}
