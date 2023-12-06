extends Node2D

var tile_map: TileMap

func _ready():
	tile_map = get_parent()  # Ensure the parent is a TileMap

func world_to_map(pos):
	return tile_map.world_to_map(pos)

func map_to_world(map_pos):
	return tile_map.map_to_world(map_pos)

func map_begin_end_progress_to_world(begin, end, progress):
	return map_to_world(begin) + (map_to_world(end) - map_to_world(begin)) * progress

func _physics_process(delta):
	GameLogic.on_physics_process(delta)
	if GameLogic.is_level_complete():
		get_tree().change_scene("res://scenes/LevelSolved.tscn")

	var player_state = GameLogic.level_state.player
	var progress = GameLogic.level_state.move_timer / GameLogic.move_duration
	position = map_begin_end_progress_to_world(
		player_state.previous,
		player_state.current,
		progress)

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

	if GameLogic.can_move(direction):
		GameLogic.move(direction)

