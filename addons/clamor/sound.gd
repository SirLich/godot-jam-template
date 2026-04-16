@tool
@icon("uid://ccsr3d0yurota")

class_name Sound extends Resource

enum PolyphonicProfile {
	
}

@export var stream : AudioStream
@export_range(-40, 40, 0.01, "suffix:dB") var volume_offset_db : float = 0.0
@export_range(0, 40, 0.01, "suffix:dB") var random_volume_offset_db : float = 0.0
@export_range(0, 4, 0.001, "suffix:Semitones") var pitch_offset : float = 1
@export_range(0, 4, 0.01, "suffix:Semitones") var random_pitch_offset : float = 0.0


@export_category("Preview")

## Customized harness for sound toolbar editor
@export var clamor_toolbar_section : int
	
func get_stream() -> AudioStream:
	return stream
	
func get_volume() -> float:
	return volume_offset_db + randi_range(-random_volume_offset_db, random_volume_offset_db)

func get_pitch() -> float:
	return max(0.01, pitch_offset + randi_range(-random_pitch_offset, random_pitch_offset))
