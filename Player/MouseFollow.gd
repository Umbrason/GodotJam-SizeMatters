extends Sprite2D

func _process(delta):
    self.global_position = get_global_mouse_position()
