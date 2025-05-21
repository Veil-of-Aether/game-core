# Veil of Aether is a FOSS action-adventure RPG
# Copyright (C) 2025  Luke Moyer

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
    get_tree().paused = false
    get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")

func _on_map_btn_pressed() -> void:
    pass # Replace with function body.
