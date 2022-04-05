extends Control
class_name SliderButton

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
		emit_signal("bar_filled")

func reset_progress():
	progressBar.value = 0

func adjust_size(parentSize: Vector2):
	rect_size = parentSize
	progressBar.rect_size = parentSize

func _on_TextureProgress_mouse_entered():
	mouseInside = true

func _on_TextureProgress_mouse_exited():
	mouseInside = false
