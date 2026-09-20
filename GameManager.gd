extends Node

var visitors = [
	"deliveryman",
	"police",
	"stalker",
	"electrician",
	"shaman",
	"mimic",
	"mommy",
	"neighbour",
]

var current_visitor := 0


func get_current_character() -> String:
	if current_visitor >= visitors.size():
		return ""

	return visitors[current_visitor]


func next_character():
	current_visitor += 1

	if current_visitor < visitors.size():
		print("Next visitor:", visitors[current_visitor])
	else:
		print("All visitors completed!")
		
