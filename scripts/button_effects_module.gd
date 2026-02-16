extends Node
class_name ButtonEffectsModule

@export var ease_type: Tween.EaseType = Tween.EaseType.EASE_OUT
@export var trans_type: Tween.TransitionType = Tween.TransitionType.TRANS_EXPO
@export var anim_duration: float = 0.2
@export var scale_amount: Vector2 = Vector2(1.1,1.1)

@onready var button: TextureButton = get_parent()

var tween: Tween

func _ready() -> void:
	button.mouse_entered.connect(_on_mouse_hovered.bind(true))
	button.mouse_exited.connect(_on_mouse_hovered.bind(false))
	button.pivot_offset_ratio = Vector2(0.5, 0.5)

func _on_mouse_hovered(hovered: bool) -> void:
	reset_tween()	
	tween.tween_property(button, "scale", 
		scale_amount if hovered else Vector2.ONE, anim_duration)

func reset_tween() -> void:
	if tween: tween.kill()
	tween = create_tween().set_ease(ease_type).set_trans(trans_type).set_parallel(true)
