extends Node2D

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var state_machine = anim_tree.get("parameters/playback")
@export var is_busy: bool = false
@export var id: int = 1

var is_leaving: bool = false
signal frog_hurted
signal frog_escaped

func set_speed(value: float):
	anim_tree.set("parameters/InOut/TimeScale/scale", value)

func play_in_out():
	state_machine.travel("InOut", true)

func play_hurted_out():
	state_machine.travel("HurtedOut", true)
	shake_once(0.4, 0.6)
	frog_hurted.emit()

func _on_in_out_finished() -> void:
	frog_escaped.emit()

func shake_once(duration: float, strength: float):
	# Создаем локальный Tween (он удалится сам после завершения)
	var tween = create_tween()
	var start_pos = position
	
	# Делаем 4 быстрых рывка в случайные стороны
	for i in range(4):
		var offset = Vector2(randf_range(-strength, strength), randf_range(-strength, strength))
		tween.tween_property(self, "position", start_pos + offset, duration / 8.0)
		tween.tween_property(self, "position", start_pos, duration / 8.0)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if is_leaving == true: return
	elif event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				play_hurted_out()