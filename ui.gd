extends CanvasLayer

@onready var question = $Panel/QuestionLabel
@onready var option1 = $Panel/Option1
@onready var option2 = $Panel/Option2

var current_question = 0

# Typewriter settings
var typing_speed := 0.03
var typing := false

var dialogue = {
	0: {
		"question": "Package delivery. Could you open the door for a moment?",
		"option1": "Who the hell delivers packages at midnight?",
		"option2": "I don't remember ordering anything.",
		"next1": 1,
		"next2": 2
	},

	1: {
		"question": "I know it's late. I'm just finishing my route. I'd appreciate it if you could open the door and take this package.",
		"option1": "Fine, I'll take the package.",
		"option2": "I don't remember ordering anything.",
		"next1": 3,
		"next2": 4
	},

	2: {
		"question": "The label has this address sir. Maybe someone else wants to surprise you!",
		"option1": "Nope, that can't be. I don't have any such friends.",
		"option2": "Just leave the box outside and go.",
		"next1": 5,
		"next2": 6
	},

	3: {
		"question": "The man slowly reaches into his pocket and shows an ID card.",
		"option1": "Take the ID.",
		"option2": "Keep the door shut.",
		"next1": 7,
		"next2": 8
	},

	4: {
		"question": "The label has this address sir. Maybe someone else wants to surprise you!",
		"option1": "Nope, that can't be. I don't have any such friends.",
		"option2": "Just leave the box outside and go.",
		"next1": 9,
		"next2": 10
	},

	5: {
		"question": "He goes completely silent for several seconds.",
		"option1": "Open the door.",
		"option2": "Call the police.",
		"next1": 11,
		"next2": 12
	},

	6: {
		"question": "He smiles... then says your full name.",
		"option1": "Open the door.",
		"option2": "Stay silent.",
		"next1": 13,
		"next2": 14
	},

	7: {
		"question": "The ID looks real... but the photo isn't his.",
		"option1": "Open the door.",
		"option2": "Refuse.",
		"next1": -1,
		"next2": -1
	},

	8: {
		"question": "The knocking suddenly becomes louder.",
		"option1": "End Conversation",
		"option2": "End Conversation",
		"next1": -1,
		"next2": -1
	},

	9: {
		"question": "(chuckles) No friends who'd send a gift? Ouch. Well, somebody paid for this delivery, and it's got your name and address clear as day. Maybe your friend who left few hours ago wants to surprise you, who knows. Anyways, just open the door and take the package man, I have to go home too.",
		"option1": "Fine, I'll take the package.",
		"option2": "Wait.....How the hell do you know that my friend left few hours ago?",
		"next1": -1,
		"next2": -1
	},

	10: {
		"question": "The hallway is empty... but someone knocks again.",
		"option1": "End",
		"option2": "End",
		"next1": -1,
		"next2": -1
	},

	11: {
		"question": "As you unlock the door... everything goes black.",
		"option1": "Restart",
		"option2": "Restart",
		"next1": -1,
		"next2": -1
	},

	12: {
		"question": "The police answer... but nobody is outside anymore.",
		"option1": "End",
		"option2": "End",
		"next1": -1,
		"next2": -1
	},

	13: {
		"question": "The man smiles wider than any human should.",
		"option1": "End",
		"option2": "End",
		"next1": -1,
		"next2": -1
	},

	14: {
		"question": "After a minute, the footsteps slowly fade away.",
		"option1": "End",
		"option2": "End",
		"next1": -1,
		"next2": -1
	}
}


func _ready():
	visible = false


func show_dialog():
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	current_question = 0
	await load_question()


func load_question():

	typing = true

	var q = dialogue[current_question]

	option1.visible = false
	option2.visible = false

	question.text = ""

	for letter in q["question"]:
		question.text += letter
		await get_tree().create_timer(typing_speed).timeout

	option1.text = q["option1"]
	option2.text = q["option2"]

	option1.visible = true
	option2.visible = true

	typing = false


func _on_option_1_pressed():

	if typing:
		return

	var next = dialogue[current_question]["next1"]

	if next == -1:
		hide_dialog()
	else:
		current_question = next
		await load_question()


func _on_option_2_pressed():

	if typing:
		return

	var next = dialogue[current_question]["next2"]

	if next == -1:
		hide_dialog()
	else:
		current_question = next
		await load_question()


func hide_dialog():

	visible = false

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
