extends CharacterBody2D


var player_controlled := true


func _physics_process(_delta: float) -> void:
	_process_movement()
	move_and_slide()


func _process_movement() -> void:
	if player_controlled:
		var spd = 120 if Input.is_action_pressed("key_cancel") else 60
		var dir = Input.get_vector("key_left", "key_right", "key_up", "key_down")
		
		velocity = spd * dir
		_update_raycast()


func _update_raycast() -> void:
	if velocity != Vector2.ZERO:
		$RayCast2D.target_position = velocity.normalized() * 16
		$RayCast2D.force_raycast_update()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_interact"):
		var collider = $RayCast2D.get_collider()
		if collider:
			if collider is TreasureChest and not collider.opened:
				collect_treasure(collider)


func stop_movement() -> void:
	player_controlled = false
	velocity = Vector2.ZERO


func collect_treasure(chest: TreasureChest) -> void:
	var text = "You got %d gold!" % chest.total_money
	chest.opened = true
	Global.money += chest.total_money
	Main.show_dialogue({
		"text": text,
	})
