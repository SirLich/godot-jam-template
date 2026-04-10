extends Resource
class_name ThemeOverride

## A tint to apply to the override
@export var tint : Color = Color.WHITE
## Grow/shrink the stylebox
@export var grow : int 
## Darken or lighten. Applied on top of the tint, if specified
@export_range(-1.0, 1.0) var lighten : float

@export var font_tint : Color = Color.WHITE
@export_range(-1.0, 1.0) var font_lighten : float
