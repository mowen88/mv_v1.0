extends Control

@onready var main_menu: VBoxContainer = $MainMenu
@onready var settings_menu: VBoxContainer = $SettingsMenu
@onready var save_slot_menu: VBoxContainer = $SaveSlotMenu

var current_menu: VBoxContainer = null
var fade_speed: float = 0.15

func _ready() -> void:
	# process_mode = PROCESS_MODE_ALWAYS
	
	# Wire up the child signals
	main_menu.new_game_requested.connect(_on_new_game)
	main_menu.continue_requested.connect(func(): show_panel(save_slot_menu))
	main_menu.settings_requested.connect(func(): show_panel(settings_menu))
	settings_menu.back_requested.connect(func(): show_panel(main_menu))
	save_slot_menu.back_requested.connect(func(): show_panel(main_menu))
	
func _initialize_menu() -> void:

	# Fade in the main menu cleanly
	current_menu = main_menu
	current_menu.modulate.a = 0.0
	current_menu.visible = true
	
	var fade_in = create_tween()
	fade_in.tween_property(current_menu, "modulate:a", 1.0, fade_speed)

func show_panel(target_menu: VBoxContainer) -> void:
	if InputManager.input_lock:
		return
		
	InputManager.input_lock = true
	
	# Fade out current active menu panel
	if current_menu and current_menu.visible:
		var fade_out = create_tween()
		fade_out.tween_property(current_menu, "modulate:a", 0.0, fade_speed)
		await fade_out.finished
		current_menu.visible = false
		
	# Setup and fade in target menu panel
	current_menu = target_menu
	current_menu.modulate.a = 0.0
	current_menu.visible = true
	
	var fade_in = create_tween()
	fade_in.tween_property(current_menu, "modulate:a", 1.0, fade_speed)
	await fade_in.finished
	
	InputManager.input_lock = false

func _on_new_game() -> void:
	# Trigger your global state change directly from here
	StateManager.change_state(StateManager.GameState.WORLD, 0.5, 1.0, "fade", "blinds")
