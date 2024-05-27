extends AnimatedSprite2D

@onready var characterBody = $".." as CharacterBody2D

func _physics_process(_delta):
    var velX = characterBody.velocity.x
    var velY = characterBody.velocity.y
    if (characterBody.is_on_floor()):
        if velX < 0:
                self.play("Move_Left")
        elif velX > 0:
                self.play("Move_Right")
        elif velX == 0:
                self.play("Idle")
    elif velY < 0:
        self.play("Rising")
    elif velY >= 0:
        self.play("Falling")