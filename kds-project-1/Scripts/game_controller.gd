extends Node

@export var shoeWarning: PackedScene
@export var shoeAttack: PackedScene
@export var blueberry: PackedScene
@export var appleCore: PackedScene
@export var radioactiveLiquid: PackedScene
@export var energyDrink: PackedScene
@export var sluggy: PackedScene
@export var leaf: PackedScene
@export var beetle: PackedScene

@export var gameOn = true
@export var linearTimeToDoubleDifficulty_InSeconds: float
var difficultyCoefficient = 1
@export var attackRate = 0.3
@export var appleSpawnRate = 0.1
@export var blueberrySpawnRate = 0.2
@export var radioactiveLiquidSpawnRate = 0.05
@export var sluggySpawnRate = 0.05
@export var leafSpawnRate = .3
@export var energyDrinkSpawnRate = 0.05
@export var beetleSpawnRate = .03

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
	if gameOn and randf() < radioactiveLiquidSpawnRate:
		spawnRadioactiveLiquid()
	if gameOn and randf() < sluggySpawnRate:
		spawnSluggy()
	if gameOn and randf() < leafSpawnRate:
		spawnLeaf()
	if gameOn and randf() < energyDrinkSpawnRate:
		spawnEnergyDrink()
	if gameOn and randf() < beetleSpawnRate:
		spawnBeetle()

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
	
func spawnRadioactiveLiquid():
	var instanceRadioactiveLiquid = radioactiveLiquid.instantiate()
	var rand_x = randf_range(16, 448)
	var rand_y = randf_range(-240, -112)
	instanceRadioactiveLiquid.position = Vector2(rand_x, rand_y)
	add_child(instanceRadioactiveLiquid)
	
func spawnEnergyDrink():
	var instanceEnergyDrink = energyDrink.instantiate()
	var rand_x = randf_range(16, 448)
	var rand_y = randf_range(-240, -112)
	instanceEnergyDrink.position = Vector2(rand_x, rand_y)
	add_child(instanceEnergyDrink)

func spawnSluggy():
	var instanceSluggy = sluggy.instantiate()
	var rand_y = randf_range(-240, -112)
	instanceSluggy.position = Vector2(0, rand_y)
	add_child(instanceSluggy)

func spawnLeaf():
	var instanceLeaf = leaf.instantiate()
	var rand_x = randf_range(16, 448)
	var rand_y = randf_range(-240, -112)
	instanceLeaf.position = Vector2(rand_x, rand_y)
	add_child(instanceLeaf)

func spawnBeetle():
	var instanceBeetle = beetle.instantiate()
	var rand_y = randf_range(-240, -112)
	instanceBeetle.position = Vector2(500, rand_y)
	add_child(instanceBeetle)
