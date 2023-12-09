extends Control

onready var GridContainer = $ScrollContainer/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	# remove GridContainer node children
	for n in GridContainer.get_children(): 
		GridContainer.remove_child(n) 

	var cnt = GameLogic.total_level_count
	for i in cnt:
		# load the button scene
		var new_level_select_button = load("res://scenes/LevelSelectionButton.tscn").instance()
		new_level_select_button.level_number = i
		# subscribe for the button's pressed signal on_level_selected
		new_level_select_button.connect("on_level_selected", self, "on_level_selected")
		GridContainer.add_child(new_level_select_button)

func on_level_selected(level_number):
	GameLogic.current_level_no = level_number
	get_tree().change_scene("res://scenes/Main.tscn")
