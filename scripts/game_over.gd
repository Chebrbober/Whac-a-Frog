extends Control

@onready var title: Label = $CenterContainer/VBoxContainer/Title
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hide()

func open():
	get_tree().paused = true
	show()
	if anim_player:
		anim_player.play("blur")

func _on_home_pressed() -> void:
	get_tree().paused = false
	FadeTransition.travel_to_scene("res://scenes/main_menu.tscn")

func _on_restart_pressed() -> void:
	get_tree().paused = false
	FadeTransition.travel_to_scene("res://scenes/desk.tscn")