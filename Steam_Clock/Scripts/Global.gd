extends Node

var hover_mode = false
var focus_time = 2.0

var current_timeline: String

func _ready():
	load_game_data()

func load_scene(value):
	print(value[0])
	get_tree().change_scene(value[0])

func save_game_data():
	var save_game = File.new()
	save_game.open("user://Saves/save.save", File.READ_WRITE)
	var save_data = get_game_data()
	save_game.store_line(to_json(save_data))
	save_game.close()
	
func get_game_data():
	var save_data = {
		"current_timeline" : current_timeline
	}

func load_game_data():
	pass
