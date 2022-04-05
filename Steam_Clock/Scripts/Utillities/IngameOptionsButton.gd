extends Control

onready var popup = $Popup


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	popup.popup_centered()


func _on_ReturnButton_pressed():
	popup.hide()

func _on_OptionsButton_pressed():
	pass

func _on_ExitGameButton_pressed():
	get_tree().quit()
