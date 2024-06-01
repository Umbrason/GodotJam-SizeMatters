extends CanvasLayer

class_name MainMenu

@onready var root = $"Root" as Container
@export var MenuBGM: AudioStreamPlayer
@export var GameplayBGM: AudioStreamPlayer
@export var levelButtonTemplate: PackedScene
@export var gridContainer: GridContainer

static var _isOpen = true
static var isOpen: bool:
    get: return _isOpen
    set(value):
        _instance.root.visible = value
        _isOpen = value
        if (value): 
            LevelLoader.unload()
            SpeedrunTimer.Reset()
        if (!value):
            var menuTime = _instance.MenuBGM.get_playback_position()
            _instance.MenuBGM.stop()
            _instance.GameplayBGM.play(menuTime)
        else:
            _instance.GameplayBGM.stop()
            _instance.MenuBGM.play()

static var _instance: MainMenu

func _init():
    _instance = self

func free():
    _instance = null

func _ready():
    for i in range(LevelLoader.levelCount - 1):
        var instance = levelButtonTemplate.instantiate() as Button
        instance.text = str(i)
        instance.pressed.connect(func(): onOpenLevel(i))
        gridContainer.add_child(instance)
    

func onStart():
    onOpenLevel(0)

func onOpenLevel(id):
    isOpen = false
    LevelLoader.loadLevel(id)

func onQuit():
    get_tree().quit()