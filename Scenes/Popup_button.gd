extends Node

func _on_Popup_button_pressed():
	var popup = get_node("PopupPanel")
	if (popup.visible):
		popup.visible = false
	else:
		popup.visible = true
	pass # Replace with function body.
