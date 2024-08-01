extends Node3D

@export var highlight_shader: ShaderMaterial

signal planet_selected

@onready var planet_material: StandardMaterial3D = $CSGSphere3D.material
var currently_selected: bool = false
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
	planet_material.next_pass = highlight_shader

func _on_area_3d_mouse_exited() -> void:
	if !currently_selected:
		planet_material.next_pass = null

func _on_area_3d_input_event(camera: Node, event: InputEvent, position: Vector3,
							normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and placed:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			planet_selected.emit(self)
			currently_selected = true
