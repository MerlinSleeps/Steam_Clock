extends Button

var slider: SliderButton

func _ready():
	init_hover_mode()
	
func init_hover_mode():
	if Global.hover_mode:
		slider = load(Global.sliderScene).instance()
		add_child(slider)
		slider.adjust_size(rect_size)
		slider.connect("bar_filled", self, "_on_SliderButton_bar_filled")
		
func _on_SliderButton_bar_filled():
	simulate_input()
	
func simulate_input():
	slider.reset_progress()
	emit_signal("pressed")
