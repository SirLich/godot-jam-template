extends Control
class_name MainMenu

@export var play_button : BaseButton
@export var settings_button : BaseButton
@export var credits_button : BaseButton
@export var exit_button: TextureButton


func _ready() -> void:
	play_button.pressed.connect(on_play_pressed)
	settings_button.pressed.connect(on_settings_pressed)
	credits_button.pressed.connect(on_credits_pressed)
	exit_button.pressed.connect(on_exit_pressed)

func on_play_pressed():
	SoundManager.play_music(Global.settings.game_music, 2.0)
	SceneManager.change_to_packed_with_default_transition(Global.settings.game_scene)
	
func on_settings_pressed():
	SceneManager.change_to_packed_with_default_transition(Global.settings.settings_scene)
	
func on_credits_pressed():
	SceneManager.change_to_packed_with_default_transition(Global.settings.credits_scene)
	
func on_exit_pressed():
	get_tree().quit()
