extends BasePanel 


func _process(delta: float) -> void:
	handle_escape()

func open() -> void:
	get_tree().paused = true
	super.open()

func resume():
	get_tree().paused = false
	super.close()

func _on_home_pressed() -> void:
	get_tree().paused = false
	FadeTransition.travel_to_scene("res://scenes/main_menu.tscn")

func _on_resume_pressed() -> void:
	resume()	

func handle_escape():
	if Input.is_action_just_released("Escape"):
		if not is_visible_in_tree():
			open()
		else:
			resume()
		
