extends Node


func _enter_tree() -> void:
	SingletonsAndConsts.current_game_elements = self


func _exit_tree() -> void:
	SingletonsAndConsts.current_game_elements = null

