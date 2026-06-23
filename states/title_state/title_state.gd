extends Control

const MAIN_MENU_SCENE = preload("res://UI/menu/main_menu.tscn")
const SETTINGS_MENU_SCENE = preload("res://UI/menu/settings_menu.tscn")

var fade_speed = 0.2
var current_menu_instance = null

func _ready():
	TransitionManager.input_lock = true
	await get_tree().create_timer(2.0).timeout
	await instantiate_menu(MAIN_MENU_SCENE)

func instantiate_menu(menu_scene: PackedScene):
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
	var fade_in = create_tween()
	fade_in.tween_property(current_menu_instance, "modulate:a", 1.0, fade_speed)
	await fade_in.finished
	
	# Unlock input
	TransitionManager.input_lock = false
	
func switch_menu(next_menu_scene: PackedScene):
	if TransitionManager.input_lock:
		return
		
	TransitionManager.input_lock = true

	var fade_out = create_tween()
	fade_out.tween_property(current_menu_instance, "modulate:a", 0.0, fade_speed)
	await fade_out.finished
	
	# Instantiate new menu
	await instantiate_menu(next_menu_scene)
	
func _on_button_pressed(button_name: String):
	if TransitionManager.input_lock:
		return
		
	match button_name:
		
		# Main Menu options
		"ContinueButton":
			switch_menu(MAIN_MENU_SCENE)
		"NewGameButton":
			switch_menu(MAIN_MENU_SCENE)
		"SettingsButton":
			switch_menu(SETTINGS_MENU_SCENE)
		
		# Settings menu options
		"BackButton":
			switch_menu(MAIN_MENU_SCENE)



 
