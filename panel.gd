extends Panel

func _ready():
	var yellow_bright = Color(1, 0.95, 0.66)
	var yellow_dim = Color(0.79, 0.64, 0.15)

	# Panel background
	var bg = StyleBoxFlat.new()
	bg.bg_color = Color(0.04, 0.04, 0.02, 0.78)
	bg.border_color = yellow_dim
	bg.set_border_width_all(2)
	add_theme_stylebox_override("panel", bg)

	$QuestionLabel.add_theme_color_override("font_color", yellow_bright)

	var empty = StyleBoxEmpty.new()

	for btn_path in ["Option1", "Option2"]:
		var btn = get_node(btn_path)

		# Normal state: fully transparent, no border
		btn.add_theme_stylebox_override("normal", empty)
		btn.add_theme_stylebox_override("pressed", empty)

		# Hover/Focus: bottom-border glow only
		var hover_style = StyleBoxFlat.new()
		hover_style.bg_color = Color(0, 0, 0, 0) # transparent bg
		hover_style.border_width_bottom = 2
		hover_style.border_color = yellow_bright
		hover_style.shadow_color = Color(yellow_bright.r, yellow_bright.g, yellow_bright.b, 0.6)
		hover_style.shadow_size = 6
		hover_style.content_margin_bottom = 4 # small gap between text and line

		btn.add_theme_stylebox_override("hover", hover_style)
		btn.add_theme_stylebox_override("focus", hover_style)

		btn.add_theme_color_override("font_color", yellow_dim)
		btn.add_theme_color_override("font_hover_color", yellow_bright)
		btn.add_theme_color_override("font_pressed_color", yellow_bright)
		btn.add_theme_color_override("font_focus_color", yellow_bright)
