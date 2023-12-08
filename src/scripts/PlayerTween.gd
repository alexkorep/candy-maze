extends Sprite


export var start_position: Vector2
export var end_position: Vector2
export var duration: float = 0.4
export var start_scale: Vector2
export var end_scale: Vector2

func _ready():
	if end_scale != start_scale:
		var tween_scale = create_tween().set_trans(Tween.TRANS_SINE)
		tween_scale.tween_property(self, "scale", end_scale, duration)
		tween_scale.tween_property(self, "scale", start_scale, duration)
		tween_scale.set_loops(0)

	if end_position != start_position:
		var tween_position = create_tween().set_trans(Tween.TRANS_SINE)
		tween_position.tween_property(self, "position", end_position, duration)
		tween_position.tween_property(self, "position", start_position, duration)
		tween_position.set_loops(0)
