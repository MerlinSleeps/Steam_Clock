extends Control

var mouseInside : bool

func _input(event):
	if mouseInside && Input.is_mouse_button_pressed(BUTTON_LEFT):
		pass

func ratioInBody(slider : TextureProgress):
	var posClicked = get_local_mouse_position() - slider.rect_position
	var ratio = posClicked.x / slider.rect_size.x
	if ratio > 1.0:
		ratio = 1.0
	elif ratio < 0.0
		ratio = 0.0

func _on_RectBeginning_mouse_entered():
	mouseInside = true

func _on_TextureProgress_mouse_exited():
	mouseInside = true
