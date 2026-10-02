extends Control

onready var timer = $Timer

var success = false

func _ready():
	$ExitButton.grab_focus()
	update_LineEdit()

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


func _on_ExitButton_pressed():
	Global.load_scene(["res://scenes/menus/main_menu.tscn"])

func _on_IncreaseButton_pressed():
	Global.focus_time += 0.5
	update_LineEdit()
	
func _on_DecreaseButton_pressed():
	Global.focus_time -= 0.5
	update_LineEdit()
	
func update_LineEdit():
	$HBoxContainer/VBoxContainer/HBoxContainer/LineEdit.text = str(Global.focus_time)


