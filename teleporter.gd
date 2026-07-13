extends Area2D


@export var destination_position := Vector2.ZERO
@export_file_path("*.tscn") var destination_map := ""

var teleport_active := true

@onready var _collision_shape := $CollisionShape2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and teleport_active and _collision_shape:
		if destination_map == "":
			Main.teleport_player_to_position(destination_position)
		else:
			teleport_active = false
			Main.teleport_player_to_map(destination_map, destination_position)
