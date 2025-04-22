extends Node2D

# SCENARIO DATA ################################################################
var option: Array[String] = [
	"Quietly increase monitoring of Jamie’s activities to gather more evidence.",
	"Temporarily suspend Jamie’s system access to immediately contain any possible threat.",
	"Directly confront Jamie or escalate the situation to Human Resources for intervention."
]

var feedback: Array[String] = [
	"You chose to quietly monitor Jamie’s activity. This could help gather more evidence, but it risks allowing the suspicious behavior to continue unchecked.",
	"You decided to suspend Jamie’s access. This stops any potential threat immediately but may cause workplace disruption or damage trust if done without clear justification.",
	"You opted to confront Jamie or involve HR. This can bring clarity quickly but may escalate the situation or harm reputations if not handled carefully."
]

var lesson: Array[String] = [
	"Gathering intel is valuable, but delay can increase risk.",
	"Quick action protects assets, but must be balanced with employee rights..",
	"Direct communication resolves faster, but must be handled sensitively."
]

var voice: Array[String] = [
	"res://assets/game/scenario_two/audio/feedback1.mp3",
	"res://assets/game/scenario_two/audio/feedback2.mp3",
	"res://assets/game/scenario_two/audio/feedback3.mp3"
]

var scores: Array[int] = [1, 3, 2]

# SCENARIO RELATED #############################################################
