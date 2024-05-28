@tool
extends MeshInstance2D

class_name SlimeRenderer2D

@onready var weight = $"../Weight" as Weight
const resolution = 16

func _ready():
	weight.weight_changed.connect(onWeightChanged)
	for i in range(resolution):
		positionSprings.append(Vector2Spring.new(40, .6))
		positionSprings[i].Position = global_position
		positionSprings[i].RestingPos = global_position
		offsets.append(Vector2(0, 0))
		vertices.append(Vector2(0, 0))
	onWeightChanged(weight.weight, weight.weight)

func free():
	weight.weight_changed.disconnect(onWeightChanged)


func onWeightChanged(_old, _new):
	var radius = weight.getRadius() + 1
	for i in range(resolution):
		var offset = Vector2(sin(i * PI * 2. / resolution), cos(i * PI * 2. / resolution))
		var dy = max(0, offset.y) * pow(offset.x, 4)
		offset += Vector2(0, dy * .5)
		offset *= radius;
		offsets.set(i, offset)

var offsets = PackedVector2Array()
var vertices = PackedVector2Array()
var positionSprings: Array[Vector2Spring]

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity");

func _physics_process(delta):
	#animate verts here
	if (positionSprings == null||positionSprings.size() != resolution): return
	var radius = weight.getRadius() + 1

	self.global_rotation = 0
	for i in range(positionSprings.size()):
		var spring = positionSprings[i]
		spring.RestingPos = self.global_position + offsets[i]
		spring.Velocity += Vector2(0, gravity) * delta
		var deltaPos = spring.Position - self.global_position
		spring.Position = deltaPos.normalized() * max(deltaPos.length(), radius * .8) + self.global_position
		spring.Position = Raycast2D.raycastPos(self, self.global_position, spring.Position, 0b1)
		spring.step(delta)
		spring.Position = Raycast2D.raycastPos(self, self.global_position, spring.Position, 0b1)
		vertices.set(i, spring.Position - self.global_position)
	queue_redraw()

func _draw():
	if vertices.size() >= 3:
		draw_colored_polygon(vertices, Color("#99e550"))
