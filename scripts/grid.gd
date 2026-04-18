@tool
extends Node2D

@export var cellScene : PackedScene
@export var width : int = 10:
	set(value):
		width = value
		if Engine.is_editor_hint():
			set_box()
@export var height : int = 10:
	set(value):
		height = value
		if Engine.is_editor_hint():
			set_box()
@export var show_box : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		if show_box:
			set_box()
		else:
			$Line2D.queue_free()
		for y in height:
			for x in width:
				var hex = Hexes.offset_to_hex(x, y)
				var node : Node2D = cellScene.instantiate()
				node.hex = hex
				node.position = Hexes.to_world_space(hex)
				add_child(node)
	
func set_box() -> void:
	var w = Hexes.horiz_spacing * width + 1 / tan(deg_to_rad(60)) * Hexes.vert_spacing *.5
	var h = Hexes.vert_spacing * (height + .5)
	var top = -Hexes.vert_spacing * .5
	var left = -Hexes.hex_size
	$Line2D.points = [
		Vector2(left, top),
		Vector2(left + w, top), 
		Vector2(left + w, top + h),
		Vector2(left, top + h)
	]
