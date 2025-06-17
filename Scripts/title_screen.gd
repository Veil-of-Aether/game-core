extends Control

func _ready() -> void:
    # give focus to the top button (start)
    $Buttons/StartBtn.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("use_button"): # if Space or Enter is pressed
        get_viewport().gui_get_focus_owner().emit_signal("pressed")

func _on_start_btn_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_btn_pressed() -> void:
    get_tree().quit()

func _on_credits_btn_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/credits.tscn")
