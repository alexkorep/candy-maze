extends TileMap

var tile_map_text = """
11111111
1      1
1  111 1
1     p1
11111111
"""

var wall_tile_id = 0  # The ID of the wall tile in your tileset
var player_tile_id = 1  # The ID of the player tile in your tileset
var keycube_scene = load("res://scenes/Keycube.tscn")  # Load the Keycube scene

onready var tile_map = self  # Assuming you have a TileMap node named "TileMap"
onready var player = $Player  # Assuming you have a Player node named "Player"

func _ready():
		load_tile_map_from_text(tile_map_text)

func load_tile_map_from_text(text):
	tile_map.clear()  # This clears all tiles from the TileMap
	var lines = text.split("\n")
	for y in range(lines.size()):
		var line = lines[y]
		for x in range(line.length()):
			var c = line[x]
			if c == '1':
				tile_map.set_cell(x, y, wall_tile_id)
			elif c == 'p':
				player.position = tile_map.map_to_world(Vector2(x, y))  # Set the player's position
			elif c == 'b':
				var keycube_instance = keycube_scene.instance()  # Create an instance of the Keycube scene
				keycube_instance.position = tile_map.map_to_world(Vector2(x, y))  # Set the instance's position
				tile_map.add_child(keycube_instance)  # Add the instance as a child of the tilemap
