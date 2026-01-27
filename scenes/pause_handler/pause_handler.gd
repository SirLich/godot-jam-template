extends CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action_released("pause"):
		var pause_screen = Global.settings.pause_scene.instantiate()
		add_child(pause_screen)
