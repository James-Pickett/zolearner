extends Node
class_name AnswerButtonOrchestrator

onready var button_texture_paths = FileUtil.get_file_paths_in_dir("res://src/scenes/answer/sprites/planets/")

export var answer_button: Resource

func _ready():
	Events.connect("init_answers", self, "_on_init_answers")

# Called when the node enters the scene tree for the first time.
func _on_init_answers(answers: Array) -> void:
	for answer in answers:
		var button = answer_button.instance() as AnswerButton
		button.set_text(answer)
		button.set_texture(button_texture_paths[randi() % button_texture_paths.size()])
		get_parent().call_deferred("add_child", button)
