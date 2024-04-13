extends RefCounted

signal tower_custom_name_changed(arg_val)
signal tower_custom_simple_description_changed(arg_val)
signal tower_custom_middle_description_changed(arg_val)
signal tower_custom_long_description_changed(arg_val)

##

var tower_id : int

var _tower_custom_name : Array
var _tower_custom_simple_description : Array
var _tower_custom_middle_description : Array
var _tower_custom_long_description : Array

#var tower_icon : Texture2D  #dont use this, use custom class/node

#

func set_tower_custom_name(arg_val):
	_tower_custom_name = arg_val
	
	emit_signal("tower_custom_name_changed", arg_val)

func set_tower_custom_simple_description(arg_val):
	_tower_custom_simple_description = arg_val
	
	emit_signal("tower_custom_simple_description_changed", arg_val)

func set_tower_custom_middle_description(arg_val):
	_tower_custom_middle_description = arg_val
	
	emit_signal("tower_custom_middle_description_changed", arg_val)

func set_tower_custom_long_description(arg_val):
	_tower_custom_long_description = arg_val
	
	emit_signal("tower_custom_long_description_changed", arg_val)



