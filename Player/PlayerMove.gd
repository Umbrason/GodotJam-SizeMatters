extends CharacterBody2D

class_name PlayerMove

signal on_body_enter(body)

const TILE_SIZE = 8

var tilesPerSecond = 10
var tileJumpHeight = 4

@export var JumpSFX: AudioStream
@export var LandSFX: AudioStream

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity");
@onready var weight = $"Weight"
var lastJumpSFXPlay: int
var lastLandSFXPlay: int

func _ready():
	floor_snap_length = floor(TILE_SIZE / 2.)
	floor_constant_speed = true

var _lastYVel: float = 0
var _lastGroundedState = false

func _physics_process(delta):
	var direction = Input.get_axis("Move_Left", "Move_Right")
	velocity.x = direction * tilesPerSecond * TILE_SIZE
	
	if (!_lastGroundedState&&is_on_floor()): 
		if (lastLandSFXPlay + 50 < Time.get_ticks_msec()):
			lastLandSFXPlay = Time.get_ticks_msec()
			AudioOneshot.playAt(LandSFX, global_position, clamp((_lastYVel + 50) / 250., 0., 1.))
	_lastGroundedState = is_on_floor()
	_lastYVel = velocity.y

	if (!is_on_floor()):
		velocity.y += gravity * delta
	if is_on_floor()&&Input.is_action_pressed("Jump"):
		velocity.y = -sqrt(2 * gravity * jumpHeightByWeight(weight.weight) * TILE_SIZE)
		if (lastJumpSFXPlay + 50 < Time.get_ticks_msec()):
			lastJumpSFXPlay = Time.get_ticks_msec()
			AudioOneshot.playAt(JumpSFX, self.global_position)

	var slideCollisionCount = get_slide_collision_count()
	for i in range(slideCollisionCount):
		var collision = get_slide_collision(i)
		on_body_enter.emit(collision.get_collider())
	move_and_slide()

func jumpHeightByWeight(w):
	if (w <= 0): return 8
	if (w <= 1): return 6
	if (w <= 2): return 5
	if (w <= 3): return 3.5
	if (w <= 5): return 2
	return 1.5
