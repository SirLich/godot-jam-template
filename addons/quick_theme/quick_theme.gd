@tool

extends Theme
class_name QuickTheme

@export_tool_button("Update", "Callable") var update_button = update
@export var font_color : Color

## The stylebox of background elements. Like Panels.
@export var background_stylebox : StyleBoxFancy

## The stylebox of elements, like the background of LineEdit, or Buttons.
@export var button_stylebox : StyleBoxFancy

@export var foreground_stylebox : StyleBoxFancy

@export var hover_override : QuickThemeOverride
@export var select_override : QuickThemeOverride
@export var disabled_override : QuickThemeOverride

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
	
func update():
	clear()
	
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
	
	set_stylebox("normal", "Button", button_stylebox)
	set_stylebox("hover", "Button", button_stylebox_hover)
	set_stylebox("pressed", "Button", button_stylebox_selected)
	set_stylebox("disabled", "Button", button_stylebox_disabled)
	
	var tab_container_panel = foreground_stylebox.duplicate_deep() as StyleBoxFancy
	tab_container_panel.set_corner_radius(Corner.CORNER_TOP_LEFT, 0)
	tab_container_panel.set_corner_radius(Corner.CORNER_TOP_RIGHT, 0)
	
	var tab_panel = foreground_stylebox.duplicate_deep() as StyleBoxFancy
	tab_panel.set_corner_radius(Corner.CORNER_BOTTOM_LEFT, 0)
	tab_panel.set_corner_radius(Corner.CORNER_BOTTOM_RIGHT, 0)
	
	set_stylebox("panel", "TabContainer", tab_container_panel)
	set_stylebox("tab_selected", "TabContainer", tab_panel)

	# Forground
	set_stylebox("normal", "TextEdit", foreground_stylebox)
	set_stylebox("panel", "PopupMenu", foreground_stylebox)
	set_stylebox("normal", "LineEdit", foreground_stylebox)
	
	var disabled_foreground = create_stylebox_override(foreground_stylebox, disabled_override)
	set_stylebox("read_only", "LineEdit", disabled_foreground)
	set_stylebox("read_only", "TextEdit", disabled_foreground)
	
