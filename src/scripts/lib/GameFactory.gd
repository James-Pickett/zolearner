extends Resource

class_name GameFactory

func create_game(category_path: String) -> Game:
	
	randomize()
		
	var game := Game.new()
	var question_paths := FileUtil.get_file_paths_in_dir(category_path)
	var all_possible_answers := get_all_possible_answers(question_paths)

	for question_path in question_paths:
		
		var path := question_path as String
		
		var question := Question.new()
		question.media_path = path

		var correct_answer := FileUtil.get_file_name_from_path_no_extension(path)
		question.correct_answer = correct_answer
		
		question.answer_options = get_answer_options(correct_answer, all_possible_answers, Config.ANSWER_OPTIONS_COUNT)
		
		game.questions.append(question)
		
	game.questions.shuffle()
	return game

func get_answer_options(correct_answer:String, all_possible_answers: Array, count: int) -> Array:
		
	var all_possible_answers_copy := all_possible_answers.duplicate()
	all_possible_answers_copy.remove(all_possible_answers_copy.find(correct_answer))
	all_possible_answers_copy.shuffle()
	
	var answers := []
	answers.append(correct_answer)
	
	for i in count - 1:
		answers.append(all_possible_answers_copy[i])
	
	answers.shuffle()
	return answers

func get_all_possible_answers(question_paths: Array) -> Array:
	
		var possible_answers := []
		
		for question_path in question_paths:
			var path := question_path as String
			possible_answers.append(FileUtil.get_file_name_from_path_no_extension(path))
			
		return possible_answers

