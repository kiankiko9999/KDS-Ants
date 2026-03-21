extends Sprite2D

func _ready():
	$Back.input_event.connect(_on_back_clicked)

func _on_back_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
