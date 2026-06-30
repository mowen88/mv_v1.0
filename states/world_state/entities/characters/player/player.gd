extends CharacterBody2D
class_name Player

const SPEED: float = 75.0
const JUMP_VELOCITY: float = -280.0
const MAX_JUMPS: int = 2

@onready var fsm: FiniteStateMachine = $FiniteStateMachine

var direction: float = 0.0
var gravity: float = 900.0
var jump_counter: int = 0

func _physics_process(delta: float) -> void:
	# Standard movement and gravity logic
	x_input()
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()

func x_input() -> void:
	direction = Input.get_axis("move_left", "move_right")
	
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
