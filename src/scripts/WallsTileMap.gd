extends TileMap

func _on_Player_collided(collider, pos):
	# Go through all children and call their _on_Player_collided function if it exists.
	for child in get_children():
		if child.has_method("_on_Player_collided"):
			child._on_Player_collided(collider, pos)

