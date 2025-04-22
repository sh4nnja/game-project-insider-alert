extends Node2D

# SCENARIO DATA ################################################################
var option: Array[String] = [
	"Investigate Alex’s recent email activities for signs of malware downloads or unauthorized access.",
	"Check Alex’s record for completion and performance in recent cybersecurity training programs.",
	"Confirm whether the phishing attempt was successful by checking system breach alerts or unauthorized login attempts."
]

var feedback: Array[String] = [
	"You discover that Alex clicked the link, resulting in malware being installed. Immediate containment actions are required.",
	"Alex had completed training but scored poorly on phishing simulations.",
	"You verify that no breach occurred yet, Alex reported the suspicious email in time."
]

var lesson: Array[String] = [
	"Regular activity monitoring helps detect and limit breaches early.",
	"Training effectiveness matters as much as completion; continuous education and realistic simulations are crucial.",
	"Fostering a culture of quick reporting is a powerful defense."
]

var voice: Array[String] = [
	"res://assets/game/scenario_one/audio/feedback1.mp3",
	"res://assets/game/scenario_one/audio/feedback2.mp3",
	"res://assets/game/scenario_one/audio/feedback3.mp3"
]

var scores: Array[int] = [3, 1, 2]

# SCENARIO RELATED #############################################################
func _on_email_pressed() -> void:
	get_tree().call_group("game", "continue_animation")
	$interface/email.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
