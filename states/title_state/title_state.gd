extends Control

const MAIN_MENU_SCENE = preload("res://UI/menu/main_menu.tscn")
const SETTINGS_MENU_SCENE = preload("res://UI/menu/settings_menu.tscn")
const SAVE_SLOT_MENU_SCENE = preload("res://UI/menu/save_slot_menu.tscn")

var fade_speed = 0.2
var current_menu_instance = null
@onready var character_image: TextureRect = $CanvasLayer/CharacterImage

func _ready() -> void:
	TransitionManager.input_lock = true
	await get_tree().create_timer(0.2).timeout
	await tween_in_character()
	await get_tree().create_timer(1.0).timeout
	await instantiate_menu(MAIN_MENU_SCENE)

func tween_in_character() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(character_image, "position:x", 0, 1.0)\
	.set_trans(tween.TRANS_CUBIC)\
	.set_ease(tween.EASE_OUT)

func instantiate_menu(menu_scene: PackedScene) -> void:
	# Delete any previous menu
	if current_menu_instance:
		current_menu_instance.queue_free()
	
	# Instantiate new menu as vbox container and set alpha to 0	
	current_menu_instance = menu_scene.instantiate() as VBoxContainer
	current_menu_instance.modulate.a = 0.0
	
	# Add the buttons from the menu and bind them to their names
	add_child(current_menu_instance)
	for child in current_menu_instance.get_children():
		if child is Button:
			child.pressed.connect(_on_button_pressed.bind(child.name))
	
	# Tween the alpha for fade in and wait until finished
	var fade_in: Tween = create_tween()
	fade_in.tween_property(current_menu_instance, "modulate:a", 1.0, fade_speed)
	await fade_in.finished
	
	# Unlock input
	TransitionManager.input_lock = false
	
func switch_menu(next_menu_scene: PackedScene) -> void:
	if TransitionManager.input_lock:
		return
		
	TransitionManager.input_lock = true

	var fade_out: Tween = create_tween()
	fade_out.tween_property(current_menu_instance, "modulate:a", 0.0, fade_speed)
	await fade_out.finished
	
	# Instantiate new menu
	await instantiate_menu(next_menu_scene)
	
func _on_button_pressed(button_name: String) -> void:
	if TransitionManager.input_lock:
		return
		
	match button_name:
		
		# Main Menu options
		"ContinueButton":
			switch_menu(SAVE_SLOT_MENU_SCENE)
		"NewGameButton":
			StateManager.change_state(StateManager.GameState.WORLD, 2.0, 0.6, "blinds", "blinds")
			# switch_menu(SAVE_SLOT_MENU_SCENE)
		"SettingsButton":
			switch_menu(SETTINGS_MENU_SCENE)
		
		# Settings menu options
		"BackButton":
			switch_menu(MAIN_MENU_SCENE)



 
