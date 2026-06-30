extends State

class_name Run

func enter() -> void:
	actor.get_node("AnimatedSprite2D").play("run")

func physics_update(_delta: float) -> void:

	actor.x_input()
	actor.velocity.x = actor.direction * 100
	actor.move_and_slide()
	
	if actor.direction == 0:
		fsm.change_state("idle")
	
	# Fall if not on floor
	if not actor.is_on_floor():
		fsm.change_state("fall")
	
	if Input.is_action_just_pressed("jump"):
		fsm.change_state("jump")
		return
		
	
	
