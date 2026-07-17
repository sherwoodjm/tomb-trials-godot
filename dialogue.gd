extends CanvasLayer


var controllable := true

@onready var label := $Control/NinePatchRect/MarginContainer/RichTextLabel


func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)


func _on_visibility_changed() -> void:
	if visible:
		get_tree().paused = true
		controllable = false
		$Timer.start(0.1)
	else:
		get_tree().paused = false
	


func set_text(text) -> void:
	label.text = text


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_interact"):
		if visible and controllable:
			print("Unpaused game!")


func _on_timer_timeout() -> void:
	controllable = true
