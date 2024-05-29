extends Node2D

signal state_changed(old, new)

@export var required_weight = 1
@export var dot_template: PackedScene

@onready var weightCounter := $"WeightCounter" as WeightCounter
@onready var button_graphic := $"./PressurePlate" as AnimatedSprite2D
@onready var dot_container := $"./Lamps" as Node2D

@export var RadioChannel: Radio.Channel = Radio.Channel.Channel_1

func onWeightCounterChanged(old, new):
		var wasOn = old >= required_weight
		var isOn = new >= required_weight
		button_graphic.frame = floor(new / float(required_weight) * button_graphic.sprite_frames.get_frame_count(button_graphic.animation))
		for i in range(required_weight):
			if (new > i):
				_lamps[i].color = Color("#99e550")
			else:
				_lamps[i].color = Color("#000000")
		if (wasOn != isOn):
			Radio.updateChannel(RadioChannel, isOn)

var _lamps: Array[Polygon2D] = []
func _ready():
	weightCounter.weight_changed.connect(onWeightCounterChanged)
	for i in range(required_weight):
		var instance = dot_template.instantiate() as Polygon2D
		dot_container.add_child(instance)
		instance.position.x = (i - required_weight / 2.) * 4
		_lamps.append(instance)

func free():
	weightCounter.weight_changed.disconnect(onWeightCounterChanged)