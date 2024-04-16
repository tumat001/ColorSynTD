extends Node

const GameRandInfoInstance_SubManager = preload("res://GameplayRelated/Managers/GESubs/GameRandInfoInstance_SubManager.gd")
const ShopSubManager = preload("res://GameplayRelated/Managers/GESubs/ShopSubManager.gd")

#


var game_main_rng : RandomNumberGenerator

var shop_sub_manager : ShopSubManager

#

@onready var tower_manager = $TowerManager
@onready var game_rand_info_instance_manager = $GameRandInfoIntanceManager

#

func _ready() -> void:
	_init_game_main_rng()
	_init_shop_sub_manager()
	


func _init_game_main_rng():
	game_main_rng = RandomNumberGenerator.new()
	SingletonsAndConsts.game_main_rng = game_main_rng

func _init_shop_sub_manager():
	shop_sub_manager = ShopSubManager.new()
	
	shop_sub_manager.initialize_shop_manager()

##########

func _enter_tree() -> void:
	SingletonsAndConsts.current_game_elements = self


func _exit_tree() -> void:
	SingletonsAndConsts.current_game_elements = null

