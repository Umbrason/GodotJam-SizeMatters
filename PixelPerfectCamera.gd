extends Camera2D
 
class_name PixelPerfectCamera2D

### Base Size of the Game ###
const baseSize = Vector2(256, 384)
 
func _process(_delta):
	var cameraSize = get_best_camera_size(DisplayServer.window_get_size())
	set_zoom(Vector2(cameraSize, cameraSize))
 
func get_best_camera_size(screenSize):
	var bestResizeX = floor(screenSize.x / baseSize.x)
	var bestResizeY = floor(screenSize.y / baseSize.y)

	if (bestResizeX <= bestResizeY):
		return bestResizeX
	return bestResizeY
