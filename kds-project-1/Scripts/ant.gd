extends CharacterBody2D

var nest_position: Vector2 = Vector2.ZERO
var controller: Node = null
var speed: float = 120.0
var target: Vector2 = Vector2.ZERO
var returning: bool = false
var moving: bool = false
var lives: int
var radioactive: bool = false

@export var attached_fruit = null
@onready var animated_sprite = $AnimatedSprite2D
const ARRIVE_THRESHOLD = 8.0

func _physics_process(delta):
	if not moving:
		if attached_fruit == null:
			if !radioactive:
				animated_sprite.play("Idle")
			else:
				animated_sprite.play("Radioactive Idle")
		return
	if !radioactive:
		animated_sprite.play("Walking")
	else:
		animated_sprite.play("Radioactive Walking")
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
	#if returning:
		#print("I'm already returning")
		#return
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
	if fruit.weight == 0:
		return false
	animated_sprite.play("Idle")
	return fruit.try_attach(self)

func die():
	if lives <= 1:
		if attached_fruit != null:
			attached_fruit.detach_ant(self)
		queue_free()
	lives =- 1
	
func walking_animation():
	if !radioactive:
		animated_sprite.play("Walking")
	else:
		animated_sprite.play("Radioactive Walking")

func idle_animation():
	if !radioactive:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Radioactive Idle")
