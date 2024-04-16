extends RefCounted

var rng_to_use : RandomNumberGenerator

#

var pool_data_to_details_map : Dictionary
var weight_total : float = 0.0

func set_pool_data_with_weight(arg_data, arg_weight : float):
	var old_weight
	if pool_data_to_details_map.has(arg_data):
		old_weight = pool_data_to_details_map[arg_data]
	
	pool_data_to_details_map[arg_data] = arg_weight
	weight_total += arg_weight - old_weight

func get_weight_of_pool_data(arg_data) -> float:
	return pool_data_to_details_map[arg_data]


func remove_pool_data(arg_data):
	if pool_data_to_details_map.has(arg_data):
		pool_data_to_details_map.erase(arg_data)
		return true
	
	return false

#

func get_rand_data():
	return _get_rand_data__using_weight_total_and_pool_to_det_map(weight_total, pool_data_to_details_map)

func _get_rand_data__using_weight_total_and_pool_to_det_map(arg_weight_total : float, arg_pool_data_to_details_map : Dictionary):
	var rand_weight = rng_to_use.randf_range(0, arg_weight_total)
	var curr_weight = 0
	
	for pool_data in arg_pool_data_to_details_map.keys():
		var weight = arg_pool_data_to_details_map[pool_data]
		
		curr_weight += weight
		#
		if rand_weight <= curr_weight:
			return pool_data
	
	print("ERR in weighted pool returned nothing")


##return true = ban/blacklist
#func get_rand_data__with_blacklist_callable(arg_is_blacklist_callable : Callable, arg_default_if_none):
	#var rand_weight = rng_to_use.randf_range(0, weight_total)
	#var curr_weight = 0
	#
	#var prev_pool_data = arg_default_if_none
	#
	#for pool_data in pool_data_to_details_map.keys():
		#var weight = pool_data_to_details_map[pool_data]
		#
		#curr_weight += weight
		##
		#if !arg_is_blacklist_callable.call(pool_data):
			#if rand_weight <= curr_weight:
				#return pool_data
			#
			#prev_pool_data = pool_data
	#
	#return prev_pool_data

#var pool_data_arr : Array = []
#var weight_arr : Array = []
#var weight_total : float = 0.0
#
#var rng_to_use : RandomNumberGenerator
#
#func add_pool_data_with_weight(arg_data, arg_weight : float):
	#pool_data_arr.append(arg_data)
	#weight_arr.append(arg_weight)
	#
	#weight_total += arg_weight
#
#
#func get_rand_data():
	#var rand_weight = rng_to_use.randf_range(0, weight_total)
	#var curr_weight = 0
	#var i = 0
	#
	#for weight in weight_arr:
		#curr_weight += weight
		#
		#if rand_weight <= curr_weight:
			#return pool_data_arr[i]
		#
		#i += 1
	#
	#print("WEIGHTED_POOL: Err not returing")
