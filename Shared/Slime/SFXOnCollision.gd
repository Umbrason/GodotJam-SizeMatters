extends Node

@export var selfBody: RigidBody2D
@export var impactSFX: AudioStream

var lastSFXPlay: int

func on_body_enter(body):    
    var otherVel = Vector2(0,0) 
    if body is RigidBody2D or body is CharacterBody2D:
        otherVel = body.linear_velocity
    var relVel = (otherVel - selfBody.linear_velocity)
    if (lastSFXPlay + 200 < Time.get_ticks_msec()):
        lastSFXPlay = Time.get_ticks_msec()
        AudioOneshot.playAt(impactSFX, selfBody.global_position, clamp((relVel.length() + 25) / 125., 0., 1.))