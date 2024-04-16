@tool
extends MarginContainer


#enum BoxLayoutId {
	#LABEL_THEN_ICON = 0,
	#ICON_THEN_LABEL = 1,
#}
#@export var box_layout : BoxLayoutId = BoxLayoutId.LABEL_THEN_ICON : set = set_box_layout
#
##
#
#@onready var box_container = $BoxContainer
#@onready var label = $BoxContainer/Label
#@onready var icon = $BoxContainer/Icon

#
#
#func set_box_layout(arg_id):
	#box_layout = arg_id
	#
	#if is_inside_tree() or Engine.is_editor_hint():
		#_update_layout_based_on_properties()
#
#func _update_layout_based_on_properties():
	#match box_layout:
		#BoxLayoutId.LABEL_THEN_ICON:
			#box_container.move_child(label, 0)
			#box_container.move_child(icon, 1)
		#BoxLayoutId.ICON_THEN_LABEL:
			#box_container.move_child(icon, 0)
			#box_container.move_child(label, 1)
			#
#
#
#func _ready() -> void:
	#_update_layout_based_on_properties()
#
###



func _on_player_gui_texture_button_mouse_functionally_entered() -> void:
	modulate = Color(1.3, 1.3, 1.3, 1)

func _on_player_gui_texture_button_mouse_functionally_exited() -> void:
	modulate = Color(1, 1, 1, 1)
