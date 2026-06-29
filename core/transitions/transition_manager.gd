extends Node


@onready var color_rect = $ColorRect
var input_lock = false

func _ready():
	# Keep the overlay hidden on boot
	color_rect.color.a = 0.0
	color_rect.visible = false

func transition(on_mid_transition, in_duration=0.2, out_duration=0.5):
	if input_lock:
		return
		
	input_lock = true
	color_rect.visible = true
	
	# Transition in - progress from 0 to 1
	var tween_in = create_tween()
	tween_in.tween_method(_update_progress, 0.0, 1.0, in_duration)
	await tween_in.finished
	
	# Mid-point function call
	if on_mid_transition.is_valid():
		on_mid_transition.call()
		
	# 3. transition out - progress from 1 to 0
	var tween_out = create_tween()
	tween_out.tween_method(_update_progress, 1.0, 0.0, out_duration)
	await tween_out.finished
	
	# Unlock input and set visible to false to finish
	color_rect.visible = false
	input_lock = false

func _update_progress(progress: float):

	# color_rect.color.a = progress

	if color_rect.material:
		color_rect.material.set_shader_parameter("progress", progress)
