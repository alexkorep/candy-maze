extends Node2D

# Use https://alliballibaba.github.io/Sokoban-Level-Generator/ to generate the levels

# Enum with tile types
enum TileTypes {
	PLAYER = 0
	BOX = 1
	WALL = 2
	FLOOR = 3
	TARGET = 4
}

func get_level_cells(level_no: int):
	var tile_map = get_child(level_no)
	var used_cells = tile_map.get_used_cells()
	return used_cells

func get_level_cell(level_no: int, cell: Vector2):
	var tile_map = get_child(level_no)
	var tile_id = tile_map.get_cellv(cell)
	return tile_id

func get_level_count():
	return get_child_count()
