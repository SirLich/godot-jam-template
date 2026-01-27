extends Control

@export var continue_button: TextureButton
@export var main_menu_button: TextureButton

func _ready() -> void:
	continue_button.pressed.connect(on_continue_pressed)
	main_menu_button.pressed.connect(on_main_menu_pressed)

func on_continue_pressed():
	get_parent().unpause()
	
func on_main_menu_pressed():
	get_parent().unpause()
	SceneManager.change_to_packed_with_default_transition(Global.settings.main_menu_scene)
