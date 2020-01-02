extends TextureButton
class_name AnswerButton

var label: Label

func _ready():
	self.connect("pressed", self, "_on_AnswerButton_pressed")
	Events.connect("question_complete", self, "remove_self")

func _on_AnswerButton_pressed():
	Events.emit_signal("answer_selected", get_label().text)
	
func set_text(text: String) -> void:
	get_label().set_text(text)	

func get_label() -> Label:
	for node in get_children():
		if node is Label:
			return node as Label
	return null

func remove_self() -> void:
	get_parent().remove_child(self)
	queue_free()