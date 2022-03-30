extends Button

## Update for inclusivness
## small addition to make dialogic usable without pressing any keys
## Simulate input after some focus time

onready var next_timer = $Timer
onready var slider = $SliderButton

var hovering_mode = false
var focus_time = 2 ## default time before input gets sent
var success = false ## checks for focus

func _ready():
	if Global.hover_mode:
		mouse_filter = MOUSE_FILTER_IGNORE
	else:
		slider.hide()

func set_hovering_mode(mode: bool) -> void:
	hovering_mode = mode
	
func set_hovering_time(time) -> void:
	focus_time = Global.focus_times

func _on_ChoiceButton_mouse_entered():
	if Global.hover_mode:
		success = true
		next_timer.start(focus_time)

func _on_ChoiceButton_mouse_exited():
	if Global.hover_mode:
		success = false
		next_timer.stop()

func _on_Timer_timeout():
	if success:
		success = false
		simulate_input()

func simulate_input():
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
