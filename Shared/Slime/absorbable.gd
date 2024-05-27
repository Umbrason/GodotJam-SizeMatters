extends Node2D

class_name Absorbable

@onready var weight = $"../Weight" as Weight
var absorbedGuard = false;

func absorb():
	if absorbedGuard: 
		return 0
	absorbedGuard = true
	get_node("..").queue_free()
	return weight.weight
