class_name Player
extends CharacterBody2D

const SPEED: float = 75.0
const JUMP_VELOCITY: float = -280.0
const MAX_JUMPS: int = 2

@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction: float = 0.0
var facing: int = 1:
	set(value):
		facing = value
		animated_sprite.flip_h = (facing == -1)

		
var gravity: float = 900.0
var jump_counter: int = 0

func x_input() -> void:
	if InputManager.input_lock:
		velocity.x = direction * SPEED
		if direction != 0:
			facing = int(sign(direction))
		return
		
	direction = Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = direction * SPEED
		facing = int(sign(direction))
	else:
		velocity.x = 0

func _unhandled_input(event: InputEvent) -> void:
	if InputManager.input_lock:
		return
	fsm.handle_input(event)
