extends Node2D

class_name Absorber

@onready var weight = $"../Weight" as Weight
@export var absorbSFX: AudioStream

func tryAbsorb(body):
	if(body == null): return
	var absorbable = body.get_node_or_null("../Absorbable") as Absorbable
	if(absorbable == null): return
	if(absorbable.weight == weight): return #no self harm
	if weight.getRadius() < absorbable.weight.getRadius(): return
	var weightGain = absorbable.absorb()
	weight.weight += weightGain
	AudioOneshot.playAt(absorbSFX, global_position)
