extends Node3D

var _is_swinging := false # whether or not the weapon is currently swinging

@export var unbreakable := false # whether or not this is an unbreakable weapon
@export var health := 100 # the amount of health points the weapon has, if not unbreakable
@export var damage := 10 # amount of damage dealt by the weapon

@onready var hitbox = $Area3D

func _ready():
    hitbox.connect("body_entered", _on_hitbox_body_entered)

func swing():
    _is_swinging = true
    # play swing animation and then set the variable back to false

func take_damage():
    health -= 1
    if health >= 0:
        self.queue_free()

func _on_hitbox_body_entered(body):
    if body.is_in_group("mobs") and _is_swinging: # check group
        body.take_damage(damage) # call mob's damage function
        if !unbreakable:
            take_damage()
