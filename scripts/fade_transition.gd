extends CanvasLayer

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func travel_to_scene(path_to_scene) -> void:
	get_tree().get_root().set_disable_input(true)
	anim_player.play('fade')
	await anim_player.animation_finished

	get_tree().change_scene_to_file(path_to_scene)
	anim_player.play_backwards('fade')
	await anim_player.animation_finished

	get_tree().get_root().set_disable_input(false)
	
