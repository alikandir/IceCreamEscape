extends Node2D
@onready var wasd_text = $CanvasLayer/WASDtext
@onready var collect_cherry = $CanvasLayer/CollectCherry
@onready var player = $Player




var wasd_text_exist:bool=true
var pl_level_cleared_screen=preload("res://scenes/level_cleared_screen.tscn")
func _ready():
	wasd_text.visible=true
	collect_cherry.visible=false


func _input(event):
	if wasd_text_exist and (event.is_action_pressed("down") or event.is_action_pressed("up") or event.is_action_pressed("left") or event.is_action_pressed("right")):
		wasd_text.queue_free()
		wasd_text_exist=false
		collect_cherry.visible=true


func _on_player_cherry_collected():
	collect_cherry.text= "[shake][shake][shake]Go to refrigerator !"


func _on_player_level_cleared():
	player.queue_free()
	collect_cherry.queue_free()
	var level_clear_screen=pl_level_cleared_screen.instantiate()
	level_clear_screen.global_position=get_viewport_rect().get_center()
	get_tree().current_scene.add_child(level_clear_screen)
