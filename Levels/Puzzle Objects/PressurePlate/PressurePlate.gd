extends Node2D

signal state_changed(old, new)

@export var required_weight = 1
@export var dot_template: PackedScene

@onready var weightCounter = $"WeightCounter" as WeightCounter
@onready var button_graphic = $"./Button"
@onready var dot_container = $"./Lamps"


func onWeightCounterChanged(old, new):
		var wasOn = old >= required_weight		
		var isOn = new >= required_weight
		button_graphic.position.y = round(clamp(new / float(required_weight), 0, 1) * 2)
		for i in range(required_weight):
			if(new > i):
				_lamps[i].color = Color("#99e550")
			else:
				_lamps[i].color = Color("#000000")
		if (wasOn != isOn):
			state_changed.emit(wasOn, isOn)

var _lamps: Array[Polygon2D] = []
func _ready():
	weightCounter.weight_changed.connect(onWeightCounterChanged)
	for i in range(required_weight):
		var instance = dot_template.instantiate() as Polygon2D
		dot_container.add_child(instance)
		instance.position.x = (i  - required_weight / 2.) * 4
		_lamps.append(instance)

func free():
	weightCounter.weight_changed.disconnect(onWeightCounterChanged)