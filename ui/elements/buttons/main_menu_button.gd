@tool

extends TextureButton

@export var label_text : String :
	set(new_value):
		label_text = new_value
		if label:
			label.text = label_text

@export var label_settings : LabelSettings : 
	set(new_value):
		label_settings = new_value
		if label:
			label.label_settings = label_settings

@export_group("Sounds")
@export var click_sound : AudioStream
@export var hover_start_sound : AudioStream
@export var hover_end_sound : AudioStream

@export_group("Private")
@export var label : Label 

func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	pressed.connect(on_pressed)
	
func on_mouse_exited():
	if hover_end_sound:
		SoundManager.play_ui_sound(hover_end_sound)
		
func on_mouse_entered():
	if hover_end_sound:
		SoundManager.play_ui_sound(hover_end_sound)
		
func on_pressed():
	if click_sound:
		SoundManager.play_ui_sound(click_sound)
