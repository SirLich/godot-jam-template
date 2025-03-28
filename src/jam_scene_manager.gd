extends Node

func _get_active_scene() -> Node:
	return _get_scene_slot().get_child(0)
	
func _get_active_transition() -> Node:
	if _get_transition_slot().get_child_count():
		return _get_transition_slot().get_child(0)
	return null
	
func _get_scene_slot() -> Node:
	return get_tree().get_current_scene().scene_slot
	
func _get_transition_slot() -> Node:
	return get_tree().get_current_scene().transition_slot
	
func change_to_packed(packed_scene : PackedScene):
	var slot = _get_scene_slot()
	for child in slot.get_children():
		child.queue_free()
		
	var new_scene = packed_scene.instantiate()
	slot.add_child(new_scene)

func change_to_packed_with_default_transition(packed_scene : PackedScene):
	change_to_packed_with_transition(packed_scene, Global.settings.default_scene_transition)
	
## Changes to a packed scene, with a transition. Transition should be a packed scene
## in which the root node is a Transition
func change_to_packed_with_transition(packed_scene : PackedScene, transition : Transition):
	transition.start_transition(_get_active_scene(), _get_transition_slot(), _get_scene_slot(), packed_scene)
