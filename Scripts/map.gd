extends Node2D

var player
var player_script

@onready var parent := self.get_parent() # the pause menu
@onready var player_icon := $PlayerMarker # the icon that will represent the player on the map
@onready var map_background := $Background
@onready var map_camera := $MapScreen # camera to display to the screen

func _ready() -> void:
    # I know this code is gross, but if it ain't broke don't fix it
    # just be glad I didn't put it all on one line
    var root = self.get_parent().get_parent().get_parent()
    player = root.get_node("Player")
    player_script = player.get_script()
    map_background.size = get_viewport_rect().size
    #map_camera.current = true

func _process(delta):
    # --- Position ---
    # Convert player’s 3D world position to minimap 2D position
    var playerPos = player.global_transform.origin
    var iconX = playerPos.x + 1000
    var iconY = playerPos.z + 1000 # Z in 3D corresponds to Y in 2D
    player_icon.position = Vector2(iconX, iconY)
    
    # --- Rotation ---
    # Match rotation of player’s camera
    var camRotationY = player.camera.global_transform.basis.get_euler().y
    player_icon.rotation = -camRotationY # Negate to match 2D clockwise rotation
    
    # --- Camera Clamping ---
    var target_pos = player_icon.position
    
    var camX = clamp(target_pos.x, 0, 2000)
    var camY = clamp(target_pos.y, 0, 2000)
    map_camera.position = Vector2(camX, camY)

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("open_map"): # if the M key is pressed
        if !self.is_visible():
            parent.emit_signal("pause")
            self.set_visible(true)
        else:
            close_map()

# render certain things in the world as icons
func render_icons():
    pass

# exit the map screen to gameplay
func close_map():
    self.set_visible(false)
    parent.emit_signal("pause")
