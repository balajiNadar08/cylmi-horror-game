extends StaticBody3D

func interact():

	var game = get_tree().current_scene.get_node("GameManager")
	var ui = get_tree().current_scene.get_node("UI")

	# Don't interact while dialogue is already open
	if ui.is_dialog_open():
		return

	var character = game.get_current_character()

	if character == "":
		print("No more visitors.")
		return

	print("Door interacted")
	print("Character:", character)

	ui.show_dialog(character)
