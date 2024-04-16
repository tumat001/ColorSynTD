extends RefCounted

const WeightedPool = preload("res://MiscRelated/WeightedPool/WeightedPool.gd")

#

var tower_id
var tower_name : Array
var tower_name_string : String
var tower_tier
var tower_classification_type

var tower_simple_description
var tower_middle_description
var tower_long_description

#weighted_pool
var tower_colors_weighted_pool_fixed : WeightedPool


#var ingredient_effect : IngredientEffect
#var tower_icon ##NO to this


func is_tower_classification_paint_type():
	return tower_classification_type == StoreOfTowers.TowerClassificationType.PAINT

