@tool

extends EditorProperty

const SOUND_TOOLBAR = preload("uid://bfg02p5mw772")

var control : Control
	
func _enter_tree() -> void:
	label = ""
	set_label_reference(Control.new())
	draw_label = false
	control = SOUND_TOOLBAR.instantiate()
	control.configure(get_edited_object())
	
	add_child(control)
	set_bottom_editor(control)

func _exit_tree() -> void:
	remove_child(control)
