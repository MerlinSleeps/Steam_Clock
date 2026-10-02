extends Control

export(int) var maxTurns = 6
export(int) var maxWilsonTurns = 2
export(Texture) var backgroundBright

var turnsLeft
var wilsonTurnsLeft
var currentFuse: Fuse
var dialogic
var won
var lastMove := "Alendra"

func _ready():
	for fuse in get_tree().get_nodes_in_group("Fuse"):
		fuse.connect("selected", self, "_on_Fuse_selected")
	currentFuse = get_tree().get_nodes_in_group("Fuse")[0]
	
	turnsLeft = maxTurns + 1
	wilsonTurnsLeft = maxWilsonTurns + 1
	dialogic = Dialogic.start("/Mansion/Minigames/Powerline/Beginning")
	add_child(dialogic)

func _process(delta):
	if turnsLeft == 0:
		game_lost()
		
func game_lost():
	set_process(false)
	$HBoxContainer.hide()
	var fuses = get_tree().get_nodes_in_group("Fuse")
	for n in range(3):
		for fuse in fuses:
			fuse.powered = true
		yield(get_tree().create_timer(0.5), "timeout")
		for fuse in fuses:
			fuse.powered = false
		yield(get_tree().create_timer(0.5), "timeout")
	dialogic = Dialogic.start("/Mansion/Minigames/Powerline/Lose")
	add_child(dialogic)

func _on_Fuse_selected(fuse: Fuse):
	if currentFuse == fuse:
		return
	elif currentFuse == null:
		fuse.aniSprite.material.set_shader_param("width", 5)
		currentFuse = fuse
		return
	currentFuse.aniSprite.material.set_shader_param("width", 0)
	fuse.aniSprite.material.set_shader_param("width", 5)
	currentFuse = fuse

func _on_AlendraButton_pressed():
	if currentFuse != null:
		lastMove = "Alendra"
		turnsLeft -= 1
		currentFuse.rotate(true)

func _on_WilsonButton_pressed():
	if currentFuse != null and wilsonTurnsLeft > 0:
		lastMove = "Wilson"
		turnsLeft -= 1
		wilsonTurnsLeft -= 1
		currentFuse.rotate(false)
		if wilsonTurnsLeft == maxWilsonTurns-1:
			dialogic = Dialogic.start("/Mansion/Minigames/Powerline/First Turn")
			add_child(dialogic)
		elif wilsonTurnsLeft == 0 && !won:
			dialogic = Dialogic.start("/Mansion/Minigames/Powerline/Last Turn")
			add_child(dialogic)


func _on_PowerlineManager_win_condition_fulfilled():
	won = true
	$Background.texture = backgroundBright
	yield(get_tree().create_timer(1), "timeout")
	if lastMove.match("Alendra"):
		dialogic = Dialogic.start("/Mansion/Minigames/Powerline/You won")
	elif lastMove.match("Wilson"):
		dialogic = Dialogic.start("/Mansion/Minigames/Powerline/Wilson won")
	add_child(dialogic)
