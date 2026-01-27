extends CanvasLayer


func _input(event: InputEvent) -> void:

	if event.is_action_released("pause"):
		if get_tree().paused:
			unpause()
		else:
			pause()

func pause():
	get_tree().paused = true
	var pause_screen = Global.settings.pause_scene.instantiate()
	add_child(pause_screen)
	
func unpause():
	get_tree().paused = false
	get_child(0).queue_free()
