extends Control

onready var grid = $GridContainer

var fuses = []
var baseFuses = []

var powered_fuses = []

func _ready():
	get_fuses()
	set_neighbours()
	update_powerflow()
	
func get_fuses():
	for fuse in grid.get_children():
		fuses.append(fuse)
		fuse.connect("is_powered", self, "_on_Fuse_is_powered")
		if fuse.isBase:
			baseFuses.append(fuse)

func set_neighbours():
	for x in range(grid.columns - 1):
		fuses[x].neighbours[fuses[x+1]] = Vector2.RIGHT
		fuses[x+1].neighbours[fuses[x]] = Vector2.LEFT
		
	for x in range(fuses.size() - (fuses.size() % grid.columns)):
		var y = x + grid.columns
		if (y < fuses.size()):
			fuses[x].neighbours[fuses[y]] = Vector2.DOWN
			fuses[y].neighbours[fuses[x]] = Vector2.UP

func update_powerflow():
	powered_fuses.clear()
	for baseFuse in baseFuses:
		baseFuse.got_power()
	for fuse in fuses:
		fuse.powered = false
		if powered_fuses.has(fuse):
			fuse.powered = true

func _on_Fuse_is_powered(value):
	powered_fuses.append(value)
