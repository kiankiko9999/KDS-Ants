extends Node

@export var shoeWarning: PackedScene
@export var shoeAttack: PackedScene


@export var gameOn = true
@export var difficultyCoefficient = 1
@export var attackRate = 0.3

# Called when the node enters the scene tree for the first time.
#func _ready():
	#print("Ready called")
	#var timer = Timer.new()
	#add_child(timer)
	#timer.wait_time = 1.0
	#timer.autostart = true
	#timer.timeout.connect()
	#print("Timer started")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	##spawnShoe()
	#pass
	
func _on_timer_timeout():
	print("Timer fired, gameOn is: ", gameOn)
	if gameOn and randf() < attackRate:
		spawnShoe()
	

func spawnShoe():
	print("It Works")
	var instanceWarning = shoeWarning.instantiate()
	var instanceShoeAttack = shoeAttack.instantiate()
	var rand_x = randf_range(16, 448)
	var rand_y = randf_range(-240, -112)
	instanceWarning.position = Vector2(rand_x, rand_y)
	instanceShoeAttack.position = Vector2(rand_x, rand_y)
	add_child(instanceWarning)
	await get_tree().create_timer(2.0).timeout
	add_child(instanceShoeAttack)
	
func spawnFruit():
	pass
