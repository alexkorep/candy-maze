extends Node

var is_mouse_pressed = false

func _input(event):
	if event is InputEventMouseButton:
		is_mouse_pressed = event.pressed
	elif event is InputEventScreenDrag or (event is InputEventMouseMotion and is_mouse_pressed):
		var direction = event.relative.normalized()
		if direction.x > 0 and direction.y < 0:
			Input.action_press('move_up')
		elif direction.x > 0 and direction.y > 0:
			Input.action_press('move_right')
		elif direction.x < 0 and direction.y < 0:
			Input.action_press('move_left')
		elif direction.x < 0 and direction.y > 0:
			Input.action_press('move_down')
