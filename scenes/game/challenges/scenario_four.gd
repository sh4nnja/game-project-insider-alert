extends Node2D

# SCENARIO DATA ################################################################
var option: Array[String] = [
	"Immediately suspend Riley’s system access to neutralize potential threats.",
	"Continue covertly gathering more evidence before taking action.",
	"Contact law enforcement immediately to initiate formal investigation.",
	"Launch a company-wide security awareness training to reinforce insider threat vigilance."
]

var feedback: Array[String] = [
	"You neutralize the immediate threat but risk tipping off Riley prematurely.",
	"You build a strong case for action, but delaying poses a continued risk.",
	"You escalate to law enforcement, securing formal support but increasing visibility.",
	"You strengthen overall vigilance, but Riley’s current threat remains unaddressed."
]

var lesson: Array[String] = [
	"Swift action stops immediate damage but could complicate deeper investigations.",
	"Evidence is vital for prosecution but balancing speed and caution is critical.",
	"Legal steps can provide protection, but must follow internal protocols carefully.",
	"Training is proactive for the future, not a direct response for active threats."
]

var voice: Array[String] = [
	"res://assets/game/scenario_four/audio/feedback1.mp3",
	"res://assets/game/scenario_four/audio/feedback2.mp3",
	"res://assets/game/scenario_four/audio/feedback3.mp3",
	"res://assets/game/scenario_four/audio/feedback4.mp3"
]

var scores: Array[int] = [3, 2, 1, 0]
