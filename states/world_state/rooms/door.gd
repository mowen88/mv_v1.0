extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:

	if body is Player:
		var exit_id: int = int(self.name)
		var world_state = get_tree().root.get_node_or_null("WorldState")
		
		if world_state:
			world_state.transition_to_next_room(exit_id)
