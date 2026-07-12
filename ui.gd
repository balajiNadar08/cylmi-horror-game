extends CanvasLayer

@onready var question = $Panel/QuestionLabel
@onready var option1 = $Panel/Option1
@onready var option2 = $Panel/Option2

var current_question = 0

var dialogue = [
	{
		"question":"Package delivery. Could you open the door for a moment?",
		"option1":"Who the hell delivers package at midnight?",
		"option2":"I dont't remember ordering anything."
	},
	{
		"question":"The man says he is an electrician.",
		"option1":"Let him in",
		"option2":"Ask for ID"
	},
	{
		"question":"He shows an ID card.",
		"option1":"Trust him",
		"option2":"Call the building manager"
	}
]

func _ready():
	visible = false

func show_dialog():
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	current_question = 0
	load_question()

func load_question():
	question.text = dialogue[current_question]["question"]
	option1.text = dialogue[current_question]["option1"]
	option2.text = dialogue[current_question]["option2"]

func _on_option_1_pressed():
	next_question(1)

func _on_option_2_pressed():
	next_question(2)

func next_question(choice):

	print("Player chose option ", choice)

	current_question += 1

	if current_question >= dialogue.size():
		hide_dialog()
	else:
		load_question()

func hide_dialog():
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
