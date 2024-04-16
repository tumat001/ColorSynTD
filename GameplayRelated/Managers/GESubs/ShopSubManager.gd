extends RefCounted

signal level_up_gold_cost_reduction_per_round_changed(arg_val)
signal current_level_up_gold_and_relic_cost_changed(arg_gold_val, arg_relic_val)
signal current_player_reroll_gold_cost_changed(arg_val)

#

const WeightedPool = preload("res://MiscRelated/WeightedPool/WeightedPool.gd")

##

var _level_up_gold_cost_reduction_per_round : int = 2
var PLAYER_LEVEL_TO_LEVEL_UP_COST_MAP : Dictionary = {
	10 : [0, 1],
	9 : [70, 0],
	8 : [60, 0],
	7 : [50, 0],
	6 : [40, 0],
	5 : [26, 0],
	4 : [12, 0],
	3 : [2, 0],
	2 : [2, 0],
}

var _current_level_up_relic_cost : int
var _current_level_up_gold_cost : int
var _current_player_reroll_gold_cost = 2


#

const TOWER_TIER_TO_INITIAL_STOCK_COUNT__NORMAL_TOWER : Dictionary = {
	StoreOfTowers.TowerTier.TIER_1 : 22,
	StoreOfTowers.TowerTier.TIER_2 : 18,
	StoreOfTowers.TowerTier.TIER_3 : 14,
	StoreOfTowers.TowerTier.TIER_4 : 8,
	StoreOfTowers.TowerTier.TIER_5 : 6,
	StoreOfTowers.TowerTier.TIER_6 : 2,
}
const TOWER_TIER_TO_INITIAL_STOCK_COUNT__PAINT_TOWER : Dictionary = {
	StoreOfTowers.TowerTier.TIER_1 : 9,
	StoreOfTowers.TowerTier.TIER_2 : 8,
	StoreOfTowers.TowerTier.TIER_3 : 7,
	StoreOfTowers.TowerTier.TIER_4 : 6,
	StoreOfTowers.TowerTier.TIER_5 : 5,
	StoreOfTowers.TowerTier.TIER_6 : 4,
}


#var tower_stock_count_weighted_pool : WeightedPool
var tower_tier_to_normal_tower_current_stock_count_weighted_pool : Dictionary
var tower_tier_to_paint_tower_current_stock_count_weighted_pool : Dictionary
#if a tower id is banned, the pool data (tower id) is removed from the pool, then placed here (in the map).
#this is to keep track of any stock changes while it is banned.
var _current_banned__tower_id_to_stock_count_map : Dictionary

###

var gui_shop_panel : set = set_gui_shop_panel

###

func initialize_shop_manager():
	_init_tower_tier_to_normal_tower_current_stock_count_weighted_pool()
#

func _init_tower_tier_to_normal_tower_current_stock_count_weighted_pool():
	for tier in StoreOfTowers.TowerTier.values():
		var tower_stock_count_weighted_pool = WeightedPool.new()
		tower_stock_count_weighted_pool.rng_to_use = SingletonsAndConsts.current_ge__game_main_rng
		
		tower_tier_to_normal_tower_current_stock_count_weighted_pool[tier] = tower_stock_count_weighted_pool
	
	
	for tower_id in StoreOfTowers.TowerId.values():
		var tower_tier = StoreOfTowers.get_tower_tier_from_id(tower_id)
		var stock_count = TOWER_TIER_TO_INITIAL_STOCK_COUNT__NORMAL_TOWER[tower_tier]
		
		var tower_stock_count_weighted_pool = tower_tier_to_normal_tower_current_stock_count_weighted_pool[tower_tier]
		tower_stock_count_weighted_pool.set_pool_data_with_weight(tower_id, stock_count)

#

func set_gui_shop_panel(arg_panel):
	gui_shop_panel = arg_panel
	
	#gui_shop_panel.connect("level_up_requested", _on_gui_shop_panel__level_up_requested)
	gui_shop_panel.connect("reroll_requested", _on_gui_shop_panel__reroll_requested)
	gui_shop_panel.connect("buy_cards_refreshed__new_batch", _on_gui_shop_panel__buy_cards_refreshed__new_batch)
	
	_update_gui_shop_panel_level_up_costs()

#func _on_gui_shop_panel__level_up_requested():
	#pass

func _on_gui_shop_panel__reroll_requested():
	pass

#this is where u do custom rules and custom things, etc
func _on_gui_shop_panel__buy_cards_refreshed__new_batch(arg_normal_tower_slots : Array, arg_paint_tower_slots : Array):
	pass


#

func set_current_level_up_costs(arg_gold_cost : int, arg_relic_cost : int):
	_current_level_up_gold_cost = arg_gold_cost
	_current_level_up_relic_cost = arg_relic_cost
	emit_signal("current_level_up_gold_and_relic_cost_changed", arg_gold_cost, arg_relic_cost)
	
	if is_instance_valid(gui_shop_panel):
		_update_gui_shop_panel_level_up_costs()

func _update_gui_shop_panel_level_up_costs():
	gui_shop_panel.set_level_up_costs(_current_level_up_gold_cost, _current_level_up_relic_cost)


func get_current_level_up_gold_cost():
	return _current_level_up_gold_cost

func get_current_level_up_relic_cost():
	return _current_level_up_relic_cost


########



func roll_towers_for_shop():
	_readd_towers_in_shop_buy_card_to_stock()
	##
	#todoimp continue this
	

func _readd_towers_in_shop_buy_card_to_stock():
	for tower_card in gui_shop_panel.get_tower_buy_cards_in_normal_tower_slots():
		pass
	for tower_card in gui_shop_panel.get_tower_buy_cards_in_paint_tower_slots():
		pass
	


