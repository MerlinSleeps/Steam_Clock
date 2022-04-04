extends TextureButton

export(Array, Vector2) var connections = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

export(bool) var isBase = false
export(bool) var powered = false
export(bool) var rotatable = true

var neighbours = {}

signal is_powered(value)

func _ready():
	if isBase:
		powered = true
		rotatable = false

func rotate(value : bool):
	var rad = 90
	if !value:
		rad *= -1
	rotate(rad)
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
