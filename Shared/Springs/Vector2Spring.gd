class_name Vector2Spring

var XSpring : FloatSpring = FloatSpring.new(20, .6)
var YSpring : FloatSpring = FloatSpring.new(20, .6)

func _init(angularFrequency, damping):
	AngularFrequency = angularFrequency
	DampingRatio = damping

var AngularFrequency: float:
		get:
			return XSpring.AngularFrequency
		set(angularFrequency):
			XSpring.AngularFrequency = angularFrequency
			YSpring.AngularFrequency = angularFrequency

var DampingRatio: float:
		get:
			return XSpring.DampingRatio
		set(dampingRatio):
			XSpring.DampingRatio = dampingRatio
			YSpring.DampingRatio = dampingRatio

var Position: Vector2:
	get:
		return Vector2(XSpring.Position, YSpring.Position)
	set(position):
		XSpring.Position = position.x
		YSpring.Position = position.y

var Velocity: Vector2:
	get:
		return Vector2(XSpring.Velocity, YSpring.Velocity)
	set(velocity):
		XSpring.Velocity = velocity.x
		YSpring.Velocity = velocity.y

var RestingPos: Vector2:
	get:
		return Vector2(XSpring.RestingPos, YSpring.RestingPos)
	set(restingPos):
		XSpring.RestingPos = restingPos.x
		YSpring.RestingPos = restingPos.y

func step(delta):
	XSpring.step(delta)
	YSpring.step(delta)
