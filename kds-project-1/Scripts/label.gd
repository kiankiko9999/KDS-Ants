extends Label

@onready var timer = $Timer
@onready var antController = get_parent()
@onready var timer_progress = $TextureProgressBar
@export var initial_time: float = 120  # Set your countdown time here

var time_left = initial_time


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	antController.points = antController.points
	# if time_left > 0:
		# time_left -= delta
		# time_left = max(time_left, 0.0)  # Prevents going negative
		# update_label()
	if time_left == 0:
		get_parent().gameover()
		pass
		
func update_label():
	# text = "Points: %d\nTime: %d\nNumber of ants: %d" % [antController.points, time_left, get_parent().ants_in_nest]
	text = "Points: %d\nNumber of ants: %d" % [antController.points, get_parent().ants_in_nest]
	


func _on_timer_timeout() -> void:
	timer_progress.value -= 1
	text = "Points: %d\nNumber of ants: %d" % [antController.points, get_parent().ants_in_nest]
