extends VBoxContainer

# Signal telling the parent MenuManager to go back
signal back_requested

func _ready() -> void:
	for child in get_children():
		if child is Button:
			child.pressed.connect(_on_button_pressed.bind(child.name))
			child.focus_mode = Control.FOCUS_NONE

func _on_button_pressed(button_name: String) -> void:
	match button_name:
		"BackButton":
			# This explicitly belongs to the settings screen context
			back_requested.emit()
		"MusicVolButton":
			print("[SETTINGS] Music volume button clicked.")
			# Your future volume adjustment logic goes here!
		"SFXVolButton":
			print("[SETTINGS] SFX volume button clicked.")
			# Your future volume adjustment logic goes here!
