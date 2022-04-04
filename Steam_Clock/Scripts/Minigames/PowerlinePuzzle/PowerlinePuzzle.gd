extends Control

onready var grid = $GridContainer

var fuses = []

func _ready():
	get_fuses()
	set_neighbours()
	
func get_fuses():
	for fuse in grid.get_children():
		fuses.append(fuse)

func set_neighbours():
	for x in range(grid.columns - 1):
		fuses[x].neighbours.append(fuses[x+1])
		fuses[x+1].neighbours.append(fuses[x])
		
	for x in range(fuses.size() - (fuses.size() % grid.columns)):
		var y = x + grid.columns
		if (y < fuses.size()):
			fuses[x].neighbours.append(fuses[y])
			fuses[y].neighbours.append(fuses[x])
