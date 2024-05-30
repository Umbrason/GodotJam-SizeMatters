extends Area2D

class_name DieInWater

@export var nodesToDestroy: Array[Node]
@export var characterBody2D: CharacterBody2D
@export var deathAnimation: AnimatedSprite2D
@export var restartTimer: Timer
@export var deathSFX: AudioStream

func _ready():
	self.body_entered.connect(die)
	restartTimer.timeout.connect(reload)
func free():
	self.body_entered.disconnect(die)
	restartTimer.timeout.disconnect(reload)

func die(_body):
	for node in nodesToDestroy:
		node.queue_free()
	characterBody2D.set_script(null)
	deathAnimation.visible = true
	deathAnimation.frame = 0
	deathAnimation.sprite_frames.set_animation_loop(deathAnimation.animation, false)
	deathAnimation.play()	
	deathAnimation.animation_finished.connect(func(): restartTimer.start())
	AudioOneshot.play(deathSFX)

func reload(): LevelLoader.reloadCurrentLevel()
