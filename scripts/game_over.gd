extends Control

@onready var title: Label = $VBoxContainer/Title
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var restart_button: TextureButton = $VBoxContainer/HBoxContainer/Restart
@onready var home_button: TextureButton = $VBoxContainer/HBoxContainer/Home

var tween: Tween

func open(text: String) -> void:
	get_tree().paused = true
	show()
	title.text = text
	if anim_player:
		anim_player.play("appear")

func pop_up(node_path: NodePath) -> void:
	if tween:
		tween.kill()

	var object = get_node(node_path) as Control
	object.modulate = Color(1, 1, 1, 1)
	pivot_offset = object.get_rect().size / 2
	object.scale = Vector2.ZERO

	tween = create_tween().set_trans(Tween.TransitionType.TRANS_EXPO).set_ease(Tween.EaseType.EASE_IN_OUT)
	tween.tween_property(object, "scale", Vector2.ONE, 0.2).from(Vector2.ZERO)

func _on_home_pressed() -> void:
	FadeTransition.travel_to_scene("res://scenes/main_menu.tscn")

func _on_restart_pressed() -> void:
	FadeTransition.travel_to_scene("res://scenes/desk.tscn")
