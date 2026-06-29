extends State

class_name Fall

func enter():
	print("Entering fall state")
	actor.get_node("AnimatedSprite2D").play("run")

func physics_update(delta):
	# Apply regular gravity while falling
	actor.velocity.y += actor.gravity * delta
	
	# Handle horizontal movement
	actor.x_input()
	actor.velocity.x = actor.direction * 100.0
	
	# Process movement so actor.is_on_floor() becomes true when landing
	actor.move_and_slide()
	
	if actor.is_on_floor():
		fsm.change_state("idle")
		return
	
	if Input.is_action_just_pressed("jump"):
		fsm.change_state("jump")
		return
