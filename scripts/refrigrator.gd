extends Area2D
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer


var open_sprite=preload("res://assets/art/refrigrator.png")
var closed_sprite=preload("res://assets/art/refrigrator_closed.png")

func _ready():
	sprite_2d.texture=closed_sprite
	Signals.cherry_collected.connect(Callable(self,"on_cherry_collected"))
	Signals.level_cleared.connect(Callable(self,"on_level_cleared"))


func on_cherry_collected():
	sprite_2d.texture=open_sprite
	animation_player.play("open")
	
func on_level_cleared():
	sprite_2d.texture=closed_sprite
