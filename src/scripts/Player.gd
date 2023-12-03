extends KinematicBody2D

signal collided(collider, pos)

const MOTION_SPEED = 160 # Pixels/second.

func _physics_process(delta):
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
	var collision = move_and_collide(motion * delta)
	if collision:
		emit_signal("collided", collision.collider, self.global_position)
