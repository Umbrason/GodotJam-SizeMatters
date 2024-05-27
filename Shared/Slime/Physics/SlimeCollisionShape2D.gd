@tool
extends CollisionShape2D

class_name SlimeCollisionShape2D
@onready var weight = $"../Weight" as Weight

func _ready():
	set_shape(CircleShape2D.new())
	weight.weight_changed.connect(onWeightChanged)
	onWeightChanged()

func free():
	weight.weight_changed.disconnect(onWeightChanged)

func onWeightChanged():
	shape.set_radius(weight.getRadius())
