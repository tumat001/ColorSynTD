extends MarginContainer

const TowerTypeGameInstanceInfoDetails = preload("res://GameplayRelated/EntityRelated/TowerRelated/TowerTypeGameInstanceInfoDetails.gd")
const TowerTypeInfoDetails = preload("res://GameplayRelated/EntityRelated/TowerRelated/TowerTypeInfoDetails.gd")

#

signal action_buy_card__as_tower(arg_tower_id, arg_tower_type_game_instance_info_details, arg_tower_info_details)

#

const MODULATE__NORMAL = Color(1, 1, 1, 1)
const MODULATE__UNBUYABLE = Color(0.3, 0.3, 0.3, 1.0)

const MODULATE__HOVERED = Color(1.2, 1.2, 1.2, 1)

##

# in event that the card represents something else: like an event
enum BuyCardTypeId {
	TOWER = 0,
	
}
var buy_card_type_id : int = BuyCardTypeId.TOWER

var _tower_id
var _tower_type_game_instance_info_details
var _tower_info_details
#var _tower_game_instance_info_details

#

var shader_mat__moving_rainbow

#

enum IsUnbuyableClauseId {
	NO_GOLD = 0,
	NO_EMPTY_TOWER_SLOTS = 1,
	
}
var is_unbuyable_cond_clauses : ConditionalClauses
var last_calc_is_unbuyable : bool

# after bought
var is_disabled_and_hidden : bool : set = set_is_disabled_and_hidden

#

@onready var tier_banner = $VBoxContainer/TierContainer/VBoxContainer/TierBanner
@onready var color_01_background = $VBoxContainer/MarginContainer2/Color01Background
@onready var color_02_background = $VBoxContainer/MarginContainer2/Color02Background

@onready var vbox_container_for_most = $VBoxContainer

@onready var tower_name_label = $FreeFormContainer/NameLabel


#####################

func _init() -> void:
	is_unbuyable_cond_clauses = ConditionalClauses.new()
	is_unbuyable_cond_clauses.connect("clause_updated", _on_is_unbuyable_cond_clauses_clause_updated)

func _on_is_unbuyable_cond_clauses_clause_updated(arg_clause_id, arg_is_inserted):
	_update_last_calc_is_unbuyable()

func _update_last_calc_is_unbuyable():
	last_calc_is_unbuyable = !is_unbuyable_cond_clauses.is_passed
	_update_self_based_on_is_last_calc_is_unbuyable()


func _update_self_based_on_is_last_calc_is_unbuyable():
	if is_inside_tree():
		if last_calc_is_unbuyable:
			modulate = MODULATE__UNBUYABLE
			
		else:
			modulate = MODULATE__NORMAL
			
	

#

func set_is_disabled_and_hidden(arg_val):
	is_disabled_and_hidden = arg_val
	_update_self_based_on_is_disabled_and_hidden()

func _update_self_based_on_is_disabled_and_hidden():
	if is_inside_tree():
		if is_disabled_and_hidden:
			visible = false
		else:
			visible = true
	

#

func helper__set_tower_id__and_update_card(arg_tower_id):
	_tower_id = arg_tower_id
	buy_card_type_id = BuyCardTypeId.TOWER
	
	if StoreOfTowers.is_tower_id_none_or_null(arg_tower_id):
		set_is_disabled_and_hidden(false)
		update_self_based_on_tower_id()
	else:
		_disconnect_to_all_info_details()
		set_is_disabled_and_hidden(true)

#func helper__set_tower_id_with_custom_info_details(arg_tower_id):
#pass



#

func _ready() -> void:
	#update_self_based_on_tower_id()
	
	_update_self_based_on_is_disabled_and_hidden()

func update_self_based_on_tower_id():
	_disconnect_to_all_info_details()
	
	######
	_tower_type_game_instance_info_details = SingletonsAndConsts.current_game_elements.game_rand_info_instance_manager.rand_info_inst__tower_id_to_type_inst_info_map[_tower_id]
	_tower_info_details = StoreOfTowers.get_or_construct_singleton_tower_info_details(_tower_id)
	
	_connect_to_all_info_details()
	
	update_display_based_on_tower_id__tier_banner(_tower_info_details.tower_tier)
	update_display_based_on_tower_id__colors(_tower_type_game_instance_info_details.get_tower_colors(), _tower_info_details.is_tower_classification_paint_type())
	update_display_based_on_tower_id__tower_name()
	
	_update_last_calc_is_unbuyable()


func _connect_to_all_info_details():
	if _tower_type_game_instance_info_details != null:
		_tower_type_game_instance_info_details.connect("tower_colors_changed", _on_TTGIID_tower_colors_changed)
		
	
	if _tower_info_details != null:
		pass
		

func _disconnect_to_all_info_details():
	if _tower_type_game_instance_info_details != null:
		_tower_type_game_instance_info_details.disconnect("tower_colors_changed", _on_TTGIID_tower_colors_changed)
		
	
	if _tower_info_details != null:
		pass
		
	
	_tower_type_game_instance_info_details = null
	_tower_info_details = null
	


func _on_TTGIID_tower_colors_changed():
	if _tower_type_game_instance_info_details != null and _tower_info_details != null:
		update_display_based_on_tower_id__colors(_tower_type_game_instance_info_details.get_tower_colors(), _tower_info_details.is_tower_classification_paint_type())



func update_display_based_on_tower_id__tier_banner(arg_tier : int):
	match arg_tier:
		StoreOfTowers.TowerTier.TIER_1:
			tier_banner.texture = load("res://GameplayRelated/GameFrontHUDRelated/Subs/_commons/GUI_TierIcon/GUI_TierIcon_LongLarge_Tier01.png")
		StoreOfTowers.TowerTier.TIER_2:
			tier_banner.texture = load("res://GameplayRelated/GameFrontHUDRelated/Subs/_commons/GUI_TierIcon/GUI_TierIcon_LongLarge_Tier02.png")
		StoreOfTowers.TowerTier.TIER_3:
			tier_banner.texture = load("res://GameplayRelated/GameFrontHUDRelated/Subs/_commons/GUI_TierIcon/GUI_TierIcon_LongLarge_Tier03.png")
		StoreOfTowers.TowerTier.TIER_4:
			tier_banner.texture = load("res://GameplayRelated/GameFrontHUDRelated/Subs/_commons/GUI_TierIcon/GUI_TierIcon_LongLarge_Tier04.png")
		StoreOfTowers.TowerTier.TIER_5:
			tier_banner.texture = load("res://GameplayRelated/GameFrontHUDRelated/Subs/_commons/GUI_TierIcon/GUI_TierIcon_LongLarge_Tier05.png")
		StoreOfTowers.TowerTier.TIER_6:
			tier_banner.texture = load("res://GameplayRelated/GameFrontHUDRelated/Subs/_commons/GUI_TierIcon/GUI_TierIcon_LongLarge_Tier06.png")
		

func update_display_based_on_tower_id__colors(arg_colors : Array, arg_is_paint_type : bool):
	var primary_color = arg_colors[0]
	_set_color_background_texrect_texture_based_on_color(color_01_background, primary_color, arg_is_paint_type)
	
	if StoreOfTowers.is_tower_two_colored__based_on_colors(arg_colors): #arg_colors.size() == 2:
		var secondary_color = arg_colors[1]
		_set_color_background_texrect_texture_based_on_color(color_02_background, secondary_color, arg_is_paint_type)
		color_02_background.visible = true
		_set_is_texture_rect_material_rainbow_active(color_01_background, false)
		
	elif StoreOfTowers.is_tower_single_colored__based_on_colors(arg_colors):
		color_02_background.visible = false
		_set_is_texture_rect_material_rainbow_active(color_01_background, false)
		
	else:  #rainbow
		color_02_background.visible = false
		_set_is_texture_rect_material_rainbow_active(color_01_background, true)
	

func _set_color_background_texrect_texture_based_on_color(arg_texture_rect : TextureRect, arg_color, arg_is_paint_type : bool):
	var texture_2d_to_use : Texture2D
	if arg_is_paint_type:
		match arg_color:
			StoreOfTowers.TowerColorId.GRAY:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Gray_PaintTower.png")
			StoreOfTowers.TowerColorId.BLACK:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Black_PaintTower.png")
			StoreOfTowers.TowerColorId.RED:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Red_PaintTower.png")
			StoreOfTowers.TowerColorId.ORANGE:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Orange_PaintTower.png")
			StoreOfTowers.TowerColorId.YELLOW:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Yellow_PaintTower.png")
			StoreOfTowers.TowerColorId.GREEN:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Green_PaintTower.png")
			StoreOfTowers.TowerColorId.BLUE:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Blue_PaintTower.png")
			StoreOfTowers.TowerColorId.VIOLET:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Violet_PaintTower.png")
			
		
	else:
		match arg_color:
			StoreOfTowers.TowerColorId.GRAY:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Gray_NormalTower.png")
			StoreOfTowers.TowerColorId.BLACK:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Black_NormalTower.png")
			StoreOfTowers.TowerColorId.RED:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Red_NormalTower.png")
			StoreOfTowers.TowerColorId.ORANGE:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Orange_NormalTower.png")
			StoreOfTowers.TowerColorId.YELLOW:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Yellow_NormalTower.png")
			StoreOfTowers.TowerColorId.GREEN:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Green_NormalTower.png")
			StoreOfTowers.TowerColorId.BLUE:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Blue_NormalTower.png")
			StoreOfTowers.TowerColorId.VIOLET:
				texture_2d_to_use = load("res://GameplayRelated/GameFrontHUDRelated/Subs/GUI_ShopPanel/ShopBuyCard/Assets/GUI_ShopBuyCard_Violet_NormalTower.png")
			
	
	arg_texture_rect.texture = texture_2d_to_use


func _set_is_texture_rect_material_rainbow_active(arg_texture_rect : TextureRect, arg_is_material_active):
	if arg_is_material_active:
		arg_texture_rect.material = shader_mat__moving_rainbow
	else:
		arg_texture_rect.material = null


func update_display_based_on_tower_id__tower_name():
	tower_name_label.text = _tower_info_details.tower_name_string


##############


func action__attempt_buy_card():
	if !last_calc_is_unbuyable:
		action__force_buy_card()

func action__force_buy_card():
	if is_disabled_and_hidden:
		return
	
	###
	
	if buy_card_type_id == BuyCardTypeId.TOWER:
		emit_signal("action_buy_card__as_tower", _tower_id, _tower_type_game_instance_info_details, _tower_info_details)
	
	set_is_disabled_and_hidden(true)

####

func _on_buy_button_button_left_released(arg_is_mouse_functionally_inside) -> void:
	if arg_is_mouse_functionally_inside:
		action__attempt_buy_card()
	

func _on_buy_button_button_right_released(arg_is_mouse_functionally_inside: bool) -> void:
	if arg_is_mouse_functionally_inside:
		pass
		#todosoon make tooltip
	



func _on_buy_button_mouse_functionally_entered() -> void:
	vbox_container_for_most.modulate = MODULATE__HOVERED

func _on_buy_button_mouse_functionally_exited() -> void:
	vbox_container_for_most.modulate = MODULATE__NORMAL



