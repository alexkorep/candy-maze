extends TileMap



var wall_tile_id = 0  # The ID of the wall tile in your tileset
var floor_tile_id = 1  # The ID of the floor tile in your tileset
var box_target_tile_id = 2  # The ID of the box target tile in your tileset
var box_scene = load("res://scenes/Box.tscn")
var player_scene = load("res://scenes/Player.tscn")

onready var tile_map = self  # Assuming you have a TileMap node named "TileMap"
onready var player = $Player  # Assuming you have a Player node named "Player"

func _ready():
	var level_no = GameLogic.current_level_no
	var level_text = GameLogic.level_texts[level_no]
	load_tile_map_from_text(level_text)

func load_tile_map_from_text(text):
	tile_map.clear()
	# Delete all child nodes
	for child in tile_map.get_children():
		tile_map.remove_child(child)

	var player = player_scene.instance()
	tile_map.add_child(player)
	GameLogic.reset()

	var lines = text.split("\n")
	var box_idx = 0
	for y in range(lines.size()):
		var line = lines[y]
		for x in range(line.length()):
			var c = line[x]
			if c == '1':
				# Wall
				tile_map.set_cell(x, y, wall_tile_id)
				GameLogic.level_state.walls.append(Vector2(x, y))
			if c == ' ':
				# Floor
				tile_map.set_cell(x, y, floor_tile_id)
			if c == 'x':
				# Target
				tile_map.set_cell(x, y, box_target_tile_id)
				GameLogic.level_state.targets.append(Vector2(x, y))
			elif c == 'p':
				# Player
				player.position = tile_map.map_to_world(Vector2(x, y))  # Set the player's position
				GameLogic.level_state.player.current = Vector2(x, y)
				GameLogic.level_state.player.previous = Vector2(x, y)
				GameLogic.level_state.player.intermediate = Vector2(x, y)
				tile_map.set_cell(x, y, floor_tile_id)
			elif c == 'b':
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

func _physics_process(delta):
	if GameLogic.is_level_complete():
		GameLogic.reset()
		if GameLogic.next_level():
			get_tree().reload_current_scene()
		else:
			get_tree().change_scene("res://scenes/LevelSolved.tscn")
				
