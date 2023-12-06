extends "res://addons/gut/test.gd"

var game_logic

func setup():
	game_logic = load("res://scripts/GameLogic.gd").new()

func teardown():
	game_logic.free()

func test_can_move():
	# Setup
	game_logic.level_state = {
		'walls': [Vector2(1, 0)],
		'player': { 'current': Vector2.ZERO, 'previous': Vector2.ZERO, 'intermediate': Vector2.ZERO },
		'boxes': [],
		'targets': []
	}
	game_logic.move_timer = game_logic.move_duration

	# Test moving into a wall
	assert_false(game_logic.can_move(Vector2.RIGHT))

	# Test moving into an empty space
	assert_true(game_logic.can_move(Vector2.DOWN))

func test_move():
	# Setup
	game_logic.level_state = {
		'walls': [],
		'player': { 'current': Vector2.ZERO, 'previous': Vector2.ZERO, 'intermediate': Vector2.ZERO },
		'boxes': [],
		'targets': []
	}
	game_logic.move_timer = game_logic.move_duration

	# Test moving
	game_logic.move(Vector2.RIGHT)
	assert_eq(game_logic.level_state['player']['current'], Vector2.RIGHT)

func test_is_level_complete():
	# Setup
	game_logic.level_state = {
		'walls': [],
		'player': { 'current': Vector2.ZERO, 'previous': Vector2.ZERO, 'intermediate': Vector2.ZERO },
		'boxes': [{ 'current': Vector2(1, 0), 'previous': Vector2.ZERO, 'intermediate': Vector2.ZERO }],
		'targets': [Vector2(1, 0)]
	}

	# Test level complete
	assert_true(game_logic.is_level_complete())
