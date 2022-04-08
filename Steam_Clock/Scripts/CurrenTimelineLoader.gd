extends Node2D

var dialogue

func _ready():
	Dialogic.load()
	dialogue = Dialogic.start("/Workshop/Morning")
	add_child(dialogue)
