extends CanvasLayer

func fadeTransition(target: PackedScene, speed:float=1) -> void:
	$AnimationPlayer.play("slide")
	$AnimationPlayer.speed_scale = speed*2
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(target)
	$AnimationPlayer.play_backwards("slide")
