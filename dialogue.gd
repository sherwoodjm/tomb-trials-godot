extends CanvasLayer


var can_clear := true

var text:
	set(val):
		label.text = val
		$Timer.start(0.4)
		can_clear = false
	get:
		return label.text

@onready var label := $Control/NinePatchRect/MarginContainer/RichTextLabel


func _on_timer_timeout() -> void:
	can_clear = true


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_interact"):
		if can_clear:
			Main.hide_dialogue()
