extends Node2D

# SCENARIO DATA ################################################################
var option: Array[String] = [
	"Investigate and trace the origin of the leaked data to identify the insider.",
	"Review and analyze internal access logs to uncover potential vulnerabilities.",
	"Implement new Data Leak Prevention (DLP) measures to strengthen data security."
]

var feedback: Array[String] = [
	"You quickly identify the source of the leak, minimizing further damage.",
	"You gain valuable insight into weak access points but delay identifying the insider.",
	"You strengthen future defenses, but the current breach remains unresolved."
]

var lesson: Array[String] = [
	"Early tracking is crucial for containment and accountability.",
	"Understanding vulnerabilities is key, but timing is critical during leaks.",
	"Prevention tools are important but must be paired with immediate investigation during active incidents."
]

var voice: Array[String] = [
	"res://assets/game/scenario_three/audio/feedback1.mp3",
	"res://assets/game/scenario_three/audio/feedback2.mp3",
	"res://assets/game/scenario_three/audio/feedback3.mp3"
]

var scores: Array[int] = [3, 2, 1]
