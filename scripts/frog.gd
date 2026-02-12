extends Node2D

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var state_machine = anim_tree.get("parameters/playback")
@export var is_busy: bool = false
@export var id: int = 1

var is_leaving: bool = false
signal frog_hurted

func set_speed(value: float):
	anim_tree.set("parameters/InOut/TimeScale/scale", value)

func play_in_out():
	state_machine.travel("InOut", true)

func play_hurted_out():
	state_machine.travel("HurtedOut", true)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if is_leaving == true: return
	elif event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				play_hurted_out()
				emit_signal("frog_hurted")
