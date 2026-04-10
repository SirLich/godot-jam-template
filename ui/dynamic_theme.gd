@tool

extends Theme
class_name DynamicTheme

@export_tool_button("Update", "Callable") var update_button = update
@export var font_color : Color

## The stylebox of background elements. Like Panels.
@export var background_stylebox : StyleBoxFancy

## The stylebox of elements, like the background of LineEdit, or Buttons.
@export var element_stylebox : StyleBoxFancy

@export var foreground_stylebox : StyleBoxFancy

@export var hover_override : ThemeOverride
@export var select_override : ThemeOverride
@export var disabled_override : ThemeOverride

func get_font_color(override : ThemeOverride) -> Color:
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

func create_stylebox_override(base : StyleBoxFancy, override : ThemeOverride) -> StyleBoxFancy:
	var result = base.duplicate_deep() as StyleBoxFancy
	
	if not override:
		return result
	
	result.color = get_color_override(result.color, override.tint, override.lighten)

	result.set_expand_margin_all(override.grow)
	return result
	
func update():
	clear()
	
	if not element_stylebox:
		element_stylebox = StyleBoxFancy.new()
	if not background_stylebox:
		background_stylebox = StyleBoxFancy.new()
	if not foreground_stylebox:
		foreground_stylebox = StyleBoxFancy.new()
	
	var element_stylebox_hover = create_stylebox_override(element_stylebox, hover_override)
	var element_stylebox_selected = create_stylebox_override(element_stylebox, select_override)
	var element_stylebox_disabled = create_stylebox_override(element_stylebox, disabled_override)

	var font_color_hover = get_font_color(hover_override)
	var font_color_selected = get_font_color(select_override)
	var font_color_disabled = get_font_color(disabled_override)

	# Properties
	set_color("font_color", "Label", font_color)
	
	set_color("font_color", "Button", font_color)
	set_color("font_hover_color", "Button", font_color_hover)
	set_color("font_pressed_color", "Button", font_color_selected)
	set_color("font_disabled_color", "Button", font_color_disabled)
	
	set_color("font_selected_color", "TabContainer", font_color)
	set_color("font_hovered_color", "TabContainer", font_color_hover)
	set_color("font_disabled_color", "TabContainer", font_color_disabled)
	
	set_color("font_color", "LineEdit", font_color)
	set_color("font_uneditable_color", "LineEdit", font_color_disabled)
	
	set_color("font_color", "TextEdit", font_color)
	set_color("font_readonly_color", "TextEdit", font_color_disabled)

	set_stylebox("panel", "Panel", background_stylebox)
	set_stylebox("panel", "PanelContainer", background_stylebox)
	
	set_stylebox("normal", "Button", element_stylebox)
	set_stylebox("hover", "Button", element_stylebox_hover)
	set_stylebox("pressed", "Button", element_stylebox_selected)
	set_stylebox("disabled", "Button", element_stylebox_disabled)
	
	set_stylebox("panel", "TabContainer", foreground_stylebox)
	set_stylebox("tab_selected", "TabContainer", foreground_stylebox)

	# Forground
	set_stylebox("normal", "TextEdit", foreground_stylebox)
	set_stylebox("panel", "PopupMenu", foreground_stylebox)
	set_stylebox("normal", "LineEdit", foreground_stylebox)
	
	var disabled_foreground = create_stylebox_override(foreground_stylebox, disabled_override)
	set_stylebox("read_only", "LineEdit", disabled_foreground)
	set_stylebox("read_only", "TextEdit", disabled_foreground)
	
