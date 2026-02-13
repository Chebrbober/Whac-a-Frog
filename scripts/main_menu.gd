extends Node2D

var button_type = null

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	button_type = "play"
	$FadeTransition.show()
	$FadeTransition/Timer.start()
	$FadeTransition/AnimationPlayer.play("fade_in")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_timer_timeout() -> void:
	if button_type == "play":
		get_tree().change_scene_to_file("res://scenes/desk.tscn")