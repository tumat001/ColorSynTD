extends RefCounted

var rand_info_inst__tower_id_to_type_inst_info_map : Dictionary


func _init_rand_info_instances():
	_initialize_tower_type_instance_info_map()

func _initialize_tower_type_instance_info_map():
	for tower_id in StoreOfTowers.TowerId.values():
		rand_info_inst__tower_id_to_type_inst_info_map[tower_id] = StoreOfTowers.generate_tower_type_game_instance_info_details(tower_id)
		
	
	

