extends Object
class_name Utils

static func callable_prebind(callable: Callable, ...bind_args: Array) -> Callable:
	return func (...call_args: Array) -> Variant:
		return callable.callv(bind_args + call_args)

static func get_editor_icon(icon_name: String) -> Texture2D:
	return EditorInterface.get_editor_theme().get_icon(icon_name, &"EditorIcons")

## Returns a point that is as close to the desired position as possible, without being
## >range units away from the reference position.
static func constrain_point_to_radius(reference_position: Vector2, desired_position: Vector2, range: float) -> Vector2:
	var offset = desired_position - reference_position
	var distance = offset.length()
	if distance <= range:
		return desired_position  # Already within range
	else:
		return reference_position + offset.normalized() * range

## Returns a point that is as close to the desired position as possible, while ensuring
## it is at least `inner_range` units away and at most `range` units away from the reference.
static func constrain_point_to_donut(reference_position: Vector2, desired_position: Vector2, inner_range: float, range: float) -> Vector2:
	## Handle invalid input overrides
	if inner_range < 0:
		inner_range = 0
	if range < 0:
		range = 2000000
	
	var offset = desired_position - reference_position
	var distance = offset.length()
	
	# If desired_position is exactly at the reference, pick a default direction
	if distance == 0:
		return reference_position + Vector2.RIGHT * inner_range
	
	# Clamp the distance to the allowed donut range
	var clamped_distance = clamp(distance, inner_range, range)
	return reference_position + offset.normalized() * clamped_distance

static func get_all_of_type(type : Script):
	var children = []
	for child in get_children_recursive(Engine.get_main_loop().root):
		if is_instance_of(child, type):
			children.append(child)
	return children
	
static func remove_all_children(node : Node):
	for i in node.get_child_count():
		node.get_child(i).queue_free()
		
static func get_children_recursive(parent: Node) -> Array[Node]:
	var result: Array[Node] = []
	var stack: Array[Node] = [parent]

	while not stack.is_empty():
		var current: Node = stack.pop_back()
		for child in current.get_children():
			result.append(child)
			stack.append(child)
	
	return result

static func get_game() -> Game:
	return get_first_of_type(Game)
	
static func get_first_of_type(type : Script):
	for child in get_children_recursive(Engine.get_main_loop().root):
		if is_instance_of(child, type):
			return child

static func wait(time : float):
	await Engine.get_main_loop().root.get_tree().create_timer(time).timeout

static func get_tree_static() -> SceneTree:
	return Engine.get_main_loop().root.get_tree()

## Generates a "pretty" random color
static func generate_random_hsv_color() -> Color:
	return Color.from_hsv(
		randf(), # Hue
		randf_range(0.2, 0.6), # Saturation
		randf_range(0.9, 1.0), # Brightness
	)

class Triangle:
	var _p1 : Vector2
	var _p2 : Vector2
	var _p3 : Vector2
	
	func _init(p1: Vector2, p2: Vector2, p3: Vector2) -> void:
		_p1 = p1
		_p2 = p2
		_p3 = p3
	
	func get_triangle_area() -> float:
		return 0.5 * abs((_p1.x*(_p2.y - _p3.y)) + (_p2.x*(_p3.y - _p1.y)) + (_p3.x*(_p1.y - _p2.y)))
	
	func get_random_point():
		var a = randf()
		var b = randf()
		if a > b:
			var c = b
			b = a
			a = c

		return _p1 * a + _p2 * (b - a) + _p3 * (1 - b)
	
	static func get_random_point_in_polygon(polygon: PackedVector2Array) -> Vector2:
		return get_random_point_in_triangulated_polygon(polygon, Geometry2D.triangulate_polygon(polygon))
	
	static func get_random_point_in_triangulated_polygon(polygon: PackedVector2Array, triangle_points : PackedInt32Array) -> Vector2:
		var triangle_weights : PackedFloat32Array = []
		var triangles : Array[Triangle] = []
		
		var index = 0
		var polygon_size = triangle_points.size()
		while index < polygon_size:
			var triangle = Triangle.new(polygon[triangle_points[index]], polygon[triangle_points[index + 1]], polygon[triangle_points[index + 2]])
			triangles.append(triangle)
			triangle_weights.append(triangle.get_triangle_area())
			index += 3
		
		## TODO: We should allow the consumer to specify their own source of randomness, if desired.
		return triangles[RandomNumberGenerator.new().rand_weighted(triangle_weights)].get_random_point()
