extends Button

var timer : Timer
var success: bool

func _ready():
	if Global.hover_mode:
		pass

func _on_Node_mouse_entered():
	if Global.hover_mode:
		success = true
		grab_focus()
		timer.start(Global.focus_time)

func _on_Node_mouse_exited():
	if Global.hover_mode:
		success = false
		release_focus()
		timer.stop()

func _on_Timer_timeout():
		if success:
			success = false
			simulate_input()

func simulate_input():
	pass
