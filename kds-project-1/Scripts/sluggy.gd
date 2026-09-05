extends Area2D

@export var speed = .5
@onready var animated_sprite = $AnimatedSprite2D
var p1: Vector2
var p2: Vector2
var airborn: bool = false
var t: float = 0.0

func _ready() -> void:
	animated_sprite.play("Sliding")

func _physics_process(delta):
	if !airborn:
		move_local_x(speed)
		if global_position.x >= 550:
			queue_free()
	else:
		t+=delta/5.0
		global_position = _quadratic_bezier(global_position, p1, p2, t)
		rotation += .2 / delta


func _on_body_entered(body):
	print("entered something")
	if body.has_method("die"):
		print("eating ant")
		body.die()


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("eaten"):
		print("eating fruit")
		area.eaten()

func flung():
	p1 = Vector2(randf_range(16, 448),randf_range(-240, -150))
	p2 = Vector2((global_position.x + p1.x)/2, ((global_position.y + p1.y)/2)+600)
	airborn = true
	await get_tree().create_timer(0.5).timeout
	airborn = false
	rotation = 0

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r
