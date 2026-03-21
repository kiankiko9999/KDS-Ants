extends Node2D

@export var ant_scene: PackedScene
@export var nest_position: Vector2 = Vector2(400, 300)  # Set this to your nest location
@export var recall_radius: float = 80.0  # Right-click recall range
@export var game_over: PackedScene
@onready var timer = $Label/Timer
var game_over_triggered = false
var ants_in_nest: int = 10  # Starting ants in the nest
var points: int = 0

func _process(delta):
	if not is_inside_tree():
		return
	if ants_in_nest <= 0 and _no_ants_outside():
		gameover()
	if timer.time_left < 0:
		gameover()

func _no_ants_outside() -> bool:
	for ant in get_parent().get_children():
		if ant.has_method("return_to_nest"):
			return false
	return true

func _ready():
	print("Ants in nest: ", ants_in_nest)
func _input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		var click_pos = get_global_mouse_position()

		if event.button_index == MOUSE_BUTTON_LEFT:
			_send_ant(click_pos)

		elif event.button_index == MOUSE_BUTTON_RIGHT:
			_recall_ants_near(click_pos)

func _send_ant(target: Vector2):
	if ants_in_nest <= 0:
		print("No ants left in nest!")
		return

	var ant = ant_scene.instantiate()
	get_parent().add_child(ant)
	ant.global_position = nest_position + Vector2(0,-50)
	ant.nest_position = nest_position
	ant.controller = self
	ant.move_to(target)

	ants_in_nest -= 1
	print("Ant sent! Ants remaining in nest: ", ants_in_nest)

func _recall_ants_near(click_pos: Vector2):
	for ant in get_parent().get_children():
		if ant.has_method("return_to_nest"):
			if ant.global_position.distance_to(click_pos) <= recall_radius:
				ant.return_to_nest()

func ant_returned():
	ants_in_nest += 1
	print("Ant returned! Ants in nest: ", ants_in_nest)

func gameover():
	if game_over_triggered:
		return
	if not is_inside_tree():
		return
	game_over_triggered = true
	GameData.points = points
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
