extends Control

func _ready() -> void:
    $Buttons/StartBtn.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
    # check to see if 
    if event.is_action_pressed("use_button"):
        get_viewport().gui_get_focus_owner().emit_signal("pressed")

func _on_start_btn_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_btn_pressed() -> void:
    get_tree().quit()

func _on_credits_btn_pressed() -> void:
    pass # Replace with function body.
