extends Control
class_name BasePanel

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hide()
	if anim_player:
		anim_player.play("RESET")

func open():
	show()
	if anim_player:
		anim_player.play("blur")

func close():
	if anim_player:
		anim_player.play_backwards("blur")
	if anim_player and anim_player.is_playing():
		await anim_player.animation_finished
	hide()

func handle_escape():
	if Input.is_action_just_pressed("Escape"):
		if is_visible_in_tree():
			close()

func _process(delta: float) -> void:
	handle_escape()
