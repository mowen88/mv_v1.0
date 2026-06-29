
extends State

class_name Idle

func enter():
	actor.get_node("AnimatedSprite2D").play("idle")

func physics_update(_delta):

	# Handle horizontal movement
	actor.x_input()
	actor.velocity.x = actor.direction * 100
	actor.move_and_slide()
	
	# Fall if not on floor
	if not actor.is_on_floor():
		fsm.change_state("fall")
	
	if actor.direction != 0:
		fsm.change_state("run")
		
	elif Input.is_action_just_pressed("jump"):
		fsm.change_state("jump")
		return
