extends Button



func _ready():
	self.connect("pressed", self, "_on_CategoryButton_pressed") 

func _on_CategoryButton_pressed() -> void:
	Events.emit_signal("category_selected", Config.CATEGORIES_FOLDER_PATH + self.text + "/")
	SceneSwitcher.goto_scene(Config.GAME_LEVEL_PATH)
