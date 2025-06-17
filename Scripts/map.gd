extends Control

var entered_from := "pause" # variable that tells later functions how the map was accessed

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("open_map"): # if the M is pressed
        if !self.is_visible():
            entered_from = "shortcut"
            self.get_parent().set_visible(true)
            self.set_visible(true)
        else:
            close_map()
    elif event.is_action_pressed("pause"): # if Escape is pressed
        close_map()
            
# exit the map screen to either the pause menu or back to gameplay, depending on entered_from
func close_map():
    self.set_visible(false)
    entered_from = "pause" # setting this here to avoid any potential conflicts later
    if entered_from == "shortcut":
        self.get_parent().set_visible(false)
