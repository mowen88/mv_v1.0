
extends State

class_name Idle

func enter() -> void:
	actor.get_node("AnimatedSprite2D").play("idle")
	
func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		fsm.change_state("Jump")
	
func physics_update(_delta: float) -> void:

	# Handle horizontal movement
	actor.x_input()
	actor.move_and_slide()
	
	# Fall if not on floor
	if not actor.is_on_floor():
		fsm.change_state("fall")
	
	if actor.direction != 0:
		fsm.change_state("run")
