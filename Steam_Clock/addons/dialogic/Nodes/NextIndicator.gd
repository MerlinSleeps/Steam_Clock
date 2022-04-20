extends TextureRect

## Update for inclusivness
## small addition to make dialogic usable without pressing any keys
## Simulate input after some focus time

onready var next_timer = $Timer

var hovering_mode = false ## checks if hovering_mode mode is on
var focus_time = 2 ## default time before input gets sent
var success = false ## checks for focus

func _ready():
	focus_time = Global.focus_time * 0.5

func set_hovering_mode(mode: bool) -> void:
	hovering_mode = mode
	
func set_hovering_time(time) -> void:
	focus_time = time

func _on_NextIndicator_mouse_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Cursor.show()
	if Global.hover_mode:
		success = true
		next_timer.start(focus_time)

func _on_NextIndicator_mouse_exited():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Cursor.hide()
	if Global.hover_mode:
		success = false
		next_timer.stop()

func _on_Timer_timeout():
	if success:
		success = false
		simulate_input()

func simulate_input():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Cursor.hide()
	var ev = InputEventAction.new()
	ev.action = Dialogic.get_action_button()
	ev.pressed = true
	get_tree().input_event(ev)
