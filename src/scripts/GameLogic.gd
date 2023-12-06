extends Node

var level_state = {
	'walls': [],
	'player': { 'current': Vector2.ZERO, 'previous': Vector2.ZERO, 'intermediate': Vector2.ZERO },
	'boxes': [],
	'targets': []
}

var move_duration = 1.0
var move_timer = 0.0

func on_ready():
	# Initialize the level state here
	pass

func can_move(direction):
	if move_timer < move_duration:
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
		move_timer = 0.0
		level_state['player']['previous'] = level_state['player']['current']
		level_state['player']['current'] += direction
		for box in level_state['boxes']:
			if level_state['player']['current'] == box['current']:
				box['previous'] = box['current']
				box['current'] += direction

func on_physics_process(delta):
	if move_timer < move_duration:
		move_timer += delta
		var t = move_timer / move_duration
		level_state['player']['intermediate'] = level_state['player']['previous'].linear_interpolate(level_state['player']['current'], t)
		for box in level_state['boxes']:
			box['intermediate'] = box['previous'].linear_interpolate(box['current'], t)

func is_level_complete():
	for box in level_state['boxes']:
		if not (box['current'] in level_state['targets']):
			return false
	return true
