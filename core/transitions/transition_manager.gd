extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var input_lock = false

func _ready() -> void:
	# Set the rectangle alpha to 0 and not visible
	color_rect.color.a = 0.0
	color_rect.visible = false

func fade_transition(on_mid_transition: Callable):
	
	# Lock the input when starting transition and rectangle set invisible
	input_lock = true
	color_rect.visible = true
	
	# Animate the fade in
	animation_player.play("fade_in")
	await animation_player.animation_finished
	
	# Transition the scene mid-fade with callable
	if on_mid_transition.is_valid():
		on_mid_transition.call()
		
	# Animate the fade out
	animation_player.play("fade_out")
	await animation_player.animation_finished
	
	# Set the rectangle invilisble and unlock input
	color_rect.visible = false
	input_lock = false
