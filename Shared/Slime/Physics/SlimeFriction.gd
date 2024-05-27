extends RigidBody2D

@export var friction = 10

func _physics_process(delta):
    if get_contact_count() > 0:
        self.linear_velocity -= self.linear_velocity * delta * friction