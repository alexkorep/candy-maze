extends KinematicBody2D

signal collided(collider, pos)

# Movement speed
var MOTION_SPEED = 100

func _physics_process(delta):
	var movement = Vector2()

	if Input.is_action_pressed("move_left"):
		# Move along y = x/2 line upwards to the left
		movement = Vector2(-1, -0.5).normalized()
	elif Input.is_action_pressed("move_right"):
		# Move along y = x/2 line downwards to the right
		movement = Vector2(1, 0.5).normalized()
	elif Input.is_action_pressed("move_up"):
		# Move along y = -x/2 line upwards to the right
		movement = Vector2(1, -0.5).normalized()
	elif Input.is_action_pressed("move_down"):
		# Move along y = -x/2 line downwards to the left
		movement = Vector2(-1, 0.5).normalized()

	movement *= MOTION_SPEED * delta
	var collision = move_and_collide(movement)
	if collision:
		emit_signal("collided", collision.collider, self.global_position)
