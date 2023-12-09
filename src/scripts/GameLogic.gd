extends Node

var current_level_no: int = 0
var level_texts = [
# 0
"""
    1111
11111  1
1x b  p1
11111  1
    1111
""",

#1
"""
1111
1 p1
1111
""",
	
# 2
"""
11111111
1      1
1  111 11111
1 x b p1   1
1 111111   1
1          1
1 1111111  1
1 x  b   b 1
1   x b x  1
111111111111
"""]

var level_state = {
	'walls': [],
	'player': { 'current': Vector2.ZERO, 'previous': Vector2.ZERO },
	'boxes': [],
	'targets': [],
	'move_timer': 0.0,
}

# Move duration in seconds
var move_duration = 0.25

func reset():
	# Initialize the level state here
	level_state.move_timer = 0
	level_state.boxes = []
	level_state.walls = []
	level_state.targets = []

func can_move(direction):
	if level_state.move_timer < move_duration:
		return false
	var next_pos = level_state['player']['current'] + direction
	if next_pos in level_state['walls']:
		return false
	for box in level_state['boxes']:
		if next_pos == box['current']:
			var next_box_pos = next_pos + direction
			if next_box_pos in level_state['walls']:
				return false
			for other_box in level_state['boxes']:
				if other_box != box and next_box_pos == other_box['current']:
					return false
	return true

func move(direction):
	if can_move(direction):
		level_state.move_timer = 0.0
		level_state['player']['previous'] = level_state['player']['current']
		level_state['player']['current'] += direction
		for box in level_state['boxes']:
			if level_state['player']['current'] == box['current']:
				box['previous'] = box['current']
				box['current'] += direction

"""
This function is called every physics frame.
It updates the move timer and the previous positions of the player and boxes.
"""
func on_physics_process(delta):
	if level_state.move_timer < move_duration:
		level_state.move_timer += delta
	else:
		level_state.player.previous = level_state.player.current
		for box in level_state.boxes:
			box.previous = box.current

"""
This function checks if the level is complete.
It returns false if the player is still moving or if any box is not on a target.
Otherwise, it returns true.
"""
func is_level_complete():
	if level_state.move_timer < move_duration:
		# Wait until the player has finished moving
		return false

	for box in level_state['boxes']:
		if not (box['current'] in level_state['targets']):
			return false
	return true

"""
This function advances to the next level.
It returns true if there is a next level, and false otherwise.
"""
func next_level():
	""" Returns true if there is a next level, false otherwise """
	current_level_no += 1
	if current_level_no >= len(level_texts):
		current_level_no = 0
		return false
	return true
