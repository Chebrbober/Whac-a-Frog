extends Node2D

@export var frog_scene: PackedScene
@onready var timer: Timer = $Timer
@onready var score_label: Label = $ScoreLabel

var current_speed: float = 1.0
var frog_array: Array = []
var score: int = 0

func _ready() -> void:
	$FadeTransition/AnimationPlayer.play("fade_out")
	if timer == null:
		return
	
	timer.wait_time = 2.0
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

	if timer.wait_time > 0.4:
		timer.wait_time -= 0.05
		print("Новое время ожидания: ", timer.wait_time)
		current_speed += 0.1

func _on_frog_hurted() -> void:
	score += 1
	score_label.text = str(score)
	print(score_label.text)
