extends Control

onready var timer = $Timer

var success = false

func _ready():
	$MainMenu/StartButton.grab_focus()

func _on_StartButton_pressed():
	Global.load_scene(["res://Scenes/CurrenTimelineLoader.tscn"])

func _on_Options_pressed():
	Global.load_scene(["res://Scenes/OptionsMenu.tscn"])

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_HandsFreeCheckBox_mouse_entered():
	success = true
	$HandsFreeCheckBox.grab_focus()
	timer.start(Global.focus_time)

func _on_HandsFreeCheckBox_mouse_exited():
	success = false
	release_focus()
	timer.stop()

func _on_Button_mouse_entered(button):
	if Global.hover_mode:
		success = true
		get_node(button).grab_focus()
		timer.start(Global.focus_time)
		
func _on_Button_mouse_exited():
	if Global.hover_mode:
		success = false
		get_focus_owner().release_focus()
		timer.stop()

func _on_HandsFreeCheckBox_pressed():
	Global.hover_mode = $HandsFreeCheckBox.pressed

func _on_Timer_timeout():
	if success:
		success = false
		simulate_input()

func simulate_input():
	if get_focus_owner().pressed:
		get_focus_owner().pressed = false
	else:
		get_focus_owner().pressed = true
	get_focus_owner().emit_signal("pressed")
