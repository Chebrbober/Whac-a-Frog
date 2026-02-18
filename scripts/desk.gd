extends Node2D

@export var frog_scene: PackedScene
@export var max_lives: int = 3 

@onready var timer: Timer = $Timer
@onready var score_label: Label = $ScoreLabel
@onready var pause_panel: Control = $CanvasLayer/PausePanel
@onready var game_over: Control = $CanvasLayer/GameOver

@onready var heart1: TextureRect = $CanvasLayer/HBoxContainer/TextureRect
@onready var heart2: TextureRect = $CanvasLayer/HBoxContainer/TextureRect2
@onready var heart3: TextureRect = $CanvasLayer/HBoxContainer/TextureRect3

var limit_wait_time: float = 1.1 
var current_speed: float = 1.0
var speed_step: float = 0.1
var frog_array: Array = []
var win_score: int = 0
var hearts: Array = []
var score: int = 0
var lives: int = 3

func _ready() -> void:
	hearts = [heart1, heart2, heart3]
	lives = max_lives

	update_hearts()

	if timer == null: return

	var config = GameSettings.current_config
	
	limit_wait_time = config["limit_wait_time"]
	timer.wait_time = config["wait_time"]
	current_speed = config["speed"]
	speed_step = config["speed_step"]
	win_score = config["win_score"]

	timer.autostart = true
	timer.start() 
	
	print("Игра готова. Таймер запущен с интервалом: ", timer.wait_time)
	
	spawn_frogs()

func spawn_frogs():
	var columns: int = 3
	var rows: int = 2
	var spacing_x: int = 60
	var spacing_y: int = 40
	var start_pos: Vector2 = Vector2(130, 120)

	for row in range(rows):
		for col in range(columns):
			var new_frog = frog_scene.instantiate()
			new_frog.frog_hurted.connect(_on_frog_hurted)
			new_frog.frog_escaped.connect(_on_frog_escaped)
			add_child(new_frog)
			new_frog.position = start_pos + Vector2(col*spacing_x, row*spacing_y)
			frog_array.append(new_frog)

	print("Лягушки расставлены. Всего: ", frog_array.size())

func _on_timer_timeout() -> void:
	print("--- ТАЙМЕР СРАБОТАЛ ---") # Этот текст ДОЛЖЕН появиться
	
	var free_frogs = frog_array.filter(func(f): return f.is_busy == false)
	
	if free_frogs.size() > 0:
		var selected_frog = free_frogs.pick_random()
		print("Выбрана лягушка для появления")
		selected_frog.set_speed(current_speed)
		selected_frog.play_in_out()
	else:
		print("Все лягушки заняты, ждем...")

	if timer.wait_time > limit_wait_time:
		timer.wait_time -= speed_step
		print("Новое время ожидания: ", timer.wait_time)
		current_speed += speed_step 

func _on_frog_hurted() -> void:
	score += 1
	if score == win_score:
		score_label.text = str(score) + "/" + str(win_score)
		game_won()

func _on_frog_escaped():
	lives -=1
	update_hearts()

	if lives <= 0:
		game_lost()

func update_hearts():
	for i in range(hearts.size()):
		if hearts[i] != null:
			hearts[i].visible = i <lives

func game_lost():
	game_over.open("You lost!")

func game_won():
	game_over.open("You won!")

func _on_pause_pressed() -> void:
	pause_panel.open()

func _process(delta: float) -> void:
	score_label.text = str(score) + "/" + str(win_score)
