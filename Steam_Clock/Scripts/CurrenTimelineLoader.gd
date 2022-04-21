extends Node2D

var dialogue

func _ready():
	Dialogic.load()
	dialogue = Dialogic.start("", "/Workshop/Morning")
	add_child(dialogue)

func expand_light():
	$CanvasLayer/ExpandingLight.expand()

func shrink_light():
	$CanvasLayer/ExpandingLight.rect_scale = Vector2.ZERO
