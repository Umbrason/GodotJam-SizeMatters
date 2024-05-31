extends Node2D

class_name Door

@export var RadioChannelMask: Radio.Channel = Radio.Channel.Channel_1
@export var inverted: bool
@onready var body2D = $"AnimatableBody2D"
@onready var sprite = $"DoorSprite"

var _spring: FloatSpring = FloatSpring.new(10, 1.2)

func _ready():
	Radio.channel_state_changed.connect(onChannelStateChanged)
	onChannelStateChanged(RadioChannelMask, Radio.channel_states[RadioChannelMask])

func free():
	Radio.channel_state_changed.disconnect(onChannelStateChanged)

func onChannelStateChanged(channel, state):
	if channel != RadioChannelMask: return

	if bool(state) != inverted: _spring.RestingPos = 1
	else: _spring.RestingPos = 0

func _process(delta):
	_spring.step(delta)
	sprite.frame = floor(clamp(_spring.Position, 0., 1.) * sprite.sprite_frames.get_frame_count(sprite.animation))
	body2D.position.y = _spring.Position * 64
