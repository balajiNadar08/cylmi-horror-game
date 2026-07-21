extends Node

var visitors = [
	"deliveryman",
	"shaman"
]

var current_visitor := 0

func get_current_character():
	return visitors[current_visitor]

func next_character():
	if current_visitor < visitors.size() - 1:
		current_visitor += 1
		print("Current visitor:", visitors[current_visitor])
	else:
		print("All visitors completed!")
