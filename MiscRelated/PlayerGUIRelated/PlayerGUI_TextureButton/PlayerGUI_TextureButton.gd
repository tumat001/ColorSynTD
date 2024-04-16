extends TextureButton

signal button_left_clicked()
signal button_right_clicked()

signal button_left_released(arg_is_mouse_functionally_inside : bool)
signal button_right_released(arg_is_mouse_functionally_inside : bool)


signal mouse_functionally_entered()
signal mouse_functionally_exited()  #on invis, on queue free, on mouse exit

var is_mouse_functionally_inside : bool


func _on_mouse_entered() -> void:
	if !is_mouse_functionally_inside:
		is_mouse_functionally_inside = true
		emit_signal("mouse_functionally_entered")


func _on_mouse_exited() -> void:
	_attempt_emit_signal_mouse_functionally_exited()

func _on_visibility_changed() -> void:
	call_deferred("_on_vis_changed__deferred")

func _on_vis_changed__deferred():
	if !visible:
		_attempt_emit_signal_mouse_functionally_exited()


func _on_tree_exiting() -> void:
	_attempt_emit_signal_mouse_functionally_exited()

func _attempt_emit_signal_mouse_functionally_exited():
	if is_mouse_functionally_inside:
		is_mouse_functionally_inside = false
		emit_signal("mouse_functionally_exited")

#########

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				emit_signal("button_left_clicked")
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				emit_signal("button_right_clicked")
			
		else: # released
			if event.button_index == MOUSE_BUTTON_LEFT:
				emit_signal("button_left_released", is_mouse_functionally_inside)
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				emit_signal("button_right_released", is_mouse_functionally_inside)
		
	
