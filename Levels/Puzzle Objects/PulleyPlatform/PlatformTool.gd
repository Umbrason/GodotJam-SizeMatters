@tool
extends Node2D

@export var LeftPlatform: Node2D
@export var RightPlatform: Node2D
@export var Platform: PulleyPlatform

func _draw():
    if Engine.is_editor_hint():
        draw_line(LeftPlatform.position, LeftPlatform.position + Vector2(0, Platform.LeftHeight), Color("FFFFFF"))
        draw_line(RightPlatform.position, RightPlatform.position + Vector2(0, Platform.RightHeight), Color("FFFFFF"))

func _process(_delta):
    queue_redraw()