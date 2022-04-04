extends TextureButton

export(Array, Vector2) var connections = [
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT
]

export(bool) var powered = false
export(bool) var rotatable = true

var neighbours = []

func rotate(value : bool):
	var rad = 90
	if !value:
		rad *= -1
	rotate(rad)
	for con in connections:
		con.rotated(deg2rad(rad))
