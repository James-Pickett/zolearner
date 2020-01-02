extends Node

export var category_button: Resource

func _ready():
	for category in get_categories(Config.CATEGORIES_FOLDER_PATH):
		var button = category_button.instance()
		button.set_text(category)
		get_parent().call_deferred("add_child", button)
	
func get_categories(categories_path: String) -> Array:
	
	var categories := []
	
	var dir := Directory.new()
	dir.open(categories_path)
	dir.list_dir_begin(true, true) # true, true params to skip hidden and navigational
	
	while true:
		var file := dir.get_next()
		if file == "":
			break
		if !dir.current_is_dir():
			continue
		categories.append(file)

	dir.list_dir_end()

	return categories