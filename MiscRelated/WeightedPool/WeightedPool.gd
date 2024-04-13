extends RefCounted

var pool_data_arr : Array = []
var weight_arr : Array = []
var weight_total : float = 0.0

var rng_to_use : RandomNumberGenerator

func add_pool_data_with_weight(arg_data, arg_weight : float):
	pool_data_arr.append(arg_data)
	weight_arr.append(arg_weight)
	
	weight_total += arg_weight


func get_rand_data():
	var rand_weight = rng_to_use.randf_range(0, weight_total)
	var curr_weight = 0
	var i = 0
	
	for weight in weight_arr:
		curr_weight += weight
		
		if rand_weight <= curr_weight:
			return pool_data_arr[i]
		
		i += 1
	
	print("WEIGHTED_POOL: Err not returing")
