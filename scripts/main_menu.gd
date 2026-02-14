extends Node2D

var button_type = null

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	FadeTransition.travel_to_scene("res://scenes/desk.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
