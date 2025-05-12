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

extends CharacterBody3D
class_name Player

var mouse_sensitivity := 0.001
var controller_sensitivity := 1.0
var twist_input := 0.0
var pitch_input := 0.0
var move_speed := 10.0
var sprint_multiplier := 1.5
var jump_velocity := 5.0
var is_third_person := true
var pitch_limit := 30
var y_limit = -25
@onready var twist_pivot := $TwistPivotTP
@onready var pitch_pivot := $TwistPivotTP/PitchPivotTP
@onready var camera := $TwistPivotTP/PitchPivotTP/CameraTP
@onready var crosshair := $GUI/Crosshair

func _ready() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:  # Fixed method name
    var input_dir := Vector3.ZERO
    
    # Controller stick input
    var rightStickX := Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
    var rightStickY := Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
    if abs(rightStickX) > 0.1:
        twist_input += -rightStickX * controller_sensitivity * delta
    if abs(rightStickY) > 0.1:
        pitch_input += -rightStickY * controller_sensitivity * delta
    
    # Movement input
    var input_x := Input.get_axis("move_left", "move_right")
    var input_z := Input.get_axis("move_forward", "move_back")
    input_dir = Vector3(input_x, 0, input_z).normalized()
    
    # Transform direction into world space relative to pivot
    var direction: Vector3 = twist_pivot.basis * input_dir
    direction.y = 0  # Prevent flying
    
    # Apply movement
    self.velocity.x = direction.x * move_speed
    self.velocity.z = direction.z * move_speed
    
    if Input.is_action_pressed("sprint"):
        self.velocity.x *= sprint_multiplier
        self.velocity.z *= sprint_multiplier
    
    # Jump logic
    if Input.is_action_just_pressed("jump") and is_on_floor():
        self.velocity.y = jump_velocity
    
    # Gravity
    if not is_on_floor():
        self.velocity.y -= 9.8 * delta
    
    move_and_slide()
    
    # Perspective change
    if Input.is_action_just_pressed("perspective"):
        switch_camera()
         
    # Rotation
    twist_pivot.rotate_y(twist_input)
    pitch_pivot.rotate_x(pitch_input)
    pitch_pivot.rotation.x = clamp(
        pitch_pivot.rotation.x,
        deg_to_rad(-pitch_limit),
        deg_to_rad(pitch_limit)
    )
        
    twist_input = 0.0
    pitch_input = 0.0
    
    if self.position.y < y_limit:
        var respawn_point = get_tree().current_scene.get_node("RespawnPoint")
        if respawn_point:
            self.position = respawn_point.global_position


func _input(event: InputEvent) -> void:
    pass

func _unhandled_input(event: InputEvent) -> void:  # Fixed method name
    if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
        twist_input = -event.relative.x * mouse_sensitivity
        pitch_input = -event.relative.y * mouse_sensitivity

# change perspective
func switch_camera():
    var pitch = pitch_pivot.rotation
    var twist = twist_pivot.rotation
    if is_third_person:
        is_third_person = false
        pitch_limit = 60
        mouse_sensitivity = 0.002
        twist_pivot = $TwistPivotFP
        pitch_pivot = $TwistPivotFP/PitchPivotFP
        camera = $TwistPivotFP/PitchPivotFP/CameraFP
    else:
        is_third_person = true
        pitch_limit = 30
        mouse_sensitivity = 0.001
        twist_pivot = $TwistPivotTP
        pitch_pivot = $TwistPivotTP/PitchPivotTP
        camera = $TwistPivotTP/PitchPivotTP/CameraTP
    crosshair.visible = !is_third_person
    twist_pivot.rotation = twist
    pitch_pivot.rotation = pitch
    camera.make_current()
