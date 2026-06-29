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
		var world_manager = get_tree().root.get_node_or_null("WorldState")
		if world_manager.has_method("transition_to_next_room"):
			world_manager.transition_to_next_room(exit_id)
