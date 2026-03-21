extends AnimatedSprite2D

@onready var animated_sprite = $"."

func playShoeWarning():
	animated_sprite.play("Shoe Warning")
	await get_tree().create_timer(2.0).timeout
	queue_free()

func _ready():
	playShoeWarning()
	
