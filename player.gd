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


func stop_movement() -> void:
	player_controlled = false
	velocity = Vector2.ZERO
