extends CanvasLayer


@onready var text_label: RichTextLabel = $Control/NinePatchRect/MarginContainer/RichTextLabel
@onready var timer: Timer = $Control/Timer

@export var seconds_per_character: float = 0.03

func _ready() -> void:
	# Connect the timer's timeout signal to our function programmatically
	timer.timeout.connect(_on_timer_timeout)
	
	# Example usage
	display_text("Hello, adventurer! This typewriter effect is powered strictly by a Timer node.")


func display_text(new_text: String) -> void:
	# 1. Set the full text layout immediately
	text_label.text = new_text
	text_label.visible_characters = 0
	
	# 2. Start the loop if the string isn't empty
	if new_text.length() > 0:
		timer.start(seconds_per_character)


func _on_timer_timeout() -> void:
	# Increment visible characters by 1
	text_label.visible_characters += 1
	
	# If there are still characters left to show, restart the timer
	if text_label.visible_characters < text_label.text.length():
		timer.start(seconds_per_character)
	else:
		timer.stop()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		# If the timer is still running, text is still typing
		if not timer.is_stopped():
			timer.stop()
			text_label.visible_characters = text_label.text.length()
		else:
			print("Proceed to next line...")
