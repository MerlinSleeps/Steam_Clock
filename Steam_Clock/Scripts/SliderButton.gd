extends Control

onready var progressBar : TextureProgress = $TextureProgress

var mouseInside : bool
var declineFactor = 1.5

signal bar_filled

func _ready():
	progressBar.max_value = Global.focus_time

func _process(delta):
	if mouseInside:
		progressBar.value += delta
	if !mouseInside:
		progressBar.value -= delta * declineFactor
	if progressBar.value == progressBar.max_value:
		declineFactor = 0
		yield(get_tree().create_timer(0.5), "timeout")
		emit_signal("bar_filled")

func _on_TextureProgress_mouse_entered():
	mouseInside = true

func _on_TextureProgress_mouse_exited():
	mouseInside = false
