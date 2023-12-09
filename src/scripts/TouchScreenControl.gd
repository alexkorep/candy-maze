extends Node

var last_direction = Vector2.ZERO

func _input(event):
	if event is InputEventScreenDrag:
		last_direction = event.relative.normalized()
	elif event is InputEventScreenTouch and not event.pressed:
		if last_direction.x > 0 and last_direction.y < 0:
			Input.action_press('move_up')
		elif last_direction.x > 0 and last_direction.y > 0:
			Input.action_press('move_right')
		elif last_direction.x < 0 and last_direction.y < 0:
			Input.action_press('move_left')
		elif last_direction.x < 0 and last_direction.y > 0:
			Input.action_press('move_down')

