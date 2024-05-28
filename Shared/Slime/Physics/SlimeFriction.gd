extends RigidBody2D

@export var friction = 10

func _physics_process(_delta):
    self.linear_damp = 0
    if get_contact_count() > 0:
        self.linear_damp = friction