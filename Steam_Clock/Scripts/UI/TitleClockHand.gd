extends TextureRect

onready var tween = $Tween

export(float) var speed := 2.4


# Called when the node enters the scene tree for the first time.
func _ready():
	tween.interpolate_property(self, "rect_rotation", 0, 360, speed, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	tween.start()
