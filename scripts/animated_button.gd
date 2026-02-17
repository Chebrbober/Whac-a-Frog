extends TextureButton
class_name AnimatedTextureButton 

@export_category("Transition Settings")
@export var ease_type: Tween.EaseType = Tween.EaseType.EASE_OUT
@export var trans_type: Tween.TransitionType = Tween.TransitionType.TRANS_EXPO

@export_category("Hover")
@export var hover_scale: Vector2 = Vector2(1.15,1.15)
@export var hover_duration: float = 0.2
@export var un_hover_duration: float = 0.2

@export_category("press")
@export var press_scale: Vector2 = Vector2(0.95, 0.95)
@export var press_animation_duration_1: float = 0.2
@export var press_animation_duration_2: float = 0.2

var animation_tween: Tween

func _ready() -> void:
	pressed.connect(_button_press)

	mouse_entered.connect(_button_hover)
	mouse_exited.connect(_button_un_hover)	

	pivot_offset_ratio = Vector2.ONE / 2.0

func _button_press() -> void:
	if animation_tween:
		animation_tween.kill()
	animation_tween = create_tween().set_trans(trans_type).set_ease(ease_type)

	animation_tween.tween_property(self, "scale", press_scale, press_animation_duration_1)
	animation_tween.chain().tween_property(self, "scale", hover_scale, press_animation_duration_2)

func _button_hover() -> void:
	if animation_tween:
		animation_tween.kill()
	animation_tween = create_tween().set_trans(trans_type).set_ease(ease_type)
	animation_tween.tween_property(self, "scale", hover_scale, hover_duration)

func _button_un_hover() -> void:
	if animation_tween:
		animation_tween.kill()
	animation_tween = create_tween().set_trans(trans_type).set_ease(ease_type)
	animation_tween.tween_property(self, "scale", Vector2.ONE, un_hover_duration)