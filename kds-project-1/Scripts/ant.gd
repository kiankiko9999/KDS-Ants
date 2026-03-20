extends CharacterBody2D

var nest_position: Vector2 = Vector2.ZERO
var controller: Node = null
var speed: float = 120.0
var target: Vector2 = Vector2.ZERO
var returning: bool = false
var moving: bool = false
@export var attached_fruit = null

const ARRIVE_THRESHOLD = 8.0

func _physics_process(delta):
	if not moving:
		return

	var direction = (target - global_position)
	if direction.length() < ARRIVE_THRESHOLD:
		global_position = target
		moving = false
		return

	velocity = direction.normalized() * speed
	rotation = direction.normalized().angle() + PI / 2
	move_and_slide()

func move_to(pos: Vector2):
	target = pos
	returning = false
	moving = true

func return_to_nest():
	if returning:
		return
	if attached_fruit != null:
		attached_fruit.detach_ant(self)
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, false)
	set_collision_layer_value(3, true)
	set_collision_layer_value(4, false)
	target = nest_position
	returning = true
	moving = true


func arrive_at_nest():
	moving = false
	if controller:
		controller.ant_returned()
	queue_free()

func check_weight(fruit) -> bool:
	if fruit.weight < 0:
		queue_free()
		return false

	if fruit.weight == 0:
		return false

	return fruit.try_attach(self)

func die():
	queue_free()
