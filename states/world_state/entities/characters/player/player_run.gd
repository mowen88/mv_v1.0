extends State

class_name Run

func enter() -> void:
	actor.get_node("AnimatedSprite2D").play("run")

	
func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		fsm.change_state("Jump")
		
	actor.x_input()
	
func physics_update(_delta: float) -> void:

		# Handle horizontal movement
	actor.x_input()
	actor.move_and_slide()
	
	if actor.direction == 0:
		fsm.change_state("idle")
	
	# Fall if not on floor
	if not actor.is_on_floor():
		fsm.change_state("fall")

		
	
	
