extends Node2D

@onready var select_difficulty_panel: Control = $CanvasLayer/SelectDifficultyPanel


func _on_play_pressed() -> void:
	select_difficulty_panel.open()

func _on_quit_pressed() -> void:
	get_tree().quit()

