extends Node


const PLAYER_SCENE := "res://player.tscn"
var player = load(PLAYER_SCENE).instantiate()


func _ready() -> void:
	player.position = get_tree().current_scene.start_position
	get_tree().current_scene.add_child(player)
	Transition.fade_in(0.25)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_interact"):
		if not Dialogue.visible:
			player.stop_movement()
			Dialogue.show()
			Dialogue.display_text("Hello world. This is an example of some dialogue happening.")
			
		#else:
			#Dialogue.hide()
			#player.player_controlled = true


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
