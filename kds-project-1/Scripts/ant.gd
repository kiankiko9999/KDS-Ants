extends CharacterBody2D

var nest_position: Vector2 = Vector2.ZERO
var controller: Node = null
var speed: float = 120.0
var target: Vector2 = Vector2.ZERO
var returning: bool = false
var moving: bool = false

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
	rotation = direction.normalized().angle() + PI/2
	move_and_slide()

func move_to(pos: Vector2):
	target = pos
	returning = false
	moving = true

func return_to_nest():
	if returning:
		return
	target = nest_position
	returning = true
	moving = true

func arrive_at_nest():
	moving = false
	if controller:
		controller.ant_returned()
	queue_free()
