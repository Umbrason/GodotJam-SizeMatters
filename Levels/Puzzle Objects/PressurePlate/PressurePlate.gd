extends Node2D

signal state_changed(old, new)

@onready var weightCounter := $"WeightCounter" as WeightCounter
@onready var button_graphic := $"./PressurePlate" as AnimatedSprite2D
@onready var dot_container := $"./Lamps" as Node2D

@export var required_weight = 1
@export var RadioChannel: Radio.Channel = Radio.Channel.Channel_1

@export var dot_template: PackedScene
@export var fully_pressedAudio: AudioStream
@export var half_pressedAudio: AudioStream

var lastHalfSoundPlayer: int
var lastFullySoundPlayer: int

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
		if (!wasOn && isOn):
			if (lastHalfSoundPlayer + 250 < Time.get_ticks_msec()):
				lastHalfSoundPlayer = Time.get_ticks_msec()
				AudioOneshot.playAt(fully_pressedAudio, self.global_position)
		elif (new > old && !isOn):
			if (lastFullySoundPlayer + 250 < Time.get_ticks_msec()):
				lastFullySoundPlayer = Time.get_ticks_msec()
				AudioOneshot.playAt(half_pressedAudio, self.global_position)

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