extends Area2D
var direction_vector:=Vector2.ZERO
@export_enum("left","right","up","down") var direction:String
@onready var sprite_2d = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	if direction=="left":
		rotation_degrees=180
		direction_vector=Vector2.LEFT
	elif direction=="up":
		rotation_degrees=-90
		direction_vector=Vector2.UP
	elif direction=="down":
		rotation_degrees=90
		direction_vector=Vector2.DOWN
	elif direction=="right":
		rotation_degrees=0
		direction_vector=Vector2.RIGHT

func play_animation():
	var tween=create_tween()
	tween.tween_property(sprite_2d,"scale",Vector2(1.2,1.2),0.2).set_trans(tween.TRANS_BACK)
	tween.tween_property(sprite_2d,"scale",Vector2(1,1),0.1).set_trans(tween.TRANS_CUBIC)
