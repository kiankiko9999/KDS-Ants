extends Sprite2D

@export var game_scene: PackedScene
@export var credits_scene: PackedScene

func _ready():
	$Play.input_event.connect(_on_play_clicked)
	$Credits.input_event.connect(_on_credits_clicked)

func _on_play_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_packed(game_scene)

func _on_credits_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_packed(credits_scene)
