extends KinematicBody2D

const MOTION_SPEED = 160 # Pixels/second.


func _physics_process(_delta):
	var motion = Vector2()
	var left = Input.get_action_strength("move_left")
	var right = Input.get_action_strength("move_right")
	var down = Input.get_action_strength("move_down")
	var up = Input.get_action_strength("move_up")
	var frame = -1
	if up:
		frame = 2
	elif left:
		frame = 0
	elif right:
		frame = 1
	elif down:
		frame = 3
	if frame >= 0:
		$Sprite.frame = frame
		
	motion.x = right - left
	motion.y = down - up
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	#warning-ignore:return_value_discarded
	move_and_slide(motion)
