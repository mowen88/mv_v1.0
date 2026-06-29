extends Node2D

@onready var current_room_container: Node2D = $CurrentRoom
@onready var player: CharacterBody2D = $Player
@onready var game_camera: Camera2D = $GameCamera
@onready var camera_target: Node2D = $CameraTarget

var current_room_node: Node2D = null
var in_cutscene = false

func _ready():
	# Instantiates the first room with room strign and spawn point paramters
	_load_room("res://states/world_state/rooms/01_a/01_a.tscn", 0)

func _process(_delta):
	if not in_cutscene and player:
		camera_target.global_position = player.global_position

func transition_to_next_room(exit_id):
	if not current_room_node:
		return
		
	var current_room_name = current_room_node.name.to_lower()
	
	if MapData.MAP_DATA.has(current_room_name) and MapData.MAP_DATA[current_room_name].has(exit_id):
		var target_room_name: String = MapData.MAP_DATA[current_room_name][exit_id]
		var target_room_path: String = "res://world/rooms/" + target_room_name + ".tscn"
		
		_execute_room_swap(target_room_path, exit_id)
		
## Triggers the visual screen transition and schedules the room swap logic
func _execute_room_swap(next_room_path, target_spawn_id):

	# Call global transition instance
	TransitionManager.fade_to_state(func():
		#player.set_physics_process(false)
		
		# Clear out the previous room layout before loading the new one
		for child in current_room_container.get_children():
			child.queue_free()
		
		_load_room(next_room_path, target_spawn_id)

	)
	
## Instantiating and setting up any room
func _load_room(room_path: String, spawn_id: int) -> void:
	
	current_room_node = null
	
	# disable camera smoothing
	game_camera.position_smoothing_enabled = false
	
	var next_room_scene = load(room_path)
	if next_room_scene:
		
		current_room_node = next_room_scene.instantiate()
		current_room_container.add_child(current_room_node)

		var spawn_node = current_room_node.get_node_or_null("Spawns/" + str(spawn_id))
		if spawn_node:
			# Set the player position to the spawn node
			player.global_position = spawn_node.global_position

		# Handle camera boundaries, targets, and matrix synchronization
		_snap_camera_to_current_room()
		
		# wait for one process frame and reeanable the camera smoothing
		await get_tree().process_frame
		game_camera.position_smoothing_enabled = true

	else:
		print("[ERROR] Failed to load room at path: ", room_path)
	

# Update boundaries and instantly snap the camera
func _snap_camera_to_current_room():
	if not current_room_node:
		return
		
	# Establish the boundary walls
	_update_camera_limits(current_room_node)
	# Align your tracking anchor node directly to the player's location
	camera_target.global_position = player.global_position
	
func _update_camera_limits(room_node):
	var limits = room_node.get_node_or_null("Limits") as ReferenceRect
	if limits:
		game_camera.limit_left = int(limits.global_position.x)
		game_camera.limit_top = int(limits.global_position.y)
		game_camera.limit_right = int(limits.global_position.x + limits.size.x)
		game_camera.limit_bottom = int(limits.global_position.y + limits.size.y)

	
