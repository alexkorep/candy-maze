extends Node2D

var tile_map: TileMap
onready var sprite = $Sprite

func _ready():
	tile_map = get_parent()  # Ensure the parent is a TileMap

func map_to_world(map_pos):
	return tile_map.map_to_world(map_pos)

func map_begin_end_progress_to_world(begin, end, progress):
	return map_to_world(begin) + (map_to_world(end) - map_to_world(begin)) * progress

func _physics_process(delta):
	GameLogic.on_physics_process(delta)

	var player_state = GameLogic.level_state.player
	var progress = GameLogic.level_state.move_timer / GameLogic.move_duration
	position = map_begin_end_progress_to_world(
		player_state.previous,
		player_state.current,
		progress) + Vector2(0, 64)

	var direction = Vector2.ZERO
	var sprite_frame = 0
	if Input.is_action_just_pressed("move_left"):
		direction = Vector2(-1, 0)
		sprite_frame = 2
	elif Input.is_action_just_pressed("move_right"):
		direction = Vector2(1, 0)
		sprite_frame = 1
	elif Input.is_action_just_pressed("move_up"):
		direction = Vector2(0, -1)
		sprite_frame = 2
	elif Input.is_action_just_pressed("move_down"):
		direction = Vector2(0, 1)
		sprite_frame = 0
	if direction == Vector2.ZERO:
		return
	sprite.frame = sprite_frame

	if GameLogic.can_move(direction):
		GameLogic.move(direction)

