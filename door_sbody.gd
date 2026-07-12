extends StaticBody3D

func interact():
	var ui = get_tree().current_scene.get_node("UI")
	ui.show_dialog()
