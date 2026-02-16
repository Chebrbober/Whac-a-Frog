extends Control
class_name BasePanel

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var close_btn: TextureButton = $Control/Close
@onready var panel_container: PanelContainer = $PanelContainer

func _ready() -> void:
	hide()
	if anim_player:
		anim_player.play("RESET")
	close_btn.set_position(Vector2.ZERO)
	close_btn.position = Vector2(panel_container.position.x + panel_container.size.x - (close_btn.size.x / 2), panel_container.position.y - (close_btn.size.y / 2))
	print(close_btn.position)
	

func open():
	show()
	if anim_player:
		anim_player.play("blur")
		if close_btn.is_connected("pressed", Callable(self, "close")) == false:
			close_btn.pressed.connect(close)

func close():
	if anim_player:
		anim_player.play_backwards("blur")
	if anim_player and anim_player.is_playing():
		await anim_player.animation_finished
	hide()
