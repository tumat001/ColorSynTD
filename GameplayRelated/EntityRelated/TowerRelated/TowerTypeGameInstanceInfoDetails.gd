extends RefCounted

signal tower_colors_changed()
signal tower_color_capacity_changed(arg_tower_color_capacity)


var tower_id

var _tower_colors : Array
var _tower_color_capacity : int

#####

func add_tower_color(arg_tower_color_id):
	if !_tower_colors.has(arg_tower_color_id):
		_tower_colors.append(arg_tower_color_id)
		emit_signal("tower_colors_changed")


func set_tower_color_capacity(arg_capacity):
	_tower_color_capacity = arg_capacity
	
	emit_signal("tower_color_capacity_changed", arg_capacity)


