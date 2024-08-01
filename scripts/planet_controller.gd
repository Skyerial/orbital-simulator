extends Node

@export var planet_scene: PackedScene

var planet_sun: Node3D = null
var selected_planet: Node3D = null
var preview_planet: bool = false


func _ready() -> void:
	planet_sun = get_child(0)
	planet_sun.planet_selected.connect(set_selected_planet)

func _process(delta: float) -> void:
	check_and_act_input()

func check_and_act_input() -> void:
	if Input.is_action_just_pressed("duplicate") and selected_planet != null and !preview_planet:
		preview_planet = true
		var planet_instance: Node3D = planet_scene.instantiate()
		planet_instance.planet_selected.connect(set_selected_planet)
		planet_instance.placed = false
		set_selected_planet(planet_instance)
		add_child(planet_instance)

	elif Input.is_action_pressed("select") and preview_planet:
		# set the planet to stop following the cursor
		selected_planet.placed = true
		selected_planet = null
		preview_planet = false
		
	elif Input.is_action_pressed("select") and selected_planet != null:
		selected_planet.currently_selected = false
		selected_planet = null

func set_selected_planet(planet: Node3D) -> void:
	if planet != selected_planet:
		selected_planet = planet
	else:
		selected_planet = null
