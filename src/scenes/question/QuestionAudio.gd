extends AudioStreamPlayer2D
class_name QuestionAudio

var audio_repeat_interval: float = 5
var pitch_scale_range: Vector2 = Vector2(0.8, 1.2)
var audio_repeat_timer: Timer

func _ready():
	Events.connect("load_question_media", self, "_on_load_question_audio")

func _on_load_question_audio(path_to_audio_file: String) -> void:
	var sfx: Resource = load(path_to_audio_file)
	.set_stream(sfx)
	start_audio()
	
func start_audio() -> void:
	play_question()

	if audio_repeat_timer == null:
		audio_repeat_timer = Timer.new()
		audio_repeat_timer.connect("timeout", self, "play_question")
		audio_repeat_timer.set_one_shot(false)
		add_child(audio_repeat_timer)

	audio_repeat_timer.set_wait_time(audio_repeat_interval + .get_stream().get_length())
	audio_repeat_timer.start()

func play_question() -> void:
	pitch_scale = rand_range(pitch_scale_range.x, pitch_scale_range.y)
	.play()
	