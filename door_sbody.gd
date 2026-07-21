extends StaticBody3D

func interact():
	print("Door interacted")

	var game = get_tree().current_scene.get_node("GameManager")
	var ui = get_tree().current_scene.get_node("UI")

	print(game.get_current_character())

	ui.show_dialog(game.get_current_character())
