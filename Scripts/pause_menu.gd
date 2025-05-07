extends Control

var _is_paused := false:
    set = set_paused
var buttons := []
var selected_index := 0

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("pause"):
        _is_paused = !_is_paused
    if not _is_paused:
        return
     
    if event.is_action_pressed("use_button"):
        get_viewport().gui_get_focus_owner().emit_signal("pressed")

func _notification(what: int) -> void:
    if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
        _is_paused = true

func set_paused(value:bool):
    if _is_paused:
        Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    else:
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    _is_paused = value
    get_tree().paused = _is_paused
    self.visible = _is_paused
    $GridContainer/ResumeBtn.grab_focus()

func _on_resume_btn_pressed() -> void:
    _is_paused = false

func _on_settings_btn_pressed() -> void:
    pass # Replace with function body.

func _on_quit_btn_pressed() -> void:
    get_tree().quit()

func _on_map_btn_pressed() -> void:
    pass # Replace with function body.
