extends TextureRect
	
signal light_animation_finished()
	
func expand():
	$Tween.interpolate_property(self, "rect_scale",
			Vector2(0, 0), Vector2(1.5, 1.5), 2,
			Tween.TRANS_QUART, Tween.EASE_IN)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	yield(get_tree().create_timer(0.5), "timeout")
	emit_signal("light_animation_finished")
