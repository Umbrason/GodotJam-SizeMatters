extends Node2D

class_name LaunchPreviewRenderer

@export var dot: PackedScene
@export var previewRange = 80
@export var previewDensity = 20

var dots: Array[AnimatedSprite2D] = []

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity");

var timestep = .05

func setArc(start: Vector2, velocity: Vector2):
	var currentPosition = start
	var currentVelocity = velocity
	var currentTime = 0.
	
	for i in range(dots.size()): dots[i].visible = false
	
	var arc: Array[Vector2] = [start]	
	var arcLength = 0
	if !Raycast2D.raycast(self, global_position, start, 0b1).hit:
		while currentTime < 1:
			var nextVelocity = currentVelocity + Vector2(0, gravity) * timestep
			var nextPosition = currentPosition + (currentVelocity + nextVelocity) / 2 * timestep
			currentTime += timestep
			arcLength +=  (currentPosition - arc[-1]).length()
			arc.append(currentPosition)
			if arcLength > previewRange: break
			var result = Raycast2D.raycast(self, currentPosition, nextPosition, 0b1)
			currentVelocity += Vector2(0, gravity) * timestep

			if (!result.hit): currentPosition = nextPosition
			else: currentPosition = result.position
			if (result.hit):
				break
		
	var dotCount = arcLength / previewDensity + 1
	while dots.size() < dotCount:
		var dotInstance = dot.instantiate()
		self.add_child(dotInstance)
		dots.append(dotInstance)
	
	for i in range(dotCount):
		var dist = i * arcLength / max(1, (dotCount - 1))
		dots[i].visible = true
		dots[i].global_position = sampleArc(arc, dist)
		dots[i].frame = ceil((i / dotCount) * dots[i].sprite_frames.get_frame_count(dots[i].animation))

func sampleArc(arc: Array[Vector2], distance: float):
	var dst = distance
	for i in range(arc.size() - 1):
		var delta = (arc[i] - arc[i + 1]).length()
		if (dst < delta):
			var t = dst / delta
			return lerp(arc[i], arc[i + 1], t)
		dst -= delta
	return arc[-1]