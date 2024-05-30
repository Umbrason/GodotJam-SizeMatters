@tool
extends Node2D

func _physics_process(_delta):
    position = floor(position / 8) * 8 + Vector2(4, 4)