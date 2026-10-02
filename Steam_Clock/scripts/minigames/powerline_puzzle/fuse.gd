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

signal selected(fuse)
signal rotated()

func _ready():
	if isSupply:
		powered = true
	if isConsumer:
		powered = false
	init_hover_mode()

func rotate(value : bool):
	if !rotatable:
		return
	var rad = 90
	if !value:
		rad *= -1
	aniSprite.rotate(deg2rad(rad))
	for con in connections:
		var index = connections.find(con)
		var rotated: Vector2 = con.rotated(deg2rad(rad))
		connections[index] = rotated.round()
	emit_signal("rotated")

func got_power():
	powered = true
	for neighbour in neighbours.keys():
		if check_connection_to(neighbour):
			if !neighbour.powered:
				neighbour.powered = true
				neighbour.got_power()

func check_connection_to(neighbour : Fuse):
	var my_connection = neighbours[neighbour]
	var neighbour_connection: Vector2 = neighbour.neighbours[self]
	var my_open = connections.has(my_connection)
	var neighbour_open = neighbour.connections.has(neighbour_connection)
	
	if my_open and neighbour_open:
		return true
	
	######################
	#if start_connection != null and end_connection != null:
	#	var connection_state = start_connection + end_connection
	#	if connection_state == Vector2.ZERO:
	#		return true
	#return false

func _on_Node_pressed():
	select()

func _process(_delta):
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
