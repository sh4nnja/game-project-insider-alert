extends Node2D

@onready var _name: Label = $result/interface/name
@onready var _rank: Label = $result/interface/rank
@onready var _desc: Label = $result/interface/description
@onready var _result_player: AnimationPlayer = $result/result_player

@onready var _scenario_player: AnimationPlayer = $scenarios/scenario_player
var scenario_count: int = 1

var _text: Array[String] = [
	"""Every action you took was precise and calculated, balancing speed, caution, and long-term thinking.
	In a world where one mistake can cost everything, you made none.
	\nYou don't just react to threats, you stay three steps ahead.""",
	
	"""You've demonstrated exceptional judgment and tactical response to complex insider threats.
	Your actions reflect a deep understanding of both human behavior and digital vulnerabilities.
	\nIn cybersecurity, there are no perfect walls, but with leaders like you, there is resilience.
	\nStand tall. Your vigilance inspires trust and safety.""",
	
	"""Your instincts are strong, and your decision-making shows clear promise.
	You can spot risks and take action, but mastery comes with experience and continuous learning.
	\nIn the ever-changing cybersecurity field, your skills will be the shield for many.
	\nKeep honing your edge. Greater challenges await.""",
	
	"You've taken your first steps into the world of insider threat detection.
	The basics are there, but vigilance, strategy, and deeper understanding are crucial.
	\nIn cybersecurity, learning never stops. Every mistake is a chance to grow stronger.
	\nStay curious. Stay sharp."
]

# INIT #########################################################################
func _ready() -> void:
	_scenario_player.play("scenario_" + str(scenario_count))

# ANIMATION ####################################################################
func pause_animation() -> void:
	_scenario_player.pause()

func continue_animation() -> void:
	_scenario_player.play()

func advance_animation() -> void:
	scenario_count += 1
	if scenario_count == 5:
		_update_results()
		_result_player.play("show_results")
	else:
		_scenario_player.play("scenario_" + str(scenario_count))

# RESULT #######################################################################
func _update_results() -> void:
	var _pscore: int = Data.get_score()
	var _prank: String = ""
	_desc.text = "You scored " + str(_pscore) + "\n\n"
	if _pscore == 12:
		_prank = "Cybersecurity Vanguard"
		_desc.text += _text[0]
	
	elif _pscore >= 10:
		_prank = "Insider Threat Expert"
		_desc.text += _text[1]
	
	elif _pscore >= 6:
		_prank = "Experienced Defender"
		_desc.text += _text[2]
	
	else:
		_prank = "Novice Analyst"
		_desc.text += _text[3]
	
	Data.set_player_rank(_prank)
	
	_name.text = Data.get_player_name()
	_rank.text = _prank

func _on_to_menu_pressed() -> void:
	_to_menu()

# HELPER #######################################################################
func _to_menu() -> void:
	SilentWolf.Scores.save_score(Data.get_player_name(), Data.get_score())
	Data.show_leaderboard = true
	
	_result_player.play("to_main")
	await _result_player.animation_finished
	
	get_tree().change_scene_to_file("res://scenes/main.tscn")
