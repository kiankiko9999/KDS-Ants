extends Area2D

@export var speed = .5
@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	animated_sprite.play("Sliding")

func _physics_process(delta):
	move_local_x(speed)
	if position.x >= 550:
		queue_free()


func _on_body_entered(body):
	print("entered something")
	if body.has_method("die"):
		print("eating ant")
		body.die()


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("eaten"):
		print("eating fruit")
		area.eaten()
