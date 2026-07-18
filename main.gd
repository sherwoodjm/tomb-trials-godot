extends Node


const PLAYER_SCENE := "res://player.tscn"
var player = load(PLAYER_SCENE).instantiate()
var game_total_time: float = 0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	player.position = get_tree().current_scene.start_position
	get_tree().current_scene.add_child(player)
	Transition.fade_in(0.25)


func _process(delta: float) -> void:
	game_total_time += delta
	
	# Pause the game when $Dialogue is visible
	if $Dialogue.visible:
		if get_tree().paused == false:
			get_tree().paused = true
	else:
		if get_tree().paused == true:
			get_tree().paused = false


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_pause"):
		if $Dialogue.visible:
			hide_dialogue()
		else:
			$Dialogue.text = "Paused."
			show_dialogue()


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


func show_dialogue(_data := {}) -> void:
	if _data.has("text"):
		$Dialogue.text = _data.text
	$Dialogue.show()


func hide_dialogue() -> void:
	$Dialogue.hide()


func get_game_time() -> String:
	var total_seconds_int: int = int(game_total_time)
	@warning_ignore("integer_division")
	var hour: int = total_seconds_int / 3600
	@warning_ignore("integer_division")
	var minute: int = (total_seconds_int % 3600) / 60
	var second: int =  total_seconds_int % 60
	return "%02d:%02d:%02d" % [hour, minute, second]
