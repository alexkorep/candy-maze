extends Node2D

# Movement duration
var move_duration = 0.5  # Duration in seconds to move from one cell to another
var is_moving = false
var start_position = Vector2()
var end_position = Vector2()
var move_timer = 0.0

var tile_map: TileMap

func _ready():
	tile_map = get_parent()  # Ensure the parent is a TileMap

func world_to_map(pos):
	return tile_map.world_to_map(pos) #+ tile_map.cell_size / 2)

func map_to_world(map_pos):
	return tile_map.map_to_world(map_pos)# - tile_map.cell_size / 2

func _physics_process(delta):
	if is_moving:
		# Update the movement timer
		move_timer += delta

		# Calculate the current position
		var t = min(move_timer / move_duration, 1.0)
		position = start_position.linear_interpolate(end_position, t)

		# Check if the movement is complete
		if t >= 1.0:
			is_moving = false
			position = end_position  # Ensure we end exactly at the end position
	elif not is_moving:
		var direction = Vector2.ZERO

		if Input.is_action_just_pressed("move_left"):
			direction = Vector2(-1, 0)
		elif Input.is_action_just_pressed("move_right"):
			direction = Vector2(1, 0)
		elif Input.is_action_just_pressed("move_up"):
			direction = Vector2(0, -1)
		elif Input.is_action_just_pressed("move_down"):
			direction = Vector2(0, 1)

		if direction == Vector2.ZERO:
			return
		var map_pos = world_to_map(position)
		var target_map_pos = map_pos + direction
		#print("target_map_pos: ", target_map_pos, "tile_id: ", tile_map.get_cellv(target_map_pos))
		if not can_move_to(target_map_pos):
			print("Can't move there")
			return

		var target_world_pos = map_to_world(target_map_pos)
		start_movement(target_world_pos)

func start_movement(target_pos):
	start_position = position
	end_position = target_pos
	move_timer = 0.0
	is_moving = true

func can_move_to(pos):
	var tile_id = tile_map.get_cellv(pos)
	print("tile_id: ", tile_id)
	return tile_id == -1
