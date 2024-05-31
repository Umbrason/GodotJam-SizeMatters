@tool
extends Node2D

@export var LeftPlatform: Node2D
@export var RightPlatform: Node2D
@export var Platform: PulleyPlatform

func _draw():
    if Engine.is_editor_hint():
        draw_line(LeftPlatform.position, LeftPlatform.position + Vector2(0, Platform.LeftHeight + Platform.RightHeight), Color("FF0000"), 5)
        draw_line(RightPlatform.position, RightPlatform.position + Vector2(0, Platform.LeftHeight + Platform.RightHeight), Color("FF0000"), 5)
        draw_line(LeftPlatform.position, LeftPlatform.position + Vector2(0, Platform.LeftHeight), Color("FFFFFF"), 10)
        draw_line(RightPlatform.position, RightPlatform.position + Vector2(0, Platform.RightHeight), Color("FFFFFF"), 10)

func _process(_delta):
    queue_redraw()