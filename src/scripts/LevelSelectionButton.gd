extends Control

signal on_level_selected(level_number)

# 0-based level number
export var level_number: int

# Called when the node enters the scene tree for the first time.
func _ready():
	$LevelLabel.text = 'Level ' + str(level_number + 1)


func _on_TextureButton_pressed():
	emit_signal("on_level_selected", level_number)
