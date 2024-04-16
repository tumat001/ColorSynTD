extends MarginContainer

signal level_up_requested()
signal reroll_requested()

#note: these slots are never changing. just here for convenience
signal buy_cards_refreshed__new_batch(arg_normal_tower_slots : Array, arg_paint_tower_slots : Array)

#

var shader_mat__moving_rainbow

#

@onready var shop_buy_card__normal_slot_01 = $MainHBoxContainer/BuyCardHBoxContainer/NormalCardHBoxCont/ShopBuyCardSlot_01
@onready var shop_buy_card__normal_slot_02 = $MainHBoxContainer/BuyCardHBoxContainer/NormalCardHBoxCont/ShopBuyCardSlot_02
@onready var shop_buy_card__normal_slot_03 = $MainHBoxContainer/BuyCardHBoxContainer/NormalCardHBoxCont/ShopBuyCardSlot_03
@onready var shop_buy_card__paint_slot_01 = $MainHBoxContainer/BuyCardHBoxContainer/PaintShopBuyCardSlot_01
@onready var all_shop_buy_card__normal_slots = [
	shop_buy_card__normal_slot_01,
	shop_buy_card__normal_slot_02,
	shop_buy_card__normal_slot_03
]
@onready var all_shop_buy_card__paint_slots = [
	shop_buy_card__paint_slot_01,
]

@onready var lvl_up_currency_tex_rect = $MainHBoxContainer/LevelRollContainer/VBoxContainer/PlayerGUI_TWTaIB_LevelUp/Container/LvlUpCurrencyIcon
@onready var lvl_up_cost_label = $MainHBoxContainer/LevelRollContainer/VBoxContainer/PlayerGUI_TWTaIB_LevelUp/Container/LvlUpCostLabel
@onready var reroll_cost_label = $MainHBoxContainer/LevelRollContainer/VBoxContainer/PlayerGUI_TWTaIB_Roll/Container/RerollCostLabel

#

func _ready() -> void:
	shader_mat__moving_rainbow = ShaderMaterial.new()
	shader_mat__moving_rainbow.shader = load("res://MiscRelated/Shaders/Shader_MovingRainbowGradient.gdshader")
	
	for buy_card_slot in all_shop_buy_card__normal_slots:
		buy_card_slot.shader_mat__moving_rainbow = shader_mat__moving_rainbow
	for buy_card_slot in all_shop_buy_card__paint_slots:
		buy_card_slot.shader_mat__moving_rainbow = shader_mat__moving_rainbow

#

func _on_level_up_button_left_released(arg_is_mouse_functionally_inside: bool) -> void:
	if arg_is_mouse_functionally_inside:
		emit_signal("level_up_requested")


func _on_reroll_button_left_released(arg_is_mouse_functionally_inside: bool) -> void:
	if arg_is_mouse_functionally_inside:
		emit_signal("reroll_requested")

##

func helper__set_tower_ids_for_buy_cards(arg_normal_tower_slots : Array, arg_paint_tower_slots : Array):
	for i in all_shop_buy_card__normal_slots.size():
		var buy_card_slot = all_shop_buy_card__normal_slots[i]
		buy_card_slot.helper__add_tower_id_as_card_to_slot_container(arg_normal_tower_slots[i])
	
	for i in all_shop_buy_card__paint_slots.size():
		var buy_card_slot = all_shop_buy_card__paint_slots[i]
		buy_card_slot.helper__add_tower_id_as_card_to_slot_container(arg_paint_tower_slots[i])
	
	emit_signal("buy_cards_refreshed__new_batch", arg_normal_tower_slots, arg_paint_tower_slots)


func get_tower_buy_cards_in_normal_tower_slots() -> Array:
	var bucket = []
	for buy_card_slot in all_shop_buy_card__normal_slots:
		bucket.append(buy_card_slot.tower_shop_buy_card)
	return bucket

func get_tower_buy_cards_in_paint_tower_slots() -> Array:
	var bucket = []
	for buy_card_slot in all_shop_buy_card__paint_slots:
		bucket.append(buy_card_slot.tower_shop_buy_card)
	return bucket

####

func set_level_up_costs(arg_gold_cost : int, arg_relic_cost : int):
	if arg_relic_cost != 0:
		_set_level_up_costs__as_relic(arg_relic_cost)
	else:
		_set_level_up_costs__as_gold(arg_gold_cost)


func _set_level_up_costs__as_gold(arg_cost):
	lvl_up_currency_tex_rect.texture = load("res://MiscRelated/CommonArts/CommonArts_Gold_12x12.png")
	lvl_up_cost_label.text = str(arg_cost)

func _set_level_up_costs__as_relic(arg_cost):
	lvl_up_currency_tex_rect.texture = load("res://MiscRelated/CommonArts/CommonArts_Relic_9x13.png")
	lvl_up_cost_label.text = str(arg_cost)

