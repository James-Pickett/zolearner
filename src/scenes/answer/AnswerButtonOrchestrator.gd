extends Node
class_name AnswerButtonOrchestrator

export var answer_button: Resource

func _ready():
	Events.connect("init_answers", self, "_on_init_answers")

# Called when the node enters the scene tree for the first time.
func _on_init_answers(answers: Array) -> void:
	for answer in answers:
		var button = answer_button.instance()
		button.set_text(answer)
		get_parent().call_deferred("add_child", button)
