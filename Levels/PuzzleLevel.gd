extends Node2D

class_name PuzzleLevel

@export var CameraStartPos: Node2D
@export var PlayerStartPos: Node2D
@export var ExitArea: Area2D

func _ready():
	ExitArea.body_entered.connect(onBodyEnter)    

func free():
	ExitArea.body_entered.disconnect(onBodyEnter)

func onBodyEnter(body):
	if (body is PlayerMove):		
		call_deferred("reloadLevel")

func reloadLevel():
	LevelLoader.loadNextLevel()