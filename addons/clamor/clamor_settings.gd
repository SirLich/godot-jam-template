@tool

class_name ClamorSettings extends Resource

static func get_settings() -> ClamorSettings:
	return Clamor.get_settings()
	
@export var pool_size : int = 50
