@tool
extends CollisionShape2D

class_name SlimeCollisionShape2D
@export var weight: Weight

func _ready():
	set_shape(CircleShape2D.new())
	weight.weight_changed.connect(onWeightChanged)
	onWeightChanged(weight.weight, weight.weight)

func free():
	weight.weight_changed.disconnect(onWeightChanged)

func onWeightChanged(_old, _new):
	shape.set_radius(weight.getRadius())
