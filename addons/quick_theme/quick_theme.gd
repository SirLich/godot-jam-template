@tool

extends Theme
class_name QuickTheme

## Sets theme properties based on your selection. For example it will clone
## your button stylebox, in order to create hover/disabled/clicked variants.
## Will NOT clear stale properties. Consider calling clear_all
@export_tool_button("Update", "Callable") var update_button = update

## Removes all properties from the theme. Consider pressing 'Update' after this
## to re-calculate everything.
@export_tool_button("Clear All", "Callable") var clear_all_button = clear_all

## Clears only the properties set by the quick-theme itself, preserving anything that was custom set
## in the theme. 
## Quick theme controls stuff like: Styleboxoes for panels and buttons, margins, fonts, etc.
@export_tool_button("Clear Quick Theme Properties", "Callable") var clear_button = clear_quick_theme

@export var font_color : Color

## The stylebox of background elements. Like Panels.
@export var background_stylebox : StyleBoxFancy

## The stylebox of elements, like the background of LineEdit, or Buttons.
@export var button_stylebox : StyleBoxFancy

@export var foreground_stylebox : StyleBoxFancy

@export var hover_override : QuickThemeOverride
@export var select_override : QuickThemeOverride
@export var disabled_override : QuickThemeOverride
@export var margin_left_right : Vector2i
@export var margin_up_down : Vector2i

@export_group("Hidden Serialization Data")
@export var constant_properties : Array[PropertyIdentifier]
@export var color_properties : Array[PropertyIdentifier]
@export var stylebox_properties : Array[PropertyIdentifier]

class PropertyIdentifier extends Resource:
	@export var name : String
	@export var theme_type : String

	static func create(name_ : String, theme_type_: String) -> PropertyIdentifier:
		var new_prop := PropertyIdentifier.new()
		new_prop.name = name_
		new_prop.theme_type = theme_type_
		return new_prop
	
func get_font_color(override : QuickThemeOverride) -> Color:
	if !override:
		print("Override is null")
		return font_color
	return get_color_override(font_color, override.font_tint, override.font_lighten)
	
func get_color_override(color: Color, tint: Color, lighten: float):
	var result = color
	
	if tint != Color.WHITE:
		result = tint
		
	if lighten > 0:
		result = result.lightened(lighten)
	else:
		result = result.darkened(abs(lighten))
	return result

func create_stylebox_override(base : StyleBoxFancy, override : QuickThemeOverride) -> StyleBoxFancy:
	var result = base.duplicate_deep() as StyleBoxFancy
	
	if not override:
		return result
	
	result.color = get_color_override(result.color, override.tint, override.lighten)

	result.set_expand_margin_all(override.grow)
	return result

func clear_all():
	clear()

func clear_quick_theme():
	for prop in constant_properties:
		clear_constant(prop.name, prop.theme_type)
	for prop in stylebox_properties:
		clear_stylebox(prop.name, prop.theme_type)
	for prop in color_properties:
		clear_color(prop.name, prop.theme_type)
	
	clear_tracked_property_cache()

func clear_tracked_property_cache():
	constant_properties.clear()
	stylebox_properties.clear()
	color_properties.clear()
	
func set_tracked_constant(name: StringName, theme_type: StringName, constant: int):
	constant_properties.append(PropertyIdentifier.create(name, theme_type))
	set_constant(name, theme_type, constant)

func set_tracked_stylebox(name: StringName, theme_type: StringName, stylebox: StyleBox):
	stylebox_properties.append(PropertyIdentifier.create(name, theme_type))
	set_stylebox(name, theme_type, stylebox)
	
func set_tracked_color(name: StringName, theme_type: StringName, color: Color):
	color_properties.append(PropertyIdentifier.create(name, theme_type))
	set_color(name, theme_type, color)
	
func update():
	clear_tracked_property_cache()

	set_tracked_constant("margin_top", "MarginContainer", margin_up_down[0])
	set_tracked_constant("margin_bottom", "MarginContainer", margin_up_down[1])
	set_tracked_constant("margin_left", "MarginContainer", margin_left_right[0])
	set_tracked_constant("margin_right", "MarginContainer", margin_left_right[1])

	
	if not button_stylebox:
		button_stylebox = StyleBoxFancy.new()
	if not background_stylebox:
		background_stylebox = StyleBoxFancy.new()
	if not foreground_stylebox:
		foreground_stylebox = StyleBoxFancy.new()
	
	var button_stylebox_hover = create_stylebox_override(button_stylebox, hover_override)
	var button_stylebox_selected = create_stylebox_override(button_stylebox, select_override)
	var button_stylebox_disabled = create_stylebox_override(button_stylebox, disabled_override)

	var font_color_hover = get_font_color(hover_override)
	var font_color_selected = get_font_color(select_override)
	var font_color_disabled = get_font_color(disabled_override)

	# Properties
	set_tracked_color("font_color", "Label", font_color)
	
	set_tracked_color("font_color", "Button", font_color)
	set_tracked_color("font_hover_color", "Button", font_color_hover)
	set_tracked_color("font_pressed_color", "Button", font_color_selected)
	set_tracked_color("font_disabled_color", "Button", font_color_disabled)
	
	set_tracked_color("font_selected_color", "TabContainer", font_color)
	set_tracked_color("font_hovered_color", "TabContainer", font_color_hover)
	set_tracked_color("font_disabled_color", "TabContainer", font_color_disabled)
	
	set_tracked_color("font_color", "LineEdit", font_color)
	set_tracked_color("font_uneditable_color", "LineEdit", font_color_disabled)
	
	set_tracked_color("font_color", "TextEdit", font_color)
	set_tracked_color("font_readonly_color", "TextEdit", font_color_disabled)

	set_tracked_stylebox("panel", "Panel", background_stylebox)
	set_tracked_stylebox("panel", "PanelContainer", background_stylebox)
	
	set_tracked_stylebox("normal", "Button", button_stylebox)
	set_tracked_stylebox("hover", "Button", button_stylebox_hover)
	set_tracked_stylebox("pressed", "Button", button_stylebox_selected)
	set_tracked_stylebox("disabled", "Button", button_stylebox_disabled)
	
	var tab_container_panel = foreground_stylebox.duplicate_deep() as StyleBoxFancy
	tab_container_panel.set_corner_radius(Corner.CORNER_TOP_LEFT, 0)
	tab_container_panel.set_corner_radius(Corner.CORNER_TOP_RIGHT, 0)
	
	var tab_panel = foreground_stylebox.duplicate_deep() as StyleBoxFancy
	tab_panel.set_corner_radius(Corner.CORNER_BOTTOM_LEFT, 0)
	tab_panel.set_corner_radius(Corner.CORNER_BOTTOM_RIGHT, 0)
	
	set_tracked_stylebox("panel", "TabContainer", tab_container_panel)
	set_tracked_stylebox("tab_selected", "TabContainer", tab_panel)

	# Forground
	set_tracked_stylebox("normal", "TextEdit", foreground_stylebox)
	set_tracked_stylebox("panel", "PopupMenu", foreground_stylebox)
	set_tracked_stylebox("normal", "LineEdit", foreground_stylebox)
	
	var disabled_foreground = create_stylebox_override(foreground_stylebox, disabled_override)
	set_tracked_stylebox("read_only", "LineEdit", disabled_foreground)
	set_tracked_stylebox("read_only", "TextEdit", disabled_foreground)
	
