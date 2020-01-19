extends Node2D

onready var nav := $"/root/Game/Navigation2D" as Navigation2D
onready var path := $Path2D
onready var path_follow := $Path2D/PathFollow2D
onready var tween := $Tween
onready var last_global_position = self.global_position
onready var starting_postioin = self.global_position
onready var starting_rotation = self.global_rotation

var is_following_path := false
var animation_time := 3
var current_question: Question

func _ready():
	Events.connect("answer_selected", self, "_on_Events_answer_selected")
	Events.connect("new_question", self, "_on_Events_new_question")

func _process(delta: float):
	
	if is_following_path:
		if path_follow.unit_offset < 1:
			position = path_follow.position
			var rotation_target := global_position.angle_to_point(last_global_position)
			rotation = lerp(rotation, rotation_target, 0.05)
		else:
			is_following_path = false
			Events.emit_signal("question_complete")
			
	
	last_global_position = global_position

func get_navigation2d_node() -> Navigation2D:
		
	var current_node := get_parent()
	
	while !current_node is Navigation2D:
		current_node = get_parent()
	
	return current_node as Navigation2D
	
func _on_Events_answer_selected (answer: String, destination: Vector2) -> void:
	
	if answer == current_question.correct_answer:
		var start := global_position
		var path_points := nav.get_simple_path(start, destination)
		var curve := Curve2D.new()
		
		for point in path_points:
			curve.add_point(point)
			
		path.curve = curve
		path_follow.offset = 0
		
		tween.interpolate_property(path_follow, "unit_offset", 0, 1, animation_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
		
		is_following_path = true
	
func _on_Events_new_question(question: Question) -> void:
	current_question = question
	position = starting_postioin
	rotation = starting_rotation
	
