extends Control

func _ready():
	await get_tree().create_timer(1.0).timeout
	transition_to_title()
	
func transition_to_title():
	StateManager.change_state(StateManager.GameState.TITLE)
	
