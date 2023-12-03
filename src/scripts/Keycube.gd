extends KinematicBody2D


func _on_Player_collided(collider, pos):
	if collider != self:
		return
	var vect = self.global_position - pos
	move_and_slide(vect)
