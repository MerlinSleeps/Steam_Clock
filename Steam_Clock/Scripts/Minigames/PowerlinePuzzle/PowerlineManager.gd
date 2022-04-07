extends Control

onready var grid = $GridContainer

var fuses = []
var suppliers = []
var consumers = []

var powered_fuses = []

signal win_conidition_fullfilled()

func _ready():
	get_fuses()
	set_neighbours()
	update_powerflow()
	
func get_fuses():
	for fuse in get_tree().get_nodes_in_group("Fuse"):
		fuses.append(fuse)
		fuse.connect("is_powered", self, "_on_Fuse_is_powered")
		fuse.connect("rotated", self, "update_powerflow")
		if fuse.isSupply:
			suppliers.append(fuse)
		if fuse.isConsumer:
			consumers.append(fuse)

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
	for supplier in suppliers:
		supplier.got_power()
	for fuse in fuses:
		fuse.powered = false
		if powered_fuses.has(fuse):
			fuse.powered = true
	check_wincondition()

func check_wincondition():
	var flag = true
	for consumer in consumers:
		if !consumer.powered:
			flag = false
			
	if flag:
		emit_signal("win_conidition_fullfilled")

func _on_Fuse_is_powered(value):
	powered_fuses.append(value)
