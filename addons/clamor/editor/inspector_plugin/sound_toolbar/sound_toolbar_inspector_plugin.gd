@tool

extends EditorInspectorPlugin

const SoundToolbarEditorProperty = preload("uid://djnyk1wx284ur")
const SOUND_TOOLBAR = preload("uid://bfg02p5mw772")

func _can_handle(object: Object) -> bool:
	return true

func _parse_begin(object: Object) -> void:
	if object is Sound:
		var control = SOUND_TOOLBAR.instantiate()
		control.configure(object)

		add_custom_control(control)
		
func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:		
	if name == "clamor_toolbar_section":
		var control = SoundToolbarEditorProperty.new()
		add_property_editor(name, control)
		return true

	return false
