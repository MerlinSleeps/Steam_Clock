extends TextureButton
class_name Fuse

export(Array, Vector2) var connections = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

export(bool) var isSupply = false
export(bool) var isConsumer = false
export(bool) var powered = false

var rotatable = true
var neighbours = {}

signal is_powered(value)
signal selected(fuse)

func _ready():
	if isSupply:
		powered = true
		rotatable = false
	if isConsumer:
		powered = false
		rotatable = false

func rotate(value : bool):
	var rad = 90
	if !value:
		rad *= -1
	rect_rotation = (int(rect_rotation) + rad) % 360
	for con in connections:
		con.rotated(deg2rad(rad))

func got_power():
	emit_signal("is_powered", self)
	for neighbour in neighbours.keys():
		if check_connection_to(neighbour):
			if !neighbour.powered:
				neighbour.powered = true
				neighbour.got_power()

func check_connection_to(neighbour):
	var start_connection = neighbours[neighbour]
	var end_connection = neighbour.neighbours[self]
	if start_connection != null and end_connection != null:
		var connection_state = start_connection + end_connection
		if connection_state == Vector2.ZERO:
			return true
	return false

func _on_Node_pressed():
	select()

######################################
##		Generalized Hover features	##
######################################

onready var timer = $Timer

var success: bool

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
	select()

func select():
	emit_signal("selected", self)
