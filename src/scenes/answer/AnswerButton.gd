extends TextureButton
class_name AnswerButton

var label: Label

func _ready():
	self.connect("pressed", self, "_on_AnswerButton_pressed")
	Events.connect("question_complete", self, "remove_self")

func _on_AnswerButton_pressed():
	var centerPos := rect_position + rect_scale * rect_size / 2.0
	print("Center Pos " + str(centerPos))
	
	var globalPos := get_global_position()
	print ("Global Pos " + str(globalPos))
	
	var centerGlobalPos := globalPos + rect_scale * rect_size / 2
	print ("Center Global Pos " + str(centerGlobalPos))
	
	
	Events.emit_signal("answer_selected", get_label().text, centerGlobalPos)
	
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