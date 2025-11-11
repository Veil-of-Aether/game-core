extends Sprite3D

@export_node_path var sunNodePath: NodePath
@export_range(10, 100000, 1) var moonDistance: float = 2000.0

var sun: DirectionalLight3D

func _ready() -> void:
    if sunNodePath != NodePath(""):
        sun = get_node(sunNodePath) as DirectionalLight3D

func _process(_delta: float) -> void:
    var cam: Camera3D = get_viewport().get_camera_3d()
    if not cam or not sun:
        return

    # Direction sun is shining (sun → world)
    var sunDirection: Vector3 = (sun.global_transform.basis.z).normalized()
    # Moon goes opposite direction in the sky from the camera's POV
    var moonDirection: Vector3 = -sunDirection

    # Move moon to fixed distance from camera
    global_transform.origin = cam.global_transform.origin + moonDirection * moonDistance

    # Make moon face the active camera
    look_at(cam.global_transform.origin, Vector3.UP)

    # Keep it upright (removes weird roll)
    var rot = rotation_degrees
    rot.z = 0
    rotation_degrees = rot
