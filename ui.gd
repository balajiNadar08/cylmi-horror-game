extends CanvasLayer

@onready var portrait = $Panel/Portrait
@onready var question = $Panel/QuestionLabel
@onready var option1 = $Panel/Option1
@onready var option2 = $Panel/Option2
@onready var bg_music = $AudioStreamPlayer2D

var dialogue = {}
var current_question: int = 0

var typing_speed := 0.05
var typing := false


func _ready():
	visible = false

func load_character(character_name: String):
	print("Loading:", character_name)

	var portrait_path = "res://portraits/%s.png" % character_name
	var dialogue_path = "res://dialogues/%s.json" % character_name

	print(portrait_path)
	print(dialogue_path)

	portrait.texture = load(portrait_path)

	var file = FileAccess.open(dialogue_path, FileAccess.READ)

	if file == null:
		push_error("Couldn't open " + dialogue_path)
		return

	var json = JSON.new()

	if json.parse(file.get_as_text()) != OK:
		push_error("Invalid JSON")
		return

	dialogue = json.data

	print(dialogue)

func show_dialog(character_name: String):
	load_character(character_name)

	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	current_question = 0
	await load_question()


func load_question():
	print(dialogue)
	print(current_question)
	print(dialogue.keys())
	typing = true
	bg_music.play()

	var key = str(int(current_question))

	if !dialogue.has(key):
		push_error("Question " + key + " not found.")
		hide_dialog()
		return

	var q = dialogue[key]

	option1.visible = false
	option2.visible = false
	question.text = ""

	for letter in q["question"]:
		question.text += letter
		await get_tree().create_timer(typing_speed).timeout

	option1.text = q["option1"]
	option2.text = q["option2"]

	option1.visible = q["option1"] != ""
	option2.visible = q["option2"] != ""

	typing = false
	bg_music.stop()


func _on_option_1_pressed():
	if typing:
		return

	var q = dialogue[str(int(current_question))]
	var next = int(q["next1"])

	if next == -1:
		hide_dialog()
	else:
		current_question = next
		await load_question()


func _on_option_2_pressed():
	if typing:
		return

	var q = dialogue[str(int(current_question))]
	var next = int(q["next2"])

	if next == -1:
		hide_dialog()
	else:
		current_question = next
		await load_question()


func hide_dialog():
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	var game = get_tree().current_scene.get_node("GameManager")
	game.next_character()
