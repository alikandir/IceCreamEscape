extends Node2D
@onready var player = $Player


var pl_level_cleared_screen=preload("res://scenes/level_cleared_screen.tscn")

func _on_player_level_cleared():
	player.queue_free()
	var level_clear_screen=pl_level_cleared_screen.instantiate()
	level_clear_screen.global_position=get_viewport_rect().get_center()
	get_tree().current_scene.add_child(level_clear_screen)
