extends Label

@onready var timer = $Timer
@onready var antController = get_parent()

var time_left: float = 60.0  # Set your countdown time here


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	antController.points = antController.points
	if time_left > 0:
		time_left -= delta
		time_left = max(time_left, 0.0)  # Prevents going negative
		update_label()
	elif time_left == 0:
		pass
		
func update_label():
	text = "Points: %d\nTime: %d" % [antController.points, time_left]
	
