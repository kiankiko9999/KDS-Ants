extends Area2D

@export var weight: int = 3
@export var ants_to_spawn: int = 2
@export var attach_radius: float = 20.0

var attached_ants: Array = []
var moving: bool = false
var nest_target: Vector2 = Vector2.ZERO
var controller = null

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.has_method("check_weight"):
		body.check_weight(self)

func _physics_process(delta):
	if not moving:
		return

	var direction = (nest_target - global_position)
	if direction.length() < 8.0:
		deliver()
		return

	var velocity = direction.normalized() * 60.0
	global_position += velocity * delta

	for ant in attached_ants:
		if is_instance_valid(ant):
			var slot = _get_slot_position(attached_ants.find(ant))
			ant.global_position = slot
			ant.rotation = (global_position - ant.global_position).angle() + PI / 2

func try_attach(ant) -> bool:
	if weight <= 0:
		return false

	var slot = _get_slot_position(attached_ants.size())
	attached_ants.append(ant)
	weight -= 1

	ant.global_position = slot
	ant.rotation = (global_position - ant.global_position).angle() + PI / 2
	ant.moving = false
	ant.carrying = true
	ant.attached_fruit = self

	if weight <= 0:
		_start_moving()

	return true

func _get_slot_position(index: int) -> Vector2:
	var angle = (TAU / max(weight + attached_ants.size(), 1)) * index
	return global_position + Vector2(cos(angle), sin(angle)) * attach_radius

func _start_moving():
	moving = true
	if not attached_ants.is_empty():
		controller = attached_ants[0].controller
		nest_target = attached_ants[0].nest_position

func deliver():
	if controller:
		controller.ants_in_nest += ants_to_spawn
		print("Fruit delivered! Nest gained ", ants_to_spawn, " ants.")
	for ant in attached_ants:
		if is_instance_valid(ant):
			ant.queue_free()
	queue_free()
