extends TextureButton
class_name Fuse

onready var aniSprite = $AnimatedSprite

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
signal rotated()

func _ready():
	if isSupply:
		powered = true
		rotatable = false
	if isConsumer:
		powered = false
		rotatable = false
	init_hover_mode()

func rotate(value : bool):
	var rad = 90
	if !value:
		rad *= -1
	aniSprite.rotate(rad)
	for con in connections:
		con = con.rotated(deg2rad(rad))
	emit_signal("rotated")

func got_power():
	emit_signal("is_powered", self)
	for neighbour in neighbours.keys():
		if check_connection_to(neighbour):
			if !neighbour.powered:
				neighbour.powered = true
				neighbour.got_power()

func check_connection_to(neighbour):
	var my_connection = neighbours[neighbour]
	var neighbour_connection = neighbour.neighbours[self]
	
	if connections.has(my_connection) and neighbour.connections.has(neighbour_connection):
		return true
	
	######################
	#if start_connection != null and end_connection != null:
	#	var connection_state = start_connection + end_connection
	#	if connection_state == Vector2.ZERO:
	#		return true
	#return false

func _on_Node_pressed():
	select()

func _process(delta):
	if powered:
		$AnimatedSprite.playing = true
	else:
		$AnimatedSprite.playing = false
		$AnimatedSprite.frame = 0

######################################
##		Generalized Hover features	##
######################################

var slider

func init_hover_mode():
	if Global.hover_mode:
		slider = load(Global.sliderScene).instance()
		add_child(slider)
		slider.adjust_size(rect_size)
		slider.connect("bar_filled", self, "_on_SliderButton_bar_filled")
		
func _on_SliderButton_bar_filled():
	simulate_input()
	
func simulate_input():
	slider.reset_progress()
	select()

func select():
	emit_signal("selected", self)
