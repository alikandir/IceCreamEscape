extends Node2D
@onready var animation_player = $AnimationPlayer
@onready var color_rect = $CanvasLayer/ColorRect

var turn_counter:int=0
var levels:Array[PackedScene]=[
	preload("res://scenes/start_screen.tscn"),
	preload("res://scenes/level_1.tscn"),
	preload("res://scenes/level_2.tscn"),
	preload("res://scenes/level_3.tscn"),
	preload("res://scenes/level_4.tscn"),
	preload("res://scenes/level_5.tscn"),
	preload("res://scenes/end_screen.tscn")
]
var current_level
var level_index:int=0
func _ready():
	Signals.enter_next_level.connect(Callable(self,"next_level_start"))
	get_tree().change_scene_to_packed(levels[level_index])
	level_index+=1
	color_rect.size=Vector2(0,0)

func next_level_start():
	animation_player.play("scene_transition")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(levels[level_index])
	animation_player.play("new_scene_open")
	level_index+=1


