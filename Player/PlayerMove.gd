extends CharacterBody2D

class_name PlayerMove

signal on_body_enter(body)

const TILE_SIZE = 8

var tilesPerSecond = 10
var tileJumpHeight = 4

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity");

func _ready():
	floor_snap_length = floor(TILE_SIZE / 2.)
	floor_constant_speed = true

func _physics_process(delta):
	var direction = Input.get_axis("Move_Left", "Move_Right")
	velocity.x = direction * tilesPerSecond * TILE_SIZE	
	if(!is_on_floor()): 
		velocity.y += gravity * delta
	if is_on_floor() && Input.is_action_pressed("Jump"):
		velocity.y = -sqrt(2 * gravity * tileJumpHeight * TILE_SIZE)
	
	
	var slideCollisionCount = get_slide_collision_count()
	for i in range(slideCollisionCount):
		var collision = get_slide_collision(i)
		on_body_enter.emit(collision.get_collider())			
	move_and_slide()
