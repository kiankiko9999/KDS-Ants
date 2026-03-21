extends Node

@export var shoeWarning: PackedScene
@export var shoeAttack: PackedScene
@export var blueberry: PackedScene
@export var appleCore: PackedScene


@export var gameOn = true
@export var linearTimeToDoubleDifficulty_InSeconds: float
var difficultyCoefficient = 1
@export var attackRate = 0.3
@export var appleSpawnRate = 0.1
@export var blueberrySpawnRate = 0.2

@onready var spawnTimer = $Timer

func _process(delta):
	difficultyCoefficient += 1/linearTimeToDoubleDifficulty_InSeconds * delta  # Slowly ramps up over time
	spawnTimer.wait_time = 1.0 / difficultyCoefficient

	
func _on_timer_timeout():
	#print("Timer fired, gameOn is: ", gameOn)
	if gameOn and randf() < attackRate:
		spawnShoe()
	if gameOn and randf() < appleSpawnRate:
		spawnAppleCore()
	if gameOn and randf() < blueberrySpawnRate:
		spawnBlueberry()
	

func spawnShoe():
	#print("It Works")
	var instanceWarning = shoeWarning.instantiate()
	var instanceShoeAttack = shoeAttack.instantiate()
	var rand_x = randf_range(16, 448)
	var rand_y = randf_range(-240, -112)
	instanceWarning.position = Vector2(rand_x, rand_y)
	instanceShoeAttack.position = Vector2(rand_x, rand_y)
	add_child(instanceWarning)
	await get_tree().create_timer(2.0).timeout
	add_child(instanceShoeAttack)
	
func spawnAppleCore():
	var instanceApple = appleCore.instantiate()
	var rand_x = randf_range(16, 448)
	var rand_y = randf_range(-240, -112)
	instanceApple.position = Vector2(rand_x, rand_y)
	add_child(instanceApple)

func spawnBlueberry():
	var instanceBlueberry = blueberry.instantiate()
	var rand_x = randf_range(16, 448)
	var rand_y = randf_range(-240, -112)
	instanceBlueberry.position = Vector2(rand_x, rand_y)
	add_child(instanceBlueberry)
