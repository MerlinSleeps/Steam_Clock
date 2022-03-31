extends Node2D

var dialogue

func _ready():
	Dialogic.load()
	dialogue = Dialogic.start("/Workshop/Workshop 1")
	add_child(dialogue)

func change_timeline(value):
	dialogue = Dialogic.change_timeline("/Mansion/Mansion 1")
