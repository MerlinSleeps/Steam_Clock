extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var dialogue = Dialogic.start("/Labor 1")
	add_child(dialogue)

func exit_game():
	get_tree().quit()
