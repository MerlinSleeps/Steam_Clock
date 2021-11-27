extends TextureRect

## Update for inclusivness via eye tracker ##
## small addition to make dialogic usable with eye tracking ##

onready var next_timer = $NextTimer

var eye_control = true ## default false ## checks if eye_control mode is on
const focus_time = 2 ## time before input gets sent
var success = false ## checks for eye focus

func _on_NextIndicator_mouse_entered():
	if eye_control:
		success = true
		next_timer.start(focus_time)

func _on_NextIndicator_mouse_exited():
	if eye_control:
		success = false
		next_timer.stop()

func _on_NextTimer_timeout():
	if success:
		success = false
		simulate_input()

func simulate_input():
	var ev = InputEventKey.new()
	ev.scancode = 16777221 #KeyCode for Enter ##TODO dynamicly change this
	ev.pressed = true
	get_tree().input_event(ev)
