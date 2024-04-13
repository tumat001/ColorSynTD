extends Control

const GUI_ShopBuyCard = preload("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/GUI_ShopBuyCard.gd")
const GUI_ShopBuyCard_Scene = preload("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/GUI_ShopBuyCard.tscn")

@onready var slot_container = $SlotContainer

##



func helper__add_tower_id_as_card_to_slot_container(arg_tower_id) -> GUI_ShopBuyCard:
	var card_scene = GUI_ShopBuyCard_Scene.instantiate()
	card_scene.tower_id = arg_tower_id
	add_buy_card_to_slot_container(card_scene)
	

func add_buy_card_to_slot_container(arg_buy_card : GUI_ShopBuyCard):
	slot_container.add_child(arg_buy_card)



