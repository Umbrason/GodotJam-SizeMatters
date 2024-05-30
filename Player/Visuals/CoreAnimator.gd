extends AnimatedSprite2D

@onready var characterBody = $".." as CharacterBody2D
@export var weight: Weight

func _physics_process(_delta):
	var velX = characterBody.velocity.x
	var velY = characterBody.velocity.y
	var animationToPlay = ""
	var postfix = ""
	if (weight.weight < 6): postfix = "_N"
	if (weight.weight < 3): postfix = "_S"
	if (characterBody.is_on_floor()):
		if velX < 0:
				animationToPlay =("Move_Left" + postfix)
		elif velX > 0:
				animationToPlay =("Move_Right" + postfix)
		elif velX == 0:
				animationToPlay =("Idle" + postfix)
	elif velY < 0:
		if (abs(velX) < 1): animationToPlay =("Rise" + postfix)
		elif (velX > 0): animationToPlay =("Rise_Right" + postfix)
		else: animationToPlay =("Rise_Left" + postfix)
	elif velY >= 0:
		if (abs(velX) < 1): animationToPlay =("Fall" + postfix)
		elif (velX > 0): animationToPlay =("Fall_Right" + postfix)
		else: animationToPlay =("Fall_Left" + postfix)
	if(self.animation != animationToPlay):
		self.stop()
		self.play(animationToPlay)
