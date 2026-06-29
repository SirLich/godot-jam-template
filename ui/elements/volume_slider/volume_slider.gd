@tool

extends HBoxContainer
class_name VolumeSlider

@export var bus_name : String
var bus_index : int

@export var label_text : String :
	set(new_value):
		label_text = new_value
		if label:
			label.text = label_text
			
@export_group("Private")
@export var label : Label
@export var slider : HSlider

func _ready() -> void:
	slider.value = Global.get_volume_preference(bus_name)
	bus_index = AudioServer.get_bus_index(bus_name)
	
	slider.value_changed.connect(on_volume_changed)
	
func on_volume_changed(new_value : float):
	Global.set_volume_preference(bus_name, new_value)
	AudioServer.set_bus_volume_linear(bus_index, new_value)
