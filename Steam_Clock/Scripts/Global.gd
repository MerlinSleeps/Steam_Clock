extends Node

var hover_mode = false
var focus_time = 2.0

func _ready():
	pass

func load_scene(value):
	print(value[0])
	get_tree().change_scene(value[0])
