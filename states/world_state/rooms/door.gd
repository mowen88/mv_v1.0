extends Node2D

var exit_id = int(0)

func _on_body_entered(body):
	# Verify player character
	if body is Player:
		# 1. Loop through children to find a numerical name override
		for child in get_children():
			if child.name.is_valid_int():
				exit_id = int(child.name)
				break
				
		# Switch state
		var world_state = get_tree().root.get_node_or_null("WorldState")
		world_state.transition_to_next_room(exit_id)
