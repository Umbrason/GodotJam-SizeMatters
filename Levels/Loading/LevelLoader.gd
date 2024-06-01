extends Node
class_name LevelLoader
@export var PlayerSceneTemplate: PackedScene

@export var Levels: Array[PackedScene]

var currentPlayerScene: PlayerScene
var currentLevel: PuzzleLevel
var currentLevelID: int = -1

static var levelCount: int:
	get: return instance.Levels.size()

static var instance: LevelLoader

func _init():
	instance = self

func free():
	instance = null

static func reloadCurrentLevel():
	if instance.currentLevelID >= 0:
		loadLevel(instance.currentLevelID)

static func unload():
	instance._unload()

func _unload():
	currentLevelID = -1
	if currentLevel != null: currentLevel.queue_free()
	if currentPlayerScene != null: currentPlayerScene.queue_free()

static func loadLevel(levelID: int):
	instance._loadLevel(levelID)	

static func loadNextLevel():
	instance._loadLevel(instance.currentLevelID + 1)

func _loadLevel(levelID: int):
	_unload()
	var levelScene = Levels[levelID]
	currentLevelID = levelID
	currentPlayerScene = PlayerSceneTemplate.instantiate() as PlayerScene
	currentLevel = levelScene.instantiate() as PuzzleLevel
	
	currentPlayerScene.Player.global_position = currentLevel.PlayerStartPos.global_position
	currentPlayerScene.Camera.global_position = currentLevel.CameraStartPos.global_position

	add_child(currentPlayerScene)
	add_child(currentLevel)

	if(levelID == 0): SpeedrunTimer.Start()

	if(levelID == levelCount - 1): SpeedrunTimer.Complete()
