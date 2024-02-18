extends Control




func _on_retry_button_pressed():
	get_tree().reload_current_scene()


func _on_next_level_button_pressed():
	Signals.enter_next_level.emit()
