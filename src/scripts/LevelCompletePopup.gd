extends Control

signal confirmed

onready var Particles = $CPUParticles2D

func _ready():
	# Get the size of the window/screen
	var screen_size = get_viewport().get_visible_rect().size
	var center = screen_size / 2
	Particles.position = center
	Particles.emitting = true
	
func _on_TextureButton_pressed():
	visible = false
	emit_signal("confirmed")
