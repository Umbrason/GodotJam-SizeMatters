extends Node2D

class_name PlayerSlimeLaunch

@onready var weight = $"../Weight" as Weight
@onready var previewRenderer = $"./LaunchPreviewRenderer" as LaunchPreviewRenderer
@export var slimeProjectile: PackedScene
@export var launchForce: float = 400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity");

func _process(_deltaTime):
	var mousePos = get_global_mouse_position()	
	var localMouse = mousePos - self.global_position
	var direction = localMouse.normalized()
	var startPos = (weight.getRadius() - .5) * direction + self.global_position	
	var launchVelocity = calcLaunchVelocity(startPos, direction * max(weight.getRadius(), localMouse.length()) + self.global_position)
	previewRenderer.setArc(startPos, launchVelocity)
	var projectileInstance = slimeProjectile.instantiate() as RigidBody2D	

	if(weight.weight > 1) && Input.is_action_just_pressed("Launch"):
		weight.weight -= 1;
		projectileInstance.global_position = startPos
		projectileInstance.linear_velocity = launchVelocity
		get_tree().root.get_child(0).add_child(projectileInstance)

func calcLaunchVelocity(from, to) -> Vector2:
	var dx = to.x - from.x
	var dy = from.y - to.y

	var vy = -sqrt(2 * gravity * abs(dy)) * sign(dy)
	var t = (dy / -vy) * 2.
	var vx = dx / t;

	var v = Vector2(vx, min(0, vy));
	return v.normalized() * min(v.length(), launchForce)
