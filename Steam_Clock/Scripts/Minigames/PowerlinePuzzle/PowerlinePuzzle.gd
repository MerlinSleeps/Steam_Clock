extends Control

var currentFuse: Fuse

func _ready():
	for fuse in get_tree().get_nodes_in_group("Fuse"):
		fuse.connect("selected", self, "_on_Fuse_selected")

func _on_Fuse_selected(fuse: Fuse):
	currentFuse = fuse

func _on_PowerlineManager_win_conidition_fullfilled():
	print("Congratulations. You won!")


func _on_AlendraButton_pressed():
	if currentFuse != null:
		currentFuse.rotate(true)


func _on_WillsonButton_pressed():
	if currentFuse != null:
		currentFuse.rotate(false)
