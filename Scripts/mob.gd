extends CharacterBody3D

var player = null
const SPEED = 3.0

@export var player_path : NodePath

@onready var nav_agent = $NavigationAgent3D

func _ready() -> void:
    player = get_node(player_path)

func _process(delta: float) -> void:
    self.velocity = Vector3.ZERO
    
    # Navigation
    nav_agent.set_target_position(player.global_transform.origin)
    var next_nav_point = nav_agent.get_next_path_position()
    self.velocity = (next_nav_point - self.global_transform.origin).normalized()
    
    self.velocity *= SPEED
    
    move_and_slide()    
