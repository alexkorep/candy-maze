extends Control

var initial_touch_position = null
var swipe_threshold = 50
var cur_action = null

func release_actions():
	Input.action_release("move_left")
	Input.action_release("move_right")
	Input.action_release("move_up")
	Input.action_release("move_down")

func _input(event):
	if (event is InputEventScreenTouch or event is InputEventMouseButton) and event.pressed:
		initial_touch_position = event.position
	elif event is InputEventScreenDrag or event is InputEventMouseMotion and initial_touch_position != null:
		var drag_position = event.position
		var action = null
		if drag_position.x < initial_touch_position.x - swipe_threshold: # Threshold for swipe detection
			action = "move_left"
		elif drag_position.x > initial_touch_position.x + swipe_threshold: # Threshold for swipe detection
			action = "move_right"
		elif drag_position.y < initial_touch_position.y - swipe_threshold: # Threshold for swipe detection
			action = "move_up"
		elif drag_position.y > initial_touch_position.y + swipe_threshold: # Threshold for swipe detection
			action = "move_down"
		if action and action != cur_action:
			release_actions()
			Input.action_press(action)
			cur_action = action
	elif (event is InputEventScreenTouch or event is InputEventMouseButton) and not event.pressed:
		release_actions()
		cur_action = null
		initial_touch_position = null