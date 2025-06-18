extends Control

@onready var parent := self.get_parent()

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("open_map"): # if the M is pressed
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
