extends Control

onready var popup = $Popup

func _on_Button_pressed():
	popup.popup_centered()

func _on_ReturnButton_pressed():
	popup.hide()

func _on_OptionsButton_pressed():
	pass

func _on_ExitGameButton_pressed():
	get_tree().quit()
