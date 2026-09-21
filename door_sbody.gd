
extends StaticBody3D


func interact():

	var game = get_tree().current_scene.get_node("GameManager")
	var ui = get_tree().current_scene.get_node("UI")

	# Don't interact while dialogue is open
	if ui.is_dialog_open():
		return

	# Don't interact while waiting for a visitor
	if not game.can_interact():
		print("No visitor yet. Wait for the doorbell.")
		return

	var character = game.get_current_character()

	if character == "":
		print("No more visitors.")
		return

	print("Door interacted")
	print("Character:", character)

	# Stop ringing when player opens the door
	game.visitor_opened()

	ui.show_dialog(character)
