extends Node2D

@export var column_down : PackedScene
@export var column_up : PackedScene
var file_path : String = "res://Scripts/max_score.json"
var state : bool = true
var time_since_last_spawn = 0.0
var spawn_interval = 3.0
var score : int = 0
var max_score : int = 0
@onready var Score = $HBoxContainer/Label2
@onready var Max_Score = $HBoxContainer/Label4
@onready var player = $player
var columns = []
func _ready() -> void:
	if FileAccess.file_exists(file_path):
		var file_load = FileAccess.open(file_path, FileAccess.READ)
		var max_score_json = file_load.get_var(max_score)
		if max_score_json == null:
			Max_Score.text = str(int(max_score))
		else:
			max_score = max_score_json
			Max_Score.text = str(int(max_score_json))

func _physics_process(delta: float) -> void:
	if state:
		time_since_last_spawn += delta
		
		if time_since_last_spawn >= spawn_interval:
			spawn_column()
			time_since_last_spawn = 0.0
		checked_columns()
	if !state:
		if max_score >= score:
			var file = FileAccess.open(file_path,FileAccess.WRITE)
			file.store_var(max_score)

func spawn_column():
	var column_Down = column_down.instantiate()
	var column_Up = column_up.instantiate()
	var position_rand = randi_range(100, 360)
	column_Down.position = Vector2(380, position_rand)
	column_Up.position = Vector2(380, position_rand + 180)
	get_tree().current_scene.add_child(column_Down)
	get_tree().current_scene.add_child(column_Up)
	
	columns.append(column_Down)

func checked_columns():
	for column in columns:
		if column.position.x < player.position.x:
			score += 1
			if max_score < score:
				max_score += 1
			update_score()
			columns.erase(column)

func update_score():
	Score.text = str(score)
	Max_Score.text = str(max_score)
