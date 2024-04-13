extends Node2D

const ConditionalClauses = preload("res://MiscRelated/ConditionalClauses/ConditionalClauses.gd")

signal obj_in_slot_changed(arg_obj_in_slot)

#

enum IsSlotUnoccupiableClauseId {
	OCCUPIED_BY_OBJ = 0,
	RESERVED_BY_OBJ = 1,  #USE methods for this
}
var is_slot_unoccupiable_cond_clauses : ConditionalClauses
var last_calc_is_slot_occupiable : bool

var current_occupation_reservation

#

enum SlotType {
	BENCH = 0,
	IN_MAP = 1,
}
var slot_placable_type : int = SlotType.BENCH


#

var terrain_layer : int

var _weak_ref__obj_in_slot : WeakRef

#

@onready var frame_sprite_2d = $FrameSprite2D

#

func _init():
	is_slot_unoccupiable_cond_clauses = ConditionalClauses.new()
	is_slot_unoccupiable_cond_clauses.connect("clause_updated", _is_slot_unoccupiable_cond_clauses_updated)
	_is_slot_unoccupiable_cond_clauses_updated(null, null)

func _is_slot_unoccupiable_cond_clauses_updated(arg_clause_id, arg_is_insert):
	last_calc_is_slot_occupiable = is_slot_unoccupiable_cond_clauses.is_passed

#

func put_slot_unoccupiable_reservation_for_obj(arg_reservation_obj):
	if is_instance_valid(arg_reservation_obj):
		current_occupation_reservation = arg_reservation_obj
		
		is_slot_unoccupiable_cond_clauses.attempt_insert_clause(IsSlotUnoccupiableClauseId.RESERVED_BY_OBJ)

func remove_slot_unoccupiable_reservation_of_obj(arg_reservation_obj):
	if is_slot_unoccupiable_due_to_reservation__due_to_obj(arg_reservation_obj):
		current_occupation_reservation = null
		
		is_slot_unoccupiable_cond_clauses.remove_clause(IsSlotUnoccupiableClauseId.RESERVED_BY_OBJ)

func is_slot_unoccupiable_due_to_reservation():
	return current_occupation_reservation != null

func is_slot_unoccupiable_due_to_reservation__due_to_obj(arg_obj):
	return current_occupation_reservation == arg_obj


func is_slot_unoccupiable_due_to_reservation__due_to_obj__only(arg_obj):
	return current_occupation_reservation == arg_obj and is_slot_unoccupiable_cond_clauses.has_only_clause_or_no_clause(IsSlotUnoccupiableClauseId.RESERVED_BY_OBJ)


#


func attempt_set_obj_in_slot(arg_obj : Object, arg_remove_reservation : bool = true) -> bool:
	if !last_calc_is_slot_occupiable:
		return false
	
	#
	
	set_obj_in_slot__forced(arg_obj, arg_remove_reservation)
	return true


func set_obj_in_slot__forced(arg_obj : Object, arg_remove_reservation : bool = true):
	if arg_obj == null:
		_weak_ref__obj_in_slot = null
		is_slot_unoccupiable_cond_clauses.remove_clause(IsSlotUnoccupiableClauseId.OCCUPIED_BY_OBJ)
	elif arg_obj is WeakRef:
		_weak_ref__obj_in_slot = arg_obj
		is_slot_unoccupiable_cond_clauses.attempt_insert_clause(IsSlotUnoccupiableClauseId.OCCUPIED_BY_OBJ)
	else:
		_weak_ref__obj_in_slot = weakref(arg_obj)
		is_slot_unoccupiable_cond_clauses.attempt_insert_clause(IsSlotUnoccupiableClauseId.OCCUPIED_BY_OBJ)
	
	###
	var true_obj = get_obj_in_slot__get_ref()
	
	true_obj.terrain_layer = terrain_layer
	
	if arg_remove_reservation:
		current_occupation_reservation = null
	
	emit_signal("obj_in_slot_changed", true_obj)

func has_obj_in_slot():
	return _weak_ref__obj_in_slot != null

func get_obj_in_slot__get_ref():
	if !has_obj_in_slot():
		return null
	
	return _weak_ref__obj_in_slot.get_ref()


##


func is_slot_type__bench():
	return slot_placable_type == SlotType.BENCH

func is_slot_type__in_map():
	return slot_placable_type == SlotType.IN_MAP

#

func get_pos_for_object_to_snap_to() -> Vector2:
	return global_position + frame_sprite_2d.texture.get_size() / 2
