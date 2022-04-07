extends Control

onready var grid = $GridContainer

var fuses = []
var suppliers = []
var consumers = []

signal win_conidition_fullfilled()

func _ready():
	get_fuses()
	set_neighbours()
	update_powerflow()
	
func get_fuses():
	for fuse in get_tree().get_nodes_in_group("Fuse"):
		fuses.append(fuse)
		fuse.connect("rotated", self, "update_powerflow")
		if fuse.isSupply:
			suppliers.append(fuse)
		if fuse.isConsumer:
			consumers.append(fuse)

func set_neighbours():
	for y in range(ceil(fuses.size()/grid.columns)):
		var firstInRow = y * grid.columns
		for x in range(0+firstInRow, firstInRow + grid.columns - 1):
			fuses[x].neighbours[fuses[x+1]] = Vector2.RIGHT
			fuses[x+1].neighbours[fuses[x]] = Vector2.LEFT
		
	for x in range(fuses.size() - (fuses.size() % grid.columns)):
		var y = x + grid.columns
		if (y < fuses.size()):
			fuses[x].neighbours[fuses[y]] = Vector2.DOWN
			fuses[y].neighbours[fuses[x]] = Vector2.UP

func update_powerflow():
	for fuse in fuses:
		fuse.powered = false
	for supplier in suppliers:
		supplier.got_power()
	check_wincondition()

func check_wincondition():
	var flag = true
	for consumer in consumers:
		if !consumer.powered:
			flag = false
			
	if flag:
		emit_signal("win_conidition_fullfilled")
