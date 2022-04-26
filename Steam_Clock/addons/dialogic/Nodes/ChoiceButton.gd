extends Button

onready var slider = $SliderButton

func _ready():
	if Global.hover_mode:
		slider.show()

func simulate_input():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	emit_signal("button_down")
	emit_signal("button_up")
	emit_signal("pressed")

func _process(delta):
	if Input.is_action_pressed(get_meta('input_next')):
		if has_focus():
			emit_signal("button_down")
	if Input.is_action_just_released(get_meta('input_next')):
		if has_focus():
			emit_signal("button_up")
			emit_signal("pressed")


func _on_Control_bar_filled():
	simulate_input()
