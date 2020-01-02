extends Node

var game: Game

func _ready() -> void:
	Events.connect("question_complete", self, "_on_Events_question_complete")
	game = GameFactory.new().create_game(GlobalSession.current_category_path)
	call_deferred("next_question")
	
func next_question() -> void:
	Events.emit_signal("new_question", game.questions.pop_front())
	
func _on_Events_question_complete() -> void:
	if game.questions.size() > 0:
		call_deferred("next_question")
	else:
		SceneSwitcher.goto_scene(Config.MAIN_MENU_LEVEL_PATH)
		