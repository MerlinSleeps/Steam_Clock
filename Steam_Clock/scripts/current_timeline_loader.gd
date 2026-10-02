extends Node2D

var dialogue

func _ready():
	Dialogic.load()
	dialogue = Dialogic.start(Global.current_timeline, "/Workshop/Morning")
	add_child(dialogue)

func expand_light():
	$CanvasLayer/ExpandingLight.expand()
	
func start_ani():
	print("yeet")
	$AnimationLayer/AnimationManager.start_default()
