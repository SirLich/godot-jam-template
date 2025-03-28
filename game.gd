extends Node
class_name Game

@export var default_scene : PackedScene

@export_group("Nodes")
@export var scene_slot : Node
@export var transition_slot : Node

func _ready() -> void:
	SceneManager.change_to_packed(default_scene)
