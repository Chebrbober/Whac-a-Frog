extends BasePanel 


func open() -> void:
	get_tree().paused = true
	super.open()

func resume():
	get_tree().paused = false
	super.close()

func _on_home_pressed() -> void:
	FadeTransition.travel_to_scene("res://scenes/main_menu.tscn")

func _on_resume_pressed() -> void:
	resume()	

func _on_close_pressed() -> void:
	resume()
