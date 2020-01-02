extends Node
class_name QuestionSession

var question: Question

func _ready():
	Events.connect("new_question", self, "_on_Events_new_question")
	Events.connect("answer_selected", self, "_on_Events_answer_selected")

func _on_Events_new_question(new_question: Question) -> void:
	question = new_question
	Events.emit_signal("init_answers", question.answer_options)
	Events.emit_signal("load_question_media", question.media_path)

func _on_Events_answer_selected(answer: String) -> void:
	if answer == question.correct_answer:
		print("correct answer!")
	else:
		print("wrong answer!")
		
	Events.emit_signal("question_complete")
	