
extends Node

var visitors = [
	"deliveryman",
	"stalker",
	"police",
	"electrician",
	"shaman",
	"mimic",
	"mommy",
	"neighbour",
]

var current_visitor := 0
var visitor_available := true

@export var wait_time := 30.0

@onready var doorbell: AudioStreamPlayer = $AudioStreamPlayer


func get_current_character() -> String:
	if current_visitor >= visitors.size():
		return ""

	return visitors[current_visitor]


func can_interact() -> bool:
	return visitor_available


func visitor_opened():
	visitor_available = false

	# Stop doorbell immediately
	doorbell.stop()


func next_character():
	current_visitor += 1

	if current_visitor < visitors.size():
		print("Next visitor:", visitors[current_visitor])
		start_waiting()
	else:
		print("All visitors completed!")


func start_waiting():
	visitor_available = false

	print("Waiting for next visitor...")

	await get_tree().create_timer(wait_time).timeout

	if current_visitor < visitors.size():
		visitor_available = true

		print("Next visitor has arrived!")

		# Start continuous doorbell ringing
		ring_doorbell()
	else:
		print("No more visitors.")


func ring_doorbell():
	while visitor_available:

		if not doorbell.playing:
			doorbell.play()

		await get_tree().create_timer(0.1).timeout
