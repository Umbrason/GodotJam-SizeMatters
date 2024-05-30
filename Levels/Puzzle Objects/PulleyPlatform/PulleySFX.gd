extends AudioStreamPlayer2D

@export var PulleyPlatformNode: PulleyPlatform

func _process(_delta):
    var avgVel = (abs(PulleyPlatformNode.rightSpring.Velocity) + abs(PulleyPlatformNode.leftSpring.Velocity)) / _delta / 2.
    var db = linear_to_db(clamp((avgVel - 100.) / 3000., 0, 1))
    self.volume_db = db

