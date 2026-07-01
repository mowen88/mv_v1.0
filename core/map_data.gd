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

const ROOM_REGISTRY = {
	"01_a": {
		1: "01_b",
		2: "01_c"
	},
	"01_b": {
		1: "01_a",
		2: "01_c"
	},
	"01_c": {
		1: "01_b",
		2: "01_a"
	}
}
