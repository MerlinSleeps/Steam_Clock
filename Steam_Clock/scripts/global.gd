extends Node

var sliderScene : String = "res://scenes/ui/slider_button.tscn"

var hover_mode = true
var focus_time = 1

var current_timeline := ""

func load_scene(value):
	print(value[0])
	var x = get_tree().change_scene(value[0])

func set_timeline(value: String):
	current_timeline = value
