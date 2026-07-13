extends Node


signal transition_finished


func fade_in(_speed_scale := 1.0) -> void:
	$Fade/AnimationPlayer.play("fade_in", -1, _speed_scale, false)
	await $Fade/AnimationPlayer.animation_finished
	transition_finished.emit()


func fade_out(_speed_scale := 1.0) -> void:
	$Fade/AnimationPlayer.play("fade_in", -1, -1 * _speed_scale, true)
	await $Fade/AnimationPlayer.animation_finished
	transition_finished.emit()
