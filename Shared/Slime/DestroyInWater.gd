extends Area2D

class_name DestroyInWater

@export var nodeToDestroy: Node2D
@export var DeathSFX: AudioStream

func _ready():
	self.body_entered.connect(destroy)
func free():
	self.body_entered.disconnect(destroy)

func destroy(_body):
	nodeToDestroy.queue_free()
	AudioOneshot.playAt(DeathSFX, nodeToDestroy.global_position)
