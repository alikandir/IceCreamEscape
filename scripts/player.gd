extends Area2D
class_name Player
@onready var tile_map = $"../TileMap"
@onready var sprite_2d = $Sprite2D

@onready var refrigrator = $"../Refrigrator"
@onready var moves_left_text = $"../CanvasLayer/MovesLeftText"



var player_sprite_with_cherry=preload("res://assets/art/player_cherry.png")
var ice_bucket_increase:int=5
@export var max_moves:int
var can_move:bool
var moves_left:int=10
var is_waiting:bool=false
var wait_amount:int
var goop
signal cherry_collected
signal level_cleared
var pl_level_failed_screen=preload("res://scenes/level_failed_screen.tscn")
var got_cherry:bool=false
var tween
func _ready():
	moves_left_text.text= "[shake]Moves left:[pulse] " + str(moves_left)
	can_move=true

func _input(event):
	if Input.is_action_just_pressed("up"):
		move(Vector2.UP)
	elif Input.is_action_just_pressed("down"):
		move(Vector2.DOWN)
	elif Input.is_action_just_pressed("left"):
		move(Vector2.LEFT)
	elif Input.is_action_just_pressed("right"):
		move(Vector2.RIGHT)

func move(direction:Vector2):
	if !can_move:
		return
	var current_tile:Vector2i=tile_map.local_to_map(global_position)
	
	var target_tile:Vector2i=Vector2i(
		current_tile.x+direction.x,
		current_tile.y+direction.y
	)
	var tile_data:TileData=tile_map.get_cell_tile_data(0,target_tile)
	
	if tile_data.get_custom_data("grid")==false:
		return
	if !is_waiting:
		var tween=get_tree().create_tween()
		tween.tween_property(self,"global_position",tile_map.map_to_local(target_tile),0.16).set_trans(Tween.TRANS_EXPO)
		moves_left-=1
	elif is_waiting:
		goop.queue_free()
		wait_amount-=1
		moves_left-=1
		if wait_amount==0:
			is_waiting=false
	moves_left_text.text= "[shake]Moves left:[pulse] " + str(moves_left)
	LevelManager.turn_counter+=1
	if moves_left==0:
		can_move=false
		await get_tree().create_timer(0.5).timeout
		if moves_left==0:
			var level_failed_screen=pl_level_failed_screen.instantiate()
			level_failed_screen.global_position=get_viewport_rect().get_center()
			get_tree().current_scene.add_child(level_failed_screen)
			Signals.level_failed.emit()
		else:
			can_move=true



func _on_area_entered(area):
	if area.is_in_group("refrigrator"):
		if !got_cherry:return
		level_cleared.emit()
		Signals.level_cleared.emit()
	
	elif area.is_in_group("goop"):
		is_waiting=true
		wait_amount=1
		goop=area
		Signals.slime_entered.emit()
	
	elif area.is_in_group("ice_bucket"):
		moves_left+=ice_bucket_increase
		if moves_left>max_moves:
			moves_left=max_moves
		moves_left_text.text= "[shake]Moves left:[pulse] " + str(moves_left)
		area.queue_free()
	
	elif area.is_in_group("jump_pad"):
		var tween=get_tree().create_tween()
		var current_tile:Vector2i=tile_map.local_to_map(global_position)
		
		var target_tile:Vector2i=Vector2i(
		current_tile.x+3*area.direction_vector.x,
		current_tile.y+3*area.direction_vector.y
	)
		var real_target=tile_map.map_to_local(target_tile)
		var tile_data:TileData=tile_map.get_cell_tile_data(0,target_tile)
		if tile_data.get_custom_data("Grid")==false:
			return
		if !is_waiting:
			print(current_tile,target_tile)
			area.play_animation()
			tween.tween_property(self,"global_position",real_target,0.3).set_delay(0.06).set_trans(Tween.TRANS_BACK)
	elif area.is_in_group("cherry"):
		cherry_collected.emit()
		Signals.cherry_collected.emit()
		sprite_2d.texture=player_sprite_with_cherry
		area.queue_free()
		got_cherry=true
	
