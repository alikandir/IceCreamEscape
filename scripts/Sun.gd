extends Node2D
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

var happy_sprite=preload("res://assets/art/sun.png")
var angry_sprite=preload("res://assets/art/sun_angry.png")
var shocked_sprite=preload("res://assets/art/sun_surprised.png")
var laugh_sprite=preload("res://assets/art/sun_laugh.png")

func _ready():
	Signals.cherry_collected.connect(Callable(self,"_on_player_cherry_collected"))
	Signals.slime_entered.connect(Callable(self,"on_slime_entered"))
	Signals.level_cleared.connect(Callable(self,"on_level_cleared"))
	Signals.level_failed.connect(Callable(self,"on_level_failed"))
	animation_player.play("default")
	sprite_2d.texture=happy_sprite
	sprite_2d.modulate=Color8(255,255,255)
func _on_player_cherry_collected():
	sprite_2d.texture=shocked_sprite
	animation_player.play("cherry_collected")
	sprite_2d.modulate=Color8(255,232,255)
	AudioManager.play_shocked()
	await get_tree().create_timer(2).timeout
	animation_player.play("default")
	sprite_2d.modulate=Color8(255,255,255)
	sprite_2d.texture=happy_sprite
	
func on_slime_entered():
	sprite_2d.texture=laugh_sprite
	AudioManager.play_laugh()
	await get_tree().create_timer(2).timeout
	sprite_2d.texture=happy_sprite

func on_level_cleared():
	sprite_2d.texture=angry_sprite
	sprite_2d.modulate=Color8(255,163,169)
	animation_player.play("level_cleared")
	AudioManager.play_anger()
func on_level_failed():
	sprite_2d.texture=laugh_sprite
	AudioManager.play_laugh()

