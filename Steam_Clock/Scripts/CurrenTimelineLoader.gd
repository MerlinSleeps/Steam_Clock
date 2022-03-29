extends Node2D

var stuffy

func _ready():
	Dialogic.load()
	var dialogue = Dialogic.start("", "/Labor 1")
	add_child(dialogue)
