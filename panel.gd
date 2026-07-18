extends Panel

@onready var question_label: Label = $QuestionLabel
@onready var option1: Button = $Option1
@onready var option2: Button = $Option2

var typing_speed := 0.03

func _ready():
	var yellow_bright = Color(1, 0.95, 0.66)
	var yellow_dim = Color(0.79, 0.64, 0.15)

	# Panel background
	var bg = StyleBoxFlat.new()
	bg.bg_color = Color(0.04, 0.04, 0.02, 0.78)
	bg.border_color = yellow_dim
	bg.set_border_width_all(2)
	add_theme_stylebox_override("panel", bg)

	question_label.add_theme_color_override("font_color", yellow_bright)

	var empty = StyleBoxEmpty.new()

	for btn in [option1, option2]:

		btn.add_theme_stylebox_override("normal", empty)
		btn.add_theme_stylebox_override("pressed", empty)

		var hover_style = StyleBoxFlat.new()
		hover_style.bg_color = Color(0, 0, 0, 0)
		hover_style.border_width_bottom = 2
		hover_style.border_color = yellow_bright
		hover_style.shadow_color = Color(
			yellow_bright.r,
			yellow_bright.g,
			yellow_bright.b,
			0.6
		)
		hover_style.shadow_size = 6
		hover_style.content_margin_bottom = 4

		btn.add_theme_stylebox_override("hover", hover_style)
		btn.add_theme_stylebox_override("focus", hover_style)

		btn.add_theme_color_override("font_color", yellow_dim)
		btn.add_theme_color_override("font_hover_color", yellow_bright)
		btn.add_theme_color_override("font_pressed_color", yellow_bright)
		btn.add_theme_color_override("font_focus_color", yellow_bright)

	# Make both buttons the same width
	var width = 550

	option1.custom_minimum_size = Vector2(width, 40)
	option2.custom_minimum_size = Vector2(width, 40)

	option1.visible = false
	option2.visible = false


func show_question(question_text:String, option1_text:String, option2_text:String) -> void:

	option1.visible = false
	option2.visible = false

	question_label.text = ""

	await typewriter(question_text)

	option1.text = option1_text
	option2.text = option2_text

	option1.visible = true
	option2.visible = true


func typewriter(text:String) -> void:

	question_label.text = ""

	for letter in text:

		question_label.text += letter

		await get_tree().create_timer(typing_speed).timeout
