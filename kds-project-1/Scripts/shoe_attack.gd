extends Area2D

@export var drop_distance: float = 300.0
@export var drop_speed: float = 600.0
@onready var stompAudio = $StompAudio


var start_position: Vector2
var target_position: Vector2
var dropping: bool = false
var has_hit: bool = false

func _ready():
	target_position = global_position
	global_position.y -= drop_distance
	start_position = global_position
	monitoring = false
	body_entered.connect(_on_body_entered)
	dropping = true

func _physics_process(delta):
	if not dropping:
		return

	global_position.y += drop_speed * delta

	if global_position.y >= target_position.y:
		global_position = target_position
		dropping = false
		_land()

func _land():
	remove_child(stompAudio)
	get_tree().root.add_child(stompAudio)
	stompAudio.play()
	# Auto free the audio player when it finishes
	stompAudio.finished.connect(stompAudio.queue_free)
	if has_hit:
		return
	has_hit = true
	monitoring = true
	await get_tree().create_timer(0.1).timeout
	monitoring = false
	await get_tree().create_timer(1.0).timeout
	_fade_out()

func _on_body_entered(body):
	if body.has_method("die"):
		body.die()

func _fade_out():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	await tween.finished
	queue_free()
