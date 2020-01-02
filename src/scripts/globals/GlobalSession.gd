extends Node
class_name GlobalSession

var current_category_path: String setget set_current_category_path

func set_current_category_path(path: String) -> void:
	current_category_path = path
	
func _ready():
	Events.connect("category_selected", self, "set_current_category_path")