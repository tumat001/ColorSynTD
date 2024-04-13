extends Node2D

const Abstract_SlotPlacable = preload("res://GameplayRelated/SlotPlacableRelated/Abstract_SlotPlacable.gd")

const ConditionalClauses = preload("res://MiscRelated/ConditionalClauses/ConditionalClauses.gd")

const TowerTypeGameInstanceInfoDetails = preload("res://GameplayRelated/EntityRelated/TowerRelated/TowerTypeGameInstanceInfoDetails.gd")
const TowerGameInstanceInfoDetails = preload("res://GameplayRelated/EntityRelated/TowerRelated/TowerGameInstanceInfoDetails.gd")

#

signal all_tower_game_instance_info_details_initialized()

#

var tower_id
var tower_type_game_instance_info_details : TowerTypeGameInstanceInfoDetails
var tower_game_instance_info_details : TowerGameInstanceInfoDetails

#

var _current_slot_placable : Abstract_SlotPlacable #:
#	set = set_current_slot_placable

#

var terrain_layer : int

#

var tower_count_slots_taken : int

#

enum IsTowerDraggableClauseId {
	END_OF_GAME = 0,
	IS_ROUND_STARTED_AND_IS_IN_MAP = 1,
}
var is_tower_draggable_cond_clause : ConditionalClauses
var last_calculated_tower_is_draggable : bool

var is_being_dragged

#

var _game_elements
var _tower_manager
var _stage_round_manager
var _game_rand_info_instance_manager

###

func _init():
	is_tower_draggable_cond_clause = ConditionalClauses.new()
	is_tower_draggable_cond_clause.connect("clause_updated", _on_is_tower_draggable_cond_clause_clause_updated)
	_update_last_calculated_tower_is_draggable()

func _on_is_tower_draggable_cond_clause_clause_updated(arg_clause_id, arg_is_insert):
	_update_last_calculated_tower_is_draggable()

func _update_last_calculated_tower_is_draggable():
	last_calculated_tower_is_draggable = is_tower_draggable_cond_clause.is_passed

#

func set_game_elements(arg_ele):
	_game_elements = arg_ele

func set_tower_manager(arg_manager):
	_tower_manager = arg_manager

func set_stage_round_manager(arg_manager):
	_stage_round_manager = arg_manager
	
	_stage_round_manager.connect("round_started", _on_round_started)
	_stage_round_manager.connect("after_round_started", _on_after_round_started)
	_stage_round_manager.connect("round_ended", _on_round_ended)

func set_game_rand_info_instance_manager(arg_manager):
	_game_rand_info_instance_manager = arg_manager
	
	_set_tower_id_related_infos()


func _set_tower_id_related_infos():
	tower_type_game_instance_info_details = _game_rand_info_instance_manager.rand_info_inst__tower_id_to_type_inst_info_map[tower_id]
	tower_game_instance_info_details = StoreOfTowers.generate_tower_game_instance_info_details(tower_id)
	
	emit_signal("all_tower_game_instance_info_details_initialized")

#

func _on_round_started(arg_stageround):
	_update_is_draggable_clause__is_round_started_and_is_in_map()

func _on_after_round_started(arg_stageround):
	pass
	#todosoon enable attack modules on after round started


func _on_round_ended(arg_stageround):
	_update_is_draggable_clause__is_round_started_and_is_in_map()


##

func set_current_slot_placable(arg_slot_placable : Abstract_SlotPlacable):
	if arg_slot_placable.is_slot_type__bench():
		_tower_placed_in_map(arg_slot_placable)
	elif arg_slot_placable.is_slot_type__in_map():
		_tower_placed_in_bench(arg_slot_placable)
	

func get_current_slot_placable() -> Abstract_SlotPlacable:
	return _current_slot_placable


func _tower_placed_in_map(arg_slot_placable : Abstract_SlotPlacable):
	_set_current_slot_placable__do_common_actions(arg_slot_placable)
	
	_update_is_draggable_clause__is_round_started_and_is_in_map()

func _tower_placed_in_bench(arg_slot_placable : Abstract_SlotPlacable):
	_set_current_slot_placable__do_common_actions(arg_slot_placable)
	
	_update_is_draggable_clause__is_round_started_and_is_in_map()

func _set_current_slot_placable__do_common_actions(arg_slot_placable : Abstract_SlotPlacable):
	_current_slot_placable = arg_slot_placable
	
	global_position = _current_slot_placable.get_pos_for_object_to_snap_to()


func _update_is_draggable_clause__is_round_started_and_is_in_map():
	var bool_check = _stage_round_manager.is_round_started and _current_slot_placable.is_slot_type__in_map()
	if bool_check:
		is_tower_draggable_cond_clause.attempt_insert_clause(IsTowerDraggableClauseId.IS_ROUND_STARTED_AND_IS_IN_MAP)
	else:
		is_tower_draggable_cond_clause.remove_clause(IsTowerDraggableClauseId.IS_ROUND_STARTED_AND_IS_IN_MAP)


func is_tower_in_map():
	return (is_instance_valid(_current_slot_placable) and _current_slot_placable.is_slot_type__in_map())

func is_tower_in_bench():
	return (is_instance_valid(_current_slot_placable) and _current_slot_placable.is_slot_type__in_bench())


#

func _on_clickable_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			_toggle_show_tower_info()
		elif event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if _tower_manager.is_in_select_tower_prompt:
				_self_is_selected_in_selection_mode()
				
			elif last_calculated_tower_is_draggable:
				_start_drag()
		elif !event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if is_being_dragged:
				_end_drag()

func _toggle_show_tower_info():
	pass
	

func _self_is_selected_in_selection_mode():
	pass
	

func _start_drag():
	pass
	

func _end_drag():
	pass
	
	
