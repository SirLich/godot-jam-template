@tool

extends EditorContextMenuPlugin

const SOUND_CONTAINER_ICON = preload("uid://b0438x8ymurdn")
const SOUND_ICON = preload("uid://ccsr3d0yurota")

func create_sound(args : Array[String]):
	var sound = Sound.new()
	var stream = get_streams(args)[0] as AudioStream
	sound.stream = stream
	
	var base_path = args[0]
	var root = base_path.get_base_dir()
	var resource_name = base_path.get_file().get_basename().to_pascal_case()
	var resource_path = "%s/%sSound.tres" % [root, resource_name]
	
	if FileAccess.file_exists(resource_path):
		EditorInterface.get_editor_toaster().push_toast("Cannot create Sound: File already exists.", EditorToaster.SEVERITY_WARNING)
		return
		
	ResourceSaver.save(sound, resource_path)

func create_sound_container(args : Array[String]):
	var container = SoundContainer.new()
	var streams = get_streams(args)
	container.streams.append_array(streams)
	
	var base_path = args[0]
	var root = base_path.get_base_dir()
	var resource_name = base_path.get_file().get_basename().to_pascal_case()
	var resource_path = "%s/%sSound.tres" % [root, resource_name]
	
	if FileAccess.file_exists(resource_path):
		EditorInterface.get_editor_toaster().push_toast("Cannot create sound container: File already exists.", EditorToaster.SEVERITY_WARNING)
		return
		
	ResourceSaver.save(container, resource_path)
	
func get_streams(paths: Array[String]) -> Array[AudioStream]:
	var streams : Array[AudioStream]
	for path in paths:
		if not FileAccess.file_exists(path):
			continue
			
		var result = ResourceLoader.load(path)
		if result is AudioStream:
			streams.append(result)
	return streams
	
func has_any_streams(paths: PackedStringArray) -> bool:
	for path in paths:
		if not FileAccess.file_exists(path):
			continue
			
		var result = ResourceLoader.load(path)
		if result is AudioStream:
			return true
	return false
		
func _popup_menu(paths: PackedStringArray) -> void:
	if not has_any_streams(paths):
		return
		
	if paths.size() == 1:
		add_context_menu_item(&"Create Sound...", create_sound, SOUND_ICON)
	else:
		add_context_menu_item(&"Create Sound Container...", create_sound_container, SOUND_CONTAINER_ICON)
