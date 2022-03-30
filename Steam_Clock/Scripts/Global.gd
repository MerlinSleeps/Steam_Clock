extends Node

var hover_mode = false
var focus_time = 1

var current_timeline: String

func load_scene(value):
	print(value[0])
	get_tree().change_scene(value[0])
