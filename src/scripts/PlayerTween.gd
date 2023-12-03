extends Sprite

signal abcd()

var start_position: Vector2
var end_position: Vector2
var duration: float = 2

func _ready():
	pass
	# start_position = self.position
	# end_position = start_position + Vector2(0, 100)  # Adjust the Y value for the movement range
	# var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	# tween.tween_property(self, "position", end_position, duration)
	# tween.connect("tween_completed", self, "_on_Tween_completed", [tween])
	#tween.set_repeat(-1)  # Set the tween to repeat indefinitely

func _on_Tween_completed(tween):
	print("Tween completed")
	self.position = start_position  # Reset the position to the start position
	tween.tween_property(self, "position", start_position, duration)  # Start the tween again
	emit_signal("abcd")
