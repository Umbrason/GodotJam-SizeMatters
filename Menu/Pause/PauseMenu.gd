extends CanvasLayer

class_name PauseMenu
@onready var menuroot = $"Root" as Control
@onready var title = $"Root/Title" as TextureRect

var _paused = false
var isPaused: bool:
    get: return _paused
    set(value):
        _paused = value
        menuroot.visible = value
        get_tree().paused = value
        if(value):
            (title.texture as AnimatedTexture).current_frame = 0
        AudioServer.set_bus_effect_enabled(AudioServer.get_bus_index("BGM"), 0, isPaused)

func _input(_e):
    if Input.is_action_just_pressed("Pause"):
        if MainMenu.isOpen: return
        isPaused = !isPaused

func showMenu():
    isPaused = true    

func hideMenu():
    isPaused = false    

func onRestart():
    LevelLoader.reloadCurrentLevel()
    hideMenu()

func onMenu():
    hideMenu()    
    MainMenu.isOpen = true

func onQuit():
    get_tree().quit()
    hideMenu()