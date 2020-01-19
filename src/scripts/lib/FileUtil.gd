extends Object
class_name FileUtil

static func get_file_paths_in_dir(dir_path: String) -> Array:
	
	# TODO: recurse to through sub folders?
	
	var file_paths := []
	
	var dir := Directory.new()
	dir.open(dir_path)
	dir.list_dir_begin(true, true) # true, true params to skip hidden and navigational
	
	while true:
		var file := dir.get_next()
		if file == "":
			break
		if !file.ends_with(".import"):
			continue 
		file_paths.append(dir_path + file.replace(".import", ""))

	dir.list_dir_end()
	
	return file_paths
	
static func get_file_name_from_path_no_extension(path: String) -> String:
	return path.get_file().replace("." + path.get_extension(), "")
	