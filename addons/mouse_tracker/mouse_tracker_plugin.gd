@tool
extends EditorPlugin

var label: Label
var viewport_2d

func _enter_tree() -> void:
	# Create and format the floating label
	label = Label.new()
	label.text = "Screen Pixel: (0, 0)"
	label.add_theme_color_override("font_color", Color.CYAN)
	
	# Fetch the actual 2D viewport container node
	viewport_2d = get_editor_interface().get_editor_viewport_2d()
	
	# Attach label to the base editor so it doesn't move when panning the scene
	var editor_base = get_editor_interface().get_base_control()
	editor_base.add_child(label)
	label.global_position = Vector2(25, 85)

func _exit_tree() -> void:
	# Clean up UI elements on plugin removal
	if is_instance_valid(label):
		label.queue_free()

func _process(_delta: float) -> void:
	# Only run when the user is actively looking at the 2D workspace
	if is_instance_valid(viewport_2d) and viewport_2d.is_visible_in_tree():
		label.show()
		
		# Get the mouse pixel position relative to the 2D viewport frame
		var local_pixel_pos = viewport_2d.get_local_mouse_position()
		
		# Ensure coordinates read (0,0) exactly at the top-left corner of the workspace window
		label.text = "Screen Pixel: %s" % str(local_pixel_pos.round())
	else:
		label.hide()
