extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var game_field = $GameField
	game_field.rect_scale = Vector2(0, 0)
	var tween_scale = create_tween().set_trans(Tween.TRANS_SINE)
	tween_scale.tween_property(game_field, "rect_scale", Vector2(1, 1), 2)
	tween_scale.set_loops(1)


