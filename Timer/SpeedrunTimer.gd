extends Label

class_name SpeedrunTimer

static var time_elapsed: float
static var active: bool = false

func _ready():
	var minutes = floor(time_elapsed / 60.)
	var seconds = fmod(time_elapsed, 60)
	var milliseconds = fmod(time_elapsed, 1) * 100
	var time_string = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
	self.text = time_string

func _process(delta):	
	if !active && (time_elapsed == 0): self.text = ""
	if !active: return
	time_elapsed += delta
	var minutes = floor(time_elapsed / 60.)
	var seconds = fmod(time_elapsed, 60)
	var milliseconds = fmod(time_elapsed, 1) * 100
	var time_string = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
	self.text = time_string

static func Start():
	active = true
	time_elapsed = 0

static func Reset():
	Start()
	Complete()

static func Complete():
	active = false
