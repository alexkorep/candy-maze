extends Node2D

var tile_map: TileMap
export var idx = -1;

# TODO extract common logic with Player.gd
func _ready():
	tile_map = get_parent()  # Ensure the parent is a TileMap

func map_to_world(map_pos):
	return tile_map.map_to_world(map_pos)

func map_begin_end_progress_to_world(begin, end, progress):
	return map_to_world(begin) + (map_to_world(end) - map_to_world(begin)) * progress

func _physics_process(delta):
	if idx >= GameLogic.level_state.boxes.size() or idx < 0:
		# Temporary state when the level changed but the box is not yet removed
		# or the box has not yet been configured
		return
	var box_state = GameLogic.level_state.boxes[idx]
	var progress = GameLogic.level_state.move_timer / GameLogic.move_duration
	position = map_begin_end_progress_to_world(
		box_state.previous,
		box_state.current,
		progress) + Vector2(0, 64)

