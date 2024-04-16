extends MarginContainer

const GUI_ShopBuyCard = preload("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/GUI_ShopBuyCard.gd")
const GUI_ShopBuyCard_Scene = preload("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/GUI_ShopBuyCard.tscn")

#

var shader_mat__moving_rainbow : ShaderMaterial

#

@onready var slot_container = $SlotContainer

var tower_shop_buy_card : GUI_ShopBuyCard

###

func helper__add_tower_id_as_card_to_slot_container(arg_tower_id) -> GUI_ShopBuyCard:
	if !is_instance_valid(tower_shop_buy_card):
		tower_shop_buy_card = GUI_ShopBuyCard_Scene.instantiate()
		tower_shop_buy_card.shader_mat__moving_rainbow = shader_mat__moving_rainbow
		call_deferred("_deferred_add_child__tower_shop_buy_card", arg_tower_id)
		#slot_container.add_child(tower_shop_buy_card)
		
	elif tower_shop_buy_card.is_inside_tree():
		tower_shop_buy_card.helper__set_tower_id__and_update_card(arg_tower_id)
		
	
	return tower_shop_buy_card

func _deferred_add_child__tower_shop_buy_card(arg_tower_id):
	slot_container.add_child(tower_shop_buy_card)
	tower_shop_buy_card.helper__set_tower_id__and_update_card(arg_tower_id)
	

#func helper__add_tower_id_as_card_to_slot_container(arg_tower_id) -> GUI_ShopBuyCard:
	#var card_scene = GUI_ShopBuyCard_Scene.instantiate()
	#card_scene.tower_id = arg_tower_id -- dont do this
	#add_buy_card_to_slot_container(card_scene)
	#
	#return card_scene
#
#func add_buy_card_to_slot_container(arg_buy_card : GUI_ShopBuyCard):
	#slot_container.add_child(arg_buy_card)



