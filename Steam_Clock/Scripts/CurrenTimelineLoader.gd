extends Node2D

func _ready():
	Dialogic.load()
	var dialogue = Dialogic.start("/Workshop/Workshop 1")
	add_child(dialogue)

func _process(delta):
	$Camera2D.position += Vector2.ONE
