extends Node


const PLAYER_SCENE := "res://player.tscn"
var player = load(PLAYER_SCENE).instantiate()


func _ready() -> void:
	add_player_at_position()
	Transition.fade_in(0.25)


func add_player_at_position(_pos := Vector2.ZERO) -> void:
	if _pos == Vector2.ZERO:
		_pos = get_tree().current_scene.start_position
	player.position = _pos
	get_tree().current_scene.add_child(player)


func teleport_player_to_position(pos) -> void:
	get_tree().paused = true
	await Transition.fade_out()
	player.position = pos
	await Transition.fade_in()
	get_tree().paused = false


func teleport_player_to_map(map: String, _pos) -> void:
	# Note: The change_scene_to_file method will delete the player node.
	# To avoid this, we need to manually change the scene.
	get_tree().paused = true
	await Transition.fade_out()
	
	var root = get_tree().root
	var current_scene = get_tree().current_scene
	
	# Remove the player first
	if player.get_parent():
		player.get_parent().remove_child(player)
	
	# Free the old scene entirely
	current_scene.queue_free()
	
	# Load the new scene
	var new_scene = load(map).instantiate()
	
	# Add the new scene back into root. Be sure to set the new scene
	# as the tree's current scene.
	root.add_child(new_scene)
	get_tree().current_scene = new_scene

	# Add the player back into the scene
	player.position = _pos
	new_scene.add_child(player)
	
	await Transition.fade_in()
	get_tree().paused = false
