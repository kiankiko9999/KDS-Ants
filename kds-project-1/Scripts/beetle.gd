extends Area2D

@export var speed = -1
@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("Walking")

func _physics_process(delta):
	move_local_x(speed)
	if position.x <= -10:
		queue_free()


func _on_body_entered(body):
	if body.has_method("flung"):
		print("flinging ant")
		body.flung()


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("flung"):
		print("flinging ant")
		area.flung()
