extends State

class_name Fall

func enter() -> void:
	print("Entering fall state")
	actor.get_node("AnimatedSprite2D").play("run")

func physics_update(delta: float) -> void:
	# Apply regular gravity while falling
	actor.velocity.y += actor.gravity * delta

	# Handle horizontal movement
	actor.x_input()
	actor.move_and_slide()
	
	if actor.is_on_floor():
		fsm.change_state("idle")
		return
