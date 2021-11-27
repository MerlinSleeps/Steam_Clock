extends Button

## Update for inclusivness via eye tracker ##
## small addition to make dialogic usable with eye tracking ##

onready var next_timer = $NextTimer

var eye_control = true ## default false ## checks if eye_control mode is on
const focus_time = 2 ## time before input gets sent
var success = false ## checks for eye focus

func _on_ChoiceButton_mouse_entered():
	if eye_control:
		success = true
		next_timer.start(focus_time)

func _on_ChoiceButton_mouse_exited():
	if eye_control:
		success = false
		next_timer.stop()

func _on_NextTimer_timeout():
	if success:
		success = false
		if has_focus():
			print("yeet")
			simulate_input()

func simulate_input():
	emit_signal("button_down")
	emit_signal("button_up")
	emit_signal("pressed")

func _process(delta):
	if has_focus():
		if Input.is_action_pressed(get_meta('input_next')):
			emit_signal("button_down")
		if Input.is_action_just_released(get_meta('input_next')):
			emit_signal("button_up")
			emit_signal("pressed")
