extends Control

var player
var player_script

@onready var parent := self.get_parent() # the pause menu
@onready var player_icon := $SubViewportContainer/SubViewport/Root/PlayerMarker # the icon that will represent the player on the map
@onready var map_camera := $SubViewportContainer/SubViewport/Root/MapScreen # camera to display to the screen

func _ready() -> void:
    # I know this code is gross, but if it ain't broke don't fix it
    # just be glad I didn't put it all on one line
    var root = self.get_parent().get_parent().get_parent()
    player = root.get_node("Player")
    player_script = player.get_script()
    map_camera.make_current()

func _process(delta: float) -> void:
    # set the player icon's transform components

    # position
    var player_x = player.position.x + 1000
    var player_y = player.position.z + 1000 # Z in 3D corresponds to Y in 2D
    player_icon.position = Vector2(player_x, player_y)
    
    # camera position
    #var camera_x = clamp(player_icon.position.x, 0, 2000)
    #var camera_y = clamp(player_icon.position.y, 0, 2000)
    #map_camera.position = Vector2(camera_x, camera_y)
    
    # rotation
    var player_rotation_y = player.camera.rotation.y
    player_icon.rotation = -player_rotation_y # negated to match 2D clockwise rotation

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
