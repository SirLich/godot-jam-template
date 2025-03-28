extends Transition
class_name FadeTransition

@export var fade_color : Color
@export var fade_in_time = 2.0
@export var fade_out_time = 2.0
@export var fade_scene : PackedScene

func start_transition(old_scene : Node, fade_slot : Node, scene_slot : Node, new_scene : PackedScene):
	var tree = old_scene.get_tree()
	
	var active_fade = fade_scene.instantiate()
	fade_slot.add_child(active_fade)
	
	var fade_out_tween = tree.create_tween()
	fade_out_tween.tween_property(active_fade, "color", fade_color, fade_out_time)

	await fade_out_tween.finished

	SceneManager.change_to_packed(new_scene)
	
	var fade_in_tween = tree.create_tween()
	fade_in_tween.tween_property(active_fade, "color", Color(0, 0, 0, 0), fade_in_time)

	await fade_in_tween.finished
	active_fade.queue_free()
