extends Node
class_name AudioOneshot

static var instance: AudioOneshot

func _ready():
    instance = self
func free():
    if (instance == self):
        instance = null

static func play(audioResource, volume = 1):
    instance._play(audioResource, volume)

static func playAt(audioResource, position, volume = 1):
    instance._playAt(audioResource, position, volume)

func _play(audioResource, volume = 1):
    var audioplayer = AudioStreamPlayer.new()
    audioplayer.stream = audioResource
    audioplayer.volume_db = volume
    var onFinished = func(): audioplayer.queue_free()
    audioplayer.finished.connect(onFinished)
    add_child(audioplayer)
    audioplayer.play()

func _playAt(audioResource, position, volume = 1):    
    var audioplayer = AudioStreamPlayer2D.new()
    audioplayer.stream = audioResource
    audioplayer.volume_db = linear_to_db(volume)
    audioplayer.global_position = position
    var onFinished = func(): audioplayer.queue_free()
    audioplayer.finished.connect(onFinished)
    add_child(audioplayer)
    audioplayer.play()