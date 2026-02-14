extends Control

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# Скрываем меню при старте и сбрасываем анимацию
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS # Убеждаемся, что код работает даже на паузе
	anim_player.play("RESET")

func resume():
	get_tree().paused = false
	anim_player.play_backwards("blur")
	# Ждем окончания анимации перед тем как спрятать узел
	await anim_player.animation_finished
	hide()

func pause():
	show()
	get_tree().paused = true
	anim_player.play("blur")

func testEsc():
	if Input.is_action_just_pressed("Escape"):
		if not get_tree().paused:
			pause()
		else:
			resume()

func _process(_delta: float) -> void:
	testEsc()

func _on_home_pressed() -> void:
	get_tree().paused = false # Обязательно снимаем паузу перед сменой сцены!
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_resume_pressed() -> void:
	resume()