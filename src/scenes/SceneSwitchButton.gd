extends Button

export var scenePath = "" # path of the scene to switch to

func _ready():
	validate_scene_path()
	
func _on_pressed():
	validate_scene_path()
	SceneSwitcher.goto_scene(scenePath)

func validate_scene_path():
	assert(Directory.new().file_exists(scenePath))