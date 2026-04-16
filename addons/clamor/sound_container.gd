@tool
@icon("uid://b0438x8ymurdn")
class_name SoundContainer extends Sound

enum SoundContainerType {
	## Plays truly randomly
	Random,
	## Plays all sounds randomly, before repeating
	RandomNoRepeats,
	## Plays each sound in sequence, then starts again at the beginning.
	Sequence,
	## Plays each sound in sequence, doesn't loop
	SequenceNoLoop ## TODO: How to handle this well in editor?
}

@export var container_type : SoundContainerType = SoundContainerType.RandomNoRepeats
@export var streams : Array[AudioStream]
var index = 0
var shuffled_indexes : Array[int] = []

func _validate_property(property: Dictionary) -> void:
	if property.name == "stream":
		property.usage = PROPERTY_USAGE_NO_EDITOR

func ensure_shuffled_indexes():
	if shuffled_indexes.size() != streams.size():
		index = 0
		shuffled_indexes.clear()
		for i in streams.size():
			shuffled_indexes.append(i)
		shuffled_indexes.shuffle()
	if index == shuffled_indexes.size():
		index = 0
		shuffled_indexes.shuffle()

func get_stream() -> AudioStream:
	if container_type == SoundContainerType.Random:
		return streams.pick_random()
	elif container_type == SoundContainerType.RandomNoRepeats:
		ensure_shuffled_indexes()
		var stream = streams[shuffled_indexes[index]]
		index += 1
		return stream
	elif container_type == SoundContainerType.Sequence:
		if index > streams.size()-1:
			index = 0
		var stream = streams[index]
		index += 1
		return stream
	elif container_type == SoundContainerType.SequenceNoLoop:
		if index > streams.size()-1:
			return null
		var stream = streams[index]
		index += 1
		return stream
		
	push_error("Something went wrong when getting stream. Was a new container type added?")
	return null
