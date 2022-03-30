extends Control

onready var progressBar = $TextureProgress

var mouseInside : bool

signal bar_filled

func _process(delta):
	if !mouseInside:
		progressBar.value = false

func _input(event):
	if mouseInside && Input.is_mouse_button_pressed(BUTTON_LEFT): 
		set_value(progressBar)
	elif mouseInside && Global.hover_mode:
		set_value(progressBar)

func set_value(slider : TextureProgress):
	slider.value = ratio_in_body(slider) * slider.max_value
	if slider.value == slider.max_value:
		emit_signal("bar_filled")

func ratio_in_body(slider : TextureProgress):
	var posClicked = get_local_mouse_position() - slider.rect_position
	var ratio = posClicked.x / slider.rect_size.x
	if ratio > 1.0:
		ratio = 1.0
	elif ratio < 0.0:
		ratio = 0.0
	return ratio

func _on_TextureProgress_mouse_entered():
	var ratio = ratio_in_body(progressBar)
	if ratio < 0.2:
		mouseInside = true

func _on_TextureProgress_mouse_exited():
	mouseInside = false
