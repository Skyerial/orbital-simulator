extends Node3D

@onready var shader: ShaderMaterial = $CSGSphere3D.material.next_pass

signal planet_selected

var placed: bool = true


func _process(delta: float) -> void:
    if !placed:
        var camera = get_viewport().get_camera_3d()  # Get the current camera
        var mouse_position = get_viewport().get_mouse_position()

        # Create a ray from the camera through the mouse position
        var ray_origin = camera.project_ray_origin(mouse_position)
        var ray_direction = camera.project_position(mouse_position, ray_origin.z)
        position = ray_direction

func _on_area_3d_mouse_entered() -> void:
    shader.set_shader_parameter("strength", 0.5)

func _on_area_3d_mouse_exited() -> void:
    shader.set_shader_parameter("strength", 0)

func _on_area_3d_input_event(camera: Node, event: InputEvent, position: Vector3,
                            normal: Vector3, shape_idx: int) -> void:
    if event is InputEventMouseButton and placed:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            planet_selected.emit(self)
