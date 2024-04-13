extends MarginContainer


enum BuyCardTypeId {
	TOWER = 0,
	
}
var buy_card_type_id : int

var tower_id

#

@onready var tier_banner = $VBoxContainer/TierContainer/VBoxContainer/TierBanner
@onready var color_01_background = $VBoxContainer/MarginContainer2/Color01Background
@onready var color_02_background = $VBoxContainer/MarginContainer2/Color02Background

###############

func _ready() -> void:
	update_display_based_on_tower_id()


func update_display_based_on_tower_id():
	pass
	

