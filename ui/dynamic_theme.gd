@tool

extends Theme
class_name DynamicTheme

@export_tool_button("Update", "Callable") var update_button = update
@export var primary_color : Color

## The background color 
@export var background_color : Color
@export var foreground_color : Color

@export var header_font : FontFile
@export var primary_font : FontFile

@export var label_settings : LabelSettings

@export var header_font_size : int
@export var subheader_font_size : int
@export var body_font_size : int

## The stylebox of background elements. Like Panels.
@export var background_stylebox : StyleBoxFlat

## The stylebox of elements, like the background of LineEdit, or Buttons.
@export var element_stylebox : StyleBoxFlat

@export_group("Elements")
## The lightening/darkening of elements bg when hovered/activated: +lighten, -darken
@export_range(-1.0, 1.0) var hover_bg_difference : float = 0.15
@export var hover_border_change : int



func update():
	if not element_stylebox:
		element_stylebox = StyleBoxFlat.new()
	if not background_stylebox:
		background_stylebox = StyleBox.new()
	
	set_type_variation("Header", "Label")
	set_font_size("font_size", "Header", header_font_size)
	
	# Background Stylebox
	background_stylebox.bg_color = background_color
	
	var element_stylebox_hover = element_stylebox.duplicate_deep() as StyleBoxFlat
	if hover_bg_difference > 0:
		element_stylebox_hover.bg_color = element_stylebox_hover.bg_color.lightened(hover_bg_difference)
	else:
		element_stylebox_hover.bg_color = element_stylebox_hover.bg_color.darkened(abs(hover_bg_difference))
		
	element_stylebox_hover.set_border_width_all(element_stylebox.get_border_width_min() + hover_border_change)
	
	# Properties
	set_color("font_color", "Label", primary_color)
	set_stylebox("panel", "Panel", background_stylebox)
	set_stylebox("panel", "PanelContainer", background_stylebox)
	
	set_stylebox("normal", "Button", element_stylebox)
	set_stylebox("hover", "Button", element_stylebox_hover)
