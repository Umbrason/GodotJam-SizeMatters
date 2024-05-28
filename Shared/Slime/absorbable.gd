extends Node2D

class_name Absorbable

@export var weight: Weight
var absorbedGuard = false;

func absorb():
	if absorbedGuard: 
		return 0
	absorbedGuard = true
	get_node("..").queue_free()
	var w = weight.weight
	weight.weight = 0
	return w
