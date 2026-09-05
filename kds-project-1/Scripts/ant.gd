extends CharacterBody2D

var nest_position: Vector2 = Vector2.ZERO
var controller: Node = null
var speed: float = 120.0
var target: Vector2 = Vector2.ZERO
var returning: bool = false
var moving: bool = false
var lives: int
var speedMultiplier: float = 1
var p1: Vector2
var p2: Vector2
var airborn: bool = false
var t: float = 0.0

@export var attached_fruit = null
@onready var animated_sprite = $AnimatedSprite2D
const ARRIVE_THRESHOLD = 8.0

func _physics_process(delta):
	if !airborn:
		if not moving:
			if attached_fruit == null:
				idle_animation()
			return
		walking_animation()
		var direction = (target - global_position)
		if direction.length() < ARRIVE_THRESHOLD:
			global_position = target
			moving = false
			return
		velocity = direction.normalized() * speed * speedMultiplier
		rotation = direction.normalized().angle() + PI / 2
		move_and_slide()
	else:
		t+=delta/5.0
		global_position = _quadratic_bezier(global_position, p1, p2, t)
		rotation += .2 / delta


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
	set_collision_mask_value(1, false)
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
	if lives == 1:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Radioactive Idle")
	return fruit.try_attach(self)

func die():
	if lives <= 1:
		if attached_fruit != null:
			attached_fruit.detach_ant(self)
		queue_free()
	lives -= 1
	print("I have ",lives, "left.")

	
func walking_animation():
	if lives == 1:
		animated_sprite.play("Walking")
	else:
		animated_sprite.play("Radioactive Walking")

func idle_animation():
	if lives == 1:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Radioactive Idle")
	

func flung():
	p1 = Vector2(randf_range(16, 448),randf_range(-240, -112))
	p2 = Vector2((global_position.x + p1.x)/2, ((global_position.y + p1.y)/2)+600)
	if attached_fruit != null:
		attached_fruit.detach_ant(self)
	airborn = true
	await get_tree().create_timer(0.5).timeout
	target = global_position
	airborn = false

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r
