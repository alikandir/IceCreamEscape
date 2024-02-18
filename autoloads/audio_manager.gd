extends Node2D
@onready var sfx = $SFX

@export var sfx_list={
	"laugh":load("res://assets/audio/chuckle.wav"),
	"anger":load("res://assets/audio/anger.wav"),
	"huh":load("res://assets/audio/huh_vocal.mp3")
}

func play_anger():
	sfx.stream=sfx_list["anger"]
	sfx.play()
	sfx.pitch_scale=1
	sfx.volume_db=0
func play_laugh():
	sfx.stream=sfx_list["laugh"]
	sfx.pitch_scale=0.97
	sfx.volume_db=-5
	sfx.play()

func play_shocked():
	sfx.stream=sfx_list["huh"]
	sfx.pitch_scale=0.97
	sfx.volume_db=5
	sfx.play()
