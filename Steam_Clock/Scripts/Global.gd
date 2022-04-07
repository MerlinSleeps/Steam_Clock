extends Node

var sliderScene : String = "res://Scenes/SliderButton.tscn"

var hover_mode = true
var focus_time = 1

var current_timeline: String

func load_scene(value):
	print(value[0])
	var x = get_tree().change_scene(value[0])
