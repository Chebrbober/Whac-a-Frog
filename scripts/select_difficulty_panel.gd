extends BasePanel 

const GAME_SCENE = "res://scenes/desk.tscn"


func _on_hard_pressed() -> void:
	_start_game("hard")

func _on_medium_pressed() -> void:
	_start_game("medium")

func _on_easy_pressed() -> void:
	_start_game("easy")

func _start_game(difficulty_level: String):
	GameSettings.set_difficulty(difficulty_level)
	FadeTransition.travel_to_scene(GAME_SCENE)