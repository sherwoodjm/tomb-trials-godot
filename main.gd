extends Node


const PLAYER_SCENE := "res://player.tscn"
var player = load(PLAYER_SCENE).instantiate()


func _ready() -> void:
	var pos = get_tree().current_scene.start_position
	add_player_at_position(pos)


func add_player_at_position(pos: Vector2) -> void:
	player.position = pos
	get_tree().current_scene.add_child(player)
