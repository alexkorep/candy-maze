extends Control

var initial_touch_position = null
var swipe_threshold = 50
var moving = false

func release_actions():
	Input.action_release("move_left")
	Input.action_release("move_right")
	Input.action_release("move_up")
	Input.action_release("move_down")

func _input(event):
	#print(event)
	if (event is InputEventScreenTouch or event is InputEventMouseButton) and event.pressed:
		initial_touch_position = event.position
	elif event is InputEventScreenDrag or event is InputEventMouseMotion and initial_touch_position != null:
		var drag_position = event.position
		if drag_position.x < initial_touch_position.x - swipe_threshold: # Threshold for swipe detection
			Input.action_press("move_left")
			initial_touch_position = null # Reset to avoid multiple detections
		elif drag_position.x > initial_touch_position.x + swipe_threshold: # Threshold for swipe detection
			Input.action_press("move_right")
			initial_touch_position = null # Reset to avoid multiple detections
		elif drag_position.y < initial_touch_position.y - swipe_threshold: # Threshold for swipe detection
			Input.action_press("move_up")
			initial_touch_position = null # Reset to avoid multiple detections
		elif drag_position.y > initial_touch_position.y + swipe_threshold: # Threshold for swipe detection
			Input.action_press("move_down")
			initial_touch_position = null # Reset to avoid multiple detections
	elif (event is InputEventScreenTouch or event is InputEventMouseButton) and not event.pressed:
		release_actions()
		initial_touch_position = null