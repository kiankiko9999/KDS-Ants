extends Area2D

@export var weight: int = 3
@export var ants_to_spawn: int = 2
@export var attach_radius: float = 20.0
var size
var attached_ants: Array = []
var moving: bool = false
var nest_target: Vector2 = Vector2.ZERO
var controller = null

func _ready():
	attached_ants.resize(weight)
	attached_ants.fill(null)
	size = weight

func _on_body_entered(body):
	if body.has_method("check_weight"):
		body.check_weight(self)

func _physics_process(delta):
	if not moving or weight >0:
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

	var slot_index = attached_ants.find(null)
	if slot_index == -1:
		return false

	attached_ants[slot_index] = ant
	weight -= 1
	var slot = _get_slot_position(slot_index)
	ant.global_position = slot
	ant.rotation = (global_position - ant.global_position).angle() + PI / 2
	ant.moving = false
	ant.attached_fruit = self
	ant.set_collision_layer_value(1, false)
	ant.set_collision_layer_value(4, true)
	if weight <= 0:
		_start_moving()
	return true
func _get_slot_position(index: int) -> Vector2:
	var angle = (TAU / size) * index
	return global_position + Vector2(cos(angle), sin(angle)) * attach_radius

func _start_moving():
	moving = true
	for ant in attached_ants:
		if is_instance_valid(ant):
			ant.walking_animation()
			if controller == null:
				controller = ant.controller
				nest_target = ant.nest_position


func deliver():
	if controller:
		controller.ants_in_nest += ants_to_spawn
		print("Fruit delivered! Nest gained ", ants_to_spawn, " ants.")
	for ant in attached_ants:
		if is_instance_valid(ant):
			controller.ants_in_nest +=1
			ant.queue_free()
	queue_free()

func detach_ant(ant):
	var index = attached_ants.find(ant)
	attached_ants[index] = null
	weight += 1
	ant.attached_fruit = null
