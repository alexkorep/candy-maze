extends Control

onready var LevelNumberLabel = $Panel/HBoxContainer/LevelNumberLabel
onready var ExitLevelConfirmationDialog = $ExitLevelConfirmationDialog

func _ready():
	LevelNumberLabel.text = "Level " + str(GameLogic.current_level_no + 1)

func _on_Button_pressed():
	ExitLevelConfirmationDialog.visible = true

func _on_ExitLevelConfirmationDialog_confirmed():
	get_tree().change_scene("res://scenes/Levels.tscn")
