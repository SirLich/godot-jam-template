@tool
extends EditorPlugin
class_name Clamor

static var _settings_path = "addons/clamor/settings-path"
const SoundToolbarInspectorPlugin = preload("uid://ch6cgsswgflbf")
const CreateSoundsContextMenuPlugin = preload("uid://dxhh1jawtmivd")

var sound_toolbar_inspector_plugin : EditorInspectorPlugin
var create_sounds_context_menu_plugin : EditorContextMenuPlugin

func _enter_tree() -> void:
	sound_toolbar_inspector_plugin = SoundToolbarInspectorPlugin.new()
	create_sounds_context_menu_plugin = CreateSoundsContextMenuPlugin.new()

	add_inspector_plugin(sound_toolbar_inspector_plugin)
	add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_FILESYSTEM, create_sounds_context_menu_plugin)
	
	Clamor.initialize_settings()

func _exit_tree() -> void:
	if is_instance_valid(sound_toolbar_inspector_plugin):
		remove_inspector_plugin(sound_toolbar_inspector_plugin)
		sound_toolbar_inspector_plugin = null
		
	if is_instance_valid(create_sounds_context_menu_plugin):
		remove_context_menu_plugin(create_sounds_context_menu_plugin)
		create_sounds_context_menu_plugin = null
		
static func initialize_settings():
	print("Initializing Clamor!")
	print(Clamor._settings_path)
	if !ProjectSettings.has_setting(_settings_path):
		print("Settings added.")
		ProjectSettings.set_setting(Clamor._settings_path, "")
	ProjectSettings.set_initial_value(Clamor._settings_path, "")
	ProjectSettings.add_property_info({
		"name": Clamor._settings_path,
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_FILE,
		"hint_string": "*.tres"
	})
	

static func get_settings() -> ClamorSettings:
	var settings_path = ProjectSettings.get_setting(Clamor._settings_path) as String
	if settings_path.is_empty():
		push_error("Settings path is empty. Assign in Project settings.")
		return ClamorSettings.new()
	
	if not FileAccess.file_exists(settings_path):
		push_error("Settings path is ill-defined.")
	
	var settings = load(settings_path)
	if settings:
		return settings
	push_error("Clamor settings couldn't be loaded")
	return ClamorSettings.new()
	
