extends TileMap



var wall_tile_id = 0  # The ID of the wall tile in your tileset
var floor_tile_id = 1  # The ID of the floor tile in your tileset
var box_target_tile_id = 2  # The ID of the box target tile in your tileset
var box_scene = load("res://scenes/Box.tscn")
var player_scene = load("res://scenes/Player.tscn")
var level_maps_scene_instance = load("res://scenes/LevelMaps.tscn").instance()

onready var tile_map = self
onready var LevelComplete = $"../../HUDCanvasLayer/LevelComplete"

func _ready():
	load_tile_map()

func load_tile_map():
	GameLogic.total_level_count = level_maps_scene_instance.get_level_count()
	var level_no = GameLogic.current_level_no
	tile_map.clear()
	# Delete all child nodes
	for child in tile_map.get_children():
		tile_map.remove_child(child)

	var player = player_scene.instance()
	tile_map.add_child(player)
	GameLogic.reset()

	var cells = level_maps_scene_instance.get_level_cells(level_no)
	var box_idx = 0
	for cell in cells:
		var x = cell.x
		var y = cell.y
		var tile = level_maps_scene_instance.get_level_cell(level_no, cell)
		if tile == level_maps_scene_instance.TileTypes.WALL:
			# Wall
			tile_map.set_cell(x, y, wall_tile_id)
			GameLogic.level_state.walls.append(Vector2(x, y))
		if tile == level_maps_scene_instance.TileTypes.FLOOR:
			# Floor
			tile_map.set_cell(x, y, floor_tile_id)
		if tile == level_maps_scene_instance.TileTypes.TARGET:
			# Target
			tile_map.set_cell(x, y, box_target_tile_id)
			GameLogic.level_state.targets.append(Vector2(x, y))
		elif tile == level_maps_scene_instance.TileTypes.PLAYER:
			# Player
			player.position = tile_map.map_to_world(Vector2(x, y))  # Set the player's position
			GameLogic.level_state.player.current = Vector2(x, y)
			GameLogic.level_state.player.previous = Vector2(x, y)
			GameLogic.level_state.player.intermediate = Vector2(x, y)
			tile_map.set_cell(x, y, floor_tile_id)
		elif tile == level_maps_scene_instance.TileTypes.BOX:
			# Box
			var box_instance = box_scene.instance()  # Create an instance of the Keycube scene
			box_instance.position = tile_map.map_to_world(Vector2(x, y))  # Set the instance's position
			box_instance.idx = box_idx
			box_idx += 1
			tile_map.add_child(box_instance)  # Add the instance as a child of the tilemap
			GameLogic.level_state.boxes.append({
				"current": Vector2(x, y),
				"previous": Vector2(x, y),
				"intermediate": Vector2(x, y)
			})
			tile_map.set_cell(x, y, floor_tile_id)

func _physics_process(_delta):
	if GameLogic.is_level_complete():
		LevelComplete.visible = true
		

func _on_LevelComplete_confirmed():
	GameLogic.reset()
	if GameLogic.next_level():
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene("res://scenes/LevelSolved.tscn")
