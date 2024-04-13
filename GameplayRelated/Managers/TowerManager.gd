extends Node2D

const AbstractTower = preload("res://GameplayRelated/EntityRelated/TowerRelated/AbstractTower.gd")
const Abstract_SlotPlacable = preload("res://GameplayRelated/SlotPlacableRelated/Abstract_SlotPlacable.gd")


var game_elements
var stage_round_manager
var game_rand_info_instance_manager

var all_towers : Array
var current_tower_count_in_map : int
var last_calc_tower_count_limit_in_map : int

###

func add_and_register_tower(arg_tower_instance : AbstractTower):
	arg_tower_instance.set_game_elements(game_elements)
	arg_tower_instance.set_tower_manager(self)
	arg_tower_instance.set_stage_round_manager(stage_round_manager)
	arg_tower_instance.set_game_rand_info_instance_manager(game_rand_info_instance_manager)
	

func attempt_transfer_tower_to_placable(arg_tower_instance: AbstractTower, arg_placable : Abstract_SlotPlacable):
	if !is_tower_placable_on_in_map_slot_placable(arg_tower_instance, arg_placable):
		return
	
	#####
	
	arg_tower_instance.set_current_slot_placable(arg_placable)
	
	

func is_tower_placable_on_in_map_slot_placable(arg_tower : AbstractTower, arg_placable : Abstract_SlotPlacable, arg_ignore_reservation : bool = false):
	var obj_in_placable = arg_placable.get_obj_in_slot__get_ref()
	
	if obj_in_placable == arg_tower:
		return true
	
	#
	
	var curr_placable_of_arg_tower = arg_tower.get_current_slot_placable()
	
	#note take into account if going in or out of map LOL
	var tower_to_place__tower_slot_count = 0
	if arg_placable.is_slot_type__bench() and arg_tower.is_tower_in_map():
		tower_to_place__tower_slot_count = -arg_tower.tower_count_slots_taken
	elif arg_placable.is_slot_type__in_map() and arg_tower.is_tower_in_bench():
		tower_to_place__tower_slot_count = arg_tower.tower_count_slots_taken
	
	
	var to_swap_in_target_placable__tower_slot_count = 0
	if is_instance_valid(obj_in_placable):
		if curr_placable_of_arg_tower.is_slot_type__bench() and obj_in_placable.is_tower_in_map():
			to_swap_in_target_placable__tower_slot_count = -obj_in_placable.tower_count_slots_taken
		elif curr_placable_of_arg_tower.is_slot_type__in_map() and obj_in_placable.is_tower_in_bench():
			to_swap_in_target_placable__tower_slot_count = obj_in_placable.tower_count_slots_taken
	
	
	#
	
	if current_tower_count_in_map + tower_to_place__tower_slot_count + to_swap_in_target_placable__tower_slot_count > last_calc_tower_count_limit_in_map:
		return false
	
	#
	
	if arg_ignore_reservation:
		return arg_placable.is_slot_unoccupiable_due_to_reservation__due_to_obj__only(arg_tower)
	else:
		return arg_placable.last_calc_is_slot_occupiable
		
	

