extends Node2D
var levels:Array=[
	preload("res://scenes/demo_level.tscn"),
	preload("res://scenes/level_1.tscn")
]
var level_one
var current_scene_index:int=0
# Called when the node enters the scene tree for the first time.
func _ready():
	level_one=levels[current_scene_index].instantiate()
	get_tree().current_scene.add_child(level_one)
	Signals.enter_next_level.connect(Callable(self,"on_next_level_button"))
	current_scene_index+=1
	

func on_next_level_button():
	level_one.queue_free()
	var new_level=levels[current_scene_index].instantiate()
	get_tree().current_scene.add_child(new_level)
	current_scene_index+=1
	
