extends Node2D


# Called when the node enters the scene tree for the first time.
func _process(delta):
	call_deferred("disappear")

func disappear():
	await get_tree().create_timer(10.0).timeout
	queue_free()
