@tool
extends StyleBox
class_name StyleBoxPlus

@export var base_style : StyleBoxFlat
@export var texture : Texture2D

func _draw(canvas: RID, rect: Rect2) -> void:
	base_style.draw(canvas, rect)
	
	RenderingServer.canvas_item_add_texture_rect(canvas, rect, texture, true)
