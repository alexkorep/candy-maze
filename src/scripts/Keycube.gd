extends KinematicBody2D

func _on_Player_collided(collider, pos):
	if collider != self:
		return
	
	var vect = self.global_position - pos
	var projected_vect = Utils.project_vector(vect)
	move_and_slide(projected_vect)

