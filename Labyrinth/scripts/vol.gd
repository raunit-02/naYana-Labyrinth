extends ColorRect


func _on_HSlider_value_changed(value):
	print(value)
	Audiomanager.set_volume(value)
	if value == -50:
		$CheckButton.pressed = false
		print('music off')

func _on_CheckButton_toggled(button_pressed):
	if $CheckButton.pressed == false:
		print('music off')
		$HSlider.value = -50
		$HSlider.editable = false
	else:
		print('music on')
		$HSlider.value = -49
		$HSlider.editable = true

func _on_Button_pressed():
	get_tree().change_scene('res://scenes/main menu.tscn')

