extends TextureRect
class_name MemoryCard

export(String) var pairTag = "Value"
export(float) var focus_time = 2 ## default time before input gets sent
export(bool) var left = false

onready var label = $TextureRect
onready var timer = $Timer

var hovering_mode = false
var success = false ## checks for focus
var selected = false

signal card_selected(card)

func _on_MemoryCard_mouse_entered():
	if Global.hover_mode:
		success = true
		grab_focus()
		timer.start(focus_time)

func _on_MemoryCard_mouse_exited():
	if Global.hover_mode:
		success = false
		release_focus()
		timer.stop()

func _on_Timer_timeout():
		if success:
			success = false
			simulate_input()

func _on_MemoryCard_card_selected(card):
	selected = true
	label.self_modulate.a = 1

func _on_MemoryGame_card_deselected():
	selected = false
	label.self_modulate.a = 0

func simulate_input():
	select()
	
func _process(delta):
	if has_focus():
		if Input.is_action_just_pressed("left_click"):
			select()
			
func select():
	if is_processing() && !selected:
		emit_signal("card_selected", self)

