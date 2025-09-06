extends Node3D

@onready var hitbox = $Area3D

func _ready():
    hitbox.connect("body_entered", _on_hitbox_body_entered)

func _on_hitbox_body_entered(body):
    if body.is_in_group("mobs"): # check group
        body.take_damage(10) # call mob's damage function
