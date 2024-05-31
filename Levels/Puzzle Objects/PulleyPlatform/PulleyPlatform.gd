extends Node2D

class_name PulleyPlatform

@export var LeftHeight: float = 50
@export var RightHeight: float = 50

@export var LeftPlatformAnchor: AnimatableBody2D
@export var RightPlatformAnchor: AnimatableBody2D

@export var LeftWeightCounter: WeightCounter
@export var RightWeightCounter: WeightCounter

@export var CenterPolygon2D: Polygon2D
@export var LeftPolygon2D: Polygon2D
@export var RightPolygon2D: Polygon2D

var leftSpring = FloatSpring.new(5, .6)
var rightSpring = FloatSpring.new(5, .6)

var centerPolygon: PackedVector2Array = PackedVector2Array()
var rightPolygon: PackedVector2Array = PackedVector2Array()
var leftPolygon: PackedVector2Array = PackedVector2Array()

var totalLength: float:
	get: return RightHeight + LeftHeight

var _leftWeightBias = 0
var _rightWeightBias = 0

func _ready():
	LeftWeightCounter.weight_changed.connect(weightChanged)
	RightWeightCounter.weight_changed.connect(weightChanged)
		
	leftSpring.Position = LeftHeight
	leftSpring.RestingPos = LeftHeight

	rightSpring.Position = RightHeight
	rightSpring.RestingPos = RightHeight

	LeftPlatformAnchor.position.y = leftSpring.Position;
	RightPlatformAnchor.position.y = rightSpring.Position

	_leftWeightBias = LeftHeight / totalLength
	_rightWeightBias = RightHeight / totalLength

	var rightPos = RightPolygon2D.global_position.x - CenterPolygon2D.global_position.x
	var leftPos = LeftPolygon2D.global_position.x - CenterPolygon2D.global_position.x
	
	centerPolygon.append(Vector2(leftPos - 1, 1))
	centerPolygon.append(Vector2(leftPos - 1, -1))
	centerPolygon.append(Vector2(rightPos + 1, -1))
	centerPolygon.append(Vector2(rightPos + 1, 1))

	leftPolygon.append(Vector2(0, 0))
	leftPolygon.append(Vector2(0, 0))
	leftPolygon.append(Vector2(0, 0))
	leftPolygon.append(Vector2(0, 0))
	
	rightPolygon.append(Vector2(0, 0))
	rightPolygon.append(Vector2(0, 0))
	rightPolygon.append(Vector2(0, 0))
	rightPolygon.append(Vector2(0, 0))

	CenterPolygon2D.polygon = centerPolygon

func free():
	LeftWeightCounter.weight_changed.disconnect(weightChanged)
	RightWeightCounter.weight_changed.disconnect(weightChanged)

func weightChanged(_o, _n):
	var externalWeight: float = max(1, LeftWeightCounter.current_weight + RightWeightCounter.current_weight)
	var totalWeight: float = LeftWeightCounter.current_weight + _leftWeightBias * externalWeight + RightWeightCounter.current_weight + _rightWeightBias * externalWeight
	leftSpring.RestingPos = (LeftWeightCounter.current_weight + _leftWeightBias * externalWeight) / totalWeight * totalLength
	rightSpring.RestingPos = (RightWeightCounter.current_weight + _rightWeightBias * externalWeight) / totalWeight * totalLength

func _physics_process(delta):
	leftSpring.step(delta)
	rightSpring.step(delta)

	leftPolygon.set(0, Vector2( - 1, 1))
	leftPolygon.set(1, Vector2(1, 1))
	leftPolygon.set(2, Vector2(1, leftSpring.Position + 2))
	leftPolygon.set(3, Vector2( - 1, leftSpring.Position + 2))
	LeftPolygon2D.polygon = leftPolygon
	
	rightPolygon.set(0, Vector2( - 1, 1))
	rightPolygon.set(1, Vector2(1, 1))
	rightPolygon.set(2, Vector2(1, rightSpring.Position + 2))
	rightPolygon.set(3, Vector2( - 1, rightSpring.Position + 2))
	RightPolygon2D.polygon = rightPolygon

	LeftPlatformAnchor.position.y = leftSpring.Position;
	RightPlatformAnchor.position.y = rightSpring.Position
