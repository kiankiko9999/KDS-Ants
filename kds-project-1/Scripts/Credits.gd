extends Sprite2D

@export var main_menu: PackedScene

func _ready():
	$Back.input_event.connect(_on_back_clicked)

func _on_back_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_packed(main_menu)
