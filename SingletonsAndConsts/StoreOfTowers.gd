extends Node

const AbstractTower = preload("res://GameplayRelated/EntityRelated/TowerRelated/AbstractTower.gd")

const TowerTypeInfoDetails = preload("res://GameplayRelated/EntityRelated/TowerRelated/TowerTypeInfoDetails.gd")
const TowerTypeGameInstanceInfoDetails = preload("res://GameplayRelated/EntityRelated/TowerRelated/TowerTypeGameInstanceInfoDetails.gd")
const TowerGameInstanceInfoDetails = preload("res://GameplayRelated/EntityRelated/TowerRelated/TowerGameInstanceInfoDetails.gd")

#

enum TowerId {
	
	# TIER 1
	
	# TIER 2
	
	# TIER 3
	
	# TIER 4
	
	# TIER 5
	IOTA = 500,
	
	# TIER 6
	CHAOS = 600,
	
	######
	# PAINT TOWERS
	
}

enum TowerColorId {
	GRAY = 0,
	BLACK = 1,
	RED = 2,
	ORANGE = 3,
	YELLOW = 4,
	GREEN = 5,
	BLUE = 6,
	VIOLET = 7,
}

enum TowerTier {
	TIER_1 = 1,
	TIER_2 = 2,
	TIER_3 = 3,
	TIER_4 = 4,
	TIER_5 = 5,
	TIER_6 = 6,
	
}

enum TowerClassificationTypeId {
	NORMAL = 1,
	PAINT = 2,
}

#

var singleton__tower_id_to_tower_info_details : Array = []


func _init():
	_generate_singleton_tower_id_to_tower_info_details_arr()

func _generate_singleton_tower_id_to_tower_info_details_arr():
	for tower_id in TowerId.values():
		var details = get_or_construct_singleton_tower_info_details(tower_id)
		singleton__tower_id_to_tower_info_details[tower_id] = details


func get_or_construct_singleton_tower_info_details(arg_tower_id : int):
	if singleton__tower_id_to_tower_info_details.has(arg_tower_id):
		return singleton__tower_id_to_tower_info_details[arg_tower_id]
	
	###
	
	var tower_type_info_details = TowerTypeInfoDetails.new()
	tower_type_info_details.tower_id = arg_tower_id
	
	match arg_tower_id:
		TowerId.IOTA:
			tower_type_info_details.tower_name = ["Iota"]
			tower_type_info_details.tower_name_string = "Iota"
			tower_type_info_details.tower_tier = TowerTier.TIER_5
			tower_type_info_details.tower_classification_type = TowerClassificationTypeId.NORMAL
			
			tower_type_info_details.tower_simple_description = []
			tower_type_info_details.tower_middle_description = []
			tower_type_info_details.tower_long_description = []
			
			tower_type_info_details.tower_colors_weighted_pool_fixed = null
			
		
	
	return tower_type_info_details

#

func is_tower_id_none_or_null(arg_tower_id):
	return arg_tower_id == null or arg_tower_id == -1

func get_tower_tier_from_id(arg_tower_id):
	return singleton__tower_id_to_tower_info_details[arg_tower_id].tower_tier


func is_tower_two_colored__based_on_colors(arg_colors : Array):
	return arg_colors.size() == 2

func is_tower_single_colored__based_on_colors(arg_colors : Array):
	return arg_colors.size() == 1

func is_tower_rainbow_colored__based_on_colors(arg_colors : Array):
	return arg_colors.size() == 6

########

func generate_tower_type_game_instance_info_details(arg_tower_id) -> TowerTypeGameInstanceInfoDetails: 
	var tower_type_info_details : TowerTypeInfoDetails = singleton__tower_id_to_tower_info_details[arg_tower_id]
	
	var tower_type_game_instance_info_det := TowerTypeGameInstanceInfoDetails.new()
	tower_type_game_instance_info_det.tower_id = arg_tower_id
	
	# color
	if tower_type_info_details.tower_colors_weighted_pool_fixed == null:
		tower_type_game_instance_info_det.set_tower_color_capacity(1)
		tower_type_game_instance_info_det.add_tower_color(TowerColorId.GRAY)
	else:
		var colors_chosen : Array = tower_type_info_details.tower_colors_weighted_pool_fixed.get_rand_data()
		tower_type_game_instance_info_det.set_tower_color_capacity(colors_chosen.size())
		for color_id in colors_chosen:
			tower_type_game_instance_info_det.add_tower_color(color_id)
		
	
	return tower_type_game_instance_info_det

func generate_tower_game_instance_info_details(arg_tower_id) -> TowerGameInstanceInfoDetails:
	var tower_type_info_details : TowerTypeInfoDetails = singleton__tower_id_to_tower_info_details[arg_tower_id]
	
	var tower_game_instance_info_det := TowerGameInstanceInfoDetails.new()
	tower_game_instance_info_det.tower_id = arg_tower_id
	
	#
	
	return tower_game_instance_info_det

func instantiate_tower(arg_tower_id) -> AbstractTower:
	var tower
	
	
	#
	
	match arg_tower_id:
		TowerId.IOTA:
			pass
	
	tower.tower_id = arg_tower_id
	
	return tower
