@tool
extends Node

class_name Weight

@export var _weight:int = 1

signal weight_changed()

var weight: int:
	get:
		return _weight
	set(value):
		if _weight != clamp(value, 1, 20):
			_weight = clamp(value, 1, 20)
			weight_changed.emit()

func getRadius():
	return sqrt(weight) * 4
