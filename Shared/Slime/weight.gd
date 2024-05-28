@tool
extends Node

class_name Weight

@export var _weight:int = 1
@export var _baseRadius:int = 0

signal weight_changed(old, new)

var weight: int:
	get:
		return _weight
	set(value):
		var oldWeight = _weight
		if _weight != clamp(value, 1, 20):
			_weight = clamp(value, 1, 20)
			weight_changed.emit(oldWeight, _weight)

var absorb_weight: int:
	get:
		return weight + _baseRadius

func getRadius():
	return sqrt(weight + _baseRadius) * 4
